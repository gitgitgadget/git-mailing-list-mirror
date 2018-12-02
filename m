Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5647211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 00:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725755AbeLBLSR (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 06:18:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53942 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeLBLSR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 06:18:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DD53437EE;
        Sat,  1 Dec 2018 19:04:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Z7Z50a10ERiWHYbNuR1JsXjpAY=; b=qq6Qnd
        475d/8mlrgM3AeGewUnQPyvRoAUw7kTortoFCGzPXXqSy71jk58XkQubCCXRTy+C
        1FGIuqxaZx/kuTkln6FA8I1MSpv0Upv2kp5zkqsG+R9nfwl4ruPuQ0zAauT6hHxc
        UYfWEa/5XdMhwIuZHXUJA9dehYxKXXWa9ados=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZUg+v6wlli7G3z8b9wtFeQHCLSuL+ZZo
        hvSjXKnPjNxfb9UA8/pmt/RFH7JPu9QOb3000JvEXjxEMrl6pT6xwWpf93KYPCCU
        EADtfmnbIUz5z+86BDUVyOSWCzl1sKcwIUdBQsG+zDqIsGmbbPv3yQ+/2fyTj001
        Dz7sN272cPQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36B56437ED;
        Sat,  1 Dec 2018 19:04:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50B06437EC;
        Sat,  1 Dec 2018 19:04:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cameron Boehmer <cameron.boehmer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] git clean --local
References: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
Date:   Sun, 02 Dec 2018 09:04:29 +0900
In-Reply-To: <CAM+q9MeVS1e11vzu+-RP-i5NhSsnRz=x21q3gcGy8L62yceiMw@mail.gmail.com>
        (Cameron Boehmer's message of "Sat, 1 Dec 2018 14:51:10 -0800")
Message-ID: <xmqqsgzgiyk2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7D8782C-F5C5-11E8-A5D1-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cameron Boehmer <cameron.boehmer@gmail.com> writes:

> 1) add a new flag
> -l, --local
>     Do not consult git config --global core.excludesFile in
> determining what files git ignores. This is useful in conjunction with
> -x/-X to preserve user files while removing build artifacts.

This does not belong to the "clean" command (who says the need to
ignore the global configuration is limited to "clean" and why?), so
"git clean --local" is simply not acceptable.

But it might be useful as an option that affects any "git" command,
e.g. "git --local-config-only clean".  I dunno.

> 2) change the behavior of -x/-X

This won't happen without a long deprecation period.

If you haven't seen and read them, check the recent list archive for
the past few weeks, with keywords "trashable", "precious", etc.

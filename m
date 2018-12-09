Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38BB20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeLIBm2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:42:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54120 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIBm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:42:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8DAF2E6E4;
        Sat,  8 Dec 2018 20:42:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wzN9Xau7Sb8tw5LcoaNaVsapN5M=; b=g/26SL
        tD5lSiNv+1eKOSF64EHU9ERUHjAEsSgxA8qqNBZ24pTLMZRDq4QRUUSW5y8SDhz1
        5eINDXT0ln1d38HS2eMKf3iKCayF2i9lS+Mcd+MAp29S5sZy8tVMv0Jaot3MLNmf
        1mbRHktcWNl0TbaYWbBy6DUjmAIPMLDr7SlzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lzEstGxy/4E4x23AJ8djZGN+J5MYNRDD
        acpwI8PFzFDWSK36t4J8ULYBUBCyEWhnKTtFKpKNJy2nzvrNTAO3yovQqL/OTvuf
        r3ZBkbjCD70db2SlWNrmtlAZ6VD6auQvgbOSn5AXCjXi1OmqGIH4Uzfb629r/gVM
        tPUJB8hMhV4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1C292E6E2;
        Sat,  8 Dec 2018 20:42:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CFF92E6E0;
        Sat,  8 Dec 2018 20:42:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: why doesn't "git reset" mention optional pathspec?
References: <alpine.LFD.2.21.1812081103500.29142@localhost.localdomain>
        <CACsJy8APyyAWM+L=HU1XM4V+qdTWqjto6x=Q06By8DbgtYfpCA@mail.gmail.com>
        <alpine.LFD.2.21.1812081232240.32380@localhost.localdomain>
        <CACsJy8AC-anZ=EA3zxWeX8UUNcZiKsQMu8x0eCHAOCUjFWoFuQ@mail.gmail.com>
        <alpine.LFD.2.21.1812081236220.32716@localhost.localdomain>
        <CACsJy8A_vaVUt389O5ABa+vsrVDgo1L3WZzVx+P0qfiaY9=p1w@mail.gmail.com>
Date:   Sun, 09 Dec 2018 10:42:20 +0900
In-Reply-To: <CACsJy8A_vaVUt389O5ABa+vsrVDgo1L3WZzVx+P0qfiaY9=p1w@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 8 Dec 2018 19:17:28 +0100")
Message-ID: <xmqqftv75vcz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC8E55EA-FB53-11E8-A2C9-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Without --mixed, you're using the first form
>
>     git reset [-q] [<tree-ish>] [--] <paths>...
>
> which accepts pathspec. If it's not clear, of course patches are welcome.

Yup.  The deprecation is about spelling with "--mixed" when invoking
the "restore these paths out of tree-ish (or HEAD when omitted)
only in the index" mode.  The feature is of course not deprecated
(but it might have been better if it were "git checkout --cached").


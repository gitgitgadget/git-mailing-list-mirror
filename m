Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB13C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CC520786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wYeu2qbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHRUIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:08:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54986 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRUIo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 16:08:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9012E5D87;
        Tue, 18 Aug 2020 16:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mEPkQ939RSDPmbe7LUQyOUi2dY4=; b=wYeu2q
        bmdBspQ8ba/c3rrST0uBlzPgoSjSEUJAHmLoAqxuH7TUL9sYZCirBycmuzA0v7r5
        6l9SqbrZdMM0YRRUFIpgvaIjk18v7HN7Oc3XJMQVGRqrI76O44oh6Ucgu/ViE3/t
        XOmaiX+SaVPj6U4WM8bQTSBXe/8eVGxxhLqas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o7UbiCryzpJ+lHFLDd/kjS7CwRrtGibS
        w1vTWkD2/FKqOYf7GcsTs3+HY2dwKYyqkERAm9UwfarKCgOb1qovPNpWLTmEksxY
        zVaZjcaP0yZNUNbSf+4EChhZvVqh1MMw3SABKtd/Tkjp4BIEXyTWLEOx6tsSCnJ/
        C2iTIvBltzI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1A8EE5D86;
        Tue, 18 Aug 2020 16:08:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 64E48E5D80;
        Tue, 18 Aug 2020 16:08:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ian S. Worthington" <ianworthington@usa.net>
Cc:     <git@vger.kernel.org>
Subject: Re: Problems with FTP PUSH
References: <196yHRLtV8416Set.1597751181@web13.cms.usa.net>
Date:   Tue, 18 Aug 2020 13:08:36 -0700
In-Reply-To: <196yHRLtV8416Set.1597751181@web13.cms.usa.net> (Ian
        S. Worthington's message of "Tue, 18 Aug 2020 12:46:21 +0100")
Message-ID: <xmqqeeo3yawr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9AA45E4C-E18E-11EA-AAE1-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ian S. Worthington" <ianworthington@usa.net> writes:

> I have a server without https and so I'm trying to establish if I can host a
> repository there using ftp.  The manuals suggest that I can, but when I try: 

Which manuals?

IIUC, a dumb HTTP(S) server that accepts only GET can still serve
"git fetch", and an FTP(s) server would be able to do the same using
similar codepath, but I do not think these can accept "git push".  A
dumb HTTP(S) may be able to accept "git push" if it does WebDAV, but
I do not think there is corresponding FTP support at all.


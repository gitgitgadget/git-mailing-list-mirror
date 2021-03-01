Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90365C433E0
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4993664EFC
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448634AbhCBPH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:07:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56857 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbhCAX7A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 18:59:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 79EBAADDE1;
        Mon,  1 Mar 2021 18:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+qFIMQsFMdaVR9S0MAQ0SytUN3U=; b=SE6Ggh
        RYtGVzRoub+toEu+P8Ww0u800dW+GAgk9v0dd8NQmKDVseRhvAqAhi6mzVUwwOmn
        vctuoI5l+lDgY0blWEIYb+rvSNyVXNkbWd9T9b6P5lLejjWJR/Gk/UwvqgogXqMs
        41Qo/xOiaG1aaPkRUltGklOJ1VdlPVMqUmfcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PONEBGyMnm0FdU+BFChkkDjYf7tyrc2I
        b6Q2Bu5lxURY2JZ3bCxFQv3sVFD5nRl4ZJ/Zm9ItEuS5cVHtCwar7sw7Y2b70jKe
        5k7QsKlqeM5wbS7A53348/O8Ij4O2o0QRsQpRorZlDf7AV19Wxffq4pCFh2a1vQe
        VSxZpGpemvo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C01ADDD6;
        Mon,  1 Mar 2021 18:57:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD494ADDA6;
        Mon,  1 Mar 2021 18:57:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>,
        Joachim Schmitz <jojo@schmitz-digital.de>,
        Matt Kraai <kraai@ftbfs.org>,
        "Randall S. Becker" <randall.becker@nexbridge.ca>
Cc:     git@vger.kernel.org, Aleksey Kliger <alklig@microsoft.com>
Subject: Re: [PATCH] config.mak.uname: enable OPEN_RETURNS_EINTR for macOS
 Big Sur
References: <YDXZY8XFRayiM1If@coredump.intra.peff.net>
        <YDXaJHnZ5LgCj9NX@coredump.intra.peff.net>
        <xmqqzgzuyqli.fsf@gitster.g>
        <YDaY/M3Rw+6xwZlf@coredump.intra.peff.net>
        <YDiRywyld/0OTT5U@coredump.intra.peff.net>
        <xmqq8s7ascby.fsf@gitster.g>
        <YDy0C9sRvboGXQ7P@coredump.intra.peff.net>
Date:   Mon, 01 Mar 2021 15:57:35 -0800
In-Reply-To: <YDy0C9sRvboGXQ7P@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 1 Mar 2021 04:29:47 -0500")
Message-ID: <xmqqczwimnps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5E5B636-7AE9-11EB-9419-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I got another off-list report of the problem. I think we probably want
> to do this on top:

Queued and pushed out.

I wonder if these hits for SA_RESTART in config.mak.uname would be a
good way to guide us.

    [6c109904 (Port to HP NonStop, 2012-09-19)]
            # Not detected (nor checked for) by './configure'.
            # We don't have SA_RESTART on NonStop, unfortunalety.
            COMPAT_CFLAGS += -DSA_RESTART=0

    [40036bed (Port to QNX, 2012-12-18)]
    ifeq ($(uname_S),QNX)
            COMPAT_CFLAGS += -DSA_RESTART=0

One caveat is that we do not know if their system headers hide the
real implementation of open(2) behind a C preprocessor macro, in
whcih case OPEN_RETURNS_EINTR wrapper may not work correctly.

>  config.mak.uname | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index e22d4b6d67..d204c20a64 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -124,6 +124,9 @@ ifeq ($(uname_S),Darwin)
>  	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
>  		HAVE_GETDELIM = YesPlease
>  	endif
> +	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 && echo 1),1)
> +		OPEN_RETURNS_EINTR = UnfortunatelyYes
> +	endif
>  	NO_MEMMEM = YesPlease
>  	USE_ST_TIMESPEC = YesPlease
>  	HAVE_DEV_TTY = YesPlease

Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9612C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42F6206BF
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 05:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZp+EPW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD1FZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726042AbgD1FZO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 01:25:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35543C03C1A9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:25:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so9753652pgb.7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v1ZDl3Srcrithp9WObCLkbcoC/p3UW/ktum0SR0gPJo=;
        b=WZp+EPW/+2vQ2WRIPnmu/OxuKBvrIs+iTOY0L+9nw5hwOWxf90tZyWyEPo+uoU1Iy4
         l4AGycznEUk2mE8Eb9eF89WXwujwRUJ9R3c6UxFtHR7yEShYDqYfDwCPmQojkn2isRq4
         50b6NnOgKWDG2QIcG9t4E/nLall4mnSHMDqqXX0tXl2fyiPg9zedlRAmPvbiOefpq4+b
         9w2sxwkhYowiOBKwkkMjjh5Ogsn2jv09lFtsTAykop+siLrvvrtdQZGqdoVrezSYbDIC
         2RwrMJLD1JJvSRD+ejxqNOj40Y/8On+hi++fiR+H8GSYyXG8gL/0fdGqQNoMGPFD8/Ge
         3WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1ZDl3Srcrithp9WObCLkbcoC/p3UW/ktum0SR0gPJo=;
        b=BeI3xoLSvuzcrG21UmGsLS5rF56R8Mcnv4qFT0EecJlOMMkFCTYmlW99hT/rQFaGPn
         kXmzLpqCNwB8BTn+Vb+5uCiXIqf1kIDa3EPooP3UHFLD2Hv7RYGd97/fvU5pJ3up1LWn
         T6VvX6pPQmrm0efVxbXEqPYvUQv4NCTaTSQH5NSIrcjtsGXUE4nA+KfYpmZHT8jL3OOS
         k0hVkkvR3/s2MrH6GIupObJz3qrJy9mZy6NBK3yTgzP8cd3WXr4lhpU0mRInAjo8e/S0
         u/krWfi1Rq+hoIJ8Wz5ttCA55GcKbckuL0X6YppEkCs+znowzoIBNm+H6xae2m/WmHW2
         0yBw==
X-Gm-Message-State: AGi0PuaOw7Vw4ugTZ9S/5hAzx+wyZ5STOb9yRe5JmNpgPjSrVhH0mkGZ
        qPyrKJlfCsBSKRlmYU/pUPSZjB51
X-Google-Smtp-Source: APiQypLE2Ja6u+aSbAgZy1AGKBDYKrAP0+00jl3x7SW0hoEeZruPVtaTixkQP0tTmF8MnTC/Ew/8Dg==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr27674340pfn.215.1588051513598;
        Mon, 27 Apr 2020 22:25:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id kb10sm970357pjb.6.2020.04.27.22.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 22:25:12 -0700 (PDT)
Date:   Mon, 27 Apr 2020 22:25:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments
 from store
Message-ID: <20200428052510.GA201501@google.com>
References: <20200427084235.60798-1-carenas@gmail.com>
 <20200427125915.88667-1-carenas@gmail.com>
 <xmqqftco94wx.fsf@gitster.c.googlers.com>
 <20200427191858.GB1728884@coredump.intra.peff.net>
 <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> -- >8 --
> Subject: credential-store: document the file format a bit more
>
> Reading a malformed credential URL line and silently ignoring it
> does not mean that we promise to torelate and/or keep empty lines
> and "# commented" lines forever.
>
> Some people seem to take anything that is not explicitly forbidden
> as allowed, but the world does not work that way.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-credential-store.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
> index 693dd9d9d7..76b0798856 100644
> --- a/Documentation/git-credential-store.txt
> +++ b/Documentation/git-credential-store.txt
> @@ -94,6 +94,10 @@ stored on its own line as a URL like:
>  https://user:pass@example.com
>  ------------------------------
> 
> +No other kinds of lines (e.g. empty lines or comment lines) are
> +allowed in the file, even though some may be silently ignored. Do
> +not view or edit the file with editors.
> +
>  When Git needs authentication for a particular URL context,

I like this.

I do suspect this is easy to run into accidentally.  In $DAYJOB (in
the context of [1]) there was a service that accidentally wrote a \n\n
at the end of a line that was used by git-credential-store.  Once the
cause was tracked down, it was straightforward to fix, but I don't
like the idea that others in a similar position may end up tempted to
just not upgrade Git.

Independently, there is the thread we are replying to.

Independently, in Debian's bug tracking system, Stefan (cc-ed)
reports[2]:

| the vulnerability in CVE-2020-11008 is related to the handling
| of credential helpers in git. In Buster this has been fixed in
| 1:2.20.1-2+deb10u3. This broke my existing configuration where
| repositories have credential.helper=store set. This is
| documented in /usr/share/man/man1/git-credential-store.1.gz
| and other files from git, git-doc etc.
| I am unsure how to proceed... is this helper now unsupported?

(Stefan, do you have more details?  Did you manually populate your
credential store?  What error message do you get?)

I wonder if in addition to the above documentation change we may want
something guaranteed to catch all cases where people would have
experienced a regression, like

diff --git i/credential-store.c w/credential-store.c
index c010497cb21..294e7716815 100644
--- i/credential-store.c
+++ w/credential-store.c
@@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
 	}
 
 	while (strbuf_getline_lf(&line, fh) != EOF) {
-		credential_from_url(&entry, line.buf);
-		if (entry.username && entry.password &&
+		if (!credential_from_url_gently(&entry, line.buf, 1) &&
+		    entry.username && entry.password &&
 		    credential_match(c, &entry)) {
 			found_credential = 1;
 			if (match_cb) {

And then we can tighten the handling of unrecognized lines to first
warn and then error out, as a controlled change that doesn't lead
people to regret updating git.

Thoughts?

Thanks,
Jonathan

[1] https://cs.opensource.google/copybara/copybara/+/master:java/com/google/copybara/git/GitOptions.java;drc=bc79a0b1ffe18f79dea0b75ba3a24b641a50a9fc;l=46
[2] https://bugs.debian.org/958929

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A61C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiAKTxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbiAKTxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:53:13 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFCC06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:53:13 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d14so179331ila.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8S7ZkdH9FQUA5wlcmPANDkIjeavL3QW0WxEG96CYio=;
        b=uzPuSnMd9JvGeGziEVffznMAe4sbIBGn+dhb+0LLKDcAUScZdesHlmJuecdCG8z9GK
         BIP2OvuhaaMhu3nzB4YpZMf24cL0GHE2tmXZ8d+VG6mFNxoJnfEKxGw5lH4KqbH7uSJA
         hfRGDM15hf0QKIE3rCK7ZQEcPcz0uGKnHLuL5PtN/vpUE/5RZHjjUxksxUSHEjd5MFXD
         vRB0Lma1OwImWzdftcyNEiKkE8pZxE8GMjhGtG6Pjx9QPqcPzKaAEygbN/I94UfQYP+/
         Rmdng2NDfbiFPv4h3xpdVTFHkxQ1JDvEecOwRARZaL7U7iFzbTjZh2G0Ht+Cd5E/AoFu
         qy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8S7ZkdH9FQUA5wlcmPANDkIjeavL3QW0WxEG96CYio=;
        b=Psuz+WApJ7hX0gJO0juDBifqt8bfkphQ+dQ+qsHjHAgwj2hiTfCVjZiAxkvqYDQUvg
         lxERYIMwoJ1fAGsHiB77WZEUjA/u5AayoPOrhrGM++TNEtAvqHYJ+xl8DmzQIadPRNuO
         howQSSPgvc4KJpaDA5iZRRjY95HmsUwfJwlGy00rqs3bcmSly7GH1aBfIo0MmOU5ZGU/
         VK/KBjm685/LviO3lGp2GjZldmBWbBTYL1iHnrfr+nNcEtfqCZSwHsFbizBVpcbB25u/
         3bQg+NoM0E3vwJ/nru7ac2ZxeRHL/9LLkaICZ5KKhTPH+PwdaRVR6CenIAaj3+4/iQZ7
         gxAA==
X-Gm-Message-State: AOAM531SO++KN0u9kO5Uj/0odEOapC4LR8WgQ+jFeDgHNI/Aw+6QX/P6
        oafrAJ/Z3Ju0VguJebycPqSCwbrVbws7CA==
X-Google-Smtp-Source: ABdhPJzs8mAgnD922ZocEaOvMel7SKHxbwUVyo5to94Tq5Z7gr/45V0BrKoTusddNk+PY+ikoslHfw==
X-Received: by 2002:a92:cd8e:: with SMTP id r14mr3256683ilb.259.1641930792509;
        Tue, 11 Jan 2022 11:53:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v5sm6338705ilu.77.2022.01.11.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:53:12 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:53:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [BUG] Re: Git 2.35.0-rc0
Message-ID: <Yd3gJ6C3jU7ZZskc@nand.local>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
 <Ydzw+RqR6IfbT/oM@nand.local>
 <010b01d80697$0c848770$258d9650$@nexbridge.com>
 <Ydzyv8ZCEpDDRBXT@nand.local>
 <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010d01d8069e$8d330480$a7990d80$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 10:51:39PM -0500, rsbecker@nexbridge.com wrote:
> I now have a different issue:
>
> make -C t/ all
> make[1]: Entering directory '/home/git/git/t'
> rm -f -r 'test-results'
> /usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
>
> Is there anyway to move to xargs? I am not sure why /usr/bin/perl is
> having issues with the build.

Tracing through t/Makefile, I am _pretty_ sure that this Perl invocation
comes from the test-lint-shell-syntax recipe.

I wonder if something like this would do the trick?

--- 8< ---

diff --git a/t/Makefile b/t/Makefile
index 46cd5fc527..d959119133 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -90,7 +90,7 @@ test-lint-executable:
 		echo >&2 "non-executable tests:" $$bad; exit 1; }

 test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T) $(THELPERS) $(TPERF)
+	@echo $(T) $(THELPERS) $(TPERF) | xargs '$(PERL_PATH_SQ)' check-non-portable-shell.pl

 test-lint-filenames:
 	@# We do *not* pass a glob to ls-files but use grep instead, to catch

--- >8 ---

Thanks,
Taylor

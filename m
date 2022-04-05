Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F1C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 01:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiDEBKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 21:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDEBKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 21:10:37 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DAD183AA
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 18:08:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id hu11so8900642qvb.7
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 18:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=263yfn7jXQt3ArGJ57p0zMwD5Mc7RT/TwdKVnF4zJIQ=;
        b=O+rDCzEFJ0wW+1nIJTYsj7iSIFFYLiE6t6YDjEsbcpWQHyRz3EHnkLSncY5FqHg7OY
         gTowVyvwJ9w+vWYrdyh/vH1iLleM6JZvLw9GoMfBbYR/LdtLsebTBGGa0eOmY6242otF
         BUQkbdLzOvCcgLNfOkkbdRwdsODTtGk/P/D6nAxoU/Y44egajj0pte//ZErIsIfkV6hR
         UWoNzHZ9IdlhwFqFTAdj9xLq+GhWdNxdU0aFtNmUFYlPoEnnHmUckAY/80n86veDiqk9
         sd0cb5B814w4oAJU+gVjbDO4lV1XgQk8dJAeBORenGvRf9UkwkgLVmG1JuPtN0Ak8mzy
         cOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=263yfn7jXQt3ArGJ57p0zMwD5Mc7RT/TwdKVnF4zJIQ=;
        b=yknQlNWiOUKCoKo/M2ml7GDgK+4ZCv2KKz3OjVngFT8RgyjTSKaOk1cyFlj/brl/C9
         jzg9Vc7WtfT4sAkiTdj6m7E7+J/FK0eSB8U95FnGxGV+bXs8TC9YRbpGsy9APR3FhRwM
         a6EARcZklDeeBQ8g5891hCjc5a+gYHLG0Cpu1VdQ4s+5CI7++ByTpGII5k9TrxyR1NSd
         QeomRkEPFSSqC9mY8T8yrdrRRVAVgKCSx/Mazuc4FUmk7417pO5QslpRE3dZHlACSWmU
         GqMcwtF1+UGaHnybGe+P2kdhLixD3rR57KfIuEDhmVNI96lxfp73KYrDD2yF6Qi0WzN4
         saZw==
X-Gm-Message-State: AOAM5308Mm9dO53WAkOZFJxjKvfoFRr1Axj1LAFvv9x328vbWyr8RPZY
        95VUmt01GAD1Jpnylz5dZDtRb/yW8Ek=
X-Google-Smtp-Source: ABdhPJw7KnTNwiRWotw/TfH0ERHcEd23pH3YuCUipgCVCQ2xOFzyCmwnhENh8/C2Dx0PifjWXMgpGA==
X-Received: by 2002:ad4:594e:0:b0:441:4d5:6a62 with SMTP id eo14-20020ad4594e000000b0044104d56a62mr879674qvb.110.1649120060323;
        Mon, 04 Apr 2022 17:54:20 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a010d00b002e1d653c2e1sm9690739qtw.46.2022.04.04.17.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:54:19 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:54:18 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Message-ID: <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
 <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
 <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
 <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 04, 2022 at 05:26:10PM -0700, Carlo Marcelo Arenas Belón wrote:
> On Mon, Apr 04, 2022 at 06:40:35PM -0400, rsbecker@nexbridge.com wrote:
> > On April 4, 2022 6:33 PM, Junio C Hamano wrote:
> > >To: Randall S. Becker <rsbecker@nexbridge.com>
> > >Cc: Git Mailing List <git@vger.kernel.org>; git-packagers@googlegroups.com
> > >Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
> > >
> > >CSPRNG_METHOD?
> > 
> > We already have
> > 
> >         CSPRNG_METHOD = openssl
> > 
> > In the config for NonStop. Should that not have worked?
> 
> only if you are not telling your openssl to hide that function[1]
> 
> Carlo
> 
> [1] https://www.openssl.org/docs/manmaster/man3/RAND_bytes.html

neverming, it seems we forgot to track this header somehow, so will need
something like (untested and likely to need changes to support NO_OPENSSL)

Carlo
--- >8 ---
diff --git a/git-compat-util.h b/git-compat-util.h
index 4d444dca274..68a9b9cd975 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -525,6 +525,10 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 #include <openssl/x509v3.h>
 #endif /* NO_OPENSSL */
 
+#ifdef HAVE_OPENSSL_CSPRNG
+#include <openssl/rand.h>
+#endif
+
 /*
  * Let callers be aware of the constant return value; this can help
  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,

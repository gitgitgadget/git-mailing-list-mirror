Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E206C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8069861006
	for <git@archiver.kernel.org>; Thu, 20 May 2021 20:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhETUmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhETUmv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 16:42:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEDFC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 13:41:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i5so12715521pgm.0
        for <git@vger.kernel.org>; Thu, 20 May 2021 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFkj72JFi3MzxNLx9juSFVeBetET4VTtf/n44Jd/NSU=;
        b=g/ixQlF7xzDAuiE2tqpwGZ9iG2hLEMD+vjroJXPworueTz8QGkY+aLKdSfDYkvgwDv
         0ylNtuxJjZ01hSQJEosMwnntX1VJtVTmWGLbIgP5/KKwBev9xcTnVQEGwJsgTI8Mz3Hv
         XsyqLbu1hukGRvwAA3mLgBh7ep39bCEXGvGGecgYs66KVYdxcUwK0ui8NUakfPEGXwg2
         K0yh9Fp5QVhpfIdFo4oinaGA8Cokykrlfsc6ZdFouQt+/r27WtRMR6vmztddZcuAgkZu
         GJ5y7567CRitlhIv0XHsWQwNtv3dKaW4cLu+05y9dB5p6ov+q58AHg2umNFE2JPelVId
         v30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFkj72JFi3MzxNLx9juSFVeBetET4VTtf/n44Jd/NSU=;
        b=VE0/6lTF9RNF7UlaUcAz2GUeoacC//NTIB+K1P4ssoBH9OSSBCOxu03525JONzgnSO
         fMEDx/eadAH5FfcUqpf/1zXlR9+sCrYd4O4q7XSYpJtahDOBjt8e1SPnDdzyRPbVrlFo
         sOqTKW8hnZdSs0bJUPliurjhlCXFDswrT+9453nvfSh5N//f3+LGbXkmZZ9DRtjDWFjq
         tu2WMwtsz+IV+0WY0/9d0g1jDQHqlOLH8d8G94BXM+sQOOIw9bMYfVcf1UroDQXBrMdY
         pkzwcjOixh/Et0ANezR5RoukLbfPf+WDyMdjHgRPFeiKbfkRrI/swsdAv8t1MHLnm9s+
         gFVw==
X-Gm-Message-State: AOAM5325ihcNuVOE8EL41z8gPph7bbJtVOexnv2qVgw30zlkEFNSgKvy
        Z32jOPL3huM5GkjD7lq2PQk=
X-Google-Smtp-Source: ABdhPJyFTsdznfdLG++iGX6BVABuQ1j8wlJmw60KxCr8XkbbibPCwVWMkWF4KPn80YpdBfKCn25imQ==
X-Received: by 2002:aa7:8186:0:b029:27d:edb:c65a with SMTP id g6-20020aa781860000b029027d0edbc65amr6217987pfi.68.1621543289261;
        Thu, 20 May 2021 13:41:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ec75:d356:9cf2:6ea1])
        by smtp.gmail.com with ESMTPSA id h26sm2680068pfk.19.2021.05.20.13.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 13:41:28 -0700 (PDT)
Date:   Thu, 20 May 2021 13:41:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Siavash <siavash.askari.nasr@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] git-credential-netrc.perl is not built and is not
 available in `exec-path`
Message-ID: <YKbJdiMNGaJAls4y@google.com>
References: <87k0nt3f8i.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0nt3f8i.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Siavash wrote:

> [Subject: [Bug] git-credential-netrc.perl is not built and is not available in `exec-path`]
>
> which is located in `contrib/credential/netrc`.

I'm missing some basic information:
- what platform are you running on?
- what commands did you use to install Git?
- what are you trying to do?  That can help us with understanding the
  problem or giving better advice tailored to the use case.  The netrc
  credential helper is mostly meant as a demo, since libcurl supports
  ~/.netrc on its own already.

Thanks and hope that helps,
Jonathan

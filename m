Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF27C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 00:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiBIALw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 19:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiBIALu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 19:11:50 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC23C061576
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 16:11:49 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 62-20020a17090a09c400b001b80b0742b0so486274pjo.8
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xe2aqC2nFlzz2hqY8X2etPILyRykX++y98Dd9kdcviA=;
        b=rYk1MOQOQVqQQSl0ZC7VMrVQada9uHpTF5hdrXIlmGg2e1alJ48FBIlmTwy+r9tolS
         /oX3DGlRpLGA97XEAkxLVw3i/jP0UHND//lGPJ+OkR8jtABfnmCUbE+843Wtcd+iSGQ8
         jyNz4Wcj2IclWvcZ2UFkekFYAoGsFLUxI5X7ohNXiWRiaRbRridEAU95u6q3pxq4BVFo
         rL6uDIvV3cmAlW5JVIZYnjNOBO3thr+3eUxtlBoY4VEgx9gSd4V+jVGCuPWKI4T64J28
         B1w1QPBaoPac2tgeYv4TGKqQ111LM81QUM2wPJWLGRH739WwDCF9ewusKpdGm8WW/inW
         YOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xe2aqC2nFlzz2hqY8X2etPILyRykX++y98Dd9kdcviA=;
        b=m/+9lOsffK+d0pWh2RBTTQLhimoG/YzLnk+3xa9g7+WxoiUbh0TCnIJfyJV2A0w8Qt
         kGEflbPfd15Op8QnvpcVxMmZKzTULdCe0dgO2iPBnZTCOBxlEzs5Yh0ARrE2FI5KX9zi
         k6/KtW9NjCyUJhZyo6cgDfBCbflzuPr4NY/471r9QsK997PFt+fM6CWBh/+S/XN7smr8
         9/T9D3wGWD8XJwrrYr9KuJ0ezFLPO2OCSEWWtYRx1pf6/xfNh5dPSuXFvmW21wtRrJMd
         GiNPgurwowT/VqJorkO/mORuXLNYoz+jYhvue22l21UUDna4vfs24fC9QdgsKhMRTYhl
         X+HQ==
X-Gm-Message-State: AOAM532JzTvAPrRToh+7hIwOD2LV1RTQxwnwc/irHm04yQkcQ5hHqn65
        Dq/OKZQN1mdt/hnAjumdJq82NlnAaum8NlkRpXwV
X-Google-Smtp-Source: ABdhPJxhsY3blouJsRm7fN6S0B2cslFV/Y4Z7xwD/Kx1y1yNIrocioFgxas71ikDe/ZT/JzNG9FCyiuQv0yWxYro6wOR
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:e40f:: with SMTP id
 hv15mr140772pjb.1.1644365508343; Tue, 08 Feb 2022 16:11:48 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:11:39 -0800
In-Reply-To: <xmqq5yppdyc0.fsf@gitster.g>
Message-Id: <20220209001139.326834-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq5yppdyc0.fsf@gitster.g>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johncai86@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> I agree that it would be ideal to have just one way generic and
> extensible enough.  I do not know if there are much difference in
> that area between the two approaches, though.  The RFC I saw did
> look more complex and rigidly specified with framing and such, but
> that is only the syntax part---in the way in which interaction
> between two processes happen, I didn't quite see fundamental
> differences.  I'd expect it wouldn't be too much trouble to add new
> commands to code written using either approach (although I haven't
> seen yours yet ;-).
> 
> Thanks.

It is similar to this approach, except:
 - the approach I sent out uses pkt-line, which might be difficult to
   retrofit to cat-file if we need it
 - in the future, we want the Git side to be able to initiate requests
 - (possibly minor) it may be confusing if we add functionality to
   cat-file that is not about reading objects

Other than that, yes, they are similar.

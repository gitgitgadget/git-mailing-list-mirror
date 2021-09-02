Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7EC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC26C60F42
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbhIBJLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbhIBJLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:11:46 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D25C061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:10:48 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id x137so873749vsx.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv1ie5UWL9cMF4qwZvmwiEdD2LWxCggtQv3yUvZUzW0=;
        b=ZqeISKJaKuBFVLQTZ28tfFSP3roeqMSPxsOgLbZAx6eZRzSMtmcBuUHErPLjZXG6iW
         mEfkpGTAyscZNf5bLLD4MCDHcwZS7Fw5CytWTs4Ne9UySCtS0c5PcvmnUVCfxaVawj6b
         OuL72FZd4XqZuKsAePL/5E82/vWeo46usa2t+pQ8A9WVRnS9gL5lRH3hi3PDI6eT74NO
         nc/c2CpmbaAXginrbebfAbyvx+WcR+kh+ErysPAlvbP2Qiu5rDEaIEBObvKyYNnO53pO
         poxfHFsofxyxZxyxiu+pRW+WySfXYgv/gUZipN4RoNEaoa0OK3FyaRLvgNTsrEBGe2px
         Dr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uv1ie5UWL9cMF4qwZvmwiEdD2LWxCggtQv3yUvZUzW0=;
        b=s8Rv5JTA9t+s5YI6B6GiaRgn/W0DmXgqwkYWGFW2dQhuv7zvnkFCAbtbVLsMmdnDCE
         Ew95A5eOnhMnLy1nKXHxHs6NRJV/NeM+bK8YsOFDwNXuY6TuxgJ4/9qel6XNooPel4W+
         gncGK8xf4f9O1bKMDleWjHmAn3iIH+IsO5UGnsmrRBml8BqCMnOqCJpjOgqp4ryxHkV0
         JLi9HsFTWI4QQ1LRdK+bIGfTuTcomjjNnqLW1ULQMUb3ArgzgrI9/tlGSYiJl+gMcO2j
         bBEroOfMnSXQX18yuKP0S8clfrZndsKCB1MoOymjjwXbNR7diY4BqHFAbDHKz6BUByIr
         m2fQ==
X-Gm-Message-State: AOAM530BYhu1rzOOcTdYeSaKDPe5mNy2vReOlmokkZZjOM57Sa2SqyKV
        BnT8u+uhZEo8IXWTMkMwxnx9+Ep7U8kTdU08P2I=
X-Google-Smtp-Source: ABdhPJx3CD1Thlv5LmEetmHrxObG0ioEC0NChAaJpEYG3yNVivpJZgkWpdcBO/ETypHQRuS/r8edyjoj3IVbMfs71vc=
X-Received: by 2002:a67:cb0d:: with SMTP id b13mr1199871vsl.5.1630573847642;
 Thu, 02 Sep 2021 02:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210902073631.50062-1-carenas@gmail.com> <YTCO56kbtQbODDeK@coredump.intra.peff.net>
 <YTCQ5aJXPMTUpKs8@coredump.intra.peff.net>
In-Reply-To: <YTCQ5aJXPMTUpKs8@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 2 Sep 2021 02:10:36 -0700
Message-ID: <CAPUEspjMbpbSvT=kVsnFgzTJKtPjU1EBo8cjgvrEqtfbeY4g3Q@mail.gmail.com>
Subject: Re: [PATCH] remote: avoid -Wunused-but-set-variable in gcc with -DNDEBUG
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you; definitely a big improvement in both accuracy and prose.

Carlo

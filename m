Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7E8C10DCE
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A9D2071C
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 20:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcJHbicu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCRUFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:05:37 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42680 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUFg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 16:05:36 -0400
Received: by mail-ot1-f47.google.com with SMTP id a2so6076859otq.9
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9lGITwNihXqOtrkuTrxZ9lqUye/oRcmfASmPin6nH8=;
        b=kcJHbicu9Fu9D45Fp4YYcHxBJNa9VlYmXw4VSaCliXCIs0FuEd1uMwAdPgbASs00YK
         sotC0xD7JbmAH0SqkjL/6RPNMjObAIMN9yNDK1Yq8D8cC3K+Az7tIBuphkpKZLZpw09r
         urXRK6zScBLmOrmWM0eB3i+wAB3QeJZvXcjkbEmxH5mbhZmSVvAna69pC0GiJ/AI4iBq
         Qm5MseW/K3aiwCy/UHwUk99i/l8h+M3y9NIbTH1nMcSl6/ocMXRS0owoFEopqamic4Bf
         BGzBR0+f7UeOKc+L0R2b2uKohbC6pCjKB09rjjCGUIqLW+ChaahUr/c76oyxe+P3rC2Z
         2PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9lGITwNihXqOtrkuTrxZ9lqUye/oRcmfASmPin6nH8=;
        b=DDYhAxItrDPQrDs0X7JN6mclUNSC0zGMwC8C+IbqD9eW0Fb2s8K4pKZPDSF/1rZhfZ
         ZvPjfXa/AED+RpTV4hxhIF7BRdWOr4IAz5X3GRgYb8Ku6y+RbPbCBt8UDqHh5/r66UGN
         Eetn2TPTwI1FzYvpLLXHsmiz22MBeH3tvv8YDtz9/L03R0eHKUk8766jMNg/cUMVm0v0
         YQ7bjMXW0jLCCmANQQ+WicCGSvAcscHvUecoMBmgjTA5XDjSEYbVCKyL/Rwwa4qMpZXc
         tb3XHwdN4d+1OgsCuDqTo/R1MZX5MkKFCQG5K4a3AqCbm23ZevACh0YRU6hLMxfF3wTN
         BJiw==
X-Gm-Message-State: ANhLgQ3lvvZTZycTXNpkN6DKUynMaDhPb//VwX45SCYjWInOm8Bga3+H
        CwZ8I+6oJe0RtSQ0XjXYMUhjp2V2fIEmJWTjZOQ=
X-Google-Smtp-Source: ADFU+vvJEOLaENTwUiIRdWh9stocCOEQQkRii4K2T9m0hs/eHnjp1dC71Phc/XOZQwnehIYfauCEUr2ijEos3ycnanU=
X-Received: by 2002:a9d:720a:: with SMTP id u10mr5053829otj.177.1584561935969;
 Wed, 18 Mar 2020 13:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACuU+s9BsWVCMXpp6KgJ-NaDuadcegZ2kVSMmuAYO9YquTK8LA@mail.gmail.com>
 <20200318192719.1127-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200318192719.1127-1-shouryashukla.oo@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 19 Mar 2020 01:35:24 +0530
Message-ID: <CA+CkUQ-gRMR2Q2ZCB=oa0mUV9fxtPKAfnpeG+mPZU_PqPKXVbg@mail.gmail.com>
Subject: Re: [GSoC] Microproject for git
To:     harshitjain1371999@gmail.com
Cc:     git <git@vger.kernel.org>, shouryashukla.oo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harshit,

On Thu, Mar 19, 2020 at 12:58 AM Shourya Shukla
> I think you must know by now that we submit patches here
> via the mailing list and not pull requests.

I addition to what Shourya said, you can also make it easier on
yourself by using GitGitGadget, which takes out the pain of sending
patches in the required format via email, see
https://gitgitgadget.github.io/ for details.

Regards,
Hariom

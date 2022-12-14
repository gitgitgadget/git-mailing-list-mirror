Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F86CC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 13:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiLNNg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 08:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiLNNgY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 08:36:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D326116
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 05:36:24 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d3so3316486plr.10
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nkBFwgT9L+6tfNxKEvrcOGRBS2KYtf99uk6sPX2agU8=;
        b=fDIjI53CgZpMbbC/drc6uSy1zgKhPwvNyOD9LgB+cgNyooDdAo62uR4ejQ4eQpnBho
         ky8xUV6taFE9oYRhBShNaAuYaDb0LIbH92BEPPiSmRfkkoWYnrPJNfCbJJbRTSp/B0Ir
         RqWiD+W/UmAYi68W3YBJvQhR03Fw+T2XJTXCFYoaB1NfsyVYmK7k+a/JyRmhhbVDl+CF
         23glivIQW3TOp+1Ia6cAps31ES3MYCxv677ZMcLWUU7hCucGXH75OTkIUJXAzjXjib3U
         /XtssmZbOC1Y8UEMTMCCMVFc+HmkZl6sLuZLnvSfjp5B8tgPyqQi8kNnYg0z6ronB/+X
         /QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkBFwgT9L+6tfNxKEvrcOGRBS2KYtf99uk6sPX2agU8=;
        b=ZEmb8Yh6gWZCoB/5zyKP6YLBqmb6BxaPsFgObpdGjU8YqU1LhYnnaUnUroBNsqpmuI
         ryhgOjUcsag5T9oIQTIPt8YBzmkvnC5yK2OHtFEZt95k6L9JqM/HDsNVJD2t1UkheBTi
         TnEb3xauEaWrG0znLNF7LiG359q8vy2RP9W3ajsEJmx8/qOJCwgAcBIUymRWH+45qZZW
         zq1iomIACRmAsdeI3IqROnhow3xhx8WW77OdcQQNL4cOvdglPzWYoD7lf1ksQrpBIVBJ
         2TZLCEzN98zRD+v8pY91eLv2j4Q116LAkVBxK4FWvrHm8wO+KSLe3EmMMk4skJKhTcpL
         zlBQ==
X-Gm-Message-State: AFqh2kpbIbN6lxd/FjNsIWVvRJnTK2nRRbFI5CcKn/wwhob+mX8PaqTT
        jhtgPFs3r1nWMZWhlcJPIgce2lM7wHt753Lo6GlVQYTTa6WSYQ==
X-Google-Smtp-Source: AMrXdXuii7JaxpdFT7XhiNA3zJ3p9Xj7v5yNuArUPuRI3TZf+vhGI45YowP8QPPeN5op3sewcraoAz9YarZpalsTp9M=
X-Received: by 2002:a17:90b:314b:b0:213:df25:7e8a with SMTP id
 ip11-20020a17090b314b00b00213df257e8amr354236pjb.154.1671024983065; Wed, 14
 Dec 2022 05:36:23 -0800 (PST)
MIME-Version: 1.0
From:   Niklas Volcz <niklas.volcz@gmail.com>
Date:   Wed, 14 Dec 2022 14:36:11 +0100
Message-ID: <CAGWBhH7ZiU_tJGj_UAB29v9Eq6C2Q-1_0YxLLN16LaEOcuV1Xw@mail.gmail.com>
Subject: Whitepace parameter for git restore
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a way to pass apply.whitespace when using "git restore" like
how it is done for git apply? I believe this might be a bug/missing
feature.
I have apply.whitespace=fix in my user git config. This usually works
fine but I was working on a patch for a project today which is using
tabs and spaces which messed up the commit. In order to avoid
cluttering the diff with whitespace changes I tried to remove the
whitespace changes with "git restore -p
src/the-file-with-tabs-and-spaces.sh" but it seems that this causes
git to fix the whitespaces again due to the configuration. I worked
around this by setting a repo local config with
"apply.whitespace=warn" but I wonder if there shouldn't be an
--whitespace flag for git restore like it is for git apply. Is this a
bug?

Best regards,
Niklas

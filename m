Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02922C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 13:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCSNLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCSNLp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 09:11:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FCE1F48E
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 06:11:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y35so4059045pgl.4
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679231501;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGZ97Ht04k2SfTtShEwMxY1CVD1dtqqlIGaAHCfKKwI=;
        b=SCYMzlgO36bxfMLFvD80Rwww7+njIJ6bvnD+slNA7QEnHtmm7Ls1mhZOiW668KsZER
         E9fPwSox4lRgs9OIhPGVsZOC9Wy8WL9aIhOQ1WOq5z9AE8ojRLGYYoSWRjnILQ6F+uCL
         0NmhSYHlrxf5NnI+VpUdbaAP+bGafWsd9Htj0CN3XzeLY8bJ98dN2EcfQ/QFQuFoX0M2
         BT0xdf5Z9oYCIzpvSI9e2SbMcZwSObUbIRjirsTaW499acCMnQiGpb8O0jM7elYNE3uQ
         8+MKlBG3JkOBgvyGFvF+xFAvOCTqL39GtxbdhjA1KklsqKRX0bBNB437+2HntOp55G2T
         7BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679231501;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGZ97Ht04k2SfTtShEwMxY1CVD1dtqqlIGaAHCfKKwI=;
        b=QvZCIpSF6TZknc4Dj+YkKPfXUSLegYjmhaG359Bsl5aBC7Nn2BO+h/9QBuMdJz2o6Q
         o8KYl83y9vq5pFNCNoD+kXV7CpD+vmfOrzOczrvJWmWD/+s0zKdAdyLnH4hLOrYVzcUL
         tZrhdTFH/SBLWt7rfc4CycmcJgph0E5Ny5GdLYTXSzwTGZBgccGdxB81Z4ELgM331mTF
         O7euPORbW1NtGY796aj1ojKKu16uSE2qkCxk3i9rWqNEfPfr5EOb+gBpoFEOqbSb/wYD
         GRpB/Bygh9Ejn1/+BEAwrH0wCytL/U5t+w9ssFkZjjiNGv9qUE/N9Y1YCvWcUP4PJNl0
         XX9A==
X-Gm-Message-State: AO0yUKUWCNV2S+CnxHYLG0mPG7k2eGBvTdx1Y3f2ug32Nn17rCsf3Wp9
        nGHcADEZONQdajfyAFfYCuQ=
X-Google-Smtp-Source: AK7set/MJ38RwpZQbxGA+wgo6v1sv5YwmIKj+qcQrx98Xg3wn4WYVfrOR7irzmy4TJooxtS+roxXPg==
X-Received: by 2002:a62:1d8d:0:b0:622:749a:b9df with SMTP id d135-20020a621d8d000000b00622749ab9dfmr10942343pfd.3.1679231500857;
        Sun, 19 Mar 2023 06:11:40 -0700 (PDT)
Received: from Developer ([14.254.246.167])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b0059442ec49a2sm4694939pfk.146.2023.03.19.06.11.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Mar 2023 06:11:40 -0700 (PDT)
From:   <sang.tts.designer@gmail.com>
To:     <martin.agren@gmail.com>
Cc:     <git@vger.kernel.org>
References: <000801d95a56$e9253f80$bb6fbe80$@gmail.com> <CAN0heSqEH+AtzXcybPY-Jd-bRtgtKmGrfxbXL-adsvjr_srEZw@mail.gmail.com> <001d01d95a63$f1fa38b0$d5eeaa10$@gmail.com>
In-Reply-To: <001d01d95a63$f1fa38b0$d5eeaa10$@gmail.com>
Subject: RE: Bug Report with Git Bash
Date:   Sun, 19 Mar 2023 20:11:36 +0700
Message-ID: <002601d95a64$57312bd0$05938370$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHl4PFjS+RqS8CpTVhw3ZGG/+gRxgJP7KFgA4RLNfuuumSXUA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Martin,
What a very quick response!
I just tried your recommendation, and it works.
There is no word that can explain my appreciation, to be honest!
Thanks a million.

--
Thanks and Best Regards!
---------------------------------------------------
Sang Truong Tan=20

Department of Electronics
HCMC University of Technology
Phone: (+84) 977 600 563 or (+84) 908 983 574
Email: mailto:sang.tts.designer@gmail.com

From: Martin =C3=85gren <mailto:martin.agren@gmail.com>=20
Sent: Sunday, March 19, 2023 7:28 PM
To: mailto:sang.tts.designer@gmail.com
Cc: mailto:git@vger.kernel.org
Subject: Re: Bug Report with Git Bash

Hi,

On Sunday, 19 March 2023, <mailto:sang.tts.designer@gmail.com> wrote:
This is a relatively simple bug. when we double-type a command, like =
'ls'.
However, in the Ubuntu environment, the command only occurs once when we
press the top arrow to use the prior command.
It is identical when using git bash.
Repeat these steps:
Type "ls: in git bash.
2. Type "ls" once more.
3. To return to the previous command, use the top arrow.
As you can see, the number of times we type the can command 'ls' does =
not
matter; it only needs to occur once.

This depends on how your shell is configured.

Look into HISTCONTROL and ignoredups.

You might want something like

  export HISTCONTROL=3Dignoredups

in ~/.bashrc.

Martin


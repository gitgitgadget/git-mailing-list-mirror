Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A0C0044D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC74E20674
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrLt8uek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733036AbgCQAnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:43:11 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46206 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgCQAnL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 20:43:11 -0400
Received: by mail-qv1-f68.google.com with SMTP id m2so9961019qvu.13
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 17:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w2dI4fQrn++J4EaKWnJhDGlcCP1sXmZ6CpOBQwxD8/I=;
        b=XrLt8uekcXKGThCm+xkRAn5baccqCq/6lbG9JQc2+wm7W7vgnlyI+BlBhCAVKSij9+
         GbZb/VOFvUoelAeuvMuHCRg+2trvl6ilAfHnrBVnOlku9+bOKdPgGy74Z16gZdk4lAMz
         XBhm2YXDJmYCkIO9Ak0Pg1lUGCJHK88qWMOFcU1Yxw9oThhneXN+F0yNdpTIQJfBHOEc
         5AcKXiEra+UHKeG03yV7eQWVYKgFMKBiuac0i9ct82rtFB3ij7LACWhbGxNK3mLE2BRP
         uhf71XjnGEfohnbVggFXkgyvJSnMbrKqOQuGmVunOyokCmixHsB0vHetgxb41Kz01viJ
         4Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w2dI4fQrn++J4EaKWnJhDGlcCP1sXmZ6CpOBQwxD8/I=;
        b=hwZ8bG99ArkCkFyyFkBuBO3JImczMmOKp8sOuzMo6KHAU6y73avzp6o1cg0yIwLKjy
         RnbZc4308uS0l58rdm92iCVR9nLZzthjjinTeszSuYvQ/d8Ts+oINETKrXrRHEg/vL3a
         +91a0GedsHxQMoYIEvOcdmT6Nn6Jk2pu0yq9RObJU40/YWZtcsfyk0fCK7srwWxFWLn+
         4maZSitPUFeBzu8842pDEkjtTxMCqXfe4P2oRarxgSd2X1jS8EW1slrvYvLvRyoSoQQa
         7PlvWlrt6NYSBRJjIouIBgEbdjNbXB5p4TD83sbS8qxW3cs5mNt1LZeJECN5LruCIFHE
         a1wg==
X-Gm-Message-State: ANhLgQ2mZyI8MymbphE/RZ67LO47a6egq+pEB/Kt2xRdHtFO1vYg0Pf8
        TmN1MWd9SeqAI9CroUgnG1Q=
X-Google-Smtp-Source: ADFU+vvK1K8IVtq6OxzfWEbRtc6y8gjmUE00b4Hm98C+srvSv6487psVBkAN+6u3i9irkHJqZ3XmWQ==
X-Received: by 2002:ad4:4d0f:: with SMTP id l15mr2563520qvl.71.1584405790750;
        Mon, 16 Mar 2020 17:43:10 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id f71sm953055qke.57.2020.03.16.17.43.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 17:43:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: =?utf-8?Q?Re=3A_=5BTOPIC_16/17=5D_=E2=80=9CI_want_a_reviewer?=
 =?utf-8?Q?=E2=80=9D?=
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200312133127.GK212281@google.com>
Date:   Mon, 16 Mar 2020 20:43:06 -0400
Cc:     James Ramsay <james@jramsay.com.au>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73783776-C6B3-42FE-B8F7-2E43BC175B58@gmail.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au> <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au> <20200312133127.GK212281@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

> Le 12 mars 2020 =C3=A0 09:31, Emily Shaffer <emilyshaffer@google.com> =
a =C3=A9crit :
>=20
> On Thu, Mar 12, 2020 at 03:14:25PM +1100, James Ramsay wrote:
>> 5. Jonathan N: patchwork exists, need to learn how to use it :)
>=20
> We've actually got a meeting with some Patchwork folks today - if
> anybody has a burning need they want filled via Patchwork, just say =
so,
> and we'll try to ask.

I just read this so I don't know if it's too late, but patchwork does =
not cope well with how Gitgitgadget uses the same email address for all =
submissions.
I reported that here:  =
https://lore.kernel.org/git/75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com=
/, but haven't opened an issue yet on patchwork's bug tracker.
I'm not sure either if the best course of action is on the GGG or the =
patchwork side, though, as perJunio's suggestion in the above thread...

Philippe.=

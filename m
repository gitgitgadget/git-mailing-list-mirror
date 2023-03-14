Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2417C6FD19
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 02:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCNCBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 22:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCNCBT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 22:01:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F22D15B
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 19:01:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kb15so13925243pjb.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 19:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678759278;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nJXZ3tcVAR2BdTEZoxh01ljXyanckskUakLQVUZw18=;
        b=fhfipcbw0yFD2Frwu2VWzC0QA4sGJL34iay66/EwQFMlHusB8qUp4EkH28Jd/uxVaU
         t1r6YIqs2xkb+GZc+pvMvEj1ZiZcrebSJ5R8TxUxNpyqLkaGknr9w05CV8PgNsGAiX68
         fdnyWonIQAYTwQro34VRFVs7s8fggTr6uDZvMePDzukanGPTwYbl72UO4h0KM13kOKR/
         tIhqKF73JJ7l212LlU6z7+vBKdUqyii0n29q9WnaCGsWWce+MOn2eBc2jVKFmqEOsSMV
         imilQbydrA0fIRdYbmRwNVYKBqoPjquVIs17WAwo7EwTO9EPNXjwkR8BkU73Yofp5oYP
         z6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678759278;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nJXZ3tcVAR2BdTEZoxh01ljXyanckskUakLQVUZw18=;
        b=gSaK1VBng0ocL/WWtMDirMNeAHgD7LHnYRo7FMIMP1f3sAw2NgA2b9NJREzI6TpZ3E
         wiPywELO6cjfuPdUIVUF8OkJ74WQ6ZXcBJLaMA4cixdtOJk+hMnPTULTC4HhnXsPjX2t
         NQcuJrJeW5JZOW+VOnUFq84eJxcUVga2vcWDGR59Gu46QlO3lRIl/BhtSVX2l+JqTj4+
         IIYYREErk5xyu4tt+RTLvPdiurqwNDnEiLvjNExpajV6r6J8Z76WaggU83bxzb2UhUSk
         kXFqA8e5OApw2vWYgLwGBJfMWYoOcpg4e7M8HXliH7O2MSBGVDlKnGC86aN5G0a+i+JJ
         fv+Q==
X-Gm-Message-State: AO0yUKUDORl2WiLn2cTJ+qITN9YZQWOuuTxhb5NcJ3Yblsb/UuWCqOvq
        s+1MlBSiUuLWV1jrKLUYxHZihNOcX1fzn1VvM9u0HvO6
X-Google-Smtp-Source: AK7set8SDgeu60GxOHYN3+tQfOvqZ5ZhOZIbcub2W/iqrK+E2r/SQ+UHkzfJkjq3SgcoLlftTJ0gBciY75LV5U5ctwc=
X-Received: by 2002:a17:90b:3889:b0:233:c921:ab7e with SMTP id
 mu9-20020a17090b388900b00233c921ab7emr4830419pjb.4.1678759278039; Mon, 13 Mar
 2023 19:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <CA+A2caFjpWZ_UqZx8YOOTxsYDWWxrXfapPBaNdQGdEX+m9GEsw@mail.gmail.com>
 <ZA/LCF7R6GUeW2H6@tapette.crustytoothpaste.net>
In-Reply-To: <ZA/LCF7R6GUeW2H6@tapette.crustytoothpaste.net>
From:   "Edward J. Ouellette" <ejouellette@gmail.com>
Date:   Mon, 13 Mar 2023 22:00:40 -0400
Message-ID: <CA+A2caGYwRfVMJaNJsQ0Egend_RkU7+L3hZyNyhTUyj_e_E12Q@mail.gmail.com>
Subject: Re: Bugs in config of Git-2.39.2-64-bit.exe
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Edward J. Ouellette" <ejouellette@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,
Yes, I'm using Git for Windows. I appreciate the link to their issue tracke=
r.
Thanks for the fast, helpful response!

Ed


On Mon, Mar 13, 2023 at 9:16=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-03-14 at 01:05:47, Edward J. Ouellette wrote:
> > Hi,
>
> Hey,
>
> > I just installed Git using Git-2.39.2-64-bit.exe on Windows 10.
> > Windows' OpenSSL was added to my PATH, and Git was NOT added to my
> > PATH even though in the config, I selected "Git from the command line
> > and also from 3rd party software" and "Use bundled OpenSSH"
>
> The Git project doesn't distribute binaries at all.  It sounds like
> you're using Git for Windows, which does.  You'd probably want to
> contact them on their issue tracker at
> https://github.com/git-for-windows/git/issues (after first verifying
> that this hasn't already been reported), since that would be the best
> way to get this fixed.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

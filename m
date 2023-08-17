Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C6C2FC22
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354733AbjHQTpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354802AbjHQTpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:45:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB4359B
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:45:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-525656acf4bso202734a12.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692301536; x=1692906336;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=15QQ5HO7WrSIhcjUfmm3ujaNwJQDdcQ44myGcSl9Tig=;
        b=PkzgVR42y/ynPzbvCLAMHEZjlxyAGX91tBtbdUcDg7GMnGBGXZ2Jx1qyYnx/gxup2W
         cb/9rPkAHg3pbJbbaesIHnm9Zvt7+jAnGgR5fKKJWiCPFsXM1YfxllnzBxBPye1CDXAS
         4PjQbZK0qSNAzwcSbTTkauZURHFqeeQnbAjbVd3kenMhWG5TkQan3rat9olF834d/ZKO
         vqMPQLcK790miWjBqWAkA9g9K5M9ymTwVNYs/xCivs//TWR1OZ7Re5xhytDORJQovgpN
         S5J7cc/ZmUM89S0RUhTmcDtGz/PZCqVnOO+c3I4n3LJ1wB3KiMnEWy6BdF7WfR00ADs2
         tgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692301536; x=1692906336;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15QQ5HO7WrSIhcjUfmm3ujaNwJQDdcQ44myGcSl9Tig=;
        b=PT0EGMZg5QOimx9afrbOOT6wBKlVcERpIZ7WVIkd5xDubehgOgC4chz9LsyHPWTM/z
         2q08hDobS0M+641UdEErqrkBsSuCOz5Vw0hBnG6Ti3q+/XuhFHbvhW5m5+TgSmu/dNWU
         Zlqm2GBqRnEdRw+hYjKZay2S0GrG/9IjWbijrPxZWXdoFTr/8FBcosot3G9ZAfjRXWZh
         1d+3HnQENP2b0VdHNosDUgFvBiFE6zA1SRIPukW2Tj00T5wq+4RB13/aSeKacDJwwI4q
         HEC9MEAQ/Tzy7SI43OPn0JR7KIa30xrbYlaGcxC2i/oN5mJVhucVhi966OaW6Uf2k/eI
         IEmg==
X-Gm-Message-State: AOJu0YyundEqb+YKn4xQHfngTIHCASVt7u7Mr4+MCyAF4HBAgTR0jY1S
        lxc0/+UD6+4c9cDGuFjX4xfPVLrLypAim1FKcxigEYWMu88=
X-Google-Smtp-Source: AGHT+IEXhqzae6lCOyxzBve1KQtddK/6+r56WKXYSbaTTKnGqK/yTeK/uOUQkvMifU67fyi7byGC9v+m2sccPXD3oeU=
X-Received: by 2002:aa7:c507:0:b0:525:ce69:b52d with SMTP id
 o7-20020aa7c507000000b00525ce69b52dmr410627edq.39.1692301535890; Thu, 17 Aug
 2023 12:45:35 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Patrik_H=C3=A4gglund?= <patrik.h.hagglund@gmail.com>
Date:   Thu, 17 Aug 2023 21:45:19 +0200
Message-ID: <CABtpZSGcL8hkk3HA3ECtt7KeLPOhuB0n7EKN1Tg5ZHpFBE0V0A@mail.gmail.com>
Subject: clone (single) commit id?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our CI setup, for reproducibility and performance reasons, I want
to be able to clone a repository with only a single given commit id
(commit hash). (Using 'git init' + 'git fetch' + 'git checkout' is
possible, but more elaborate/low-level.)

At https://lore.kernel.org/git/MN2PR12MB3616C1F2E97A18547740651DF9E29@MN2PR=
12MB3616.namprd12.prod.outlook.com/
it is stated that:

> Never mind, I see, feature exists but server needs to allow it. Sigh.

However, I'm not able to find this in the Git documentation. Can
someone point out how to configure this? Can this be better
documented?

/Patrik H=C3=A4gglund

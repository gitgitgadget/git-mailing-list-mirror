Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE62A1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 15:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfAQPrV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 10:47:21 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:50680 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQPrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 10:47:21 -0500
Received: by mail-it1-f181.google.com with SMTP id z7so2055384iti.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LdxnD7PsMJ+tVlrFmqluIvYL3erQnBle1e2HCQmRZCs=;
        b=B0h/V9IrL824AI5HYbP03I4ehn60Xu9IRMcIu39JwcQ7gUj62XMZWH8VF5DkBwu+GB
         X0VsCn1jGYxYjlQ66XeTYM7fuv9SoFmqRo8Nb0gi6b/R/To8lJE4S/j1p5FQckzs9vaU
         seUoZY2qQvzESdf4Am7kOCC3tG1R0ckkzmBSc0lcGxv16hDFm0iHKiGQ3v++dVQFaWiR
         F5y17427y86563T+OmBVyONJRF+zDcPnf06F8QpZ46U+DFc2e+VIsUyEZwgP0hGUXogE
         J7Mv/GZTOUDFlXNiOzCob8xuxWVw/L+8IM9T7F2agBfPCsrLC07lxVUUO2cDl8MGVNbZ
         N/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LdxnD7PsMJ+tVlrFmqluIvYL3erQnBle1e2HCQmRZCs=;
        b=QM7xXDdDLVAg8XaOE0crcgXVrERVCJft/3UzDLAug5uTqK9MAEzz4eMi+9LVlj1Ct1
         XxrfESHPd+3DWWgltkfTcaGc1VxfOV/9IMd5eCYYXGJ6gWELWI2rOovEkoDAP0p7hWtN
         AhZ9yHOdswuvtuzzMyEwr1Bm8s/ttUwm1j0J0AGMWbD9P9LRyzksS5Km/vllOrhPkF7r
         RG5/YLQTRHDUXKgBfvjpVTdN8o6KcqUssMKZ1UStTsgbQsgNO6cXjq+lLvlgQsejoouT
         0O6ydBfm+MtGxkxuKjYuZB8RXot8sib5l54vWVfUU8eQEIZa2s0o4qalaJQDgdySney6
         r5xQ==
X-Gm-Message-State: AJcUukf1UA0vdwS37iXDfnCREb1haHSosIn7h8FkCjfrt8so4ebcLLaA
        CAjbXwXKzTGrFQX9EpeKnb5GfGWnZnqgKia/Zux2csOp0/o=
X-Google-Smtp-Source: ALg8bN5a0LYDu7YiQEUvz1fMooMWemzRIX1OMYvaWOXJeYkH/W2cj2x8ZflB1tb7MuOWWkehH7PiN31R+O0Q/EOJBjI=
X-Received: by 2002:a02:40c9:: with SMTP id n192mr7692533jaa.78.1547740040369;
 Thu, 17 Jan 2019 07:47:20 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?S=C3=A9rgio_Peixoto?= <sergio.peixoto@gmail.com>
Date:   Thu, 17 Jan 2019 15:47:09 +0000
Message-ID: <CAK3b1G+88a=xfO=6wfRi1SMy3xtca2NcFyxuBLKwSifb_L9xwA@mail.gmail.com>
Subject: Change on check-attr behavior
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think there is a bug on the check-attr behavior of git when asking
for the "allowed-ext" attribute.  Check the logs below to see that
with version  2.20.1.windows.1 we get unspecified even the attribute
is there as you can see when asking for all the attributes.

=3D=3D=3D OLD VERSION =3D=3D=3D
> git version
git version 2.8.1.windows.1

> git check-attr -a test.py
test.py: text: set
test.py: allowed-ext: 100

> git check-attr allowed-ext test.py
test.py: allowed-ext: 100

=3D=3D=3D NEW VERSION =3D=3D=3D
> git --version
git version 2.20.1.windows.1

> git check-attr -a test.py
test.py: text: set
test.py: allowed-ext: 100

> git check-attr allowed-ext test.py
test.py: allowed-ext: unspecified

Cheers,
S=C3=A9rgio Peixoto

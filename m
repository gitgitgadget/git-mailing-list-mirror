Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025AC1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1055C20735
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 22:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKzedY4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVWgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 18:36:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35379 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWgx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 18:36:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id k13so1711905qki.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Bai8ac5Ee24X0FsctJWHBBIl4HapAELtdnN3sqgCmKs=;
        b=kKzedY4X+9AHajJ+MbOOkdl0B/A9rp91MFtj0Ld2VIPAaoiK79ntlrDbxjHumIFE1s
         4XyJ7PTyyQyee5oUdFqR4kUBIPF6X1DgvZk5TBG8o2Kb9tm0vOLAbFW7GWAHEFJZcIaQ
         7Nka3di1+Oa/ybYjtcVSntm2ZBzghSC+2hIY+LhRKcPJVDcBR7lJSH5ZBOa9C8RP6Wnq
         F4Jrvv75wW07KdLdPFcLPAtnwtu2BiuqYjx16O5YBgIUoAkt0acC3D+UUGvr78BGy/kR
         u3q+qbZ0fndR7lkv3Db0OU/J4pB29hx5UI3n1UDQL30oLMfUEndSV/sYsHZeFN1Qup50
         NA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Bai8ac5Ee24X0FsctJWHBBIl4HapAELtdnN3sqgCmKs=;
        b=sRFgviReyDakq8pEveKdYuVzayI2rvXQZrHBFfG6Te/E+WbepZB0ypqllDdnTkbI6R
         BJk/1G+pvYyFyBn28cvCUqrHnuYBmrAOVz1Nzo9Ek+2fd0m5Fi92o1NX5XpoMsdmF7GP
         0UnvH3uHg8bfEJ2N6gwHkPAg4DtCi8nxMOv/lqzmSZjiILDoHkaFXS60lzz14QnPGO+M
         NcyoxGx2SP+kyRXErKBVBTZG1E6uu+5K9JbSkVHTxtDCKwT8M82/FYA1IfLLRxQvWXIt
         MJjGR7Zzxxn8q+cgBmnom4IPReQgjxOlKKaQHMIF9snDoc4VxroDGx4QL9XLF1XO99t+
         AJvw==
X-Gm-Message-State: ANhLgQ3XgjItSFG63iKzZZCqdZlNeuUlwj1tsC07gNvqBaKkYmYhv/CJ
        IMlqYwwaozObRs+mVaSjKy0=
X-Google-Smtp-Source: ADFU+vsrWBRI3dJJYmqw6z8KZrJVxYEncF4fCqWX7eBb5Y3l3zveR7qQ7/FGcHcnS6DMMX7qrXn3nA==
X-Received: by 2002:a37:b44:: with SMTP id 65mr16675959qkl.201.1584916610518;
        Sun, 22 Mar 2020 15:36:50 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u13sm9683903qku.92.2020.03.22.15.36.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 15:36:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 3/5] doc: explain how to deactivate submodule.recurse completely
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200320213729.571924-4-damien.olivier.robert+git@gmail.com>
Date:   Sun, 22 Mar 2020 18:36:49 -0400
Cc:     git@vger.kernel.org,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <934EF1ED-E2A9-4561-8A3D-1B0F71129252@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com> <20200320213729.571924-4-damien.olivier.robert+git@gmail.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 20 mars 2020 =C3=A0 17:37, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> +	When set to true, it can be deactivated via the
> +	`--no-recurse-submodules` option. Note that some Git commands
> +	without this option may call some of the above commands affected =
by

For clarity I'd write "some Git commands lacking this option" instead,  =
as "without this option"=20
*could* be interpreted as "invoked without this option".

> +	`submodule.recurse`; for instance `git remote update` will call
> +	`git fetch` but does not have a `--no-recurse-submodules` =
option.
> +	In this case a solution

I'm not sure "solution" is the best word here, maybe:

"For these commands a workaround is to temporarily change the =
configuration..."

Note: s/temporary/temporarily/

> is to temporary change the configuration
> +	value by using `git -c submodule.recurse=3D0`.


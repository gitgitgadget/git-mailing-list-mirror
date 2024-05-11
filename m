Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546117F
	for <git@vger.kernel.org>; Sat, 11 May 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445775; cv=none; b=Br/rU/FfqxBOB1UrnmKUf1F8WJUVeGP4KXNKfDEZ23GzbAHQCIy+s8IRyQtRz4s2V6GwDz1jgbZi4H2eSnUW0DyeGA6QkLc1+WH1yCazCvJX0542EP83acsid2lQy398LxBdj1zlmOc8Ls38UcY7g/4g9BnBBYr3nerbGjKLhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445775; c=relaxed/simple;
	bh=QMUJyrYmcq4Rrzx79HU6B8d+VA9fuTDk9Kh6IfRFJoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USCwnPw9NF8e5yElSvl56i+liqVrn9Hto9+GHG6f4m8R5K+kk1R1lV2JjI9AM86BodMPWsUxPUxwYlTo5a2a/ruZVjLFZ7yEi1s7r5Xwaal8INDlbe092txIVie43thGQgOLy+3l6a77uIw9AG+BV3qK8wwhDWpBeNaNXlfRKhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so22462566d6.1
        for <git@vger.kernel.org>; Sat, 11 May 2024 09:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715445772; x=1716050572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMUJyrYmcq4Rrzx79HU6B8d+VA9fuTDk9Kh6IfRFJoM=;
        b=O2l14lihlFkquyaai+p+EqBoQmtCvTZ2E97j/wpCkboOltyHl4a6iSjyPf8nNjbQYJ
         6dFLG+j/b+LqOMiI+g3P035z/LVTVKGTWAh6/wjeCwUhVVPFa4fDkK2SiWUEmTYunDaP
         biDaQDPHBRAr9dJWyt732ilnawMVT+agqBBo0Cg2BhYi+9PcLgCdjna7JgGaJoeePUO2
         K5xzemkaz/5DbmeAy8uM05f/NoB3FYBPs1eZTYaFJ518BeqybUoGYziabeTAmdDD1n0s
         i7Zqrdc1a67LcrzHq30FXSatEnBSTAevAwX0v4nxOIY8nJPlODI59V2+1x2/UwSpvlOr
         0jDA==
X-Gm-Message-State: AOJu0YxAz8oIWKuoojaQLYDcAH71AjHUPWV/Ue5NStAjro1kaWJXWhem
	n6DepMcmnS/t2EMYPvJ6dmwXkHRRTEA8edrbm9I6e0jWsk3o7MZMPAyucnjKBuM1zkL5vPq/vHL
	MNi70iQ5e61ily5lUbMUkdYXThcle9lBZ
X-Google-Smtp-Source: AGHT+IHlGHFhmU54oBrJrRKzO3okvLEbr0Olte7gCVUoxjRF+1y42J3twr6F7XnUiI9eVhfeUKBxfaghHhl7e7q9pu8=
X-Received: by 2002:a05:6214:334:b0:6a0:b93f:e678 with SMTP id
 6a1803df08f44-6a15cbc452fmr152992486d6.10.1715445772259; Sat, 11 May 2024
 09:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715339393.git.ps@pks.im> <2b40b784fe146b4d17de9accd4afc53144c93812.1715339393.git.ps@pks.im>
In-Reply-To: <2b40b784fe146b4d17de9accd4afc53144c93812.1715339393.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 11 May 2024 12:42:39 -0400
Message-ID: <CAPig+cT9ZiZCzPL682Y8aos_=Ptq=doV9UCQd3M4c4kr6qzhvA@mail.gmail.com>
Subject: Re: [PATCH 14/21] builtin/config: convert `do_not_match` to a local variable
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 5:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The `do_not_match` variable is used by the `format_config()` callback as
> an indicator whteher or not the passed regular expression is negated. It
> is only ever set up by its only caller, `collect_config()` and can thus
> easily be moved into the `collect_config_data` structure.

s/whteher/whether/

> Do so to remove our reliance on global state.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

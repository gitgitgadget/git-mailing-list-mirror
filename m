Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2B34BA59
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759068888; cv=none; b=o4QwJ08VJzjDHpw1bB3aiBVlXvstBqCxfZziilX99b1yQrRHUZbMeZmI4gEtAkyxACNk/l0+fq3cCX/XlQp6ziOGqYfSJaSmVaRdHTjkjPf/hzWlIZf+Jfdcait20gZK0CzQbojm5YtaMBAD8qTiWXOU+kiQVoGh6xYAmMQdU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759068888; c=relaxed/simple;
	bh=MOvT0iJnNZFlHtnU18cA9xA/m2XcuCd27/ZoZBRXq9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ri3DMqJbmqojR/CdDRwWppkMP8BilvizJaIIBW7qQVKnpYtYBP0d1H6dcENvSmvSC7DCKQPWw4+ZKijV57lEvaCKkTg2KW8oUxHbl2fSbsMbmSjzN6x2REAAFxfeLIShs77AapLIXMU0h6BtidoMkFmRJwymrm8PoJ6fxBOR16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXrIkPrI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXrIkPrI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6317348fa4fso566947a12.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759068885; x=1759673685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4nhZFZr2zuhMSXRpcptRhIYLkbBXw8e/Ak7ROacSp4=;
        b=SXrIkPrI0hpzI/+q42E0m0VJzsG4ngodfAaK+TZ5ekis8hpN8ldZhXPkVB4uEsGStu
         lBKecooh24QbMN1E5YGF4KBUg0Kc+PU8v2DWSwt6Vw4kZ4euG0iFboyjwm7ibBX0SSJl
         V5OeQBQb/LY08Y5jLU+Se3J5IZ8QjlMyJ+g0oiotA4wahjsrfuao+TWZBmtpOBsRkq/E
         tDbHIBLEkEem4wNMcAFlg/qyZjZ6Z7/3U+SWLx04acyCwGWZj0IwF2WMLwQxnpJLLQFr
         6HO1uw8czPvYjxcIsQmklfXj60hqz5cH1zSYh6f28ijx42DCseZq8JqOJhFEnKy+AQC+
         whyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759068885; x=1759673685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4nhZFZr2zuhMSXRpcptRhIYLkbBXw8e/Ak7ROacSp4=;
        b=HR3HQyrGshRstLbOKZ36mF7OaHD3f66p4ehthYF7ESIfexAcCW6yLAHVbmpwvavltJ
         a4R7rZQLvO/PKrsvpHniWWj59igYojYpoxpoHRCK/pEfAm3o5F88fMrzUcza1mA+NWvQ
         oX8deYVsnW9Wmspj0+gngjlhCR5rXzWWv1/Fyw459Ywhd/YoAeSrV8Vny9bsRQpd6cL3
         uyOlMxI4O3mPNau2RqhsQwGpN4WbyncBep3iaB+2ksaAAkfuRtpfH+SVNu3VqsIaQWlN
         0L4eQ/Xm5d98uTpEZ0wCUymIWWagZ1jTj0t3qzAfSxpo2bC1kTi4SxrXbDCVX3AobS1H
         05og==
X-Gm-Message-State: AOJu0Yw77jwLwBA65qWH9asma5hicNZuQ1N9fmkHLi9pyjjSggH9tQ/t
	Jp4RI3N+jwlr81FBwcQjOiAwp0PyeG7sjOvnBZe/1pWPz9svGg1BOemV4jjj29qfEUGN069tVtU
	cohRJ3rzNK59h1ogFAf501qXaQos+pmc=
X-Gm-Gg: ASbGnctnw9f1N9UFJKNzm802ZBPwINMeiq7e3l99dADPdkiGUy2GobkTToMUw/Cf7HV
	b0M0DzR2umoXjIkJHxseQbUI3fvDvEcZHQ6QFQ6ESBagCWRr9bRb1U0Y8QxcJTuAZlHAKhn6Aq2
	X6fG/CZUJmgZd4NMpVTIsYqXhu4DnvJy62GjEgE3HxqKqlVmnB4mP1TYCyMN2baWu5CNPigSaWc
	m5RRys4MXARQPKPEh8VjFFF8Af0Z703bckybSlPUHv0YPJrDEzqy7OipXOE2qwm7LnMtFixJ7S8
	IOY=
X-Google-Smtp-Source: AGHT+IE64KL79UOxQU1z4wmH2UUEOIcENq7+h3+OsOPHBqUU4iXUwgd6Hafv7iW76R3Wu3rteAbbz3o4e8rS/ytd21A=
X-Received: by 2002:a17:907:3d8f:b0:afe:d48e:34ed with SMTP id
 a640c23a62f3a-b34be6d54acmr798367366b.6.1759068885271; Sun, 28 Sep 2025
 07:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGJzqsn7BbaVckJ17XhsDHLtmS3OZPBG=oniwe+FRjhEwGc+Eg@mail.gmail.com>
In-Reply-To: <CAGJzqsn7BbaVckJ17XhsDHLtmS3OZPBG=oniwe+FRjhEwGc+Eg@mail.gmail.com>
From: M Hickford <mirth.hickford@gmail.com>
Date: Sun, 28 Sep 2025 15:13:55 +0100
X-Gm-Features: AS18NWAsi4iZtm1LEl5MUs9H5XejRdUWxRmwPa81Ne94bGZ_13CXueBeHaFlL4g
Message-ID: <CAGJzqs=8QHB2UjECVpEB2_R85dG1oHg2F2ewDRVpun8XqbboKQ@mail.gmail.com>
Subject: Re: Feature request: partial URL matching for credential config
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Sept 2025 at 19:48, M Hickford <mirth.hickford@gmail.com> wrote:
>
> Hi. A git-credential-oauth user would like to define separate
> credential config for two URLs prefixes of the same host (eg.
> https://example.com/org1/* and http://example.com/org2/*)
> https://github.com/hickford/git-credential-oauth/issues/83
>
> I don't believe this is currently possible
> https://git-scm.com/docs/gitcredentials
>
> > If the "pattern" URL does include a path component, then this too must =
match exactly: the context https://example.com/bar/baz.git will match a con=
fig entry for https://example.com/bar/baz.git (in addition to matching the =
config entry for https://example.com) but will not match a config entry for=
 https://example.com/bar.
>
> Any thoughts on adding support for URL prefix matching?
>
> Example syntax could be credential.https://example.com/org1/*.key
> (explicit wildcard) or credential.https://example.com/org1/.key
> (implicit wildcard)

Here's a simpler example without OAuth -- configuring a personal
username for https://git.example.com and an enterprise username for
URLs beginning  https://git.example.com/syscorp/

credential.https://git.example.com.username=3Dtim
credential.https://git.example.com/syscorp/.username=3Dtimothy.smith

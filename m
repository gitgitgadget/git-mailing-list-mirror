Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8C1400A
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722756760; cv=none; b=tacnXxD1eTN3cCLIbeVBQ+SJLSvJ2vkZkI1VbiXNpNvp+mxSoI4w2BCXUO5m0ATPA05ZI6DIinP1T0U8djzz0zlYNFwNaL4mPa9O2v65Ife3KVxOW0ndaPbgp1KPk4OuCTCK5oykqiIcTyPP+X6NhY0KvMjiDmWJR+OuAt96gLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722756760; c=relaxed/simple;
	bh=xDttUNNOQFxH4XWUPrd/kVJ9M/73Vm6fWYIvDdORkYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szQbp6q7RRS6/ZRqRwRApnzVoWYb1CiaIvUgR+SORiH6j1j//64GilmhhCk1S9fqSqhAxT9hbYVwOYHYzGNP/ormqv/fKQEM0Wm+UxHezUX6aNUD8aw9fR+8S3m/+/mYwuX+imr7DyShfJ3LVLfEO8bDcwv50Z4+Q++muMwdRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7b349a98aso65648086d6.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722756757; x=1723361557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7gqfIT7GCTGDrrDKt+DS7FMidMraiUYmqGwoAiLcBA=;
        b=pu8KDQuIRfJ0edPMltia5H9JRBxTylwLMaZ7qSmh9gdHRkm3RyuWKOWodYyNnC6tyx
         BYWfiF21H6xC0BRnJoEAiys0L1X3apci+bT1sQr6cRT3Bsew3CoBQ02vUSi9txcBMrjH
         ealcKBAbRta7oQtYsfDqdZJQ8BgR9s7bqR7IlQ2eAlQvEfeIDk5QycMSsMYj86Kbjpa1
         UhCmd+WvLrY+07r5dqkgK6/VmaPQcKPLVOsb6Pp4/qThvzrDKynFlPbXKmPwXMiupLew
         aZkINF4A08UVXmEFsn8Ch7ym/0VGVVslQpSwbdysMXLvlIh80BCjADW5CwbdJyhOZHj9
         9u/g==
X-Gm-Message-State: AOJu0YzS7SxjbnKw50bxBntNF3TqE+ZQ04qf31xedLR9IU4Xouvuisjz
	AHh1tnx5elUg8tloMIH06Byn35FmcUb5MUN/I8noR1dRVPNul2b0IAjxutIgxIgzGxr+T000TVH
	mkz3nXtY2I9K+utfnVx4csgRp4zifAA==
X-Google-Smtp-Source: AGHT+IEqsBsB5OMunkopwgCe4Y/rNWfgYkWJpcrD93CRs/tW8TwUI++Pk2t4yLhOgDNiPRoAmhWvi1mlqSCpAMJWvng=
X-Received: by 2002:a05:6214:448c:b0:6b5:eba0:d0ab with SMTP id
 6a1803df08f44-6bb9839fdc4mr98185116d6.15.1722756756936; Sun, 04 Aug 2024
 00:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804071137.30326-1-abdobngad@gmail.com> <20240804071137.30326-5-abdobngad@gmail.com>
In-Reply-To: <20240804071137.30326-5-abdobngad@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 4 Aug 2024 03:32:25 -0400
Message-ID: <CAPig+cSAG4hcLRg9nAg7JGssm5Eh87-z4kWSu_RLgJZuzhyX8w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] [Newcomer] t7004-tag: do not prepare except
 outside test_expect_success
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 3:12=E2=80=AFAM AbdAlRahman Gad <abdobngad@gmail.com=
> wrote:
> do not prepare expect outside test_expect_success
>
> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
> ---
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -131,10 +131,10 @@ test_expect_success 'listing all tags if one exists=
 should succeed' '
> -cat >expect <<EOF
> -mytag
> -EOF
>  test_expect_success 'Multiple -l or --list options are equivalent to one=
 -l option' '
> +       cat >expect <<-\EOF &&
> +       mytag
> +       EOF
>         git tag -l -l >actual &&

This patch also changes bare `EOF` to `\EOF` which correctly signals
to the reader that no variable interpolation or other processing is
happening inside the here-doc body. Such a change of semantics is
significant enough that it normally warrants mention in the commit
message. In fact, often the `EOF` to `\EOF` change would be done in
its own commit. However, it's probably not worth a reroll in this
case; v3 is likely a good place to stop unless a reviewer finds a
problem which demands v4.

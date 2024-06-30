Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1AE14038F
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719770798; cv=none; b=ZyQNrujnB7spqUFjGyQ0p4IyaPZSJSuTuBZr/kLcxSo8irVB5LniOe8HNPfJ53K/SddnwahhYsgoD4pbWgmuRgcqzO8Km+p3ACBUVHTWo96DdcxVs5RyCwOQlm+GGN7eFHAiLJdOG3lnlzci/2wQBkFz6WmsU8+aF+biFZeXUOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719770798; c=relaxed/simple;
	bh=/J+f7/DCe0JBHNs7Fk9Y9cQvm9WneIAOIVb2LMnhu1g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=slESg6spr8grydsrKLwXGkosnagOv3mBWBRFK7dQqbISQ+La9oXdxTCJQ+d3FGVZfZIc7bo6tc/DBRwX0YkC0/ytEKUv790jTfuXXo2TkczjjJvCCJq7NWb494YBUN0kp5cGQxaYSA7U+YBOo6CarMLOzt/Ay4pg0vOhq3tL+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtyah6AJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtyah6AJ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-642035f8c4eso22520757b3.0
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719770795; x=1720375595; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHv3RYlHRpLYhe3yNsd57NuMbMUQNxD13Qd26VIzoms=;
        b=Gtyah6AJ5dbScQqKrtnKMkRRTlTQ4Hy7VJ48QdrN+5+AAEy82/9nDwjtY+O99PsNF/
         8hrTDBLteBvrWMNF8EubLKS0ALnvCJVhxI/OwbxuUZknGj1Z7BmG0NtYg7mPFSCGtE9A
         ULe1KtOOYQLBYnFMACMCzQEyJBN+uMPcyE8RIPWrRExqL/JidRx0JijIWweldbLqlJgo
         zbAYYBuk6qUlZi1N59bYcr/umwt2T1TVF4lv5kZSvFD8EKGxAGYqzJ8/yeQRG9tTWfZM
         hP6hriTusxahCyhPaMQNzicaqZdiKAjLhnt7d5TgMEe0jVzpYYppv2XEiNIeqfyzIJDd
         x4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719770795; x=1720375595;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHv3RYlHRpLYhe3yNsd57NuMbMUQNxD13Qd26VIzoms=;
        b=tup/Pzv7XVuGSPRfbIpevzleeMDVWZSlu7K6LnEkabE/gKJNNM8ERj0HzH+xUUhiYQ
         o9LwBcYQnaOb+Os9Nw6uGC8Nt5yvDnBeR0Dsgxo6W1ABx4UQz5DGNN7Obyop4pyrCns1
         gJJ73Rt9CoSDLnNtGSWTaaby4yb3jqvy2f6DKoL5hC9pt6qarmQI0ZOHF09YGPAmbolp
         WJTPU+nocNB/LF7HCpq14LhWnyKn+iWi4MGLe/UtonHI/qfV5EzrsMMxefS/jPklCVgU
         CT59dDbWToE478PvVzvEmAlu6FnHIUUl6+RGA3r9IIRrdMWG8TgzHE2UepTN3vb9PDQL
         WxuQ==
X-Gm-Message-State: AOJu0YwoenCfqcwMw88tFy8o0EK003VPwgEJZrAGl21jaonih7ire1u5
	+24iHAoH9WMdqZ9Ik2lQPPOJ6XNp4fIYG9euhKn84eivh5hj7mZLhmnQiSJo3Z57iDNcaWhZ4hn
	L2cndQSaYDPxgOWFIUZrj9G2oH+EUJ/05
X-Google-Smtp-Source: AGHT+IHZxa5V4bXNaYVUSBlZ8DiFgET3nrLJ83JFXjhp7C9qfu2JrPeqwFGY81xoDCszuboR1W4+Ji8WZ7tu9luemsk=
X-Received: by 2002:a81:7e0f:0:b0:615:b6f:ad35 with SMTP id
 00721157ae682-64c7277c71cmr36328517b3.33.1719770795543; Sun, 30 Jun 2024
 11:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Sun, 30 Jun 2024 19:06:24 +0100
Message-ID: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
Subject: Determining if a merge was produced automatically
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm looking for a robust way to determine if a given merge commit
could've been produced automatically by `git merge`, without any
manual intervention or tampering, such as:

  - resolving conflicts,
  - stopping (`--no-commit`) and modifying,
  - amending the commit.

My initial idea was to re-enact the merge. If the merge failed, I
would conclude that the original merge couldn't have been produced
automatically. If the merge succeeded, I would compare it with the
original merge. Any differences would indicate that the original merge
couldn't have been produced automatically. Otherwise, I would conclude
that it could've been. This approach is simple, but involves multiple
steps and requires clean-up.

My second idea was to use `git show --diff-merges=3Ddense-combined`,
which only prints hunks that come from neither parent. If nothing is
printed, I would conclude that the merge could've been produced
automatically. This approach is simple, single-step, but seems to have
an issue. In my experiments, I found that if some hunks from different
parents were located closely enough, output was produced. So, checking
if nothing is output could lead to false negatives: a merge that
could've been produced automatically might look like it was tampered
with.

My third idea was to use a recently added feature, `git show
--remerge-diff`, which seemingly embodies my first idea and is immune
to the issue of the second. It is also single-step and requires no
clean-up:

> Remerge two-parent merge commits to create a temporary tree object=E2=80=
=94potentially containing files with conflict markers and such. A diff is t=
hen shown between that temporary tree and the actual merge commit.

However, this bit means that I shouldn't entirely trust its output:

> The output emitted when this option is used is subject to change, and so =
is its interaction with other options (unless explicitly documented).

What is my best course of action?

Thanks,
-Pavel

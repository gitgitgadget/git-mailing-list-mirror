Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D08E13B29F
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896287; cv=none; b=NpGMUmViRZdZ0kVJbdFb7TvG9McffUh7tBgm83wy9/9UcVKZo7J6DwuZLyqoo4Z10XPATcZCQh3/cQSOF0yqx4WCH+LKiJfiGSZ2H6tgP2IbOl0R4fAh1eoPRuaYIx8jX8LlgtNd0ZiBUlDpV76JInQxVvbdcprYXTKXzySg8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896287; c=relaxed/simple;
	bh=XupkeVe7v7jMcpxL+jDJ2bRdmgxkEwN2L9BHi2Ps/BQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UXNhWh2mH0LB7M+hI430NrWfdtJrcNhWLQwa6HekXbbcdqb+fvX1aepGLGBpDBZ+D8MwdxP5LAzvOiuEiMEnYj50WONk+zq3uHqw9RFQ67gUQg1USSwLNhoiwEvFdqPlSeCjUUtq7p83IsGP/q6V+BoZihx2BAojNIJxW5abG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=felesatra.moe; spf=pass smtp.mailfrom=felesatra.moe; dkim=pass (2048-bit key) header.d=felesatra-moe.20230601.gappssmtp.com header.i=@felesatra-moe.20230601.gappssmtp.com header.b=3HfUDRZS; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=felesatra.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=felesatra.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=felesatra-moe.20230601.gappssmtp.com header.i=@felesatra-moe.20230601.gappssmtp.com header.b="3HfUDRZS"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51f2a8fd349so257002e0c.1
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 18:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=felesatra-moe.20230601.gappssmtp.com; s=20230601; t=1738896283; x=1739501083; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XupkeVe7v7jMcpxL+jDJ2bRdmgxkEwN2L9BHi2Ps/BQ=;
        b=3HfUDRZSaTK76tMHHP4ahz8kz1/6tPZi4mRK1Htx6cWpcegZvBR9OUo8JkL3gu1+iL
         cEpZuEN9jZNzhnLetdXAuNamis9Pf/mMc7EBIxOnXjQ1mql9i3IdHPzId0Rmq4UfYVFT
         qbiVcJ/hZrEC/2f+K+smQwhLU2hyBSUscdmfeecLo0jQaUvRJ1esgQoz0SphaIbzkoPF
         s5L1XEAJJWO3uPPgorsBshLYug75Eya7wFqFVHjKjltEYPZg6gCMi9pnO1DycpwkhiPs
         jxUGwxtqwXQVZp0I+VhSjSo1TOo94pLy/fJXQ+OYS7GNevQNCHyXh7avr0DmOFyhOTOH
         6JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738896283; x=1739501083;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XupkeVe7v7jMcpxL+jDJ2bRdmgxkEwN2L9BHi2Ps/BQ=;
        b=tpRCVQ/ysdrwUXPteZEe8fGg419Km3KAI7BR18aQgp/fefW8KHtFqy83pN0/CctqgV
         50TEg+VuMwTnGak2/xyalJz7MQ0VOrBl8gsz8oHWwrgPG2rMGFWqL0eNdP1S4aR6Eccv
         Jh1aUi5ouqz5xotGUG1JRrMqYJZ+wzr2wJ5FiYNOPgzygwCTlb2/HB95L49kJ8hqcjU6
         f4rxYmLc7WrEqnbciMR+iT+aMMxVyva177kQcuzhxRxBcdd/TNOmdAB+zF3ua+4ngZdf
         iMQ51sRbxFu0lzcvdAhBMc2IaoFQawVzP4EhhMTcBkHYiVaMszSjleya8IeJpZz3+S3k
         kVmg==
X-Gm-Message-State: AOJu0YylLvPWUxyemGdtv3IpC3iCPCGfoRczh8S3ROUpWoDtd+jhpoed
	UfSft1qZ2jx/a3olqkl4lfG87hFLVXMKnZCKrY634eCEvJuzgCQtzgMPTGsM6gg0StyCb57gCp2
	57oHsUW0jbqvx4q1BFPHeSQVBtQ6rXqsOpe7JIqB5r9RI4pXGO+4=
X-Gm-Gg: ASbGncst+dm7fo9fA1NdFJNXao0uxey60XvZ9ZRxlmi38BqdLikgTFoDuWqfl03MZZf
	FzGddfeMZICA7PwiGJg9B3i+ddvo5ewsh/gxU51AP08Zudc95FuUM84XueHeZR8PeFssZJtSzbA
	/pKFNgNsc0Yx2BJ0xOas1zB+GOMgk=
X-Google-Smtp-Source: AGHT+IHdTsbezA4/raz9jxRX0+ZVQf9MTWvA5dRcy2cMw/Re7gPP/bLkwY2QfzaYJyvsvH1HNkrVSQRAq91RjnKjdnA=
X-Received: by 2002:a05:6122:794:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-51f2e0b2c0fmr1374244e0c.2.1738896283559; Thu, 06 Feb 2025
 18:44:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allen Li <darkfeline@felesatra.moe>
Date: Thu, 6 Feb 2025 18:44:33 -0800
X-Gm-Features: AWEUYZm416sV_MnmXjuHOMh77kwJ2vVX-rRA5RZy3oOloHiVqcdizQ8PYcyWyfk
Message-ID: <CADbSrJzNCOP0t=Vsdopa2+GFth_J84E8SEvpRJYfg8uxYnH3ng@mail.gmail.com>
Subject: Unknown error with concurrent config read/write on Windows
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Windows, Git encounters fatal errors (that do not happen on Linux)
when reading and writing the Git config in parallel processes.

I and some peers can relatively easily reproduce this by running in
parallel (e.g., in two separate terminal/PowerShell windows):

for (;;) {git rev-parse HEAD}
for (;;) {git config --local user.name foo}

The rev-parse "thread" will spew messages like:

f100762176b7b085e81cafe261a049d809772ace
f100762176b7b085e81cafe261a049d809772ace
f100762176b7b085e81cafe261a049d809772ace
warning: unable to access '.git/config': Permission denied
fatal: unknown error occurred while reading the configuration files
f100762176b7b085e81cafe261a049d809772ace

This affects any command that reads the Git config (which is all/most
of them); rev-parse is just a convenient stand-in.

I have seen the work to make lockfile renames (and thus config edits I
believe) more atomic in
https://lore.kernel.org/all/cover.1729695349.git.ps@pks.im/T/ which
should be in 28.0 IIUC.

However, the above issue can still be reproduced with an RC build of
28.0 (of the Git for Windows distribution).

Based on where the unknown error text occurs in the code, I speculate
that the "atomic rename" of config.lock to config is allowing
subsequent readers to read an incomplete version of the config file,
which means that the fix I referenced above may be deficient in some
way.

I will omit the context around my problem, which can be summarized as
"legacy infrastructure/scripts", but I'd like to frame this bug report
as "this works on Linux, but not on Windows" in the hopes of getting
some help, although I understand this may not be the highest priority.

(Apologies in advance for my ignorance with Windows and/or using this
mailing list.)

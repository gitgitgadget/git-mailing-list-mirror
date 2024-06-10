Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883222EEF
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043933; cv=none; b=V96pz19h0TZBnFd08gS2n9JXHsFz4UMM44ZIznRTAgZj5uTVgollqEHree0WLD593roeeD6tci9FhX9AA6oY6yVmNSpaS4HiyfXjHkUnG/f6GRe9GzgLWBXDqZAM1y84F+69lYzaIQOabLNL+EVwmG0PcHnyQgR/RQnf+IiaQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043933; c=relaxed/simple;
	bh=9SBzXEw5gQ3EfN7pUyq4hgYQzB8vPYOkXTu1zLXrGd4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sx6N3F/AQQuiHEBrs10XCQNVKtNDzokE42gwIWLLZiNQ8vv4/zOV7unpEpLptAA4Dhzy1BK9IvlvkxOmYRNy8jeK0PQFtJ+b7qXge4SiDGZHIk1ZJiyR+4qeuEMmAugB8p/Lv5tI7WAexbvGNDk02Iuwz+fTVkyDFEL9/8wzOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6USA/Cf; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6USA/Cf"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5baeab9fd60so770953eaf.2
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718043930; x=1718648730; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9SBzXEw5gQ3EfN7pUyq4hgYQzB8vPYOkXTu1zLXrGd4=;
        b=f6USA/CfYsgNUro56tdi/8Yj7wCtGbqFJNtoHis8Md2+hrhb54ji6apPegngI1IgBg
         R2P4PT2Wc9tGmDU395REYT8fUpAQ1GsrRvpvFjYQslH3EAXQBRJuwo0p68UUL1URiJzV
         /1Qoif9yYYxk2jez+cO6n9W1d/3p1qD82FTYpfv40EH1pLpLxAkacNUcYl87nbgm3F2N
         3xmRHaVTqg5q+6F8OeSJa0Bml4s4wdnQQxhnzwxvVLgdY10xG5k7kC5r6W5Oi3rOs7OA
         cc8o9iuFhM2VUPCOCGB1GEubPweEBy5T1EzepPXG0nUSJ0ikRW+BbyktSsFAf19pSsUB
         XTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043930; x=1718648730;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SBzXEw5gQ3EfN7pUyq4hgYQzB8vPYOkXTu1zLXrGd4=;
        b=HgFnZUhZY0a4g67Fj/PNk0CUB2Go+aUZ8afMP0fA4UruH5/WZNsjq0CP1tjMwwRhFL
         J7eiKvuwtapf1290KTo6Uu7VwedQ82Pu/STpN+gcCY5cyibT5NvvVDN4JIZe24wMcGL0
         4hiO0y86sdxppUlQzX3NSGA/pn9IjY0tA0pyQyTwSVctjchjeZd0agU/AcGab9daHRRk
         hI9/flDDQMjp/S+LxvV82HzlGnTmQXACmz34jYluogzPGkxcHEzBkVZVS59vXQfTAzPb
         IUCdWmnbHdrEmDiEpPiu4DFja5OQYQMf+zz70qumD8/0V8B0LYgymbFgYrVWyY1h8fki
         ScKg==
X-Gm-Message-State: AOJu0YzN+VfyzHCStRpz3O2Jrt77lMZhhRYTgFzNKiigC2N9IyTjXBaW
	3YjfL1Q4qQhJGczRsTIr9lb0V90xNsmLVUxEE98mDXn21G8JlxNQcSJcmC+kHVrrVoo6kMI+iMP
	QCZDw3gbF5SyrTZe+/mIr77fVE1bES/u6
X-Google-Smtp-Source: AGHT+IFj3Q4Zf0CWfMtD9/AJR3fNcv2Teugy7JTZRFWtTAsj8BknwgnUHeWpki7f0hfPg910WzA7AcctEVGQyESJ1Ys=
X-Received: by 2002:a05:6359:6e05:b0:19f:2d30:8d8a with SMTP id
 e5c5f4694b2df-19f2d309a1bmr777294855d.24.1718043930241; Mon, 10 Jun 2024
 11:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: matthew sporleder <msporleder@gmail.com>
Date: Mon, 10 Jun 2024 14:25:19 -0400
Message-ID: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
Subject: bundles discovery and clones
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I have recently been playing with git clone --bundle-uri and loving it
because I can clone with almost-*zero* resources being used on the
server!

I am a little confused by https://git-scm.com/docs/bundle-uri
mentioning "discovery" and things. Is this something being added to
the git cli, a special feature for other clients, or is it still too
early-days to talk about much?

I would love to produce bundles of common use cases and have them
auto-discovered by git clone *without* the --bundle-uri parameter, and
then let our CDN do the heavy lifting of satisfying things like:
git clone
git clone --depth=0
git clone --single-branch --branch main

I'm not sure I hold out as much hope for pre-bundling pulls/updates
but any movement towards offloading our big-ish repos to CDNs is a win
for us.

Thanks,
Matt

Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386FD15EFDB
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327558; cv=none; b=W+hGqnM2GuJw+Br3Zue2g0cS+/ZESRL32vhbvDNkhW2NHwxgdgAz3eYs+ARyDPl8RJEm5jDnT4mJGj0YF5oX20oC4tdGn238ZJzRxpCazSa62kHM2TlQRrhRcYH/9emttEmSh1j/lW3AxMxym9GpX9X3XKYDcsPY/J1rAXTjo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327558; c=relaxed/simple;
	bh=EzY+ygaMcSbzpGcFK97c/wcrcPxyx3nIibQ75s8L5kk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Zw8AOev5LEBDzSfdTx9M4y/7ZoOXhtBZeE0l9hq6hr5ynzNcsP7R9Mo/zEZxrCB1eKyXr+OK7JbXolAiqAwlU0Uqjy5F0uTxbeF4erPHil+oExOybT9znXyUO9DeetX6jvXdc2BFS9iyWx2HckK2Y2BP340oeVURu+jSQkisfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vi7cq413; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vi7cq413"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b27bbcb5f0so653889eaf.3
        for <git@vger.kernel.org>; Fri, 10 May 2024 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715327556; x=1715932356; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EzY+ygaMcSbzpGcFK97c/wcrcPxyx3nIibQ75s8L5kk=;
        b=Vi7cq413OKP8Q7BLjeK0TCKmBnkNnt4DvxckoZC37vqUFJoR46W3kXxVmHze/xmDpd
         wo6tdsPLH4GhB12cn4FBwd7bjct57qdmRRDU1oCekH9c8UbaplBAg6HAf0ntm7i+ms6n
         1J1vqzh64NnAg4mzPaJjzRiUx0POeMrCVpmu+6Ano80LXQX+4f3iy82qa+Hrub+DljrK
         ZGbFR0Q9Wx4sbtdlHpE+K6fL2M3g6e7X1LiFmXl1aqdLhto7KIDfZyCVbRRjTpi89kcz
         VZO1LfjcApaR0QOC4ykEThiaCD89Qp+72Tckpworr4XeTREuedGPO+3SFVgEUGtGnpyN
         7R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715327556; x=1715932356;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EzY+ygaMcSbzpGcFK97c/wcrcPxyx3nIibQ75s8L5kk=;
        b=kc+AYECCi7B3nM81o8wM3+v0VrJncxsrvzjo9pLzPFdCGj6LvCYt/bW08SGQMo5N+o
         JJz3ulPgXZI8PBYb9iOgnnesHe3D5dgxOOEU+oujZLgq+fXsOTYUo+d80qJI7IRev+Z/
         qEUagY/u7qvEZiwTCsueK8LKutxYL1GL3xdVl7MVgs+TTd8Kkl7Fz92wpgFkotwB7Elo
         +qNg6F7PPBELM1TDAa5cmLk1kSaAxf3HV6Lyqmj3qaYhPv3g7ySaV/1nUwXNuhe5C5JC
         FQz/j6rAT1YcvQXqGvdcmD/wxge5ouhQAJzoFQAAbQcx0SkW5EMGoejyt5VH39+tCHhG
         Nsvg==
X-Gm-Message-State: AOJu0Yw8pP0gYCGjQVPH7+XH+a6DEeFr1g0x3qOJAf/apux8SA+7YVmn
	7yW2qx5/2eH8AfUaCdT4Bi0lBQ6T+XEi/IgdYP6d/GkpONlRJVwRYJfcX6Iwp2to185mm/HAZpq
	Sjdg58k0/hxu6kl8fvOt01SLGCLkkcWtX
X-Google-Smtp-Source: AGHT+IF3wSfvlanajU2tN6SDOsvP9WMGTAcCq7R4abfSy8xoPNjrp/mrqNGnDkIgnBVCudiWuI2ZQQwO6YYDqlWOMIw=
X-Received: by 2002:a4a:5541:0:b0:5b2:7677:4f27 with SMTP id
 006d021491bc7-5b28195ee6fmr1877103eaf.4.1715327556016; Fri, 10 May 2024
 00:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ryenus <ryenus@gmail.com>
Date: Fri, 10 May 2024 15:52:25 +0800
Message-ID: <CAKkAvazeFvCfT7tZm3emwA=k-NnzPD7X0v4t2E9Ja4r-GpZfoQ@mail.gmail.com>
Subject: Error: failed to store: -25299
To: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Command I run: `parallel git -C {} fetch ::: repo1 repo2 rep3`, which is
to fetch multiple repositories in parallel using GNU parallel.

This worked pretty well for me in the past, however with git version
2.45, maybe 2.44 as well, it would randomly emit below error:

> failed to store: -25299

OR

> Already up to date.
> failed to store: -25299
> failed to store: -25299

This is on a Macbook with multiple cores. And it seems to happen to a
random subset of the chosen repositories.

But if I do this without GNU parallel, or `parallel -j1` with only
one worker, things work just fine.
And when I switched back to git 2.43.2, I don't see such error either.

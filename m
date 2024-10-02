Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560762030A
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853170; cv=none; b=UU+wsxO+rJzxX5yjj3RJAf5qM9tMFezUQxRYbPS2rjCIQNBCxNDf2qLuftKE8EWwf/uCxiaSUkVIgvraTKy085BhhLyyILhD2y0lQsgjm1nq3gAl1Eh6UJ8FULPMQgA8J1RmlDvvuBs/jLxqW8MKo+jzw3Ub6WHyNLEquEDbf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853170; c=relaxed/simple;
	bh=OFS2tWmSvMze76wF6tqPKwPs2AdTZWbb4m2r9qDf2H0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Oic1mU4RdQpKxcv6nqqFS6J6yHUdMYnslIR61GWGqwizdDqBRIsswgfkoNStND3v/wt57MA4t3N6pnysZCxKSPd+7+2BS0HLwEnEpLdpLQFMGyQwBIGI3hKSwSx9K/SkRihyrhlWHB8xB83CCx4HEoZhDQlgbs6Fafh0fgI4xkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL697amD; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL697amD"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84e857bc0feso329287241.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 00:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727853168; x=1728457968; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OFS2tWmSvMze76wF6tqPKwPs2AdTZWbb4m2r9qDf2H0=;
        b=fL697amDxUXgZyUZOMnb2PHAWBJGkyvUrRBLmkKKtIoi20h9Njn6LE6Tc/MMrv5hWj
         QI6dVYudGlBiQLZADutUTxqmMQEE3T/j0KzCaNZXSpMkiCKAn3FXLFrOjcLaAOzYRP8q
         HO9W/Iy1sYmPXMtlngsjBPnG0FtPeV1Jj5b/UkmfzCfNSFss8OOqBMYg/R+kBb1rixqh
         1ZkeYhseWFdfMh+py3HeP+mtu+Kh1B5yrBpFMZZbCoUyxsEGUiiZ83/cnvNxb590uhHm
         szGf1FSazVQixi9K7LEA6uH992eWcSavavYGG1cmOcDxQ61gk/XzXokLDK0p2jS8bJem
         RGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727853168; x=1728457968;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFS2tWmSvMze76wF6tqPKwPs2AdTZWbb4m2r9qDf2H0=;
        b=G7Q3OQ9DRslAjwdsRTALTuTidKZAqXQrkRKp2xEtmmFjENwUHgLVBHH2YNb+C+Hmz0
         xxorIcFlgRG2GkbRmzcR2hpPFFS2/7Stm7oKZHg92GjhzZbc3IeP2jWTFUa7SoCoXyAO
         Q+TdlbROxoIFxzdg0XC/VonWHAQzNbOTpQ16X+lt3s3sZL2vyCDm4BYh2Tq8QKzgXwlT
         UM2s+cnunuCe3OJMiJOh3nz0OJxXTPoVNsl+jaCmCssYCd1+CfD5wMSLJywSxhC9ofE/
         P9lytBJWm8bQOYrrVDQicgdedfDIZiyeGLzzUzDSZYAUuemvWNhBilYDEy0IM1QMANSp
         dzpg==
X-Gm-Message-State: AOJu0Yxpgpw5/p7e10YB/M9yzhT90r1X4SqeQor6A0LEjIoSwzkek3Z9
	e+ZuM7OaaY3TYtpMbon8waNv+c1OeHxEX4+zqN5ZjcZjist4K5krxkH2LGCJWkcH+1pzSlZPcIq
	b+acYEW8kiFpkbyVU4eDjnCyr2rq8gZ2D6G99Sg==
X-Google-Smtp-Source: AGHT+IHTMjAVD4pwFnWoVIgt29O5QHsi/Hnk5/m20IM2+6jclF8L6CBUVh2hmmen4V1cslO91MDAuN6IMVG2r4kCHl4=
X-Received: by 2002:a05:6102:4414:b0:4a3:a2d9:eef1 with SMTP id
 ada2fe7eead31-4a3e64d7353mr1736580137.9.1727853167960; Wed, 02 Oct 2024
 00:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 2 Oct 2024 07:12:37 +0000
Message-ID: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
Subject: [Outreachy] Potential intern.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I am Usman Akinyemi from the Outreachy program, I just got
selected for the second round contribution stage, I got interested in
the git project as it is one of the most important OpenSource
projects. Also, my skills are aligned with the required skill for the
projects and it is related with what I did at systemd where I created
a new unit test framework which is now the primary framework used
across the project. This development has significantly enhanced
testing efficiency by improving error reporting and debugging,
streamlining development processes, and increasing the reliability of
the software.

I hope to learn and contribute meaningful contributions to git.

Also, if there is anything I need to learn about, kindly let me know.
I really appreciate it.

Thanks.
Usman Akinyemi.

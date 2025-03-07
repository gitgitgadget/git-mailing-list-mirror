Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2A23F279
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365919; cv=none; b=I3npkkWV0EqmZKf1KAc1ksBgEGOItK0lJztLAPnDEE+KxYorM7LVXgBZv2v8S3Cz4tv2KhGvw27L4bJZu9Po/xTlO8zeU2owR+Kc1s1OkBGToYWpLAIlMzpKkfdSDh/h4nwqhn3BgsNBn8Jx8+O2nHECKhg9iiGZt2ti/xYLubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365919; c=relaxed/simple;
	bh=6znIVWFDiWThW0Ko+mCqSXqKekLXSDLFP0p3lvLVcOo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=J20Pyy/oVgcDi8DFJaDjPTlpJfYIed/XjZFEhEIGOuS1oDW4QJs2kacNd3+9c2r6L+H8qwNcZAaDa5TNxxj6eaKQK8U22J00su9vA0NFNiVVJpr88nASwpejYBo5369PfCAnpyQszVFhNUdWU5rtb4RKCkJeDUsqpq85udTTJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER4HJfzo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER4HJfzo"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso719089a12.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 08:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365916; x=1741970716; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6znIVWFDiWThW0Ko+mCqSXqKekLXSDLFP0p3lvLVcOo=;
        b=ER4HJfzoFxCqUablNhbBDsYUsbpwsq/73mSY9ORDDSKH1nssG0LLlQXPaeZ7iLQwyX
         SRTrsoFFQ4ZHFJ2dZJ7T51Sci6Fv0cglQuutRdS8nyVrSjxgRTWzGRDfYmH7aH9OAdzp
         sXo7FZIkwcIiSR8vemndMLzBldJA9G7bOUbx0q8AJ+kTsJs0e73uaX6gl36Ay/WPs8L3
         ydTgXC0bPZE+sVOYS3WH10K2dfVzMGEPRn6f1M/q1zTzmfGfDiJDHBPMkX4vFESko6lt
         xhWzUmaQRpOVlm01fmNQNLjRNZPDceyJylxyDWXvl2bKOIpentM8bSWYAO9XFvyCYV8Q
         EJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365916; x=1741970716;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6znIVWFDiWThW0Ko+mCqSXqKekLXSDLFP0p3lvLVcOo=;
        b=qPSV8o899Kk5aS9jIYO0rGBZCtlxs9slZtfkjQMU1PfrngUv5x5vAtOrEWZ/ly/XmN
         AWMI9AbouKblVinUSZ+ST2IBi51ziHK5lfUJmJhKyASXUnaT1LciJjXRFWVCUjDjlSnJ
         4sdfjZZRPqUxykVtWFUSrK1LGy6/Vj4Oq5qnHBkKNzENOIBftpyyZaMGwKsyYUutBf9P
         6zUdCgVWgBxY2YLQjafY2c+9kXuhjX5LgA3IP5FnsXFjTMgRd3CnPiRCJcxy+j7eiQhA
         omkLKn5RT/nmpRSOLif/gUba1JQqvr2XFdXnu9X9yYszTPuNKkOf5+/v4+zaHZz21qOW
         Yk1g==
X-Gm-Message-State: AOJu0Yx/elTGfsPwwAdwTEZc3O6RKbUjkwKeAYhOlrNZI9W/m7BLIQAp
	4Awp4axC7szzv+24XKf9W+tCi0q/wP1II62GpIWvQ/16+05Jd/9x5AG+y2aDVRIKNYzKn0l/6qf
	zeoM5WBDXVc9KPUNf2Bk9YwUtOqm8ig==
X-Gm-Gg: ASbGncvM47/CFRB5D/YJlzI/8Avif5gwIWy4fopw3+b+XsiS9UTTmfP0WlXOfB08wRL
	JHfLj6PSuJ5ZuhdCM7HVpBcFtsNUKY9XLYjgKOGnT7onps/TLA+uNPTxI508BD9NCEBprORH1NY
	bdBPDyjf/bBwUpFWz8A92SCYlVLUfD2r9MiS4wmpI/YrL9Jweid0ZSsgEhPug=
X-Google-Smtp-Source: AGHT+IF0Av1ixuL0oEwpL3ACnIuS66dMrSGorOrHa4OI7TXXXCZNxoVxy3bfV+jMmvPTgDwFNUN/smf6J0saE9op6LM=
X-Received: by 2002:a17:907:c302:b0:ac1:fb60:2269 with SMTP id
 a640c23a62f3a-ac2526e5e9dmr479070566b.27.1741365916195; Fri, 07 Mar 2025
 08:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xylon Chacier <xchacier@gmail.com>
Date: Fri, 7 Mar 2025 16:45:09 +0000
X-Gm-Features: AQ5f1JrrzRkyOtfN5VgXwR4cZyoXkSTOGFsNTSeNZXcFFyTasHhpevsR_oQgBoM
Message-ID: <CAM1NYDbc1MSCKBp8ViiqGLOhbt76=weH67nh05Wcw8t8N8GbNw@mail.gmail.com>
Subject: Lessons
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would like to tell you this, in a message, can you teach me, with
more clarity, your service? Can you show it in images, by any chance?
Aside=E2=80=94as an incidental note=E2=80=94have you read the repository en=
titled
create-your-own-x? I find it may taint your reputation a slight
little, but you can take a look if you like.

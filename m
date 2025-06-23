Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4028AAE1
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692211; cv=none; b=bimybQAOYLZogY5/4R9QBhqvoIg1V+HsVUVFhsr38J+EvB3unf4bMx9rnGcUAVPJOItyOskincGCUAcJwVliwAijlK0flXcI5g+uttzWDsE33Q4QGpLD38UgeT6++QNX83aKd75ytY/kna8GEO0LEypQtkoWzFg+QRrbBe6+XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692211; c=relaxed/simple;
	bh=rCBX5oG5qoY8lvdiQZxd7dPM7ROIoZF8nJ2+Yna7Vj0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=b99AvxZZDAdsPgi6Fkx8J51whvnrBVXePB+ZkWRn3KHj1jtQ+ypz4nLMAxs/N8Mz7aRwwgjZh4MBdhkKstt6c+cZjEvqK7wXn4dTQyaRvnzLOmZHNMeY0R99y399AJuxyv7WgHZ29olkz4WN4E6OINY02db8yu1fdZ2n05FEMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l82K4hdo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l82K4hdo"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-551efd86048so4295416e87.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750692208; x=1751297008; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdeB7g4ZeMzJ68O55zq0iGjkJhqvnwwFNTdz169kr0I=;
        b=l82K4hdokCBD/ykINmyeECJpaxzQw+43xaNqERcnK1pvmH3XCkMci91X9GfP+gqAdt
         cmwk1PYBbGYoCgqCvdWJmOKhsnM1PqrcHgEWYiiq4fU1Qp2dodebv80DYyTtwl58aHID
         bhlNmfb3Y/WKxF31jgf9PyjQwFtxDCwDwM1puhOvz4O9wCaTiMOhKIX1/O2NfksuKHaP
         aeuyqsNvKF8s44+HarkUfMlrSQBaOdPXb8S5087FPvJMAnCjjrskOkrL5hGSUy7hp/pi
         mBFwNYHYlcjS+VuL2pf9rzqtsx9agazsGdBaLiR59oQpJxdueYfRqoxmDhtrVH8kw+9E
         LGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692208; x=1751297008;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VdeB7g4ZeMzJ68O55zq0iGjkJhqvnwwFNTdz169kr0I=;
        b=iA1RHqOvsnva0Mu1ZlFvwkc6zUUKKNMpTeba+RKV6NGpHe7hxDBgLWn0XV6+tGAVaO
         MnJ00zm9eEUEHEBcgdOMQ26vvaJGUUzCtYKIXqh3K7qKoTdM3Ze3ZNWnqLvxpzWmWKer
         8Jj2c9g8Xy87dnG8LCTtAvaygxq/QnkZH2NyLxCBc85VLHUNz9lrHopyJ+m/QNVCriMR
         JQ4Cgi4g5HyOSyDhq5bwC4oqgsYoUZK0huuE3+3v4T5D/5eFweT/F3O9TmXsI/cHqdap
         BpfFgsg0htd6rMj8Nq9Tog8qDhjsO88HOYlAMPJSw9MQL2wHYmad8DHGm4VJvF4JO7Fk
         Yd9g==
X-Gm-Message-State: AOJu0YzwcVCgFr12img1/rovmlbdRcPTDkPVZjgEJeQqkecY4hdP83vf
	WOqp6sZwe2S5iXc0+pApfHi6v5c9UIq8pI93c2mTTAoeFH0fEkPE6KW/3PrkvVN+7XE=
X-Gm-Gg: ASbGncu5ijAKlIWN+Vs61lJ7meqtokRBqbCvEJ5uXyXVUizLWB+ntOXamPH4Tzv0iTj
	sg7KJXGwKJBRDBYA+ars+0L8fiP8QJAV1NJLjaHJfcte2Qg+o3yWq4tV9J7cg+lOSwxDCy8N9/x
	IFbg/o2MQPlDtyxbQHs9Fn1dvUDl5eloBuk+YjxOsGtmw4NA0LDpMplg4RQbn41HsI9W4NTQuDU
	vdMhRONQqHq+FG8EuiyLvPQvnn239oCYy53G+spRcb6jSYuP+xUt6AlYzOTTGFyxDe9rWf8PI7g
	cKrulFQjBKCZH6E0jGdcZFsHk7h7mpAVXFzLrLHfcPdVtU5g+n2Kp0ZpS7abaU3+mRoVFVpOG1E
	tm1KIvMqQpNi9gCNRc8CHJzE6slOS
X-Google-Smtp-Source: AGHT+IFvjdulHJiWZ7iQLYkP+XqHpq9LyLGp1+GdOZQJ3ozw+FdonjHCVWeaQVfNGDzA21FD+olncA==
X-Received: by 2002:a05:6512:108d:b0:553:37da:2bad with SMTP id 2adb3069b0e04-553e3d0b69cmr3306570e87.38.1750692207826;
        Mon, 23 Jun 2025 08:23:27 -0700 (PDT)
Received: from ?IPV6:2a02:2168:869f:a400:d234:c3a:b39d:e0d? ([2a02:2168:869f:a400:d234:c3a:b39d:e0d])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41473desm1438836e87.36.2025.06.23.08.23.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 08:23:27 -0700 (PDT)
Message-ID: <ce1ad61e-f0cd-44d9-9b0c-4b7a5f941fd9@gmail.com>
Date: Mon, 23 Jun 2025 18:23:19 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
To: git@vger.kernel.org
Content-Language: en-US
From: Andrey Butirsky <butirsky@gmail.com>
Subject: bug: Can't clone from "grafted" bundle: fatal: remote did not send
 all necessary objects
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

while I can clone from the "grafted" repo directly, I can't do the same 
if I make a bundle first and try to clone from it.

To reproduce:

- prepare some shallow source repo, e.g.:
$ git clone --depth=1 <repo_URL> <repo>

- make sure it can be cloned fine directly:
$ git clone <repo> test_clone

- now create a bundle from the shallow source repo:
cd <repo>
$ git bundle create test_bundle --all

- try to clone the bundle - the error is produced:
$ git clone test_bundle bundle_clone_test
Receiving objects: 100% (183/183), 61.94 KiB | 6.19 MiB/s, done.
Resolving deltas: 100% (91/91), done.
error: Could not read 3541f044006078ac02f6a587ae87f682359efec0
fatal: Failed to traverse parents of commit 
47f57af427b311c96e964b7ffc0500dc0aa64c4f
fatal: remote did not send all necessary objects

The commit 47f57af427b311c96e964b7ffc0500dc0aa64c4f is grafted.


Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908611E1A17
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271654; cv=none; b=rPuX4xV02q1NY9Gn22caNZ4Z+CH+jNvc+A8Ru7kNo5kwXeRfaTLwkC2ON5JR68Dj5N2+01cA5mdu5ZNNrgy/3w4Zx+ttN5BD520ORGbhLiio9RFVIJIkKpxVK5XOrA7yFeUkHZmcEMcNI9ppFJJoUAnPHHWLB0WZfugALlJQLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271654; c=relaxed/simple;
	bh=uu2m+NxqQQhBTGvrh5sueINokFKCKFnfkljne2Bkz10=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WNhsxpTvPEauRaUU66sBRGAJQ1p7BAe2Mttzsiq5ldvl6o4ce0/yxrp0Rc61YKFIaks+/UBg4Gzj+7w2nDtmoRABgR5zgYlXYgsXy3gtUIhuKqUtIQpAKBe0fbpFXKACbwyM93Kd0/YL6X+Gxe3BIiUYwpXEfC/qM3L4pTOdwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6QVf1K0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6QVf1K0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so100559066b.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744271651; x=1744876451; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jbJEMkzRb3YvqiESIwDUIBOUzHvEvG8a7aCei3iTA4=;
        b=c6QVf1K01dtRa4dAXG16jkj/AksmVJF2jGOWk3fdaUpklvNAjtNK4RS9IaHTwnk7M6
         5cJ9CH5Efe/H42n+E67rUpxPanNoY4d0i/Ujbbh4mJzJsoWyGl4s11o3Ei9tkILDhSd3
         xRYDW9Ka7c2lM2hvWL2WUKk4EwBEkVOtl6+6jIzfm65phgdJZiIvqOLiPp+WHv2JDonE
         FKvsdyTUYI4pRUobY6cO27WWRzAu8RWB43oPcGqF8HcfYUrIGv9JbaDa+0ahLigpVUUX
         IJ6u/ZctpHKYYNvRvRcyeoO3uENZYFDVrR7dT4erhlmOAofcyg3aW1ZtMp+AIzPprmQC
         IgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271651; x=1744876451;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5jbJEMkzRb3YvqiESIwDUIBOUzHvEvG8a7aCei3iTA4=;
        b=TH1ihmuYOPspLkDDZ147MrU5gYo4tPSUFNQfSeJuYXZYJyuM4HKF7G0QOgY4YL5U5N
         dogyhFqrgP3yzojn4i5VR4DUBVrcxgQS/lJRbInnWNHtT2y4C6bVsJKXjL59JDDriCnT
         SLJZD/wowgLFbN+wUo2nFwuvM+1oh9NPTtPXRKbqZRe3h8nLsfHuPsucJ2kfeHM8WNrY
         jJnZmtCCTmVggdDdlgfJmwXNwfbur8tEw7onjKaRuTe7ToD5jkiDr76o2lbkeKm4xNxl
         xgoEBklmZSfonN6GN/d4n87gV643PBt6+eXsoWmMnCJmObxPnoyG2o/GyNyXGO9zngL8
         7xBQ==
X-Gm-Message-State: AOJu0YxTGEEZ1WJzsraESDjmJ0zrf7TYbol9SH+L6vn/jViIqHKZil60
	ZCIucTX3S51kmZsXyQxFnZCM9qT2iLEIf829QdRqZRyTDLV3OsPvOw5/gg==
X-Gm-Gg: ASbGncvEi44hMohE9gpOgMtQwlg2g1uvcnGtMHeBrfCOXAStjnXSw5Tr5KLmgqSkkHy
	1lfXq7nISkyniKUflYHaE0ZAVI3rQkFzf8/WjG7V3c+D7yksfbtnHQG4T46/5aA7CGX3q83a2yz
	2QF+MQqr0KFdYSRJ02UN5ydr//VPCsBfRm92Mi4QhwJhXdZX4QuPHpCIYhtNNYuW6KaREsDTW3S
	LCzJqVMfKTiXvyr865vyJaWl5w3oEyUAX5G9Zo+vyhird6m0rjq3zrRg5nwdk7KiRzC4xGEWsTH
	EYa0QT+g6tNQBhSNyFRD/5SC7PccKocvaY8ufFZUDgA=
X-Google-Smtp-Source: AGHT+IHT8X+zdKhnvjHX0i2UJGznFKQqgfaoDMB+wnEuOoE3bZL5rHsR3YPJXQgenu/FB8mY0LGCow==
X-Received: by 2002:a17:907:cd0d:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-acabd3bbf6bmr139671066b.37.1744271650701;
        Thu, 10 Apr 2025 00:54:10 -0700 (PDT)
Received: from [192.168.0.114] ([213.175.43.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3e08sm229080466b.14.2025.04.10.00.54.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:54:10 -0700 (PDT)
Message-ID: <ac87b389-2bf8-4c2e-aecd-9e86f65ca8c1@gmail.com>
Date: Thu, 10 Apr 2025 09:54:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, cs
To: git@vger.kernel.org
From: =?UTF-8?Q?Oliver_Gond=C5=BEa?= <ogondza@gmail.com>
Subject: [RFE] Add config option to always add --signoff to git commit
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, I would lide to propose an enhancement.

As a user, I need several repositories to have my commits both gpg 
signed, and their messages decorated with the `Signed-off-by:` trailer. 
This is a requirement to have the contribution accepted by respective 
communities.

The first part is easy to achieve using `commit.gpgsign=true`, but the 
latter, not so much.

Caveats with current feature set:

- Passing `--signoff`/`-s` every time is easy to forget. Even more so 
when some commits can be done by external tools (IDEs doing git pull 
with merge, etc.)

- Creating Git alias almost get there, but one cannot override what `git 
commit` does. So one have to remember to use the alias, that is error prone.

- Using custom hooks to pre-prepare the message is a bit more elaborate. 
Scales poorly with growing number of repositories requiring signoff. Can 
collide with other hooks touching the message for some other reason.

Possible courses of action:

- Introduce new config option `commit.signoff`, that would be 
independent of `commit.gpgsign`. It would simply cause `git commit` to 
always behave like `git commit --signoff`.

- Add 3rd possible value to `commit.gpgsign` to both sign and add trailer.

- Change `commit.gpgsign` semantics to always add the `Signed-off-by:` 
trailer if set to true. Likely have compatibility implications.

- Train developers to never forget `--signoff`/`-s`, befriend `git 
rebase --signoff` :-/

I appreciate any feedback. Thanks!
-- 
oliver


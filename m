Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85F1F236B
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651162; cv=none; b=VqqJNmZ0eRVqUHkwAoM58+oaaKUty1zhvo5p9Tm7CucpU7uTr8fX0O+0wA46S0rcfZbQED1q707JJBViL4kmopZjbEIEmjJvqCBbj8Gg0XnLpP3uH97UN9JK+zM8KLRg/MWYwAtIEp2IhiQ1xNNpsRvtW6gvUK1OrPHmgA3v+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651162; c=relaxed/simple;
	bh=YAnwJ62hyyL9W8op7sPKgYEtpgieFmj3Oixz+o44HNM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jO+ENXHpvuxBeJdevbdenNsZQILMPwtwmkNt+Ge4525q4bnAWHA2uxCgZr9LEbRIZB+Ck8c24+c/WTHlqNWCE+VnEPuM1IWYjakRJ7wh9CjW+kCo088/OWOmUBRkBAS6wddPhNSNd+yZOOPBO3PNNGdljftWoWroZi5A/eq5z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrRX5Hjz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrRX5Hjz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399838db7fso4443941b3a.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744651159; x=1745255959; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6r6qRCOTY0w4w1PKuD6PfiWo2n/t/0vtaxozPrJgpc=;
        b=CrRX5HjzdWgKIW4KCjuI65VhjJRYpDuCstDekR1m8J7tEy3NFZ76NiwO4Iu4wGT+Ot
         h5uqfgMzRjXVMTBDDTmeZw38qOabCdfNsQa/dW8sjeVmuU5OiWL5PealeEAvSwDLwSPx
         RqrzKGmjZNco6W99AL0Gu/5yRaUkgahsUVM87/yw3CcL8SYSCksGomBIVycU9mNc9HJB
         mZU+916yh1DRj9MaUW//03AvD+vKq5Jcmd2SaK2hVtI7kU+4nTjVvaid/2VH0PboLj32
         Am+9r8xsf7DAMorNNYLWWr/dU3+aZuXTRc3N2GasBnkhTESqTm2qeT6bHkWE5bjbHTME
         vQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744651159; x=1745255959;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6r6qRCOTY0w4w1PKuD6PfiWo2n/t/0vtaxozPrJgpc=;
        b=Lj6qRU8LIf4DjeyGTU5qrTXAckk7XiiN45X8+hIJOKehwEQ152FgGcGB/AQ9+ipk4L
         6pSTOvCJqu7mY2PcNi0c2wBwjhrbt2OiL3Nhbw98xn6nQNmYQEzJlrEUxdrOPyTdsVtU
         yUiLqtA1KXyVvnaJXocpNgvm9wC53/Y7ZiEDqrc9sqcakL4gYB1zO9rQBzK8FI7wTYrW
         hEU2ZOXTGtLhUrJvd3Lf9epQ6mScNnHN6JsDA3sVL2EPxgJzh+5pIw4UP1r9O1qFKsT8
         ZfL+Ds47l20Xu1pP0yfB4rmWXMuAmS/9/mlT3r4r0iZ5HzI4wxlb3JEpH47lua1wGzCZ
         rA3A==
X-Gm-Message-State: AOJu0YyADi9BALvbu7fKcWj4PVx1+ma6qeeLjB9Vx5YUozsGzjCUiZLh
	fsrld1SCpgxCduxRzX2mYmTffR3DMXnrcqxOUmxQBzQYQao+SihSh1DPgPnU
X-Gm-Gg: ASbGncvwssC6QNUZzsJbNOH9SZdivqOqNxn4powP8k7HV+YFO8/SImuK9OWzdKereGE
	HEF169QngALK8fb2zbEjiwaSGYdXrRVI7A+QIT6guxu+k5VpQEzHmBj2pc3nUJlPLHyI7bA/nis
	Gxk3geQGsOxEDOZ5+p5lSMSWy4+0Hh9AU36LmtIppeMsquBoQ0TaFkXVefuhvoBvCSKhQ4V4nR+
	XeK+pOwEfoyxxqMsarZ9ed8JS53ZcDMpFhaAbQTZhF4lWVEB1uC7b4i74Qskm0J+nGLYZ+OgtKD
	ACwqnkWBxonllu+DHKHvFGnQgwy4hWRRrtd3CCBgUPo8xPUDWi9MQIqS0S80nk3uO8ZXP+R3
X-Google-Smtp-Source: AGHT+IEgfMuavTMuYzqD/hTvnaYf3fZ0ODvGmJzbLmA5XKelftH7VlGQHrmejorObvWH2YVW/Yi+HA==
X-Received: by 2002:aa7:88ca:0:b0:736:5813:8c46 with SMTP id d2e1a72fcca58-73c0c9b4c05mr470614b3a.8.1744651158505;
        Mon, 14 Apr 2025 10:19:18 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:8e7e:85b7:aff:5cfe:b6e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd219894bsm6891207b3a.34.2025.04.14.10.19.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Apr 2025 10:19:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Potential bug: Git instantly converts utf-8-bom to utf-8
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <DM6PR12MB386578E1F28B532600ADF575F7B32@DM6PR12MB3865.namprd12.prod.outlook.com>
Date: Mon, 14 Apr 2025 14:19:05 -0300
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A743D2B5-0397-4AF3-899B-FC3D3AD2B5CB@gmail.com>
References: <DM6PR12MB386578E1F28B532600ADF575F7B32@DM6PR12MB3865.namprd12.prod.outlook.com>
To: messester <cnotsomark@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> When I clone the git repository =
https://github.com/NinekoTheCat/infinilore.cs.git into an empty =
directory and run git status it shows changes where all the files are =
deleted and then added again.

I tried here. I'm in a Mac, it shows that several file changes.

> The difference seems to be in the first line as opening it in a text =
editor aware of encodings shows the change from utf-8-bom to utf-8.

Given the warning messages it looks like it is more related
to CRLF/LF than to UTF-8.

At least here, for example, the listed modified '*.cs' files
are the ones that ends their lines in CRLF. This is, running:

```
file $(git ls-files '*.cs') | grep CRLF | cut -d ':' -f1 | sort
```

shows me the same files as

```
git status '*.cs'
```

You can also see that are some '*.cs' files that are not
CRLF-terminated by running:

```
file $(git ls-files '*.cs') | grep -v CRLF | sort
```

> I'd be very very grateful if anyone could explain what's going on and =
have a solution.<patch.cat>

Perhaps a solution is:

- Define a CRLF or LF as a standard
- Convert all the files that don't follow the standard that you
  have chosen to the one that you have chosen
- Declare it in the .gitattributes file

Hope that it helps you!



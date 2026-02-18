Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A351DF73C
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397186; cv=none; b=fTW/I0euilbtbQjoAUW3f0dDmkQcy6NA5bUr9SZN1+8JMqptPWQ6MxQ+Ms1sMhGZLIJcwiQMNHyysYernALI1AukAoL7bbLZjwX3DBH1eqFDxRrZN95+YZVXC0atS7fNHvXPKdioeCyh1d3tQd4nQFbYGoTA/wY1knZ4vtTAESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397186; c=relaxed/simple;
	bh=W8AcKHb+fTaOD0LVshTfP6wBF7IdfmicNsLQ9AZi8rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqkKyddO9owO03fuFlSQOozMlZs5DOIQQ3IrvdXXdDsdrWhY3oYmGkXapbDSKSb/nedS/yyEIoboffPHLRDqOWtvZYI2ZJANb77V33laDv5vEhFtHVBBplgAIZPhYNnNtlTNXr0P1qBHIXHZzcj/Xqf1Qii88Rwk0iF8OoBrtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEOoyadP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEOoyadP"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-481188b7760so40859695e9.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 22:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771397183; x=1772001983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYD7vpLfg8+jEaqaDqByd2utyxJxqQNUB6S8XakD9lo=;
        b=CEOoyadPrWltA7UDvb4xUWCspZdWwjFk6wpVOqRj8vIZ5zwIJ76EnXDNL8ukpm1CHu
         xDl1I1oUVKVgKn6vBoHhRLzsBEv8oKgn3OcUiCkRUcAEiEV1ggzHBD+4z/EexbsmFPCG
         iEMTuTdIUN0NDe9I+MiVZlG/JU247up9+KwjMiVq6K2ymMpOYM9sehEzyXsbYac7VNEX
         nTLOz62X0Mj9B5o3gKoP7IQD/d//ouI/9KwtktsfSXX99OgZ5PVyYIQl4cj70BI5FImW
         +tXUoCTU4putufcwgEI9LgpChOsiGvXg3IJW1nIThcZXkKS/4IxHJ+zw7e5AEIuldlz+
         ZsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771397183; x=1772001983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oYD7vpLfg8+jEaqaDqByd2utyxJxqQNUB6S8XakD9lo=;
        b=omWl0TjDQ5ELRmkR87Vlkwnwq6oCDvXT7Kbe2jMOnRI1PJH5qHL/J7vbyi4pxkEz7/
         aXLUm4U5/QkIAhJOayWywhiF423PGmIiulNZp6iU/Iqm4uRXW4GQhZoB3Gly+u2G1b+A
         y3P7qAR1BObFRtk/dshqWqiCJKglrvv4/B9ev3btisiTsk/+CQYRh/k4DG2XcZDON7ZZ
         sWcsREZjALZBHvXYJ997WRb4kqd+3yM2kL+XsDjd1HObdvS/lIGnAdQxowrxtwDLPJik
         rzzhVuHTu4ppKGpcDb/MLnmLY8NabowSq7AsBSmxqeQL9cf+tavJLDgrirTOQC/UGJgA
         CiVg==
X-Forwarded-Encrypted: i=1; AJvYcCWUZQX896XJZewteTcHF4QE233R55E+TV5PSK2rPFMIQ+pIWIT8TnzBMbjO5UKKzj9LQOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0YenV7QkggoJWeZpl8b4W3AXYMyBD3nXg9m9dqKSWJ6v5eZ7
	tzyhvz/iMNdT0x8Sa8jSTFSSrvnW2M8YuTsqdETGGW+hqDXrfYBHuKBg
X-Gm-Gg: AZuq6aKrpwd5f6Jd/h53DX0WWDfA05XD7XzSa522tHNhlnHmcv8rSDgELnR/mXyWKd+
	YN3/wLIc1PGxXrG5FtUGVYuFhL32qvRulZuVCg7SUtaqvZJLWRtHB5OxTH4lMKEB+VmvM/EDI1l
	qM+6jL+VoWQD4/eXqPl/JNofYtgxUtpU27f5RHUqX0egxvpAlPE2VZMUAeaH85Cg+sMIcDt7nHm
	Aq6ZjrzyWN8IAsB3u0RpZsaFGyTVGIq5Rhc3HCt0IZlQUGfZGxASHgrWOiqLWU3jIHpWUZKhyc5
	cX0tXZezDeBx6jlQZokYz4GIurn7Coc1naIgSlL5K1icZsBlBnVARGBl9nq2QwzTB7f5LMeFPor
	Wu1XdJX+xets2b6cApVGyfAreKYUYV8s3fYg0IIMsgufNNOt281tHSwQfYAwOeJUMYERxZTk/Nv
	Y90DF68R8Mpj1zXGM/hN5cd4MruFydVcxILqZnCRkfx/96ZZcTSRg9CzsrezC+EBzl4zCqiHylJ
	d+sIRM2HlZuhKTckFn4/hOBYEecUwIfkPMswm5Ljn7jTPtFdg==
X-Received: by 2002:a05:600c:4fc4:b0:483:6f82:9719 with SMTP id 5b1f17b1804b1-48398a4b0aamr15986465e9.2.1771397183093;
        Tue, 17 Feb 2026 22:46:23 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837a5d562esm268219595e9.15.2026.02.17.22.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 22:46:22 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: ps@pks.im
Cc: christian.couder@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Fix tests with missing iconv(1) executable
Date: Wed, 18 Feb 2026 07:46:13 +0100
Message-ID: <20260218064613.172817-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.77.g4627d513d6
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Replying with git send-email as I didn't received your email in my Gmail box.) 

> In any case, this patch series causes the MSVC jobs to pass again on
> GitLab CI.
>
> Changes in v3:
>  - Split out the changes for the ICONV prerequisite into a standalone
>    commit.
>  - Link to v2: https://lore.kernel.org/r/20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im

Thanks. I think it's better with the ICONV prerequisite changes in their own commit.

The series looks ready to me now.

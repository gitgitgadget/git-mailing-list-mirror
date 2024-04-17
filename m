Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732184E14
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370787; cv=none; b=RaRL8U/KXeFN+FQbmw74OS6ytfwovwNVBOeYqyNp7MMS1RauHphADBKLIKmHni2p6LxtW6fJrLp8tZNZWsURD4CwnymdKwVzRsYyR1sKYis9n5yKcwcLYLNXqSkbzkKP6K9yufG3dUxrwMlFmPBhXbtMQDGj5cwr6aS+I64ee3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370787; c=relaxed/simple;
	bh=ca+Y105/BunsBWrKCv2XkJWmmZvLlISZ6cj523B16XE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhQO0kmTkT09Im+cDHdjalzErCebd2bzvt6J5iNUPt4g54XppD/4axmVLnJwxK7kjdGXIbCb8/8JBMvk8jfwiv3j5WkEDwyAsGgP61xHAE+l685UNOyXSxq56y4jorxFKAue1XAhMpaiTz0ySffUg/SqR7crORl0BJmUwaTJCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W97OGQ09; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W97OGQ09"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c5ee4ce695so1721390b6e.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370785; x=1713975585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ca+Y105/BunsBWrKCv2XkJWmmZvLlISZ6cj523B16XE=;
        b=W97OGQ09gEyNGMq25tu+sscCrDlN11PFJSJww6EayW1e272XXdaWkqPuImUhffM0F1
         ZOz77lNatsJbr0RFyRF8Leqz67yJJzZvpNb2Cv+qDgjmt9tEkXnS93WUQyI9uzY3pbEQ
         9HsxTZV301ngHKCxdGyzLRTtdk+dH/iV2ys2MB+OcXYr0oGBrHCJr72mhvVo/4BpmMAD
         Wp3U0ZvXvjh9TXXmXuW/0eTsvuy6EPFIvZMIwFbgwPnwpmmBmZXDP4C5yWgpgPjoIYOA
         ekypGh9iOHfkhbrEaLxzKUvTV/tRv/u9rkoUrxk5MILWRJzwSjLiouMaI7P4ZxvztgCM
         y8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370785; x=1713975585;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ca+Y105/BunsBWrKCv2XkJWmmZvLlISZ6cj523B16XE=;
        b=wQw5PiNArVDPSQn0onR7Gi6AnoYgdwGWoEOaNb8gw6ZVNLwajkQVAuuXWhK8DPeatj
         rajA4c9E09O0Wy8WGps6EU9e1lv9/nJoWdHv+zKbdMZp5KMtVyCNNX8NKXOCuldqq5Qg
         8NAhsVv237wL5R7wYunnbyz6KtqUYTeGpNjS1Z+Y6GEX3009A/pvhNz3jVvtYSdPRBQd
         rjXvYU6CV8UjZooLU8Bj8Ct19O4geM1D+bFPdGz0Ls4vFAqvoLDgMVbUHTU8Bo1qnt/C
         y2zrShRltdR6ILYSKPRC6NcCBUyv1xUtj7pZQ7gmoN1FxIJ6Fx3JYtlPaCGt77N/ibjV
         54qg==
X-Forwarded-Encrypted: i=1; AJvYcCVf0NpYykB9iz5PQNqZli/WSwq0ED76M8o9cYmXPWAkUM3dadpNEyh9kWZBqWSFlxT3dCUqKKjSggkk29v5zG8FuX9g
X-Gm-Message-State: AOJu0YwJareosFAqf/yKyMJnZ70dMMCAKBwLVU8ZagJmhk4uAuISLnr+
	LXQ/S1Z6WdmlCEJWn3AlPuc3m5tb3qZuKv8sc4odoI/ztxa6zwdFFsrSxWEk/Loe99pdc24AlJ9
	cw7whdwonI5wwudZvNIh+C6QfbhdBIQ==
X-Google-Smtp-Source: AGHT+IHK630+Lekdkk9zNt3v7ZAq+v/83GGJmxea9mUSXVejGSfug84x6QdpOdL2rRvuQWjxutpPErDrkKmmhQ8NjSc=
X-Received: by 2002:a05:6870:1715:b0:22a:582a:9bcc with SMTP id
 h21-20020a056870171500b0022a582a9bccmr18506370oae.53.1713370784628; Wed, 17
 Apr 2024 09:19:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Apr 2024 16:19:43 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1713334241.git.ps@pks.im>
References: <cover.1713334241.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Apr 2024 16:19:43 +0000
Message-ID: <CAOLa=ZTRY6hmQqC2BozFkLmLQWnkQ4+sSug_8N1ZY9+aHNqCTg@mail.gmail.com>
Subject: Re: [PATCH 0/2] builtin/receive-pack: convert to use git-maintenance(1)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000fc9a7406164d383c"

--000000000000fc9a7406164d383c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series adapts git-receive-pack(1) to spawn `git
> maintenance run --auto` instead of `git gc --auto` like all the other
> parts of our codebase do nowadays. This removes the last internal user
> of `git gc --auto`.
>

I don't have enough context here, so why do this?

--000000000000fc9a7406164d383c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1dbc83b5b2e34cf3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZZjlwd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGdDREFDZk9LYkU0ZThnbE9oM1RtVWlmOXcwbkJSdwpaMnlNL1UyaFR4
cmdpZEE1VHdtNjc5WUNoYjlOTVlDcEpEdHU5UjRGMEZ4dnRYK3luTDQwUEQ3NktvanIwSlRMClZT
V3VJamJwOWpWRFBYVlV1b2IrYk1oWjJ0QmlxOGRiK2IvSDE2U2sxQnpqQ0xOODQ2ZTZnKzB2U1pw
cTBZVC8KUjNOL05uV0xvNkdZQVJWUU9xRjlUdWVjTE1KdDRIcEFWZlFVRkNWTXM4NzhLM3NHcmMw
eVNYS2JTTDMyNlVKegpMMDZlb2RnNUtSenJGaTJoQmo3N0w4ZzBxSDN4SXhMcE02RjNCTnVKWDJW
QzNscDl6MjRGYUN4SkVSa253bHg4CitMWC9uVTFQZHBPWUFQWFJBdk9ZTldQd2ZoS1RvQ0FOenkx
cjNhZnAyVkFnZWZ6cm5xNWpQNHJIZXdid25UN1kKeThoZkFHY2UvMEl1YkdVRG5HMis3c0IzVjlX
c1NDQzlTYmEwNTJzVGk1U0hPREN5SkdadWNaSzVhaGRpc3dqMQovenlmcU9DSmhCdDVzb2xxVHYw
aHZxcUd6RVJIcVlSbmJRZUNpSGR0M0xURUlUUEQ1Y01aMGlzeUVBVUF3enZECkRJZk5mZnhNY2FZ
S00zNEd0Q3I4MUJObC9LdWoyTmlHWEU1RG9pOD0KPVRTdzAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fc9a7406164d383c--

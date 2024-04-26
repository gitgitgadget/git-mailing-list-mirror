Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74708200D5
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159638; cv=none; b=gdAawy0wqKuIGPgq7vfWglmzw+MMujwzbiScQ8mqkFnAtV5qF9xwKQxxIFsT726y8/Xq+S08Aq88ms+OixnJPeNyt+XsNURkTOe8wY+Yd7egnqeIu6NaS2rGQTviZH99TYZfiMsM4stLxw1M4iVu2UJjBR5aM1fmrvTqMo+n8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159638; c=relaxed/simple;
	bh=qJPErRscc1aTUDqysgXWFLG/+TbYLCBb+PAY/ME2vTI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=srXxKGZhOMBJpzOSeSENSgTSCLGd8GEfui+L7dE/rg1Iij4mNtk0DrY8U1phbspmEGAzsCSvvMFPnon2RHV+EvvdQi+r05tpoKdmMdlYse3ljCjfLZeFdy/ENNdSRrPMMEx8CFUFSkk/J20s32ri5CxRHsaXJsE8gVTwi/M/Scg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvww4/zB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvww4/zB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34c90082dd7so99563f8f.1
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714159635; x=1714764435; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/PZp5Ju9K6IWSlyOpZOlIZbuNOzSUpGef6BHscvcTc=;
        b=Vvww4/zBp9iM8RTfcAnLPN1Z5Wy9IdaH/dfvaWMi1S619gbEk/V/vzSee+SE2CAqC4
         8R5GrkZiVEAPkvTq9J7N/vGPMsSJjVkDQxRmidETrRsBx28m2IMTCez5NF1cm3ODokJm
         QCvx+WJgHifqy9/8PHcJKbBQyQb7uBh6QnNveuaOKsooQ/rVWyKHdNYf0aqkadjx534L
         5JZ6UYSEDE8KvAvmGPO7dk1xmziu8m/0NFjYAGFWDIt1x+lU5l2OZDYTdurbFDdIc+O/
         E84lIY/xMSMjiGJk5uygwJQjeyOfjCBl0lT9rcwTk4KUmQqtKZsI3y6ItayLr2kkg5yy
         hTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714159635; x=1714764435;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/PZp5Ju9K6IWSlyOpZOlIZbuNOzSUpGef6BHscvcTc=;
        b=GKrkCMb04TZk0t7pwPx21jbqK7QKNB0yt0+b71DsvEseDjPCHwyU3k11SynMVasfQy
         ATubwpXYKOEafmb5sU1C0Y6BTYiW8uRV1eEj1w0kN0RXAj6efJghUk9ciiQ8jNh+RP9l
         yYdDeZwV1nPcLENCNHaOAI2JRp3gZJ3zUM8tIcUQmEeQxCJwI5e18HMokcoPsGdzZWpt
         eu5Lk1g0P3I/JjnfSBdghF5npPgvZbIF/wuwpYNamnsBhqDKPolX0qbJuib8fJHlIL0y
         CJntBbDQmZIJ0B6pfhRHeHwJVKrfOe/nyjf0/cfK8B6ie5DTHyczFxvvVzh8Ndrlw9y2
         QXnA==
X-Gm-Message-State: AOJu0Yy+zap7ks4AxxKK7SjlInMhTtS3W5e5dbJ9p+AL6EplVnfnmyKy
	Tcqb+S8yeb4KxOh1OeVEIM4gcp+oxkSN5EuC88uchR2uk9hRawcM9mK0/GUP8X7f0s1E3Egw54c
	hzXnxOnraICD/yKdVuuJbNRLbvZiKxL+o
X-Google-Smtp-Source: AGHT+IEkUkRoUSRRk3qOGDdnyHO+F0PuKG6EK6mmZjbOkNe1twP/riKeKl9qeV7PPnpV9XODgHQAaRfaz9k3V2Qzkx4=
X-Received: by 2002:a5d:618d:0:b0:346:85a0:20af with SMTP id
 j13-20020a5d618d000000b0034685a020afmr2325621wru.35.1714159634670; Fri, 26
 Apr 2024 12:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Thomas Desveaux <desveaux.thomas@gmail.com>
Date: Fri, 26 Apr 2024 21:27:03 +0200
Message-ID: <CACPMLSqTA6pY3hiawhTAmhfvWME8NRUehauy6g-oUaHjordWqA@mail.gmail.com>
Subject: Git Bug Report: git credential 'url' parsing clear other fields
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I encountered what seems to be a small bug in git credential parsing.
Just want to confirm it's not expected behavior.
I'm willing to work on a patch.

First time submitting a bug to git (and a potential patch),
so let me know if I do anything wrong!

What did you do before the bug happened? (Steps to reproduce your issue)

Run git credential approve with the 'url' field of the form NOT as first entry.

example:
git -c credential.helper= -c "credential.helper=store
--file=.git-credentials" credential approve

input:
```
username=user
password=s3cret
url=https://example.com/repository.git
```

This next input works as intended.
input:
```
url=https://example.com/repository.git
username=user
password=s3cret
```

This was reproduced on both master and next branches.


What did you expect to happen? (Expected behavior)

Credentials should be saved with `username` and `password` provided.
`url` parsing should not clear the `credential` struct.


What happened instead? (Actual behavior)

`username` and `password` are correctly parsed and stored in the struct.
`url` parsing then clear the fields.


Culprit would be this `credential_clear` in `credential_from_url_1`.
On branch `next`, commit  `2a3ae87e7f8e9585d7565a8b5d6a6c9c28d6d943`.


Thanks,
Thomas Desveaux

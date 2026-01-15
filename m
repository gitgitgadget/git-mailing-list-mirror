Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46C346E71
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495013; cv=none; b=OTVRpAb86YFk5M/FouIiiVVG+QyLB6S5rPKMF8Iy7BsRvMwpyUPObDGT3STEn0IW/iQ7XDbM+23yMBDwwyF0VbE7XSzG627GnQ2as+j/HIX336dDSv4x9iTm/vQ+EU9sELrjCfs0aN0JVSEsvJ7vjaRG5DWwnT9d+hJhcPikDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495013; c=relaxed/simple;
	bh=Dov8asOrNEvX/7Mcwzf+6GmFBAw6Cq+asnwYGZG5W2k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GROe0/tUGhtfQmpRwQuS3kDSOEHuvIWoNExcuZlBP59yoTPHi7awLTYGWQcC7rxo/pvWcYH6Mi8EroZMINx2ZsgqUcYh+kTVXjQQSIyEY1IIbFk7auVYb8zC5VEbmCS/UsucznKuT+xxaLG5n10C+L8jhZjZdxNoM4IszN5Hx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/GeY6KX; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/GeY6KX"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ae287a8444so527200eec.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 08:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768495011; x=1769099811; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxBDSk0DcUhi31/tBaAcXjbZiSodaJxjl/XadMPF41Q=;
        b=K/GeY6KXS5rPmDrmSL0KT/9WBd3sTA0zw4WZArMpd+ef3xDqMRPf4CNOJgH6VyN3R6
         jzToSbi/W3oAkTr91QDSjce+C2p+L2dxWkUnBfHGyZpzewfYVfFGk50GH1JqA8S2vhTy
         rvjsgjLx24fL0LZjU0vF8IaD3ZiZKJ17OkEC5chJkalfIuV3c/+UDeCRjf5jqmRBtyqy
         H5gofpyGaFtXwtQzJ9qtwY5cH/zg5482vaipnH6M6FcssNNIc+8+WDdDthp9rOsIL52U
         GNUAKRq1AKb9IJAREjuZXcw8AKEjkrvhMCgMIg+2d/urflX2HWFfDHdJP0rZAPpuLm9t
         5bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768495011; x=1769099811;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxBDSk0DcUhi31/tBaAcXjbZiSodaJxjl/XadMPF41Q=;
        b=toyDysiQqIINjlbg42Rhn6Zf86C40gGqOpvsnt3nwvZjm94/m/o8YeyX8/Bk5BK2DE
         /0aAawlp1dCiBsGt6EeSkDiQyPISHjOAaGqV1yywrr6Aw3C4txyJaefQql5xwkVTAN22
         Hl1KSxePHaUeS/+uCFQP3r/Wj/omPyvsZ0HlsDS2Sf8DtdbOjNaNnNX3F2AJCxoyMahD
         alkgSLjnOdG/JaxLo/Yo6QNBoMeyxwpeDMlV8gJzCY8cXXXl/qHgY+N7ihoPtM0zgC8L
         XaEgM5tv5qzkMQyEFFoLmMTDsOmfgbMuxB8bLBSK9mTZa2x6kaMnoDoYGyxRB/ljWrrS
         AvnA==
X-Gm-Message-State: AOJu0YzibyiMrrHoSC5TYx2svuHOWU1j9h523aDtR9jGuZLNbGDX5brn
	moZfS63xAwmGOXdjFxBtWknrr4bjCp8WyBMNtDv2eBCsL2XhlMjWgoiKfrYegA==
X-Gm-Gg: AY/fxX56dQP0Jgo2apMG7yLLk2tZq6hM9LXz9P67pp5YBEFgvRBRLLPKrVG6gewJoSh
	tJzXMGlQdsaDffKtVA8PLXyQxQO1Hky+m9mIVIP20YXG6bk0XYJ1LrK/qJqouEYV1AqJu3o65XM
	ZgvIgVPl5IbJmi2z2XKiLt3EapZGnyL1+9Hn2m7k1SzcuRkGMuCqtHGEGlrtXgMH6DGTh/jjUmf
	Z0I4X6N0QfMzsBAtWJC9Vmq5X2DEIyXNnINe1kxmgB5Ez2MQjsm+ghqr37ElIiMlQzmisjEYRFO
	2yPThLVhjcI+CZaDcf97F94FiZNM/pfc3gLDMXixbfXp1EhwNsSzEP34uvf2qR2uO2av00xH+9Z
	YwtDzjgHwIBUtlKbM6BTIxZCn8AUQo0B0werNCAQ8egKUf4UvdZirMLOKhBP1F2AXELrF2sd7jJ
	2hU3ZvrQzMyYG/7ZQ0SI6sI5v1TVWr8ueWwrnj7tKAduLKOA==
X-Received: by 2002:a05:7301:9e43:b0:2ae:56ef:c85d with SMTP id 5a478bee46e88-2b6b34b2b47mr117017eec.9.1768495010736;
        Thu, 15 Jan 2026 08:36:50 -0800 (PST)
Received: from [192.168.1.99] (23-93-72-44.fiber.dynamic.sonic.net. [23.93.72.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619b49sm58490eec.16.2026.01.15.08.36.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 08:36:50 -0800 (PST)
Message-ID: <12239ac3-bc9c-4484-8633-a255a706011c@gmail.com>
Date: Thu, 15 Jan 2026 08:36:49 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: Repost: Inconsistent Behavior in 'git add' (git 2.52.0)?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Any response to this?

Should I submit it in a bug report even though it's
probably not a bug?

Thanks,
Jon

---

A while back (6 Sep 2025) I submitted a report about how running

     git add x bogus_file

where 'x' exists but 'bogus_file' doesn't results
in 'x' not being added to the index. Peff was kind
enough to explain that the presence of even 1 invalid file invalidates
the whole 'git add' command, no matter how many valid files
are included. OK, fine.

This morning I was experimenting with what happens if a file
is specified on a 'git add' command line where the file exists
but is in a .gitignore file. I was expecting the same behavior
as when the file doesn't exist at all. Here's what happened:

% ls -l file1 jon
-rw-r--r-- 1 jonf 15 Dec 30 15:36 file1
-rw-r--r-- 1 jonf  0 Jan  4 11:19 jon

% git check-ignore -v file1
.gitignore:2:file1      file1

So far, so good. Both file1 and jon exist, but file1 is
in .gitignore. Just for yuks, I start with a clean repo.

% git init
Initialized empty Git repository in /tmp/fish/.git/

The index is empty, as shown by
% git ls-files --cached
%

I then ran

% git add file1 jon
git add file1 jon
The following paths are ignored by one of your .gitignore files:
file1

Again, this is exactly what I expected. But, running
'% git ls-files --cached' shows

jon

This is *not* what I expected. I expected the 'git add' command to
not add anything to the index, the same way it behaved when I tried
to add a file that doesn't exist (see the beginning of this message).
But, apparently specifying a missing file is considered a different
kind of error than specifying an ignored file.

Once again, I'm wondering if this is expected behavior.

Cordially,
Jon Forrest



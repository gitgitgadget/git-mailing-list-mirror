Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D1A55
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555200; cv=none; b=myaJCXX39VfgGcsQ3ILJF+rd9viTFGOsEI227QwkEM5MHCyJIdD+3B284Dm4rcIgb8TfF2deKDccy4MeLqQbtzHXaeCsKHDatxZuo30rd6YnxHvRqjbEIDxa6Bs+FIwmbWDVeNkTiNhgWM+FE6ikIIrWpTS4StgdppptoiDYZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555200; c=relaxed/simple;
	bh=cHyTX69d+CppTj1iig4AHVKdeWH0lCVPqogz2opKphg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hGHRcmmBgTPzj2b8WAkuFC2+iK6FgOW18PCRt12/UusQBikZVJeY4Qd8DkpvtPK5UA+HnX8X69XRriyGC3x+U/XN2yIDvZw/iCOIEULc+5wg3aFYsvN3uyOniZkygu3ONEQDXfLa71XxB7OF8T9kZWKDFvSI8UEsZ1lsJOL9bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ies57C9j; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ies57C9j"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a07fac8aa1so145227235ad.1
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767555198; x=1768159998; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dq6yyYnaGN5ri8y6rWS+O+vCg2QXr9J66SsNwPgCsQg=;
        b=ies57C9jfXArk5PjZEviZaUpENx03S3Fqhyjxi8qFXhQUKA0i9WhAbbXMz8O0f4rBB
         YcQ/N4N+n1ZEe9IXogmrNb6urQQxMeXmAuC5uTXmIKtw2gwoN1ZP6AsKdDoBM/wuLvK0
         wkuV8kJYMlks+V4Cum7eBbcxfbamchf6LTL6MRUStG/OiYrca+6n17oICG4+T5LdVLYi
         7FYER0vbo7Tuk3XWHkHOaezxNkh50ubQKXt0cyyunHlhciC48n4LCG7Pj0j/c8LX4e7N
         SEnFIV3SXoYdtFc3/rUYAYrnl4wZLjFZxwU0Srs5ggsq3oIJT8UtCVLwZ9ce9uRZt2+B
         1juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767555198; x=1768159998;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dq6yyYnaGN5ri8y6rWS+O+vCg2QXr9J66SsNwPgCsQg=;
        b=Bsb2w9tFR9QoddxwAu/+nDTzkBz3IN2DWLD21gdvrpo0f6R+dkoBiqFbsmpPdZhY4Q
         sW/bFP9PXEDUXJeghW7CBzlre0/4F+acNxkCaAsrMnUK5sEXwHPW9MulKs0n4FLLkICV
         KifdrTpLuMYxby3sMSkvfKfvUcrCV+SYXXfRI4UuZydVZfu+7Yo/laLutAK1hgoZ9knc
         u34mtbiS+E4EpHitZ4y9WuApyNP754Dk1iSz0lxfXwybsqe4YMD3EJAjgG6y7r3402XM
         7+zPsBfP1h6/g4KDSJoB788YeufXB8MHB0Ko9Y5BvSNrUVjJFQMHONyE+Tww/Xzc7qem
         qiCw==
X-Gm-Message-State: AOJu0YzaZURFzMAgusejyR0qvhRN/nfFIgbKgO+/rFtKiBrLJYmB2aAL
	Hp+ocH4XKdFlSlkcKBjKqVt8gUFBnNcV7lVK8jWPvAcVW+dcBeYIBVRQc8Txuw==
X-Gm-Gg: AY/fxX7yof/XVnmRP1ZTeJzMj2EsB/pc+u5ryyMtMwZqfYhkXi+PixOUT7ra5C000MC
	UwlinBEm1o13c29oB/s/Gj7Sbdyl68ZJSkL2APvRJjkHV+OhJ59X+DVwUS5GpIta1tv7LyGz9yD
	2RiR05caJ8RZgpZUuHxMLZCv+AtSC86kyHtz9Re0bxtcrwbqwpRCaeVqsmy2nRPoMVa1wuv+aj8
	2LLVCliqs+Qj/tMeCjo1y825GD9Q8PoENLwwCn0e+W7bRS3lXT8PdltmzGdT+aqdRnnACHObzdY
	N2cEPbT81pXZzGSK2rVOkoy/LpJoT6PIxfyCatRvPXCtdgrJ7LHGygv7BoD/vKUSaMBvKqTIco9
	260Tr97QfmnIboftL4shRxhf5jxqr2fnOfB/u3TJAd6YWqOsNjQPJk6caNDCPkE837v+aCINJNU
	KO1qbrW2IG9a5SSjOiNNDBiQS6o/4bc61Afe+1jxT04OmmtQ==
X-Google-Smtp-Source: AGHT+IG0hj1BuHT33XU3dBSKmkpNvbt+ds0r07MwXZYXcMzA2FZZ1+4YY5yL4WtcXdd8IUuYq62m0A==
X-Received: by 2002:a05:7023:c087:b0:11d:f5d5:f699 with SMTP id a92af1059eb24-121722abe01mr35298278c88.20.1767555198217;
        Sun, 04 Jan 2026 11:33:18 -0800 (PST)
Received: from [192.168.1.99] (23-93-72-44.fiber.dynamic.sonic.net. [23.93.72.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e38sm9594196eec.34.2026.01.04.11.33.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 11:33:17 -0800 (PST)
Message-ID: <292537bb-e903-4baa-929c-6ffd0bf55a8e@gmail.com>
Date: Sun, 4 Jan 2026 11:33:17 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Jon Forrest <nobozo@gmail.com>
Subject: Inconsistent Behavior in 'git add' (git 2.52.0)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

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











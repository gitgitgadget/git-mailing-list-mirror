Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535C1E521
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254495; cv=none; b=EhJ38LiGZcqH7GKO5vxttC/BsWwsohN3TGP5HLMf/StKNM6cPXxP7MXw0CaFpuTo0V5G8VW/1K2fplbgSYMOHmTBCEX0YX+GA2YTV5I8TtpMVGNrw11as5g5MPx4P6oM0iMy7d47HNcOm7ZVR4K619lWEU69eTjOt9e1ETkQeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254495; c=relaxed/simple;
	bh=Ez99jm0/mTCY6JV3vf4dCkdTzQTS/tJdNFv3J5e73ks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JRHUtxamg+Ihvolw3yntKE2EUpwjSyPROz8JYI0LM3I8FJpYCzvvUO77M8UXmisqiBqNhsG6YULcBlH2q3WjvDavL0NZzkbjM3iMZPD4HjxFI3ggMf3Y18Wt3q8ZdkG5yMioRGx65NY5Elh4WkkGD3/ckG0cx6lkPkgmieH21As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9i5Witr; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9i5Witr"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30039432861so171742441fa.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 04:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736254491; x=1736859291; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FinsT7ulYuOlpCjnacZtyfataVmkw4WdkqP2Q0lMKDg=;
        b=l9i5WitrkH5Rd0H0/+IMGWpETWEZptykjWDyqhiN5bZn+bv7GvjGU6/oBgWbU2+Bqi
         w7rl471PAadTitFt6P+qevylJlVKVlS3+t/PRyHBS8Iaij/UHdqsKN1MBhP81OOlqmW2
         YoUtUh8C2qj8g1tfjVjLC1RLByCBgQ6ymsi062qTXyRyd2ZHMMK/CHfbBYq7YBkKTUeC
         ovkrFBJqXKNSGiBQp65CZ/6QjxCIGFSnnYjm/TkMKR0buVuI4TsZdKdDC2hpBW0GQM58
         Xe87HNy+WvCvu6De8C/+Nk9PFDggVUo05hWjXa6BtlrQhlct/TPN5o3qw/qgFghQoahE
         JMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254491; x=1736859291;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FinsT7ulYuOlpCjnacZtyfataVmkw4WdkqP2Q0lMKDg=;
        b=VAP8I0IwWE8yyVyKzWY5qAYBLCBlhk/pLk9IHSrNJZq5WGLfPujmlR6KRVdNLRosP/
         1Zuf8NQ08fMRTrBzyxjx+c3TCyrI2ZFmmepQc7at+nmfliTkRsTNmox2iRIlchtBmjuW
         YbfdLUq8u+X8eP3uG0kc3em4MIG2tlgoOT6R0oJhmQnTuLXXcAwjROqrUSTdSnfcZTul
         1PGLSLx4/Mmq41jg2ZlkMRXvh7M0RQm6EATGOi3r29SbF0+wBBO48sL28GX1bTo8pL4r
         4QOl1h4gcl43k1obmjZzbvUzBaMzUDGUFLglJWx0jtUpdltydgvvwssWsffSBss7/JI9
         ILYA==
X-Gm-Message-State: AOJu0YzApE6dIoZ6kzxC0OUiaPqnmbp5ahSWGzTWd1AgK46LJS5FW4pn
	gGWmjXxcbGLaSzE1dghi4Mh5SjeBs8PJbZQtDbKh/Ez+Y4MJ3s1R8YoyG5nsE2pq31RXJ2ja9HZ
	Mw2roxy/VBMAZgpeXrWWNQp0N56Vs6NM=
X-Gm-Gg: ASbGnculmfMpfRKJsOXkBT+Kstzgk/HFybmyUwoRccRwbcR46cNgKKO0S3CdLPHZSaR
	UTjm8f+DjGW1+z/1wYaHIekYjYul3+uGF9kZrEA==
X-Google-Smtp-Source: AGHT+IEEwCtNdpwztVvvSHi7NoGJ7sroWGM0fUcBP567F+vQ1XeGBrG7uTRJWSzwwBHBEvJjRTjC+N5ckOubYVUNIsg=
X-Received: by 2002:a05:651c:4ca:b0:302:3355:f756 with SMTP id
 38308e7fff4ca-304685de7e4mr172889121fa.35.1736254491334; Tue, 07 Jan 2025
 04:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Giampaolo Bellini <iw2lsi@gmail.com>
Date: Tue, 7 Jan 2025 13:54:40 +0100
Message-ID: <CAHzTO8mwYp0nyhhNJUOLdarHAAjVCmuPgEfoQmRtL0-Uu1M8cg@mail.gmail.com>
Subject: git status to show only ignored files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

   is there a way to set git-status to list only explicitally-ignored files ?

So far I'm using:

    git status --porcelain=v2 --branch --show-stash --ignored=matching
--untracked-files=normal

but I'm getting also a list of untracked files and dirs (prefixed with
the question mark sign)

# branch.oid 7afefc0fc6542ea00e478eb61811d0830abb4134
# branch.head TEST
# branch.upstream origin/TEST
# branch.ab +0 -0
? .gitignore
? Configs/
? Logs/
! Configs/non-tracciarmi.txt

Note that:

git status --porcelain=v2 --branch --show-stash --ignored=matching
--untracked-files=no

is not working and reporting "fatal: Unsupported combination of
ignored and untracked-files arguments"

   thanks a lot

           Giampaolo

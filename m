Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3763F9D5
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527243; cv=none; b=PEW1nVCYYe89xRrqj3HRW1DVniYzsF0IXWLu5ukBEWPWcjcvVUg5gJ7WvaOBeVTsM2qFOYBa4iTi+QFyEl/EDthWivYJmBGlOZH8Hv5qrBs6zvitNzrrZKIBn2xNGxho9bNzCuDiO8MTAU7+kx8PL0Arj+b66IH1ho2X04QNOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527243; c=relaxed/simple;
	bh=4lHXb4vu+n5WLeyYJzRxLgtXD4sHEC5dHUrPUTQ3vbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ebnbWnxnkFvncjimsdlWzJB+zK9Au5OXjVafSzlLg63dY8kP+hwNaQdStbZ2tUMks86QYwuY/i44/ulfRsZnBjYdJXsOP1WjCXv1sVUJz66CwbN5WIuUXyJiEbdFGLjExwQUcKPCw5O/n84DE6JX+zC9ZkQQR9/3iUY1n5ETI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guf9CWBP; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guf9CWBP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so2568622a12.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725527240; x=1726132040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=627ylYWW/utZNEZnMnCNMPfqitz4d+x70VS2pOXy+N4=;
        b=guf9CWBPlIcYdw+Uv3D7y+8YoHl8nSGMGcR1Dk+L0cdTkstLbmYDumClnCqDqXPoqO
         vX9j3FgNj1N5o/IZfNdgqIfaPlu9HVQZBz9Cfll57Wa+0AmECIHoXMm9mnSwl+pqOcNh
         36D0j2HMgUjaDf/M9GDyj+F2bWquVMXiau/tAwpttAn/H4o/0jXjkrXK5IXWBFTjBYel
         qhCA131jbyCAvZvKGijflSlmv+eXhKmBOHQqZrG2eooyaBrNOkBPxplOSNUKQEPxPkoj
         1WEZ05UVll9+/0vLLG7TgJP6W5BS8ErCPDGsR7jSrYTfdJQqyCpJXPDMjpFbn0m9lU8P
         PlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527240; x=1726132040;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=627ylYWW/utZNEZnMnCNMPfqitz4d+x70VS2pOXy+N4=;
        b=F19Y6V/XJx00JAu5zYKWebbXSh3wFEHPHXpb2NZa2+vKI//TLqPt2OBN7BNioGhvJQ
         tMTjtfi8+Zi2fBalN3APG3OHF6z1asHBB5RgXXvUfHfOnqln5tCHSZPpGDGN1cgehWsK
         dfD8eXN3xcsAz1lLemGlpbSLHYirr6/UG3dFa+tmWAbtyqgfsqe4BYKpe5jcu7hwzcO9
         0Nj21ypo3jy7NXOA0VjX8O2HP5HKM372QyALOWMBbxDHojOJ2fpJpIC1TyzN2cJsfMtB
         cP8a2ttt5SBKh+Lma+jBCSIGwg5Thg9tj3tqds8Fk9jbFfR3K1ksZNPfraKimXae6fCu
         ODVA==
X-Forwarded-Encrypted: i=1; AJvYcCVmCbOwjfQw1QgU+Cb2MwhYUMLaERLDToVlbJHNX0pVQE9XxX0jAs/M5BhHzz1XMnAim9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuhPZAoFgawE/czbW2oJ5oJrhyka+USkCKTQLZt/sojGSqaAMH
	edtv2BFKb+3BVZNDIAZMRC0gB85dTjrTjorheHztVRL+BPO04T5UZIdTlw==
X-Google-Smtp-Source: AGHT+IEx/6Z2jgx4AQZbMUNlHFQSR0CIjII90Jizyap+8I8O5kin4sprNyR0NFR7phbeQKWmLqYjWw==
X-Received: by 2002:a17:907:868f:b0:a7d:8912:6697 with SMTP id a640c23a62f3a-a8a42f8afeemr489708766b.3.1725527239544;
        Thu, 05 Sep 2024 02:07:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e285asm106572566b.207.2024.09.05.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 02:07:19 -0700 (PDT)
Message-ID: <612756e2-fc84-4d49-9f74-ff1998f66f7c@gmail.com>
Date: Thu, 5 Sep 2024 10:07:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: =?UTF-8?Q?Re=3A_=60git_remote_set-branches_=28without_--add=29_=3Cn?=
 =?UTF-8?Q?ame=3E_=3Cbranch=3E=E2=80=A6_=60_does_not_add_refspecs_to_=60remo?=
 =?UTF-8?B?dGUuPHJlbW90ZT4uZmV0Y2hgIHdoZW4gYHJlbW90ZS48cmVtb3RlPi5mZXRjaGAg?=
 =?UTF-8?Q?does_not_exist?=
To: Han Jiang <jhcarl0814@gmail.com>, git@vger.kernel.org
References: <CANrWfmR1y64OP+506JUO3Beic9kn5_TrhMQ1ZucVcDEn03noLg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CANrWfmR1y64OP+506JUO3Beic9kn5_TrhMQ1ZucVcDEn03noLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2024 11:37, Han Jiang wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)

It is always helpful to show how to reproduce a bug but please try and 
aim for a minimal reproduction recipe. It is much easier to follow if 
you show which output lines come from which command. In this case one 
can reproduce the issue with

$ git remote add test git@example.com
$ git config --get-all remote.test.fetch
+refs/heads/*:refs/remotes/test/*
$ git config --unset-all remote.test.fetch
$ git config --get-all remote.test.fetch
$ git remote set-branches test main topic
$ git config --get-all remote.test.fetch

I haven't looked into what causes this. I wonder how likely users are to 
be affected - how did you get into a state where there was no fetch 
refspec set for your remote?

Best Wishes

Phillip

> cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
> mkdir --parents -- './server' './client';
> git -C './client' init './repo'
> git -C './client/repo' remote --verbose
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote add server 'file://'"$(realpath
> './server/repo.git')"
> git -C './client/repo' remote --verbose
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches server branch1 branch2
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches --add server branch3 branch4
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches --add server branch3 branch4
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches server
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches server branch1 branch2
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches --add server branch3 branch4
> git -C './client/repo' config list --local --show-scope --show-origin
> git -C './client/repo' remote set-branches --add server branch3 branch4
> git -C './client/repo' config list --local --show-scope --show-origin
> 
> What did you expect to happen? (Expected behavior)
> 
> (local config has branch1 and branch2:)
> remote.server.fetch=+refs/heads/branch1:refs/remotes/server/branch1
> remote.server.fetch=+refs/heads/branch2:refs/remotes/server/branch2
> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
> 
> What happened instead? (Actual behavior)
> 
> (local config does not have branch1 and branch2:)
> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
> remote.server.fetch=+refs/heads/branch3:refs/remotes/server/branch3
> remote.server.fetch=+refs/heads/branch4:refs/remotes/server/branch4
> 
> What's different between what you expected and what actually happened?
> 
> Anything else you want to add:
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.46.0.windows.1
> cpu: x86_64
> built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.9.0
> OpenSSL: OpenSSL 3.2.2 4 Jun 2024
> zlib: 1.3.1
> uname: Windows 10.0 22631
> compiler info: gnuc: 14.1
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe
> 
> 
> [Enabled Hooks]
> not run from a git repository - no hooks to show
> 

Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524941945C
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=elecard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elecard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elecard-com.20230601.gappssmtp.com header.i=@elecard-com.20230601.gappssmtp.com header.b="EHlYUNN0"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50d176eb382so6100365e87.2
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elecard-com.20230601.gappssmtp.com; s=20230601; t=1702993175; x=1703597975; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sETaOohgW2mYzLhWm2jqBpVQHD7iYEwEzMT3Bvh+EMQ=;
        b=EHlYUNN03g0Viv+0I1ywB66MVVvhNzYzbdEgO1egPaoENvxCDx5ltlXRKO6BHkESdk
         P0HEGLuzZ0iLEC3Iz5HWwdul1f3pp5XDK+FDPs82K4tbBv82O8NKGHmvqPKRi3oUyTxl
         L2pdl5KR21gQ3HNSR90gDHDA9FhP8FylT0VnyRwQMhIE/HJBDTC7rs/H2Eadfn9x3LGZ
         HwElW5Le1Ldjw3b/OZ2CDRTiIF5UgvAr4v3Tad8V7vR9AcTuEZaJRu/6slpj4owbbxuG
         JRxt+d77j1XkLIb27k7fQOW5IiT5+mGLpcHxIPTw8UgytK4Ex3gZckaAE4FE4ghkcV6S
         Y2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993175; x=1703597975;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sETaOohgW2mYzLhWm2jqBpVQHD7iYEwEzMT3Bvh+EMQ=;
        b=t8wtGPZ/6MZpD5LCssbBurH1Cr4ia13mXaSJQeE8Q33trPXVZXyzji0/Se1BKkDSBa
         FmlYt1On3g7lQ7vObgZEl0CrkMLFArvy0R8wjzljjbgL8e0sotHNNqVFrFktTVef08ep
         CFVz5BZUKEOMwm852roA6e32S1CFeM35/pJjXtBXS9TRBigv7Jj5mLKytMfnaFSJezif
         gP1vh/ihPKmPI/Wci/wUSgq0HQgY0iS/Z5rdgOEUij4PRqQ7Mb1EeVWYvGGzxiveyqB0
         4yglsQGuee/z5qeV3cldPaBeSIiRoDt56TvP5sNGPFCkpZp0cLshmkPd3Tk+rGLJAoqm
         E/rw==
X-Gm-Message-State: AOJu0YwuASv10EybKscqyzRlJosbbXT2sItQQB8sWQJ895MhKeWec3R9
	m09Gw7BoktFCWgyHvRx0gcHDjXySNOx7yNWlwog=
X-Google-Smtp-Source: AGHT+IG5XisbpFjndw0jlBvBQLJG50bO0sFvY8UDTtt+Eo/EN00+UoC47+Rw7SdvZYhGa7kaed3a9Q==
X-Received: by 2002:a05:6512:3d1b:b0:50b:fa7f:6ebe with SMTP id d27-20020a0565123d1b00b0050bfa7f6ebemr11262963lfv.20.1702993175388;
        Tue, 19 Dec 2023 05:39:35 -0800 (PST)
Received: from [172.16.3.59] (gate.elecard.ru. [93.91.165.2])
        by smtp.gmail.com with ESMTPSA id b26-20020ac2563a000000b0050e399c2a50sm547662lff.141.2023.12.19.05.39.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 05:39:35 -0800 (PST)
Message-ID: <535d231b-3351-499d-abf0-b571dbd3c965@elecard.com>
Date: Tue, 19 Dec 2023 20:39:34 +0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Anton Sergeev <anton.sergeev@elecard.com>
Subject: Problem with commit-graph verify
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi folks,

I have a problem with 'commit-graph verify' in poco repository ([1]).
A commit appeared there with an odd timestamp and time zone ([2]):

     git show --no-patch --pretty=%ai 
381ac1d9a82c9682a5046dd51802a687a81ace91
     # 2106-02-07 06:28:18 -11309508

The main problem is that the 'commit-graph verify' return error:

     git commit-graph write
     git commit-graph verify
     # commit-graph generation for commit 
1763a5017d8c0a9af6094fde91c43a5722bbde4c is 1699836629 < 4702109779
     # Verifying commits in commit graph: 100% (9489/9489), done.

     echo $?
     # 1

And this results in an error on fsck:

     git fsck
     # ...
     # error in commit 381ac1d9a82c9682a5046dd51802a687a81ace91: 
badTimezone: invalid author/committer line - bad time zone
     # ...
     # commit-graph generation for commit 
1763a5017d8c0a9af6094fde91c43a5722bbde4c is 1699836629 < 4702109779
     # ...

     echo $?
     # 20

I found that first error can be masked using 'fsck.skiplist' file. But 
can't find how to mask the second.
Is there a workaround for this case?

System info:
* git version: 2.43.0
* OS: Debian GNU/Linux 11 (bullseye), x86_64

Notes:
* This error originally occurred on a local GitLab installation, that 
periodically run fsck on all repos. And the poco repo mirror in our 
GitLab instance is now marked as failed.
* Another strange thing about this commit is that git can't find any 
belonging branch for it, but parent and child commits are has ones:

     git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short 
-n10 4261-move-autocommit-abstractsession
     # ac7e39ff8 2023-11-14 | Fixed indentation in ci.yml 
(4261-move-autocommit-abstractsession) [Friedrich Wilckens]
     # 543ea150a 2023-11-14 | Github workflow: re-activated 
linux-gcc-make-postgres [Friedrich Wilckens]
     # a2d10dffe 2023-11-13 | PostgreSQL SessionImpl: reuse autocommit 
flag of AbstractSessionImpl. [Friedrich Wilckens]
     # d32f62031 2023-11-13 | MySQL SessionImpl: make sure autocommit 
mode is on when session is openend or reset. [Friedrich Wilckens]
     # c919b7f79 2023-11-13 | chore(CI): re-enable mysql [Alex Fabijanic]
     # ffd0007f2 2023-11-13 | fix(Data::AbstracSessionImpl): protect 
autocommit feature handlers #4261 [Alex Fabijanic]
     # 1763a5017 2023-11-12 | Brought MySQL backend in line with 
_autoCommit flag of AbstractSessionImpl. [Friedrich Wilckens]
     # 381ac1d9a 2106-02-07 | feat(Data::AbstractSessionImpl): add 
autoCommit property and tests #4261 [Alex Fabijanic] <---
     # 18eea1bb7 2023-11-11 | temporarily comment failing mysql ci until 
fixed [Aleksandar Fabijanic]
     # 6a5387ec2 2023-11-11 | add visitor pattern implementation for 
Poco::Dynamic::Var (#4144) [Alexander B]

     for _c in 1763a5017 381ac1d9a 18eea1bb7; do
       echo "* $_c:";
       git branch --contains=$_c | sed 's/^/  /';
     done
     # * 1763a5017:
     #     4261-move-autocommit-abstractsession
     # * 381ac1d9a:
     # * 18eea1bb7:
     # 
2366-pocoprocesslaunch-unix-possible-memory-leak-when-launching-invalid-command
     #     4261-move-autocommit-abstractsession
     #     569-DateTimeParser-cherry-pick
     #     devel

Links:
[1]: https://github.com/pocoproject/poco
[2]: 
https://github.com/pocoproject/poco/commit/381ac1d9a82c9682a5046dd51802a687a81ace91



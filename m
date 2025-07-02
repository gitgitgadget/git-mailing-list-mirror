Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08751F1306
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488128; cv=none; b=gsD7xGG4l2c8Xg4qNANOMOw0lgAJQZCw1xJO5zMH7z5R+3G4pwKtvaDaT1+kT4QDhpq/3RVArff2v3BkTNtjdWPrrh0Zkiohd+ZcwYenawBA7tbr0HA9lqzYQTBwE7zNEp/2eiUsf7nl+2SOjO6By3Y9cSw0Pxo0TiYuZWtFDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488128; c=relaxed/simple;
	bh=X316NTpgTq4+mY9GjdR67UCJak3jFrr6DzEmU0GsEqk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=agi5ciC/gB6cTE9tudxE2mxbUDCzSU6czCKb2tRRGZsPvWe5Y6E5Dd6a5TXBvxZb/L9VKRox8zlkALGwCM5E2O73Cqdsid0XbHN3Bv5M72de97rrTJI0hAwObg4/O3MkdiBAHHYOmsX3T2yrkXjK5n4/9Apygl/N3+xgbczeUBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIzozMmF; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIzozMmF"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e05bb6efe0so3720685ab.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751488125; x=1752092925; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxv0Bwi3FpLVEY31OFzWBYhhGOt/3TGa1ct2FGDZKh0=;
        b=PIzozMmFw46n20ASq/KKf/L42ZRu8Faq2urcp+lI/Z7c/G1WsClQXWlfgjmbjPJ8g5
         R28H0eMaa4xfInypK0mpU/XANhP1X3K/poM8uAnPNg5cmr6efWy8TyCxP2Ax0dRVC81p
         eV3KZqk+zhi66mmZgji8E80JJIzsenYLQ3cbiLr8DTik4PcgZsTMNoHZCG69BCTudlo7
         B6aJqDDWEqmPNSreCiWFsnJ3RyExIkPFvocJBQkUhana4zr6HcrZbNgJ1dsVuULBDhjJ
         lxsRJUCfc74qGHc9cN90wE/sjolrH2ORVYTKVqtOqGhJ7U4gEC7sF9CH03NvPkRfcorB
         nfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488125; x=1752092925;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jxv0Bwi3FpLVEY31OFzWBYhhGOt/3TGa1ct2FGDZKh0=;
        b=O4L3vYK5A+ELq4UM2rnZJHty24c7qGrGeeHCspPc5HkHmYK8J8f8ufSmg5Xu6s7jMB
         dz8hBnBnCnPEvAu7+KJrq1o16XLkInO6bB3AVKjddj1c2IbJdR0YqkNhJoqmeVtdDShj
         yyOJZNlVskIqTsGxRNoAfa0ea4gCldqwh8lVj1C8zCO/Eo4nVg94Oo4qjF7Wr8tUehdP
         qDINXWuPzBFgkRpQIrjGqcC+pBor47PNhDkzTNtHda9Nsjb6qepeR2vvxPZSTvmJ8yew
         QxOq12HKbnzS4++vGcEggdzTDRvWflz4v0SwloCcaun/Z6nYLkfKsAdXN00WI+MYxDg6
         rV8Q==
X-Gm-Message-State: AOJu0YzUZQnN0PSoLwglv7V3zxAZU4O4cR7QvTB5UWXTXAzQ7X2aAzKM
	xbXBx8u/XwZ1uJfRiCjyNf7XBdNO2vb56PXBlfv4oVsvdoHM4L1isDoK9sI48g==
X-Gm-Gg: ASbGnct1LOkwoCxhA0mohTEShPvKj4JaIfRigUm1qbn3TGAo+RzBJv9jExk1/gPGi27
	oj4lK3axATK7xzmU+zEVrp4RktRFdkmiveWJqHJtpRWu+rKwRjS/7ChwjKdWNzHqdw3nrrGUeVv
	QRDYFJS7/MPiwWx2kFaSTCcKyzIegU4kpIJbQwnATWFlDcTnQks8cGFdDEgt3yspNpv6YtR3MYE
	fnfRxSURyOU4KBrsw0Ykr6F0zeZkkyIKH3NPpkeEE4+HKpC1xloEI05uO9GiqYayrBm+wUYoKAe
	Sti99y+FfEgaVmVB+Sf18jYkgXsy+bkmji37idKSOsedcxsQWf6GGes+x+XxTz5ij7Hq/0snxGA
	XTgwjxBd62d+rXgLf1baL/Fisa8+O
X-Google-Smtp-Source: AGHT+IE3iSKKFMx7FEQ/EJKmL70qr7DE0R7xTLjNn/OdQz+PRvoP/T5DBZ+ylh9d14LBX52tWMqESA==
X-Received: by 2002:a92:c24d:0:b0:3dd:b7ea:c3d9 with SMTP id e9e14a558f8ab-3e05c94a668mr7442765ab.7.1751488124789;
        Wed, 02 Jul 2025 13:28:44 -0700 (PDT)
Received: from [192.168.1.105] (c-73-176-204-61.hsd1.il.comcast.net. [73.176.204.61])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-502048d7d5bsm3097572173.61.2025.07.02.13.28.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 13:28:44 -0700 (PDT)
Message-ID: <64308d3f-281b-49a3-bc10-57878903bf4c@gmail.com>
Date: Wed, 2 Jul 2025 15:28:43 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Eric Salem <ericsalem@gmail.com>
Subject: Behavior of git log --diff-filter=d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all. What am I doing wrong here?

The git log --diff-filter documentation[1] for deleted files says:

> Select only files that are Added (A), Copied (C), Deleted (D)...

> Also, these upper-case letters can be downcased to exclude.
> E.g. --diff-filter=ad excludes added and deleted paths.

A simple test:

$ cd $(mktemp -d)
$ git init
Initialized empty Git repository in /tmp/tmp.xnvNav956B/.git/
$ echo test1 > file1.txt
$ git add file1.txt 
$ git commit -m "first"
[master (root-commit) 71288dd00aff] first
 1 file changed, 1 insertion(+)
 create mode 100644 file1.txt
$ git rm file1.txt 
rm 'file1.txt'
$ git commit -m "second"
[master 6ff8f522b744] second
 1 file changed, 1 deletion(-)
 delete mode 100644 file1.txt
$ echo test2 > file2.txt
$ git add file2.txt 
$ git commit -m "third"
[master 41498d26ea5e] third
 1 file changed, 1 insertion(+)
 create mode 100644 file2.txt
$ git log --format="%H"
41498d26ea5ee6820834aa51351e1e7ce6ce8733
6ff8f522b744dfbc7c2201c5bf77cf5acc3028ce
71288dd00afff60f3a6576f93930aeb0130e5cd1
$ git log --format="%H" --diff-filter=D
6ff8f522b744dfbc7c2201c5bf77cf5acc3028ce
$ git log --format="%H" --diff-filter=d
$ git log --format="%H" --diff-filter=d --stat
41498d26ea5ee6820834aa51351e1e7ce6ce8733

 file2.txt | 1 +
 1 file changed, 1 insertion(+)
71288dd00afff60f3a6576f93930aeb0130e5cd1

 file1.txt | 1 +
 1 file changed, 1 insertion(+)
$ git version
git version 2.50.0

--diff-filter=D behaves as expected, but when using "d" instead, I don't
get any output unless I add another option (such as --stat or
--name-only).

Is this expected behavior?

Thanks,

Eric

[1] https://git-scm.com/docs/git-log#Documentation/git-log.txt---diff-filterACDMRTUXB

Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10379475
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058872; cv=none; b=gGCXUtwnPvd3Yyx5rmc9x1DrpURdRFF7DkgabRhpIudwup908/7nzfM5a502BJcCNWOwLQL+SfhLepDqCoc1sy6vvU4O6M2iIWkzOST6KkxAHYBf3PRsxhikpjAciDeuB8Wnp4j4u3RvnmzWmZsFUIZWDSf74k4Jj5p60uU2uR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058872; c=relaxed/simple;
	bh=crQmYzMYL1bHTUV1Gjju2hKedp0Lk26vDpwnhrt5E4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=dWnH8oMpbooy8eS51HXcfPEPlTffQgYU+aWyeiknwbYshWsgWdlAYq/qn52JF9h/vPZ+kGejaX4o8sRsCoLtae2idUpEYyHyK53ZuncKeWAnPxqKsnJ8Ji24BF9OW1jhfDEbkmoW1WeA+ZIy6FyPNg7PUoP5KeZ+fXWOiywhFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/2t6VlO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/2t6VlO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso48011885e9.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 07:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058869; x=1747663669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i6Zg5VLa3jOR+P7xddo8DMp09S88xjGgcIP/bs3ftBg=;
        b=c/2t6VlOFZmhj5PtouvcXttfSXHA90UvaN6gzT1QWXt4LMYs+/RPWgqbLA4XLi6bcI
         YC8wBiyRSknFH9HAkTS+0lcK7TdANpFFWvXTt+6ZekS2z5XlBmp8ALVr+auvlGsO6/di
         n+yVju9yyDoCaW1iZogk/2M/ui3pC600XnFoTGPZKccG5eRYTNoMe24pyhCHb21gZsjs
         Va0hDpb0qSOHdE2BDbOyyqqpn7dSnoDbunPlNQ4l+tyZnK/9IDDf3Or6jvAshyfd3Mfe
         OcUUyAI3+Tknu1N+w4/QA+uKfYRd33Izua696Dcph7qrA1Co22ktQkhxtG/muW4tj4UV
         cw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058869; x=1747663669;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6Zg5VLa3jOR+P7xddo8DMp09S88xjGgcIP/bs3ftBg=;
        b=ibB7cCJ/IiEAX78fDJDdaeL5zy40/HjwkbtFM3TgNEGLWagrImpuLAfAj/66I9O9+P
         nakFz1PGq/I0yyJgShehXrLsFWuti7uAMnw8+okRw8ZNQ9e3oNAiRTS57atAF9ElAkO4
         z1QTdxk4rntzm167iLYlhs4i1D2bBXRQwsfQJxnVaXagM8w2RiKNj5oA1F3HaHrWkEUO
         c/a8c/2RmUGUvu5RwYQuDlqo7xes2jCMdvHAl0qFYu1eZlEfp4f7vORzjyvbyvG6GZa9
         F0VGTeicT2EK4zBuyTobLu4YCQR2TSOMXI0OMaWe9TFywVcZkNziWAdFwo9HuYYYx1RW
         CZmw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBxLbPXs3KPrqc4BVGPB9QnebsYcN9uWw0OS9pxcmJufa+X94J+/gVsa+/BOX2spqm8E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+5qhfOPmqdUNhklqXAPOWiq1vsP9ctqN14rkxf4HZlVd3NSl
	kEqsVIACtMjVXRFIJy8F7iPTMur2PEHY05AAQQSUVxqnqdO+z/Sd
X-Gm-Gg: ASbGncuB5VGdRi8KEYA5VKkDoNkRs2ymYzxK7dpgX2ZUsiT3LfmxMRwGKXOPFKMdaSO
	fRgjkYqBECxhenvR4A1Zf/jXje/NdKVUTyol3oJKMwKvdlqGPpb063nJWB4SevOHcx6CzqHG6Gy
	EkB5o3fcvx1zwCHX8ZmstD8IvqGFSXWN1A396IX8W44ugzUjp6mW7UJleyQ8OoiL/fDu/Jw1NP/
	ZIyluNbgSJ4hddf1t97xEaSmTDdrSOCH6mtVI2KivYSipUD1bK6zJ7rGpJ8FrQA45O9yxvNbgEj
	i6NLHowIVawssiXd/m8wAGQBUBBRbhZ8ieOhWdy9FSIL1f0RbycDDv3gH56PSqMHPV1FwWRhXsj
	j+ezpTvVWsu/Iloxcq4+HW1jqLL0=
X-Google-Smtp-Source: AGHT+IEWiiEegcnFI5JjRxI3Nzp5CiBgtJMCzylWdr+m4fyYrghw8CIZZoLl015EZgtOQGRqo0Tr/A==
X-Received: by 2002:a05:600c:3d05:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-442d6db8d28mr100207895e9.21.1747058868667;
        Mon, 12 May 2025 07:07:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67d74b5sm128125335e9.2.2025.05.12.07.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:07:48 -0700 (PDT)
Message-ID: <6bebcee9-1315-4ec3-a49b-d767f0f67bf7@gmail.com>
Date: Mon, 12 May 2025 15:07:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug report for pull --rebase
To: Mr Bill <billc56196@gmail.com>, git@vger.kernel.org
References: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>
In-Reply-To: <8c075e6e-c28c-4146-66bc-9bd7bc705611@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2025 22:36, Mr Bill wrote:
> 
> Hi, I ran across this doing a pull --rebase using the current master version of git
> 
> This happens on Slackware linux, using git HEAD, version 2.35.8, and 2.46.2
> 
> I have a clone of the ffmpeg video package, with a few custom commits on top of it,
> I periodically fetch and "pull --rebase" to update the underlying ffmpeg code.
> I tried this recently, and my custom commits disappeared.
> 
> 
> I looked further with a small test, and it looks like this is happening:
> 
> The setup:
>     "base" repo with a few commits (A, B, C)
>     "clone_1" cloned from "base", with a few extra commits (F, G)
>     "clone_2" cloned from "clone_1"
> 
> Add a few more commits for base (D, E)
> 
> Then use "git remote set-url origin" to point "clone_2" to "base"
> 
> Then, in "clone_2" do "pull --rebase"; the F and G commits disappear.

After the url is updated the reflog for the upstream branch still has
an entry for "G". When "git pull --rebase" runs "git merge-base
--fork-point <upstream-branch> HEAD" it will return "G" and so that
commit will be excluded from the commits being rebased. Running

   git fetch && git rebase --no-fork-point

should keep the commits "F" and "G". Alternatively instead of updating
the url you could rename the "origin" remote and then add a new remote
called "origin" pointing to base. That way when you pull the reflog
for the upstream branch will not have entries from the previous
remote url.

> Then, in "clone_1" do "pull --rebase"; the F and G commits are retained.

That's because "F" and "G" are not in the reflog of the upstream branch
in clone_1.

It's debatable whether "git pull --rebase" should use "--fork-point" by
default. On the one hand it is convenient when the history of the
upstream branch has been rewritten but on the other hand it leads to
unexpected surprises like this. The fact that there isn't a way to
disable it and it ignores the rebase.forkPoint config setting does not
help.

Best Wishes

Phillip


> Something like this:
> 
> # commit trees:
> #
> #    base: A---B---C          (initial base repo with 3 commits)
> # clone_1: A---B---C          (clone_1 cloned from base at commit C)
> #    base: A---B---C---D---E  (base added extra commits D and E)
> # clone_1: A---B---C---F---G  (clone_1 added extra commits F and G)
> # clone_2: A---B---C---F---G  (clone_2 cloned from clone_1 at commit G)
> #
> # *** now, change clone_2 to use base as the upstream url, and fetch / pull / rebase to get up to date ***
> #
> # * set clone_2 upstream to point to base repo
> # * "pull --rebase" in clone_2 (should fetch from base repo and rebase F and G after D and E)
> #
> #   expected result: A---B---C---D---E---F---G
> #   actual result:   A---B---C---D---E
> #   commits F and G are gone
> #
> # Doing "pull --rebase" in clone_1 gives the expected result:
> #   expected result: A---B---C---D---E---F---G
> #
> 
> This looks like either stale state info after the "set-url" command,
> or I'm doing something wrong.
> 
> I can repeatedly cause this to happen in my local ffmpeg devel area, if that helps debug/test this.
> ... and answer questions, if any.
> 
> Thanks for the help!
> Bill
> 
> P.S. here's the test script I used for this:
> 
> --------------------------------------------------------------------------
> 
> #!/bin/bash
> 
> set -o errexit
> 
> BASE_WORKING_DIR="rebase_bug.working"
> 
> # Clean up the test area
> rm -rf "${BASE_WORKING_DIR:?}"
> mkdir  "${BASE_WORKING_DIR:?}"
> cd     "${BASE_WORKING_DIR:?}"
> 
> WORKING_DIR="${PWD}"
> 
> mkdir test_rebase_base.git
> cd test_rebase_base.git
> 
>      # create the base git repo, with commit A, B and C
>      git init
>      echo "Commit A" > testfileA
>      git add testfileA
>      git commit -m "Commit A"
> 
>      echo "Commit B" > testfileB
>      git add testfileB
>      git commit -m "Commit B"
> 
>      echo "Commit C" > testfileC
>      git add testfileC
>      git commit -m "Commit C"
> 
> cd ..
> 
>      # Clone the base area into the clone_1 area
>      git clone test_rebase_base.git test_rebase_clone_1.git
> 
> cd test_rebase_base.git
>      # Add commit D and E to the base area
> 
>      echo "Commit D" > testfileD
>      git add testfileD
>      git commit -m "Commit D"
> 
>      echo "Commit E" > testfileE
>      git add testfileE
>      git commit -m "Commit E"
> 
> cd ..
> 
> cd test_rebase_clone_1.git
>      # Add commit F and G to the clone_1 area
> 
>      echo "Commit F" > testfileF
>      git add testfileF
>      git commit -m "Commit F"
> 
>      echo "Commit G" > testfileG
>      git add testfileG
>      git commit -m "Commit G"
> 
> cd ..
> 
>      # clone from clone_1 into clone_2
>      git clone test_rebase_clone_1.git test_rebase_clone_2.git
> 
> cd test_rebase_clone_2.git
> 
>      # change clone_2 to point to base
> 
>      git remote set-url origin "${WORKING_DIR:?}/test_rebase_base.git"
> 
>      # expecting this to pull in the "base" extra commits, and move the local HEAD commit after it in sequence
>      git pull --rebase
> 
> cd ..
> 
> cd test_rebase_clone_1.git
>      # do the same pull --rebase in clone_1
>      git pull --rebase
> 
> cd ..
> 
> cd test_rebase_base.git
> git log --oneline > "${WORKING_DIR:?}/test_rebase_base.oneline.log"
> cd ..
> 
> cd test_rebase_clone_1.git
> git log --oneline > "${WORKING_DIR:?}/test_rebase_clone_1.oneline.log"
> cd ..
> 
> cd test_rebase_clone_2.git
> git log --oneline > "${WORKING_DIR:?}/test_rebase_clone_2.oneline.log"
> cd ..
> 
> # The test_rebase_clone_1.oneline.log and test_rebase_clone_2.oneline.log should match, but they don't
> 
> echo "done"
> 
> --------------------------------------------------------------------------------------------------
> 

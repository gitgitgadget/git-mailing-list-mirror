Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190B10F7
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723864544; cv=none; b=bVpUwfw7Ve3Hy2hPPDP5uSVUIG8drOGyLiupf4jTrhJuLrswO+0Yu7BF+VR0JAdaCvw/9s0vQ53hZ+oy/SIAOIeoC7K0AxAQN0I3g7orQd1ig55zCOl4MyPQaskTsiRVwhi1kctNZfmZ8pRADYXDZXycYbzBultNzC8s8/amOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723864544; c=relaxed/simple;
	bh=O6rahuwuJTlmFbxlG/w0zIajktYlUEdG1kfdJBmREaw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nnYUHoWt4ziVu1i76GPtUlKr7bS9O817EaNoA07EYji0zD/DG8AtWu8TzErAMYLnsp0Hg7jXiziq4oZsD07lLwnIrKTQdkxWHgr9esVzTsph/K4UTR+WKP1aFZwTV43aJijeU1NcMzCzOmBC8GqHXCKQM2eORSF2dc4XiG1VLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di73jD3y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di73jD3y"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6b443880945so5370077b3.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 20:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723864542; x=1724469342; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dVw6TzWn8D+7BVhuhE3VG1ywn91NjND0W1yL1zcvgTM=;
        b=di73jD3yhdv6p3aU1lK+qS8EcXOazAWxe+hZuw23VA6xXZ2M6SxM4i/b/fxWAkTQO0
         tHUkYFkXuygqpdcVFYevnPwvRdaWqgsDUCC1siRc5X1ESyJKm+QCdQNrZVEcWxj29m+w
         dZ1E271CJiBf9wIT8zeMqyZKJzEvk/bJ4aWfLCXsGvdyqzkaeixtGFLNhrps2klSvU3o
         zGvMcDLbJQV74qAUhzJSK5zQdbMA7egMWAA9d0Y0rbApggHrOjvubh1OEJeFluoassRp
         3xNGwMnqc5pv2HdAyHspBwDX7tnspQzhuTvOJ5rWVEVXKmdse3o7UQf8OUkFlLbYEgFO
         6dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723864542; x=1724469342;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVw6TzWn8D+7BVhuhE3VG1ywn91NjND0W1yL1zcvgTM=;
        b=sqDPczSj5rrV8EiRXs3X72/4z5Oe4AIKuf72ObuJXTodA/2Tj2cGCDOjcvs/q5cvfN
         auxvojZEYdLMu5u9un5tcW68kxVULROPAO+DravnHn95cf5xz22ErL14xWMifgRc8Oec
         DZ9vk0NnqKCqsw28EUVLO9Drh9WUVz1KskCl3+eLv9ltsR2R9Ga+k9V+SH9zUuFR/H+u
         xpTvecv0vEoagopsQk3kmU6qQmOd4QhOgGoeXYXOs9ZSj8L1p4MLJwZfnvl/r7lGNGMc
         QahZpTovkDBW8cxPDXPLrS1MiDWRhGfCuaicUgPVFz9kBfqKa70toDFH/OsWVPoVnhD+
         j03Q==
X-Gm-Message-State: AOJu0YzHoJPlYwf4PDmX6pqMU6LgNywxfCcR5pdJzyG/WImeU9HNk2EB
	r4lAOQWrxi8q1ZJxMRB16/dAkBkLdeL5bkCKFOF11Mqlvbv7/EcX51HUS72+jSigUzPYxsTLk1E
	YJAdcPUKnl5szVWrpOnAaZ2IoTDUCHlNu
X-Google-Smtp-Source: AGHT+IG4bnYx0F6Din3DGNgxwuQqShIYcqJPcXYKib3UhY4ao6AOspk8jMD3cBDgADECLGwetBfsR+gzXPPyOwhlPeI=
X-Received: by 2002:a05:690c:6d0e:b0:64b:893f:fc28 with SMTP id
 00721157ae682-6b1bd17d13dmr49172727b3.46.1723864541800; Fri, 16 Aug 2024
 20:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James <purpleidea@gmail.com>
Date: Fri, 16 Aug 2024 23:15:05 -0400
Message-ID: <CADCaTgpcmMbLoKR-rWf_roWfbgWJL6HuURDxwovvKQA8syf=vw@mail.gmail.com>
Subject: Regression bug with latest SAFE ownership patch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I am not a subscriber to this mailing list, so please please CC-me on replies.

I believe the recent changes for the safe ownership patch seemed to
have introduced a regression. I have a git repo which is on a shared
server that I trust and control. Adding a safe.directory does _not_
allow me to use this repo anymore. I can't even run a `git fetch`
without an error. I have renamed the repo name and directory, but
output is otherwise precise. Full logs and versions shown below:

james@computer1:~/whatever$ git remote show server2
fatal: detected dubious ownership in repository at
'/home/someoneelse/whatever/.git'
To add an exception for this directory, call:

    git config --global --add safe.directory /home/someoneelse/whatever/.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
james@computer1:~/whatever$ git config --add safe.directory
/home/someoneelse/whatever/.git
james@computer1:~/whatever$ git config --add safe.directory '*'
james@computer1:~/whatever$ git fetch server2
fatal: detected dubious ownership in repository at
'/home/someoneelse/whatever/.git'
To add an exception for this directory, call:

    git config --global --add safe.directory /home/someoneelse/whatever/.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
james@computer1:~/whatever$ cat .git/config
[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[branch "master"]
    remote = origin
    merge = refs/heads/master
[remote "server2"]
    url = ssh://root@server2:/home/someoneelse/whatever/
    fetch = +refs/heads/*:refs/remotes/server2/*
[safe]
    directory = /home/someoneelse/whatever/.git
    directory = *
james@computer1:~/whatever$ git version
git version 2.45.2
james@computer1:~/whatever$ ssh root@server2 git version
git version 2.45.2
james@computer1:~/whatever$

Thanks,
James
@purpleidea
https://purpleidea.com/
https://github.com/purpleidea/mgmt/

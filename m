Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF2234A324
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835420; cv=none; b=dYiOULHKGF9gFfU6FtdFDIDBURZUgEksctZxBhR8TUpu5vv+dskOXasMt3vXETbrt5CRAjSeNZkdHc15PFtRBXdsp/56UG3uJ2V4+CL9cXKEXyfZwQSn1KHOPDj/Qt2Xi8RiDI9YlDhUr6LP3jFh3Tc0tiWsu02eiL62Tv6axtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835420; c=relaxed/simple;
	bh=TKmXiDkw4uKqIODvbeBILQs6SwVnwTaRtqZqbnmp2tI=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=VHA48MMq6XcYqTqf6v+Jrwmatm3Mh4hPU0jO/z82M24pjB2oe/kyA0YoIuVD5b6OAdZbd6QjH9PBveH7xqcynU/e+AyXAEUGGo+856A+V4gVcMlGjs1mPRHIV04BiHyONwqU/0pvEikRsTbkGmMpmWa5cD/ji9CdNtOcZm4quzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQiWVuVV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQiWVuVV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so15717475e9.2
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835417; x=1757440217; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUuTBvr+OnFGtY9bq/TvvW0tHoiOWKm4ey+nGS6Lp98=;
        b=RQiWVuVVzTJwSEIOCVEZ/S6AoNzI/Ehs/RcsP3/gdY/9S+nQF0qn63f86a5n966ohT
         vj0yHOUVAkMGDNt52TOqNi4edSweqwdkmByCBrH6FpL1783+QyQRK/EwkWviOKSsYRW7
         xkg5tm7yGRa7xNPXIKzuddvpKpXlTyDZvVz/p2U+L+7/vmtnLL/iYMr5tCpHQ3rGEcly
         JaOgHrPiHTCX+5PtRr2BZ4vDpJU0xkRk6jrlqyBnzgLIZ6eOw392JbhDRHyNjncWIbPH
         QjX5dCAzoVeh8a0AFyIlQpxOC2JgzPAzNXvmVvZUgSF9jwcLsZML7LyKUj9hBRszlKo9
         FJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835417; x=1757440217;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CUuTBvr+OnFGtY9bq/TvvW0tHoiOWKm4ey+nGS6Lp98=;
        b=fW0TIFWAkT2mg2ZQyol/YjsOKkN6nitqtk3YJPMQGCTh09er0atxRkaOkNBgsxfr5l
         TRyFkGsenUPwaEZFWOhehxWOzdraG/+/Ywmbttgybtjmo5c0gvMAv9zb9mdTKzY3a1Z1
         0ms15FUeIIsOffsgY6S1vA0m6ztGGWja4NDMv+PCAf3Y0DHgyqvPasVZsQLQE8avHywj
         XvGw8218ONxupgLy5hrugYR3rWBcCDmwYe8uoT+nVTMm03c8DN8/xQipZ9A8jyI0oUp6
         r8AimXBL9Sat0xZqRf9nLfeUjQ6g5uVjNly4tf1rgN5H3+pp7kvC6Gbef37pUO2dgMoP
         AHZw==
X-Gm-Message-State: AOJu0Yy0FHQh0wZ8vE74Cv4T+0ULp3esR4kewXBO7ctMCiHW2ysOrUYA
	ED7vEcAyk+Od7ZuOvKH4IyOnNaxmezGmlFZNhgyX/yDsZxgaupAgcGGPug1wWRfM+CaQVQ==
X-Gm-Gg: ASbGncuE2wa0gHJit2iTOgPrBCWrdJAyFGGpOfJNYr1Fx7JyL8MtbyRqCU1JJdQJ6UZ
	PB0cOe2RADpsskZxqlYJgvto+aNBdm0OV/4vG9ocgqbACR+LdOLOmVKQlSnnlyxUdv+AS+OgH/+
	wceiLVMk9DgS66ic/cEe39xsUdtHmAs05Q2zFqWnWLcSC8io5ySbZWq+1ssRUmsM9s9E+q/vfnI
	1ASfjDmTvZ7SUhhgdRjquoRutIloRcYEEeY1Hg7vze+T6sg6oKvbruR7FF7gBivca3bfVxt6ycN
	6RbaYRMHBw1ZKcR4bUE+Fz3zTjPP/+I6dJlS6oySoCAF6W8v1/JU8/ZA++ccDi6iL9tFKRCrGYE
	/FiF47W42Qi/yrCojUL4xO1D9m1xtXEV3gYmnFiyPC2dN033zL6wXZ/KCcT0KrdBndo/sDv3s4/
	C5IHxXNwgPyw==
X-Google-Smtp-Source: AGHT+IFB5fbRfEAEG2GbKO3e9uaDH1A+G0KSjajtMHshNAvd7/061vRsf+ZOa1kEGEJpT0qCsACObA==
X-Received: by 2002:a05:600c:a44:b0:45b:725e:6acc with SMTP id 5b1f17b1804b1-45b8557c5d6mr132663535e9.31.1756835416856;
        Tue, 02 Sep 2025 10:50:16 -0700 (PDT)
Received: from ?IPV6:2a02:2f0e:d80c:d600:4613:b722:1dbe:95e8? ([2a02:2f0e:d80c:d600:4613:b722:1dbe:95e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d21a80c723sm15542846f8f.9.2025.09.02.10.50.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:50:16 -0700 (PDT)
Message-ID: <6be0928c-df10-417e-a264-f4562f9d2585@gmail.com>
Date: Tue, 2 Sep 2025 20:50:14 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Cristian Dinu <cristian.virgil.dinu@gmail.com>
To: git@vger.kernel.org
Subject: Bug: ls-remote refuses to run when work tree mounted in container
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

First of all hello,

I think I found a bug in git, 'git ls-remote', to be more specific.

My workflow on my current project consists of using git work trees and 
testing
the work I do in a podman container. My project is an Ansible playbook 
meant to
automate different things. One of those things is doing some git clones.

Ansible module 'ansible.buildin.git' makes use of 'git ls-remote' to obtain
some information about the git repository I want to clone:

This is what the Ansible module executed behind the scenes:

'''
git ls-remote http://some.repo.com -h refs/head/master
'''

The problem I'm facing has to do with 'git ls-remote' requiring you to 
run it
in a git repository or in no git repository, but something in the middle 
makes
the tool blow up.

Here are the exact repo steps so you can reproduce and better understand the
issue I'm facing:

1. 'mkdir -p /tmp/git_ls_remote_bug'

2. 'cd /tmp/git_ls_remote_bug'

3. 'git clone --bare https://github.com/git/git.git .bare/'

4. 'echo "gitdir: .bare/" > .git'

5. 'git worktree add master'

6. 'cat master/.git'
    Should output 'gitdir: /tmp/git_ls_remote_bug/.bare/worktrees/master'

7. 'podman run -it --rm -v "./master/:/workdir:ro,Z" fedora:42'


The next steps are executed in the container:

8. 'dnf install -y git'

9. 'cd /workdir'

10. 'git ls-remote https://github.com/tmux-plugins/tpm -h refs/heads/master'


Will return:

'''
fatal: not a git repository: /tmp/git_ls_remote_bug/.bare/worktrees/master
'''

This is the bug I want to point out, even if I did a 'git ls-remote' on 
a remote
repository 'git' or maybe 'git ls-remote' in particular wants to be 
executed in a
git repository.

I want to add the following, if I do 'cat /workdir/.git' inside the 
container it
will show 'gitdir: /tmp/git_ls_remote_bug/.bare/worktrees/master' and 
because that
is not present in the container at all it thinks it should not run.

I did not explore git's code to see if I can do a patch, but from a 
user's point of
view I think 'git ls-remote' should skip the 'Am I in a git repository?' 
check and
just query the remote repository when a remote repository is provided as 
argument.

At the moment of writing I used git 2.51.0 both on the host and in the 
container.

~ Cristian

PS: It's the first time I write to a mailing list, if I did a mistake 
tell me so I
     can learn.


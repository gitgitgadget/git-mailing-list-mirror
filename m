Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5B522A
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407018; cv=none; b=JNBZv14woTPvuJULffLSTDuuwTdtPZ4glC0f+YmU8OVAHQsV+skg2guB+SRx/FnELvcFiUhHC8h//17EuCsPHihysUQ5VgS5np8GfhWp9NQccqmglmrNsTzraNwDFeXI5GcUC4uIjkBTbuQmKo3TjOmBGO1/Dz5QhiXi+LfBAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407018; c=relaxed/simple;
	bh=FdVn6ONuzTDmgiZHQX/VIj1KLjy8m1rP3T76xmM5Uo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv+PgTs/GC0aENvZdxuemdmVkF7iJZ42zWXtMSf91h0sXGfVOORxQTOWKtcew0KGhiJZMmLrhur2BBZ9LJhs/8Jh0MGKdUbyu6joIl5pQYN76ig8ZMBVECwc6rDeOnEfT+8f/U6aw88xH75f7IvHZ63Sk/m2NjrtIwTvRBfgQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOBGPhEL; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOBGPhEL"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so4856538e87.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407015; x=1720011815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=20ghrANxzM8RNMPX3DRPj6HwfFQzZ9p5NIHzqU+4/RA=;
        b=fOBGPhELyU1fPv4QsZlsi7ZqVAkz8PY0GnYcLwLaGrydom5O/yydBXQMsR7zLJDoKK
         n8J9+ONCalyKjySwx4YOeKHJfOki1XY/lB00cfV8jDU/XET1jtAPoAdeb5J/hkB2Kg5B
         t9ybRqEaucBzBLlJPAAw7v0PVWgbPfkTqnql/8kC5UJKbClBJFlZCPRvpP1jskNm8FQb
         hkxFZ/OmunXll9ow2A6tvaZgKaBxBBwY+f1Q1GAH8xhhbYJC5RFEScNo5aRLuYz6qRsE
         IfYiVbDVnHUM2rkg/SEtSnDmYhoBN5firs/mFE/yYTYVX+iG4NjZ12bqo/18ROH86kL9
         A/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407015; x=1720011815;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20ghrANxzM8RNMPX3DRPj6HwfFQzZ9p5NIHzqU+4/RA=;
        b=JmRHKg5fJekC2mEQ6HwUSvmCg3/KmFvP2ZVYEURmi6ClTuoUuc83ZgGQdqESjxpEi9
         8uLCXUegeM0Z9CmhEmPnCOPES3on0Ihr+ZARbHiwVy+/ZetF6DY6RcBGOoukXGog/wPw
         mVUTL62IzD18EhUtydrjKsAA+V3VIGZFiq5aBFS5sVdEbHoXn0WY8Wi7KfveC0pmqA88
         t1cZY8/xZRGR5heh44oQc9gaSjLAUrBJmNdqZYLxbErsTOsHmr88xtyEgmjUiZW33ECl
         AtR/iNP1eIyXFongwjD7RKgApn7668ce0LGA9ZI/rOsUIAZTKeoWNHTDNi0KIaOx3/1p
         iyvg==
X-Forwarded-Encrypted: i=1; AJvYcCVKWeh9ycrpc7qtj9NJxjx9eOwBDJ3jszKn0WaepjPyzl7A9MJhY6vJNU6JZi3BvJPxakOKAMK+5eStiupEOAPRysPw
X-Gm-Message-State: AOJu0Yw0DQcIKE+0+uY2tMSupbJNKLMWqdTTF/JcdMC7ukjVr9CMNgGh
	PxiyYCmNHzub6v9g/q9UU3/n0LL1KjBi4b3lqD7jN4bjCynvNkLM
X-Google-Smtp-Source: AGHT+IF3d4H48AIb93jvt9wvCle++BE3vBI4VLycfzRNRzGWY1kMYBMuUxCZX0mUdezZs7iT6/Jqjw==
X-Received: by 2002:ac2:5299:0:b0:52c:c9ce:be8d with SMTP id 2adb3069b0e04-52ce186482cmr6705931e87.57.1719407014566;
        Wed, 26 Jun 2024 06:03:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-424c8468caesm25388195e9.44.2024.06.26.06.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:03:34 -0700 (PDT)
Message-ID: <834862fd-b579-438a-b9b3-5246bf27ce8a@gmail.com>
Date: Wed, 26 Jun 2024 14:03:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Local git server can't serve https until repos owned by http,
 can't serve ssh unless repos owned by user after 2.45.1
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 "David C. Rankin" <drankinatty@gmail.com>, git@vger.kernel.org
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
 <xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
 <20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
 <20240625183411.GW19642@kitsune.suse.cz>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240625183411.GW19642@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Michal

On 25/06/2024 19:34, Michal Suchánek wrote:
>
> Adding the repository to the list of safe repositories is a known
> concept that was already required for gitweb and for working with the
> repository locally, and applying it to git-daemon as well is consistent
> although it does require configuration changes for some users.
> 
> The real problem here is that adding the repository to the list of safe
> repositories does not make it possible to serve it by git-daemon.

That is indeed unexpected. I set up git-daemon on my laptop this morning 
and in order to get it to work one has to add "."  as well as the 
repository paths one wants to serve to the list of safe directories. 
Clearly that is undesirable and does not really feel any safer that 
using "safe.directory=*". What is happening is that git-daemon checks 
that the repository path is listed as safe and then changes into that 
directory and forks

	git upload-pack --strict .

"git upload-pack" then checks "." against the list of safe directories 
which fails. It fails because the safe directory check does not do any 
normalization such as cleaning up "//" elements (as seen in your 
example) or expanding relative paths on $git_dir before checking it 
against the list of safe directories.

I think the fix is probably to make the safe directory check use the 
absolute path of $git_dir. In the mean time there is a workaround if 
you're happy to add "." to the list of safe directories.

Best Wishes

Phillip


> Thanks
> 
> Michal
> 
> 
>>
>> Michal Suchánek <msuchanek@suse.de> writes:
>>
>>> On Mon, Jun 17, 2024 at 11:15:13PM +0200, Michal Suchánek wrote:
>>>> Hello,
>>>>
>>>> On Mon, Jun 17, 2024 at 11:47:20AM -0700, Junio C Hamano wrote:
>>>>> "David C. Rankin" <drankinatty@gmail.com> writes:
>>>>>
>>>>>>    Security enhancement in 2.45.1 have broken ability to serve git over
>>>>>>    https and ssh from local git server running Apache. (web server runs
>>>>>>    as http:http on Archlinux)
>>>>>>
>>>>>>    The fix of adding the following to gitconfig (system-wide and
>>>>>>    per-user in ~/.gitconfig) does not solve the problem:
>>>>>>
>>>>>> [safe]
>>>>>> 	directory = *
>>>>>
>>>>> It is not clear what you exactly meant "per-user" above, so just to
>>>>> make sure.  Is this set in the global configuration file for the
>>>>> httpd (or whoever Apache runs as) user?
>>>>>
>>>>> The purpose of "dubious ownershop" thing is to protect the user who
>>>>> runs Git from random repositories' with potentially malicious hooks
>>>>> and configuration files, so the user being protected (in this case,
>>>>> whoever Apache runs as) needs to declare "I trust these
>>>>> repositories" in its ~/.gitconfig file.  What individual owners of
>>>>> /srv/my-repo.git/ project has in their ~/.gitconfig file does not
>>>>> matter when deciding if Apache trusts these repositories.
>>>>
>>>>
>>>> looks like the semantic of 'dubious ownershop' changed recently.
>>>>
>>>> Disro backport of fixes for CVE-2024-32002 CVE-2024-32004 CVE-2024-32020
>>>> CVE-2024-32021 CVE-2024-32465 to 2.35.3 broke git-daemon. No amount of
>>>> whitelisting makes the 'fixed' git serve the repository.
>>>
>>> Same regression between 2.45.0 and 2.45.2 which allegedly fixes the
>>> same CVEs.
>>>
>>> Looks like downgrading to gaping hole version is needed to serve repositories
>>> in general.
>>>
>>> Please consider adjusting the fix so that repositories can still be served.
>>>
>>> Thanks
>>>
>>> Michal
>>>
>>> To reproduce:
>>>
>>> cat /usr/local/bin/git-ping
>>> #!/bin/sh -e
>>>
>>> # Try connecting to one or more remote repository URLs
>>>
>>> while true ; do
>>>          git ls-remote -h "$1" >/dev/null
>>>          shift
>>>          [ -n "$1" ] || break
>>> done
>>>
>>> mkdir -p /srv/git/some
>>> chown hramrach /srv/git/some
>>> su hramrach -c "git init --bare /srv/git/some/repo.git"
>>> su hramrach -c "touch /srv/git/some/repo.git/git-daemon-export-ok"
>>> version=2.35.3-150300.10.36.1 ; zypper in --oldpackage git-core-$version git-daemon-$version
>>> systemctl start git-daemon.service
>>> git ping git://localhost/some/repo.git
>>> <nothing>
>>>
>>> version=2.35.3-150300.10.39.1 ; zypper in --oldpackage git-core-$version git-daemon-$version
>>> systemctl restart git-daemon.service
>>> git ping git://localhost/some/repo.git
>>> fatal: Could not read from remote repository.
>>>
>>> Please make sure you have the correct access rights
>>> and the repository exists.
>>>
>>>
>>> systemctl status git-daemon.service
>>> ● git-daemon.service - Git Daemon
>>>       Loaded: loaded (/usr/lib/systemd/system/git-daemon.service; disabled; vendor preset: disabled)
>>>       Active: active (running) since Thu 2024-06-06 08:29:28 CEST; 6min ago
>>>     Main PID: 31742 (git)
>>>        Tasks: 2 (limit: 4915)
>>>       CGroup: /system.slice/git-daemon.service
>>>               ├─ 31742 git daemon --reuseaddr --base-path=/srv/git/ --user=git-daemon --group=nogroup
>>>               └─ 31749 /usr/lib/git/git-daemon --reuseaddr --base-path=/srv/git/ --user=git-daemon --group=nogroup
>>>
>>> Jun 06 08:29:28 localhost.localdomain systemd[1]: Started Git Daemon.
>>> Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: fatal: detected dubious ownership in repository at '/srv/git//some/repo.git'
>>> Jun 06 08:29:39 localhost.localdomain git-daemon[31756]: To add an exception for this directory, call:
>>> Jun 06 08:29:39 localhost.localdomain git-daemon[31756]:         git config --global --add safe.directory /srv/git//some/repo.git
>>>
>>> git config --global --add safe.directory /srv/git//some/repo.git
>>> mv ~/.gitconfig /etc/gitconfig
>>> git ping git://localhost/some/repo.git
>>> fatal: Could not read from remote repository.
>>>
>>> Please make sure you have the correct access rights
>>> and the repository exists.
>>>
>>> git config --global --add safe.directory /srv/git/some/repo.git
>>> mv ~/.gitconfig /etc/gitconfig
>>> git ping git://localhost/some/repo.git
>>> fatal: Could not read from remote repository.
>>>
>>> Please make sure you have the correct access rights
>>> and the repository exists.
> 


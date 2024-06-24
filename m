Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED15FC08
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250634; cv=none; b=n5X0xu8yYXeYe4LeGkaQxIGYvKkHCkO4JWaovXDhIw+NtwziEIhHoCMgpt///58ZDuJXjl42hu8tWIIoqa0jO1YOq3xvcQXAb8TnJ5OeZV28mios1frRnoyKxYUEmkG40qn3m9cMk5cHFu71ZPyjtSnpCd1cjC4iRU43fomUhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250634; c=relaxed/simple;
	bh=UqvJ5x9Gm7pWTnF8gkkGKCBhdJZaconAeFXgc4stlq8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IDgLwLzg2CgK3xVWqNu5orjDnY/m6L15e5bQTmpI28SrR1Rx3B9E35UgqbTf5YbAbKTdHRhUYyukeVFbOKH3RWpgRKE7UCNNzbPArpgYopGVQ8tXmeUUN+18PnOSRXKSvk9mfoO0d1Rusp4fCMGvZf59cn3NKT/dImf/ME9YON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hfo4bKBv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfo4bKBv"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-719843c8478so87911a12.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719250632; x=1719855432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uklvvXG4OPp1Fq0TtOzwvpeHRymgM0ZzFT+s7Q/YwRM=;
        b=Hfo4bKBvgaZ5/SkCtTudcsedzo/FOH64HGGPyK2/qWpTYCZYte3ZdF32PQmrbXsu33
         kE3Ttu6di1FyxBDy3eH5efy+x66dMUDN+I29UnjAfEiUB1dtHOuczbVqRZ4BaKIjqpFt
         qVGEOSCtjPRmsCw/mDcaeXEAlIv6z9Uro5dU1n3kdlznqLcyGp25x9hwolwRcAUucMeX
         h3JWVsGYTqilKb6aiifYAaOrZWnO6GBDdi1nHBIPKUGHJ1LmQEh7aFpNmETfKdLe5Qxh
         eoMi76jHCWyslGrRScBBm+TH/CMGHRG7G06aMUip/nh34RhKhe/JS4T3mooKNqbzT2kD
         9TbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250632; x=1719855432;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uklvvXG4OPp1Fq0TtOzwvpeHRymgM0ZzFT+s7Q/YwRM=;
        b=Zd2a6lI6JsNm0BvszzlLC+HlxqFE7UMikSexoWtotUUsse9ESvEpshT8V0I9pLvCnC
         NTvMCjWVXKbbBA8nZvJAuuy2IL+sG516KLNBy72KEvRkN5ivC7rbLk1Uo3TqSRPQ41Wu
         8ausik8uEMDVoaiEOOTX3t4qPi+LYikNuKZ4fCnq/LCgRfxA/oJkXvuZ3lgz4SwqTntW
         Dedgi4MRQn90lFXZcwdLUTiJCucK94teBcEnZJWXh42dMqhRiwXiujoxPupSc+TCklX7
         SOpEqqhuAjkn/h8l2Lx5h7w8hdaIn5z2U06oGtEzBupxrVrUYUYG2G3GmsmsfJRZNEoE
         HLcA==
X-Forwarded-Encrypted: i=1; AJvYcCVca8PHJ1n/28Sxq+R2SHXxjc3RKmufPHSpVwKJI+LZG62LU10M6QpX18A6ykWuci6gB3U7SlFjvKwTpuOWD/BSJycC
X-Gm-Message-State: AOJu0YxAggHfdClyjAJ9Q0EgIhBTA6EVGekj5Z3Ys2UUlqDG1vg10VEX
	ucaGUXPIPNgCQgnZpyK9zuH1/ER2hsAXa+VQLxmzA+O9Dp1TeRTk
X-Google-Smtp-Source: AGHT+IEv3ibpa2an1s408i/K602vaac46yUOAcUq8UvMXsXzLQa2f6fH4EeaPurvmLAKQMTRE8zubg==
X-Received: by 2002:a05:6a20:3d86:b0:1b5:ae2c:c730 with SMTP id adf61e73a8af0-1bcea5b2a1fmr7902075637.3.1719250632048;
        Mon, 24 Jun 2024 10:37:12 -0700 (PDT)
Received: from ?IPV6:2409:40c2:1f:653a:1b35:f353:ca67:2514? ([2409:40c2:1f:653a:1b35:f353:ca67:2514])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067ff77b73sm2548257b3a.219.2024.06.24.10.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 10:37:11 -0700 (PDT)
Message-ID: <4224c251-c6f7-4b2a-b182-b0a12ee300c8@gmail.com>
Date: Mon, 24 Jun 2024 23:07:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Karthik Nayak <karthik.188@gmail.com>,
 git@vger.kernel.org, Paul Millar <paul.millar@desy.de>,
 Jeff King <peff@peff.net>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
 <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
 <69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
 <735b4a95-fe8e-4bff-9dd3-10ddd4bdb5b5@gmail.com> <xmqqcyo6cnbb.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqcyo6cnbb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> What is the reason why you want to change the owner of a file in
> your test?
>
> If it is merely to make sure you cannot write to the .git/index
> file, temporarily doing chmod of the .git directory in a test (with
POSIXPERM prerequisite) may be one way to do so, and you do not need
the second user in the system test is running.

I want to change the owner of a checked-in file and not the `.git`
directory.  This is because of what you noted in an earlier message:

> As many attributes of each file (like the
> last modified timestamp and who owns the file) are recorded in the
> index for files that were verified to be unmodified (this is done so
> that by doing lstat() on a path and comparing the result with the
> information saved in the index, we can notice that the path was
> modified without actually opening the file and looking at the
> contents), after doing something (like "git diff") that causes this
> information updated while the files appear to be owned by you

Currently, `git describe --dirty --broken` reports the working tree as
dirty if you change the owner of a file.  And as Phillip pointed out,
calling `git update-index --unmerged -q --refresh` to update the index
fixes this.

What I want to test looks something like this:

# initially, the file is owned by a non-root user
chown root file
git describe --dirty --broken  # incorrectly suffixes the output with '-dirty'

As mentioned earlier, the dirty suffix goes away if the index is
refreshed before running describe.  This is what I really want to
assert -- that there is no '-dirty' suffix when owner of a file is changed.
This kind of simulates the scenario where `git describe` is run in a
docker container as was originally reported by Paul:

> mkdir test-container
>
> cd test-container
> 
> cat >Dockerfile <<EOF
> 
> FROM docker.io/debian:bookworm-slim
> 
> WORKDIR /work
> 
> RUN apt-get update && apt-get -y install git
> 
> EOF
> 
> podman build -t test-image .
> 
> 
> 
> mkdir test-repo
> 
> cd test-repo
> 
> git init echo "Hello, world" > README
> 
> git add README
> 
> git commit -m "Initial commit" README
> 
> git tag v1.0.0
>
>
>
> git describe --tags --dirty --broken
>
>
>
> podman run -v `pwd`:/work --rm -it --entrypoint '["/usr/bin/git",
> 
>    "describe", "--tags", "--dirty", "--broken"]' test-image


Thanks


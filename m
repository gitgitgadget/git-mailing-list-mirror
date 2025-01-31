Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A11C3BF9
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738331575; cv=none; b=G+q+rK+iJadC8bcsuM520mta4p+wCAq2RqyhllqCPz8nl3h4OQlfHSY3v9LwT8d22a/VSMNtIlgv3nfDrGr2AOY6SrkvRCc0i3BdjMONfUd3RIcfsOCH5iXaHC0MuH9/i25xhBhwAiBjhtFQuFFykaLlhOzT3iCo8tAsSIYxAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738331575; c=relaxed/simple;
	bh=J1TrUH6Z3VHAmhZu/eqp0Tk+vnLg0qBDZhn5H2XdUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEuEjCRnjhAoELV98/69jEpW4iHmihgOOHC4n5pQJL+lEfYD8hE7qWF6kBR9C3wNVdJVZvXYlxnXHXJ9jjFN0FJ0RpO5KtXaAYbiPw6y6w8BqqtopbfWFANvGDknf+wIiXtsUxqEEzVRsTnPC2PJZ3W9Fu1dkuRrwkRWd/psm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGhzhccI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGhzhccI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-218c8aca5f1so29137335ad.0
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738331573; x=1738936373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQT1ATWyA8DRaD698+tAeDm2e0ixpV9A4KfI3HBfk0A=;
        b=VGhzhccI/HQG2r4Hq17GcTS4OU3Es3cCAxor9Ayzuy3X+UoXEFuj/PiAv2OLHz0GP/
         q2EvuxCnnOBPjxhCw87YxZiIWOE8xHCEi8wjW3KkQ/PHLktp5YSYIXmyY93YU2XImANZ
         2Go13qv0bvGqGCVR/qpgOITCR7JExrWuO8Jbu/ebuXEVMNQ2depfsFOrTalgBOl/Xn+K
         fhFFjNS/gTBp6g6dX1MFWznTMxnKJzSV5K3ZE2tmXOZhoG0W3kWUuMUUYhrMNi/IXuXm
         0X2G7Rvw3TU/x2THFRzPj77xj+SF7RU7ISay2B0yu2uHXQJDWCiEcpe8vfD4FLmv3Ac4
         PVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738331573; x=1738936373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQT1ATWyA8DRaD698+tAeDm2e0ixpV9A4KfI3HBfk0A=;
        b=G0EpC1cwLEKwH3qk28DafndJaaDZY1DqEIG8ZDdya7vvsnAkHBbp1mxXZC8TfwW3c+
         xw8jcPzPzCbAUiXXOaCttkLXtvdf3teLsOg7H/Zv2FBk9E50nApLpPscWXLJXNG8RR7M
         5NbpMy6sw9pnNE/FpwqtU9yygwxHhvMlPcX0RWpG+91rJ6XSmL/Oj0XkvQiD3K+x9N0r
         2Xj7rm/cRzeA1qM9IAXLUDOC34E7UJWFFzuBYH0TL/z+krUr9BhGS/trrmtMwuBdUHTi
         FM5+6r8+QRqLf97/iXLP+LRc7UaZZ5tmgm73plLzESo2cA0UtH/hAbjV3Gsu1k3Y9HJc
         gIyQ==
X-Gm-Message-State: AOJu0YxmKTOh9z9v/i/puUSBJA9pd5UFcn4p2LdGGk+XAUCXmR1SMd8w
	+RVoE2svdSWznO06XQ6XpMW9hppFBY4lXisrMkMMrkZxPA6D5Q+U
X-Gm-Gg: ASbGncvRlTBCujgn7lp/NcMzarEkJxG4Ga0V1hfNwtvf4ix/PpmgWitEGi9u3zahwiI
	nuW8yzgXLSSQoUF14GMjdZ2TgtsfRyz6NyUO1lUxowOq/rAZoedl+bY8bbMWm6xfquDvRZeptV+
	lwpDWIDCqe1oZSNO6elSHwcDxzoLJW3+LBnsoPRAnjaYm/WW1kL9PcZGtkIEDX0Xlky533uZKJ8
	3UJZodTeA/OOsn0uWSw5y35SCm20gicAeCPFMRYXXGPU1E3wlSy1Ne9+qsmGQ6+aOjTTg==
X-Google-Smtp-Source: AGHT+IGyN70xMYsngKIgjpOfyV5ZO0ePc3N0nOG3yn4362H3dyQ0l6LzZmU//BYhiDEPtT1RQx13Tw==
X-Received: by 2002:a17:903:2a88:b0:20c:9936:f0ab with SMTP id d9443c01a7336-21dd7e00f28mr160617915ad.47.1738331573468;
        Fri, 31 Jan 2025 05:52:53 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21de31edddfsm30639395ad.8.2025.01.31.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 05:52:52 -0800 (PST)
Date: Fri, 31 Jan 2025 21:54:27 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/8] packed-backend: check whether the "packed-refs"
 is regular
Message-ID: <Z5zWE1M4u3NrROI-@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r6-52eBgT4TUYG@ArchLinux>
 <xmqqplk4duuk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplk4duuk.fsf@gitster.g>

On Thu, Jan 30, 2025 at 10:23:15AM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > It might seems that the method one is much easier than method two.
> > However, method one has a significant drawback. When we have checked the
> > file mode using "lstat", we will need to read the file content, there is
> > a possibility that when finishing reading the file content to the
> > memory, the file could be changed into a symlink and we cannot notice.
> 
> To me, the above sounds like saying:
> 
>     The user can run 'git refs verify' and it may declare that refs
>     are all good, and then somebody else can come in and turn the
>     packed-refs file into a bad one, but the user will not notice
>     the mischeif until the check is run the next time.
> 

Yes, it is.

> It is just the time that somebody else comes in becomes a bit
> earlier than the time the 'git refs verify' command finishes, and
> there is no fundamental difference.
> 
> > With method two, we could get the "fd" firstly. Even if the file is
> > changed into a symlink, we could still operate the "fd" in the memory
> > which is consistent across the checking which avoids race condition.
> 
> The end result is the same with the lstat(2) approach, isn't it,
> though?.  'git refs verify' may say "I opened the file without
> following symlink and checked the contents, which turned out to be
> perfectly fine".  But because that somebody else came in just after
> the command did nofollow-open and swapped the packed-refs file, the
> repository has a packed-refs file that is not a regular file after
> the command returns success.  So I am not sure if I am following
> your argument to favor the latter over the former.  What am I
> missing?
> 

Let me give you some background. In the version 1, I used the following
way:

```c
lstat(...)
if (!IS_REG(...))
    report_error(...);
strbuf_read(...)
```

Patrick has told me that there is a possibility that between the `IS_REG`
and `strbuf_read`, the "packed-refs" could be converted into a symlink.
So, my idea is that we could use `open_nofollow`, when we have got the
file descriptor, no matter what happens to `packed-refs` file (deleted or
changed into a symlink), we could operate the file descriptor and read
its content.

However, on a platform with O_NOFOLLOW, this situation will also happen.
So, I think we may just use "open_nofollow" now and don't talk about the
method one at all to avoid confusing readers.

> As long as both approaches are equally portable, I do not think it
> matters which one we pick from correctness point of view, and we can
> pick the one that is easier to use to implement the feature.
> 
> On a platform without O_NOFOLLOW, open_nofollow() falls back to the
> lstat and open, so your "open_nofollow() is better than lstat() and
> open()" argument does not portably work, though.
> 

Yes, actually in my first implementation, I didn't notice this. But the
CI told me that and I finally chose "open_nofollow".

> > Reuse "FSCK_MSG_BAD_REF_FILETYPE" fsck message id to report the error to
> > the user if "packed-refs" is not a regular file.
> 
> Good.  Say "regular file" on the commit title, too, and it would be
> perfect.
> 

Let me improve this in the next version.

> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index cf7a202d0d..42c8d4ca1e 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -617,4 +617,26 @@ test_expect_success 'ref content checks should work with worktrees' '
> >  	)
> >  '
> >  
> > +test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit default &&
> > +		git branch branch-1 &&
> > +		git branch branch-2 &&
> > +		git branch branch-3 &&
> > +		git pack-refs --all &&
> > +
> > +		mv .git/packed-refs .git/packed-refs-back &&
> > +		ln -sf packed-refs-bak .git/packed-refs &&
> > +		test_must_fail git refs verify 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: packed-refs: badRefFiletype: not a regular file
> > +		EOF
> > +		rm .git/packed-refs &&
> > +		test_cmp expect err
> > +	)
> > +'
> > +
> >  test_done
> 
> OK.  I notice that the previous step did not have any new test
> associated with it.  Perhaps we can corrupt "HEAD" *and* replace
> packed-refs file with a symbolic link (or do some other damage
> to the refs) and make sure both breakages are reported?
> 

As I have said in the previous comment, we cannot detect the error if
"HEAD" itself is corrupted. However, we will check the referent in the
later. So, we don't need to do this.

> It does not have to be done in this step, and certainly not as a
> part of this single test this step adds, but we'd want it tested
> somewhere.
> 

If we need to check the referent of the "HEAD" in the "packed-refs". We
could do this in the later test. I could cover this in [PATCH 6/8].

Thanks,
Jialuo

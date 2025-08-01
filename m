Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A671FA272
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034953; cv=none; b=G4wp/X5hw6QUykw/wZiV+GfoAOiy28e7EONPkYOQK6pdHWVU1GFKlk4zR4Hb2+slxxVw0wwfsczV0e+B6cIKAeYbhrAoeaBerEth4n1+7QUWeLYQyIoTf3D8N9hM0f+/lnUfA4VfoxS9Meo9ffKnmRdCRGxC+WjbVdtiAFEjcEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034953; c=relaxed/simple;
	bh=VDNChLs4bq59EPwsgQcXyvs9rJLGtrjSIM3H8Ypjo/k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A80Kn0mjVxd3vVpiEdBrqQ56i300dglILlt+7wlrKLGqSBpQjWepwl7AzoN/Iq3Cltaq30v9E1kuNaYP5osX9iw8Vk4pUyts6YF9g6sU0KtEGBO2baw9ezDNrQ2tmSRPYBG8jHkhdZzGUGN4vbkICFCQnwysbxXzx7fATj8D5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st; spf=pass smtp.mailfrom=martin.st; dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b=3Uxe8TwL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=martin.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=martin.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=martin-st.20230601.gappssmtp.com header.i=@martin-st.20230601.gappssmtp.com header.b="3Uxe8TwL"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-33230f1347fso9471971fa.3
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martin-st.20230601.gappssmtp.com; s=20230601; t=1754034945; x=1754639745; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAM/YlOy6PoNY/pBbzRhUsKH6DcVSA/0001kALP88Yk=;
        b=3Uxe8TwLvm7zrCuIonY4+m3cXYWfkmVTEMwAVQ6CBMb0pUkyrUohdeXQGmHxnNfwOf
         /bUneqjG35znBBeEDbQJLDWIONRMz43TVvy6aEizqUr0OqVe+olZcwJN0R5ipe77CFh5
         PKzvDWWXI9Hqon+NZfBXZubO3SM9iTzmDpb1tpMNJ4DQ1fyIa1sOvGw3cyEoe++9qVhR
         askH7mwa6FWCpHMap3kfX98YwNGMPZZk91LMX3StLH2dgWt157e7s8r55YhsNe47Y2e1
         kusEe4u1iZao43GAkdowhMW9gSfChHY35TbYhwoJq2ZSgugI+mbNh5chkgMMXYVoERhi
         UkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754034945; x=1754639745;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAM/YlOy6PoNY/pBbzRhUsKH6DcVSA/0001kALP88Yk=;
        b=KZiz5zHnxFw5ZdkP0MKQkKX8owF5VwSI/zfcmmYbuP8DgSrR4d56Rw2vDM5dTqamOC
         Rn+1Y725TJ1V9dHO4yHGQ/cPw+5J9Huuxekvt6LNL/MDvVEtIBP5l+fCkpeRhF+bmYo+
         naHwLh+NyMI5fe4oggx3vHiDQ4qOTTSxtcGsnv5/KFsm7l62QBPGEjnubB/nkskgTHEa
         BfH55EQmDJL5OrunRPwTv75eety9Ejjy87U73e5fW7wcDKLVZkx5AlEIQudTOV4E/HTe
         rHyw4y429voD7noBt6xYh0KAVNv+BqkpQbjS2TjoUdn2/Q98xVlbcmWZ7Lw0++Ra6XHW
         tXpQ==
X-Gm-Message-State: AOJu0YzdO25Yz94x20xyu34Rs66Ej+5pRM7h3p4eZ0k3a9ovfGu4Jwi/
	Bi3LdXLQXkISMHZjg77KkWqEyfnnousw4P7rRJ/tyP9qewlyu0GDJKXg5EeW7r/JYA==
X-Gm-Gg: ASbGncsMb9PTw7O7w6hdvRxyHlnlvxXLM6KQhRRH1FLUYCUUlqL1rXvql6B5wYTzI57
	4Y+WVF+ae3C8UdlqjmK/L1HXBkju7IYjo6et9RFep/+sRXCRtvGHJFvBwnTDKB5O92Nr2a6nAhF
	mHwW+lkAbBHBrgWBk9qRu20wryX2h7Lw8vefLqJO1BXhPdgeaUbpqbXyUNKtu84Vq7uzs55qsfM
	HVtQE3+Tmw0m7OrWcKtV7ioD3UCWS7LGUfPc8E+p8g3vjosz91HlgMXRKF1H0B9l7cWoqYxp6YI
	eZ0qyB+4pi9WWFkijJDJEq0TYGaiktdQu2iPQEwSdTxYQq3oEoYj0eEzGY5+KFMmkCVyVud58Xe
	JoahmU1/x2VP6ictFF2k66X1aSR1rft9DeLbf9bDQslxXyIPMJ1fRoNeJR7yRwRBawS4xcz1qST
	8YMGrlFN6NZJXYoIIfm8pTX7TBoH2v
X-Google-Smtp-Source: AGHT+IGQh+VS7GnEeH5acLjapY/buvPv1YDUgp8IRdRp5b8CHNiqRc3a402l77UobffywEeG1NwqVw==
X-Received: by 2002:a05:651c:4104:20b0:32b:8e39:b0c7 with SMTP id 38308e7fff4ca-33248480a61mr2669561fa.40.1754034945283;
        Fri, 01 Aug 2025 00:55:45 -0700 (PDT)
Received: from tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net (tunnel335574-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:11::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388fefe7sm5037991fa.69.2025.08.01.00.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:55:44 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:55:42 +0300 (EEST)
From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org
Subject: Re: [PATCH] meson: Check whether git is new enough to support ls-files
 --deduplicate
In-Reply-To: <aIxQWSrnMOuEmfHo@pks.im>
Message-ID: <69faab5-43d4-812c-90f-c518ff7f618@martin.st>
References: <20250731121533.178747-1-martin@martin.st> <aIxQWSrnMOuEmfHo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Patrick,

On Fri, 1 Aug 2025, Patrick Steinhardt wrote:

> Our commit messages are described so that we first describe the error
> and then we describe how this is fixed, and typically they are written
> in such a way that they can be read without requiring you to also read
> the subject line.

Thanks for the commit message rewrite!

> So something like:
>
>    When using the Meson build system with an old-enough Git version
>    that does not yet know the `git ls-files --deduplicate` option one
>    can observe the following error:
>
>        ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.
>
>    The failing command is used to find all header files in our code
>    base, which is required for static analysis.
>
>    Static analysis is an entirely optional feature that distributors
>    typically don't care, and about we already know to skip running the

I presume this is a typo, and this should be "typically don't care 
about, and we already know to ..." - I've amended your suggestion in this 
way locally.

>>  headers_to_check = []
>> -if git.found() and fs.exists(meson.project_source_root() / '.git')
>> +if meson.version().version_compare('>=0.62')
>> +  new_enough_git = git.found() and git.version().version_compare('>=2.31')
>> +else
>> +  # On Meson 0.61, we can't check git.version(), so we just have to
>> +  # assume that the found git is new enough.
>> +  new_enough_git = git.found()
>
> I'd rather call this `git_supports_file_deduplication`. It's a bit of a
> mouthful, but `new_enough_git` raises the question of what it is new
> enough for.

Fair enough, good suggestion. Although based on your other suggestion 
below, we don't end up needing this part at all.

>> +endif
>> +if new_enough_git and fs.exists(meson.project_source_root() / '.git')
>>    foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_excludes, check: true).stdout().split()
>
> I wonder whether we could avoid the whole version check machinery and
> just change this command to `check: false`. If so we accept in case the
> command fails, which we can check by calling `.returncode()`.

Thanks, this sounds like a much neater way of avoiding the whole issue!

// Martin


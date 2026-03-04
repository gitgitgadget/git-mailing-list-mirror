Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A33D5242
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649712; cv=none; b=uxq/Q3bH53lZQczq2Apw7gMuAXmghqtNN870afdX5hGQO83N8e/0J070jTvCA7mFUUvMezmQXp10oYN765gp4/y/qJnC53RWDPhInt5sWHE2k/jvaTFjqGygqiaWC/6OP3RT2ng/UKAsJKqZv5RJjwYqn6SQmZ3BpaB9AFvHJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649712; c=relaxed/simple;
	bh=Y82JJNHVj2BQ9xqD1MzLpFsVUc5Vna5GIvpjboSR1Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3X5BjkZZ8bo0s2zcv1NzsbGDEg3dqRgm0LHirnqWX6l44zCTtOtsultCKdf2bwPuysfqYQqdhKhKbsFcOFTrq75ndJNZHiOolx/CcprL77f28K9LyO1wx2VmPDPzWg1G5ZbMlLa8vJpPSazJO4cy3WNSf2EW6Mfbvg+4PzQfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBGWmiY9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBGWmiY9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a8fba89cb5so4440035ad.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772649710; x=1773254510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWwzCm+vwrq7U2Euh5Sytml0o0vAaL/u8GnBtzs1XWI=;
        b=mBGWmiY9hXo4Lo2geNKxN9PnvgghDwzlL6Y7PUov5AHEGY2CV3b7cwjTQVLCWACwzE
         /DhvjsCjaA0FE8+/khF6GnYs72XIrVu7yCKUFWmkeN3d7OCPTYO1uqdyZn3nr5lHhev6
         kViw52qra2vKJ7WEBpdn+giGrkZSJssSA6/IN5Y/ZMkCNStABeglDoamuTKtnaVF6sgR
         o8ymsmFQ6KxUT9AqBH0JOndG4tBD5Tqsm3ivN59x20ZU2sluXmYxpKfryqdiGibnkicD
         OAftArqi3oW7yRT1SThvfAham5NORrSpaYLgXerv54XgZzi6ukJ8RI0qobqmBN6e3G5L
         5wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772649710; x=1773254510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWwzCm+vwrq7U2Euh5Sytml0o0vAaL/u8GnBtzs1XWI=;
        b=ABafL23zDztC7yff/OdHlioPLKDHj95WiJu/m3ipfYIOiZlRkjLSZ0wtKCRFFKzRxb
         vnTUnqtQN3U30GG1YqffRaIA9P460XDw5zaPMazJcCsCa4thcqhuKelEMBtS0MPeuaKY
         gaYuRA+2D5KVth2oS1blqF9txT1drfSMDtYIRi+UyG1TpHAwJq37DDu0uP/zlAGsBSD/
         3BZpk6o+DX+ceiCOAaPapgK+CT+hKjBmIh0RMGgmddxmxHfv6YYQmV7U32V6zH0l1yxm
         izfMvthvev2Zkf6qimOp142jADzUZmgoETkhJ8Vqc8nHlIZtCB5YKrvchdbOJj5HRMjj
         dL6w==
X-Forwarded-Encrypted: i=1; AJvYcCWceY57p+jiPP/F7dBA6mK8ai2Gk+eF5+Yke5207Vfz1dHbYhQF4TXE7fU9Zt88/08TRxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhz7bECS9h0FyXhi77wLAGpWG7W+INJPtTlrN/A3JoEyWqilWi
	gMt2LvTqVzH7YX5bOGgl08cyL61Y69YdFcDNpLM8EPJBoW30/8hfJklA
X-Gm-Gg: ATEYQzzv0Yl51v+Vu7hIWJNbbHniBKOU66QVwvJwf84fscOOLog+qB7A9r/qvkOTkKp
	wJGGtpoGSgEWsvdn6ejyqiRvfMCmQCi0Atvxp7TSsF2cyCbpiv9MVlM0FqE0Wu/DbWfKpnyZWOF
	6YggGer/rSsFyYxKfAP/4/6D/gt/PQKP7+xB7Iw/FNEr3QTD/dNeh5kS8az/vHKgqg1LUbGRfcP
	9XBlUIfneWwQk4UUVIp5i4g4kd9j3rhLfroNHuHJYnBdG1T60i0kl+S3Uwbg1wuL7FHu5Dkocvw
	EEBfZnTyIQFVBirB3dC8SvkAXIfzH7yhWRdKddHclaZ18iAXjFUOQu35XvHYvfo3LCz+9JgHH10
	nSvlCdpLwP94wiyJHy8z+IMXwU83stx5HZhvwK4Cakkzf2uOEpHtOug7BP1L2T7smxSr0CU2Kpk
	ae4d0f0+n81kFC3/g4FIlAoktcIXl0YVga5d2P3fVpeQAb3AA+6OMmVQDldsJEjmYmnJ6F8/zGH
	2iehSvzANna
X-Received: by 2002:a17:902:cf07:b0:2a0:992c:1ddd with SMTP id d9443c01a7336-2ae6ac04429mr20666885ad.8.1772649710224;
        Wed, 04 Mar 2026 10:41:50 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ef997sm16609487a12.2.2026.03.04.10.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 10:41:49 -0800 (PST)
Message-ID: <00f6d468-7d00-4edc-886d-723322420539@gmail.com>
Date: Thu, 5 Mar 2026 02:41:46 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
 karthik.188@gmail.com, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
 <xmqqjyvu42pw.fsf@gitster.g> <460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
 <xmqqo6l49mrt.fsf@gitster.g> <99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
 <xmqqfr6fa63h.fsf@gitster.g> <fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com>
 <xmqqcy1j8o5r.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqcy1j8o5r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio,

On 3/5/26 02:06, Junio C Hamano wrote:

> v12 does work differently from what we have been aiming for, but I
> find that it arguably is a much safer approach.

Maybe, but my main concern was that adding 'die()' in 
'setup_git_directory_gently_1()' might not be the best choice. 
Considering the implementations of the preceding functions, I though 
locating 'die()' in 'setup_explicit_git_dir()' might be a better choice? 
By the way, I noticed there's a '(read_gitfile(path))' macro that 
expands to 'read_gitfile(path, NULL)'. I was planning to pass 
'error_code' here, essentially moving the logic from the original 
'setup_git_directory_gently_1()' to this location, where the former 
would only be responsible for returning the error status... The changes 
would be a bit too extensive if I did it that way.

Since you say the v12 patch is safer, I have no objections. I'm 
completely unsure about the overall structure of this part. Skill issue.

> Even though the updated read_gitfile_gently() returns finer-grained
> READ_GITFILE_ERR_* codes than the original, read_gitfile_error_die()
> does not change behaviour from the original.  Any caller that use
> read_gitfile(path), which is read_gitfile_gently(path, NULL), like
> the setup_explicit_git_dir() codepath we have been looking at lately,
> lets read_gitfile_error_die() react to the error code, which is to
> behave exactly as what the code did before this patch.

I should have considered this. I feel that the changes in v12 are 
actually more like a band-aid fix compared to the previous ones.

You mentioned this change didn't touch 'read_gitfile_error_die()', and I 
think that's one of the benefits of such simple modifications. I just 
can't be entirely sure what the trade-offs might be — perhaps it's my 
lack of experience, but I always worry about digging a deep hole for 
future developers to fill. I'll keep learning.

> So, I dunno.  After all, these two NEEDSWORK comments have been with
> us for quite some time, and reminded us that we may want to consider
> if we need to do anything differently.  I do not think we mind if we
> conclude negatively, taking "no, it is of dubious value to tighten
> error checking in these code paths" as an answer to these NEEDSWORK
> comments.  v12 is slightly less defeatest than that stance in that
> we are only allowing the callers that care about what kind of errors
> they are getting and and want to decide how to react to them, while
> keeping the default error behaviour the same for those who do not
> ask with &error_code what kind of errors we saw.

I see.

> The patch makes the behaviour change for callers that pass an
> &error_code pointer to read_gitfile_gently() and act on the returned
> error code itself, like the discovery code path.  As long as these
> callers are audited and adjusted as necessary, we have very little
> risk of regression.
> 
> I won't be doing a full audit in this message, but just to give
> taste of what is expected ...
> 
> $ git grep -n -e 'read_gitfile_gently('
> 
> builtin/init-db.c:212:		p = read_gitfile_gently(git_dir, &err);
> 
> This caller gives &err but it never looks at what is in it after the
> call returns, so there shouldn't be any behaviour change.
> 
> setup.c:465:	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
> 
> This is followed by
> 
> 		ret = 1;
>          if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
>              gitfile_error == READ_GITFILE_ERR_READ_FAILED)
>                  ret = 1;
> 
> I do not offhand know if this list of "error codes that should
> result in returning 1 from this function" needs to be tweaked to
> adjust for the change in this patch.
> 
> worktree.c:390:	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, &err));
> 
> This is followed by code that reacts to path being NULL and shows
> the contents of err in an error message.  Should be benign.

I don't think this needs to be changed. If a new error_code 
READ_GITFILE_MISSING is encountered, then this isn't a repository at 
all, so it won't enter the if statement, and ret = 0.

If encountering the READ_GITFILE_ERR_IS_A_DIR, the 
is_git_directory(path->buf) check takes precedence. If it detects a 
valid .git directory, it returns 1. Therefore, the gitfile_error 
function doesn't need to match IS_A_DIR at all.

Thank you for taking the time to review my (roughly made) patch.

Goodnight,

Yuchen

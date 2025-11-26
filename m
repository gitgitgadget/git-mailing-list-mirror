Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CB533B6DD
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172966; cv=none; b=ji0wIggZpc4XLAE9cjnU8azm6oPSfzcqg8lpcXo1+eYMLXN8Ag1oc3cK6magSJFIR1g/Sm9fcUYD5hzMn52XIuwS6oP076eEsDK8+xWnu6elCQDBU/WHCgTfvkxYxJIvZr1ItyQXUK2qTDUo2suTtTsyKLJ63d2nvTCLHZb0mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172966; c=relaxed/simple;
	bh=AHkVZrLmt6k3c39TwUt/j+gsCoIXYM85SfXlkRaDyhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcFCRMQbLe/O4yPSB+X9XG2emRZDGiVk5r4GjkVo2FScmTXlW6pUP3aHwayFqe1h+j/CihK4dsZOSsldU9QAMroCDygaYYrFaWTeZTNtU6tgWojUDcE21fexu/uaZsptnVmBTePFX0dQcMig/n43UJ78u6ZTR5NhdkQePi6s+bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGEVl3T7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGEVl3T7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779a637712so42706105e9.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 08:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764172962; x=1764777762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9+hO/PhJtrgt4luCk4SazPTi9vAMo+5CSsN66f0SARg=;
        b=AGEVl3T76l+prAt7DMaYU4sBGBep0OD8P1mX/l3rb/QVsLvikq0WKb/pB/bt2/m4Sn
         +DtgsQbMV5kz9TJP0oSrtcXAMAOjMWAhaAYe0Chgpk9ZpAbzhwRbYiZCFrv/5oIIagZ4
         ujFUdQZRrW7nkBkdBkwLvzuPH3wF2eEWlGNjWBf52bgMAAiKLhC6RRJVlT40bJJFr357
         i861z+GoXjZFhGGbCzAVJFdmxomyZXSd2bTIL03YW6eS81U4oy+iBJAn8Z2nLKGYkMc7
         N9jzV0girFnWqvWikAeNE6lRnI+BVFudhPSju9uNvFiLKnM1KWybE1b6ldsPqouqdYnn
         apiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172962; x=1764777762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+hO/PhJtrgt4luCk4SazPTi9vAMo+5CSsN66f0SARg=;
        b=Pm1mSpCAgNKmvhapQyHlzY2R1ESEzEvNLA6nLsWkXj9mtdtifMFt1eoizUD1vEZI0M
         0ErfL1SLCHGPFsu0lkX355VWpSzHn5vPlGPgz3LlwJq377mrG7JT0BU7CwL0Vd7Yh2Gi
         UAbRQqSwFkmnBXIoANdoDZFv79UOgpRxT2EqQPbW30WJEnf/cC0mZTmCof4Q+sfn50Kn
         W3gflFF1TYrGqnM+fDaCPefvL+UFUGIT3kSJxVf0wzUZLGJpP9PjveFWe0jSTnaj1F8x
         Cz/EEej0ue6dLaUXaLbui+34AQEWsJ2IflphluFtc7TvlVH7OMvQSYxdQFOA7NqpqK6B
         VpMg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0ExINfCjMSxMLNdpQAuudPxptY+fkgsKNQEtngiAy3W2Ox1KXEPg8o5FTIRJT9eV3No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N6Ls7/qurNcbW8C/vmQiE/QHuXFNt4CbshTGPX6/wTSrIJQy
	iKxLL7qUi0J5CmvP8+fRIAeHvrPxVGDlMk22M2tUAbZthAi63R+/VQl7h4+Zrg==
X-Gm-Gg: ASbGncu+8V02cl/l9tdiM9s2QdmG0zjrvvHLsYrANWK6VspMy7d1oFtyC1iP4+s6jPf
	Ffv755lZZzkDr10pHDJ3rV0B8JuTFJFnOXCNJKT+m3/hBgAOY/K5FivXxy9AhhlYysali82AQm7
	f0ziQuhU1AVDJoeG3sdUvKmxcte6oJXH+pSSoYoeNkyZFajtV0sHxdSGNasyRKYgN7Cl6jWfa0s
	NR3Xm9LyTF1RcE3AMoVNhHnUrro9uJO9fFFRGLlrb6Xs97LIIVOsA4mWp5SkQU08wy8SKCEpyEU
	yrTxO3ECDR5a3dCd17AoqD1dBvh1IaCTu8C9ms7e0qWZtgAqCmRZFBaiYuX4dXHk8FrIjMaa/QA
	/UlYgVOczFiwsZ1EAqZnIBkpJW8S9Pew/E/Hk0zlwtlA+UakCQy+q0WNjGwkjW6MPKeV7agm9Lp
	FfjIjG+i4/stpeB1TSMRF3pEXb/HPN8wBBC8PX0w/Y80+Zk21t2b8oRBSrpWnPaRg=
X-Google-Smtp-Source: AGHT+IHgourLntKEr2i899HHKGZlbBWUhb3L+wR8dPtSEZcpXXENh9GQUWqB5rgmoiMn0K3QXb9w3Q==
X-Received: by 2002:a05:600c:4694:b0:477:7a1a:4b81 with SMTP id 5b1f17b1804b1-477c0170599mr167981395e9.9.1764172961968;
        Wed, 26 Nov 2025 08:02:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adf0b2asm47933565e9.11.2025.11.26.08.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 08:02:40 -0800 (PST)
Message-ID: <061c627f-46a4-4da7-af5e-17fda552e29a@gmail.com>
Date: Wed, 26 Nov 2025 16:02:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] doc: warn against --committer-date-is-author-date
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, j6t@kdbg.org,
 Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk
References: <d17060d9b72.1759952528.git.code@khaugsbakk.name>
 <V2_committer-date-is-author-date.1@msgid.xyz>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <V2_committer-date-is-author-date.1@msgid.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

This looks good, I appreciate the detail in the commit message. Sorry 
I've only just got round to looking at it.

Thanks

Phillip

On 20/11/2025 16:26, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This option could create a commit history which violates the assumption
> that commits have non-decreasing commit timestamps. Warn against that in
> both git-am(1) and git-rebase(1).
> 
> The genesis of this option is from git-am(1) and was added in
> 3f01ad66 (am: Add --committer-date-is-author-date option,
> 2009-01-22). The commit message doesn’t give us an example
> of a use case, but the thread starter does:[1]
> 
>      I've a big set of patches in a mbox file: there's sufficient info
>      inside for git-am to work.
> 
>      Yet, each time I do import these, my sha1sums are changing because of
>      different commit dates.
> 
>      I'd like to force the commit date to match the info/date from the time
>      I received the email (and therefore always get back the right
>      sha1sums).
> 
> [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
> 
> So the motivation was to treat git-am(1) as an import command that
> creates the same commit IDs.
> 
> Putting aside the question of whether you should be using git-am(1) for
> importing commits, this approach is problematic:
> 
> • you still need to apply the commits to the same base if you want the
>    same hashes; and
> • you need the same committer.
> 
> And if you expect the same committer, why is this person applying the
> same patches multiple times with the goal of making *identical* commits?
> 
> That was all for git-am(1).
> 
> It was added to git-rebase(1) in 570ccad3 (rebase: add options passed to
> git-am, 2009-03-18)[2] in order to plug options that could not be sent
> on to git-am(1). At this point the utility of the option graduated to
> making no sense; a use case for `git rebase --committer-date-is-author-
> date` is still yet to be found.
> 
> Just warn against using this option on both commands and remind the user
> to consider whether they really need it.
> 
> † 2: See also 7573cec5 (rebase -i: support
>       --committer-date-is-author-date, 2020-08-17) for the commit for the
>       merge backend
> 
> Suggested-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
> 
> Notes (series):
>      Topic name: kh/committer-author-date
>      
>      Topic summary: "--committer-date-is-author-date" can create a history
>      with commit timestamps that are not strictly increasing. That doesn't
>      play well with the revision walking machinery. Warn against that.
>      
>      (See https://lore.kernel.org/git/cover.1759873165.git.me@ttaylorr.com/ )
>      
>      -----
>      
>      v2:
>      
>      Add sentence “You should consider if you really need to use this option.”
>      in front of “[make sure you] only use this option to ...”.
>      
>      The problem here is whether to:
>      
>      1. Go over the history of why it exists
>      2. Say don’t use it
>      3. Prod them to think about why they are using it
>      
>      Opt for (3) in the spirit of giving the user the rope they may think
>      they need, just with a reminder to consider what they are actually
>      trying to achieve.[0]
>      
>      There was a discussion about deprecating it. But this version still
>      just warns.[0]
>      
>      And:
>      
>      • Commit message: Drop “legitimate uses” after reviewer feedback and
>        discussion. The message goes into why the reported use case does not make
>        enough sense
>      • Use `WARNING` as a callout instead of `NOTE`[1]
>      • Put the warning paragraph second/last[2]
>      • Commit message: Use “override” instead of “lie”.[3] Either works but
>        “override” is more neutral[4] and not less forthright.
>      • Drop “clock skew” and git-rev-list(1) mention[5]
>      • Commit message: Tweak “The genesis” paragraph: “is from git-am(1)” since
>        most of the explanation goes over the git-am(1) option
>      • Use “non-decreasing commit timestamps”. I guess “strictly increasing”
>        means that the commit timestamps need to be greater for each.  But a commit
>        B that follows A can have the same timestamp, that’s ok.
>      • s/applying commits/rebasing commits/ in git-rebase(1)[6]
>      
>      🔗 0: https://lore.kernel.org/git/xmqqbjm695p4.fsf@gitster.g/#t
>      🔗 1: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
>      🔗 2: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
>      🔗 3: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
>      🔗 4: https://lore.kernel.org/git/6a921119-6fba-4f82-916f-d80d3f46d54d@app.fastmail.com/
>      🔗 5: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
>      🔗 6: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
>      
>      v1:
>      
>      I thought about marking it as deprecated but eventually found out why it
>      was added. And it wasn’t for some (still unknown) dedication or
>      not-explained *want* to keep the committer date and author date in synch
>      just-because (as I thought[1]).
>      
>      Hannes asked[2] why it is a porcelain option? (You can after all script
>      the same behavior with a little effort.) Personally I think the Git
>      porcelain is not shy about providing facilities for crafting made-up
>      histories to its users. And I personally think that’s a good thing.
>      
>      This does seem to indicate that this option doesn’t make much sense for
>      git-rebase(1) though, no? Given that it will `--force-rebase`, i.e. will
>      force new commit IDs.
>      
>      🔗 1: https://lore.kernel.org/git/93041214-4774-49eb-b8bd-24648134cded@app.fastmail.com/
>      🔗 2: https://lore.kernel.org/git/6af09726-e3bf-4903-87ae-9524ad334678@kdbg.org/
> 
>   Documentation/git-am.adoc     | 7 +++++++
>   Documentation/git-rebase.adoc | 7 +++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
> index 221070de481..264d21a7de7 100644
> --- a/Documentation/git-am.adoc
> +++ b/Documentation/git-am.adoc
> @@ -161,6 +161,13 @@ Valid <action> for the `--whitespace` option are:
>   	commit creation as the committer date. This allows the
>   	user to lie about the committer date by using the same
>   	value as the author date.
> ++
> +WARNING: The history walking machinery assumes that commits have
> +non-decreasing commit timestamps. You should consider if you really need
> +to use this option. Then you should only use this option to override the
> +committer date when applying commits on top of a base which commit is
> +older (in terms of the commit date) than the oldest patch you are
> +applying.
>   
>   --ignore-date::
>   	By default the command records the date from the e-mail
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 956d3048f5a..0f808c82b28 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -507,6 +507,13 @@ See also INCOMPATIBLE OPTIONS below.
>   	Instead of using the current time as the committer date, use
>   	the author date of the commit being rebased as the committer
>   	date. This option implies `--force-rebase`.
> ++
> +WARNING: The history walking machinery assumes that commits have
> +non-decreasing commit timestamps. You should consider if you really need
> +to use this option. Then you should only use this option to override the
> +committer date when rebasing commits on top of a base which commit is
> +older (in terms of the commit date) than the oldest commit you are
> +applying (in terms of the author date).
>   
>   --ignore-date::
>   --reset-author-date::
> 
> Interdiff against v1:
>    diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
>    index c36ae679cfb..264d21a7de7 100644
>    --- a/Documentation/git-am.adoc
>    +++ b/Documentation/git-am.adoc
>    @@ -156,18 +156,18 @@ Valid <action> for the `--whitespace` option are:
>     	See also linkgit:githooks[5].
>     
>     --committer-date-is-author-date::
>    -	NOTE: The history walking machinery assumes that commits have
>    -	strictly increasing commit timestamps, with some tolerance for
>    -	clock skew (see linkgit:git-rev-list[1]). You should only use
>    -	this option to lie about the committer date when applying
>    -	commits on top of a base which commit is older (in terms of the
>    -	commit date) than the oldest patch you are applying.
>    +	By default the command records the date from the e-mail
>    +	message as the commit author date, and uses the time of
>    +	commit creation as the committer date. This allows the
>    +	user to lie about the committer date by using the same
>    +	value as the author date.
>     +
>    -By default the command records the date from the e-mail
>    -message as the commit author date, and uses the time of
>    -commit creation as the committer date. This allows the
>    -user to lie about the committer date by using the same
>    -value as the author date.
>    +WARNING: The history walking machinery assumes that commits have
>    +non-decreasing commit timestamps. You should consider if you really need
>    +to use this option. Then you should only use this option to override the
>    +committer date when applying commits on top of a base which commit is
>    +older (in terms of the commit date) than the oldest patch you are
>    +applying.
>     
>     --ignore-date::
>     	By default the command records the date from the e-mail
>    diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
>    index 336ee90f7e3..0f808c82b28 100644
>    --- a/Documentation/git-rebase.adoc
>    +++ b/Documentation/git-rebase.adoc
>    @@ -504,17 +504,16 @@ merge backend;;
>     See also INCOMPATIBLE OPTIONS below.
>     
>     --committer-date-is-author-date::
>    -	NOTE: The history walking machinery assumes that commits have
>    -	strictly increasing commit timestamps, with some tolerance for
>    -	clock skew (see linkgit:git-rev-list[1]). You should only use
>    -	this option to lie about the committer date when applying
>    -	commits on top of a base which commit is older (in terms of the
>    -	commit date) than the oldest commit you are applying (in
>    -	terms of the author date).
>    +	Instead of using the current time as the committer date, use
>    +	the author date of the commit being rebased as the committer
>    +	date. This option implies `--force-rebase`.
>     +
>    -Instead of using the current time as the committer date, use
>    -the author date of the commit being rebased as the committer
>    -date. This option implies `--force-rebase`.
>    +WARNING: The history walking machinery assumes that commits have
>    +non-decreasing commit timestamps. You should consider if you really need
>    +to use this option. Then you should only use this option to override the
>    +committer date when rebasing commits on top of a base which commit is
>    +older (in terms of the commit date) than the oldest commit you are
>    +applying (in terms of the author date).
>     
>     --ignore-date::
>     --reset-author-date::
> 
> Range-diff against v1:
> 1:  d17060d9b72 ! 1:  203a9b9db2c doc: warn against --committer-date-is-author-date
>      @@ Metadata
>        ## Commit message ##
>           doc: warn against --committer-date-is-author-date
>       
>      -    This option has legitimate uses but could create a commit history which
>      -    violates the assumption that commits are strictly increasing in terms of
>      -    commit timestamps. Warn against that in both git-am(1) and git-rebase(1).
>      +    This option could create a commit history which violates the assumption
>      +    that commits have non-decreasing commit timestamps. Warn against that in
>      +    both git-am(1) and git-rebase(1).
>       
>      -    ❦
>      -
>      -    The genesis of this option is 3f01ad66 (am: Add --committer-date-is-
>      -    author-date option, 2009-01-22). The commit message doesn’t give us an
>      -    example of a use case, but the thread starter does:[1]
>      +    The genesis of this option is from git-am(1) and was added in
>      +    3f01ad66 (am: Add --committer-date-is-author-date option,
>      +    2009-01-22). The commit message doesn’t give us an example
>      +    of a use case, but the thread starter does:[1]
>       
>               I've a big set of patches in a mbox file: there's sufficient info
>               inside for git-am to work.
>      @@ Commit message
>               I received the email (and therefore always get back the right
>               sha1sums).
>       
>      +    [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
>      +
>           So the motivation was to treat git-am(1) as an import command that
>      -    creates the same commit IDs given the same base and committer.
>      +    creates the same commit IDs.
>       
>      -    [1]: https://lore.kernel.org/git/46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com/
>      +    Putting aside the question of whether you should be using git-am(1) for
>      +    importing commits, this approach is problematic:
>      +
>      +    • you still need to apply the commits to the same base if you want the
>      +      same hashes; and
>      +    • you need the same committer.
>      +
>      +    And if you expect the same committer, why is this person applying the
>      +    same patches multiple times with the goal of making *identical* commits?
>      +
>      +    That was all for git-am(1).
>      +
>      +    It was added to git-rebase(1) in 570ccad3 (rebase: add options passed to
>      +    git-am, 2009-03-18)[2] in order to plug options that could not be sent
>      +    on to git-am(1). At this point the utility of the option graduated to
>      +    making no sense; a use case for `git rebase --committer-date-is-author-
>      +    date` is still yet to be found.
>      +
>      +    Just warn against using this option on both commands and remind the user
>      +    to consider whether they really need it.
>      +
>      +    † 2: See also 7573cec5 (rebase -i: support
>      +         --committer-date-is-author-date, 2020-08-17) for the commit for the
>      +         merge backend
>       
>           Suggested-by: Johannes Sixt <j6t@kdbg.org>
>           Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>      @@ Notes (series)
>       
>           v2:
>       
>      -    • Deprecate in addition to warning
>      +    Add sentence “You should consider if you really need to use this option.”
>      +    in front of “[make sure you] only use this option to ...”.
>      +
>      +    The problem here is whether to:
>      +
>      +    1. Go over the history of why it exists
>      +    2. Say don’t use it
>      +    3. Prod them to think about why they are using it
>      +
>      +    Opt for (3) in the spirit of giving the user the rope they may think
>      +    they need, just with a reminder to consider what they are actually
>      +    trying to achieve.[0]
>      +
>      +    There was a discussion about deprecating it. But this version still
>      +    just warns.[0]
>      +
>      +    And:
>      +
>      +    • Commit message: Drop “legitimate uses” after reviewer feedback and
>      +      discussion. The message goes into why the reported use case does not make
>      +      enough sense
>           • Use `WARNING` as a callout instead of `NOTE`[1]
>           • Put the warning paragraph second/last[2]
>      -    • Use “override” instead of “lie”.[3] Either works but “override” is
>      -      more neutral[4] and not less forthright.
>      +    • Commit message: Use “override” instead of “lie”.[3] Either works but
>      +      “override” is more neutral[4] and not less forthright.
>           • Drop “clock skew” and git-rev-list(1) mention[5]
>      -
>      +    • Commit message: Tweak “The genesis” paragraph: “is from git-am(1)” since
>      +      most of the explanation goes over the git-am(1) option
>      +    • Use “non-decreasing commit timestamps”. I guess “strictly increasing”
>      +      means that the commit timestamps need to be greater for each.  But a commit
>      +      B that follows A can have the same timestamp, that’s ok.
>      +    • s/applying commits/rebasing commits/ in git-rebase(1)[6]
>      +
>      +    🔗 0: https://lore.kernel.org/git/xmqqbjm695p4.fsf@gitster.g/#t
>           🔗 1: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
>           🔗 2: https://lore.kernel.org/git/601b145d-b183-4101-acb3-4a32b2ec4380@kdbg.org/
>           🔗 3: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
>           🔗 4: https://lore.kernel.org/git/6a921119-6fba-4f82-916f-d80d3f46d54d@app.fastmail.com/
>           🔗 5: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
>      +    🔗 6: https://lore.kernel.org/git/3a8dfd13-982d-4c83-b675-1e9a63bb6ab0@gmail.com/
>       
>           v1:
>       
>      @@ Notes (series)
>       
>        ## Documentation/git-am.adoc ##
>       @@ Documentation/git-am.adoc: Valid <action> for the `--whitespace` option are:
>      - 	See also linkgit:githooks[5].
>      -
>      - --committer-date-is-author-date::
>      --	By default the command records the date from the e-mail
>      --	message as the commit author date, and uses the time of
>      --	commit creation as the committer date. This allows the
>      --	user to lie about the committer date by using the same
>      --	value as the author date.
>      -+	NOTE: The history walking machinery assumes that commits have
>      -+	strictly increasing commit timestamps, with some tolerance for
>      -+	clock skew (see linkgit:git-rev-list[1]). You should only use
>      -+	this option to lie about the committer date when applying
>      -+	commits on top of a base which commit is older (in terms of the
>      -+	commit date) than the oldest patch you are applying.
>      + 	commit creation as the committer date. This allows the
>      + 	user to lie about the committer date by using the same
>      + 	value as the author date.
>       ++
>      -+By default the command records the date from the e-mail
>      -+message as the commit author date, and uses the time of
>      -+commit creation as the committer date. This allows the
>      -+user to lie about the committer date by using the same
>      -+value as the author date.
>      ++WARNING: The history walking machinery assumes that commits have
>      ++non-decreasing commit timestamps. You should consider if you really need
>      ++to use this option. Then you should only use this option to override the
>      ++committer date when applying commits on top of a base which commit is
>      ++older (in terms of the commit date) than the oldest patch you are
>      ++applying.
>        
>        --ignore-date::
>        	By default the command records the date from the e-mail
>       
>        ## Documentation/git-rebase.adoc ##
>      -@@ Documentation/git-rebase.adoc: merge backend;;
>      - See also INCOMPATIBLE OPTIONS below.
>      -
>      - --committer-date-is-author-date::
>      --	Instead of using the current time as the committer date, use
>      --	the author date of the commit being rebased as the committer
>      --	date. This option implies `--force-rebase`.
>      -+	NOTE: The history walking machinery assumes that commits have
>      -+	strictly increasing commit timestamps, with some tolerance for
>      -+	clock skew (see linkgit:git-rev-list[1]). You should only use
>      -+	this option to lie about the committer date when applying
>      -+	commits on top of a base which commit is older (in terms of the
>      -+	commit date) than the oldest commit you are applying (in
>      -+	terms of the author date).
>      +@@ Documentation/git-rebase.adoc: See also INCOMPATIBLE OPTIONS below.
>      + 	Instead of using the current time as the committer date, use
>      + 	the author date of the commit being rebased as the committer
>      + 	date. This option implies `--force-rebase`.
>       ++
>      -+Instead of using the current time as the committer date, use
>      -+the author date of the commit being rebased as the committer
>      -+date. This option implies `--force-rebase`.
>      ++WARNING: The history walking machinery assumes that commits have
>      ++non-decreasing commit timestamps. You should consider if you really need
>      ++to use this option. Then you should only use this option to override the
>      ++committer date when rebasing commits on top of a base which commit is
>      ++older (in terms of the commit date) than the oldest commit you are
>      ++applying (in terms of the author date).
>        
>        --ignore-date::
>        --reset-author-date::
> 
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0


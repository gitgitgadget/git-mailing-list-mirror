Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2322033A
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740947651; cv=none; b=NttVxnyNk7kbn6h0OjA/6Bj5pFe6fnn9/5vHH/uP0GohVCWwarFrq+Ei3MlGhwb9QCpI7izNZyp4WlYLEdRcxYEBpy+OL/rRm6O6WcbrI/w3NBH54ZSQ7MSG0+Ev3h9vwOCrA7NOD1Nq+dvgpUxaawlLL073UycLn/mCkV+y6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740947651; c=relaxed/simple;
	bh=jdYs+IMB2z/OD3L7SR+H4+d3z2zO49UfjhhuzRZmCjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuaDOw5yV45ra8M0Gcz8zFjBJPXIS706W+gLNJ2Iht7+8PTs0GYwjZLCjq7C4/+AFFUSQWG2Hjh4yy6CGihhjnFr8RJh39IJ8ccjovpaMvkDtMdnNT+Q60CFQ2EuleqFzKgg6o9GC3Dzqb/oVTT2waFBbqxvkEasHh0QFz8m474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=NJ12VpGg; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=VCTJ0zLd; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="NJ12VpGg";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="VCTJ0zLd"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6e889e77249so32950016d6.1
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 12:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740947648; x=1741552448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4nF1dG2gin9uFXN1qVjNqMGPmOVx+nb7aD6Jc+fziOg=;
        b=kvIzxxrnG4FYSQzmwWSWKpcFwX2khGwgtAiP6WEx+ErVlu+b0vY2MAQD7YBeJcec5Q
         6a2kkcI5hqE35XLaTwR9flwvNVx5itWF7ZNxnCFXfVKuazO6gC68wSTJ42CeZTifxvVq
         fiY+axhlFiP7bwHWhXDoYu5VBw12gBOxDbWtTg1rxbChqw0Tk81hvMCLDGu3jAS1IT5O
         d3m4H9aXbYFmfTyj3iaZxaQWeO+cMyWF284jzpvQE9eMSvfWtf2NJ3kknXmRPIbGzeNB
         ApRqwUP3tOLLpbn4dBp2LN01hiPwmz30xl4KuqwzlYzZEHhqHt3KydwpOJ6cylM0UvE6
         MPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt1NsiwWpSls+oEtfVwT5hjicwvYgoGG489dgZq6jY23HgsCuErtfrHSGO5o0zw5464Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WpIGuZj3WyXoknoloi3gMhuEqzwdqiWIbFc4q/fCQ0O1u2Xu
	qa54NENFsH5FveYStlIv6yOVx308xt+xoNH1sC+6LCy6yx7IILZGc1ONszAJZH7PaclKQX3GzIA
	Y2dn9hd64IN+TlvKbkaqY9E3HvZzw8Jyn
X-Gm-Gg: ASbGncuYEh556wtkPbSLV9kyDNok4/K0gh73FvscPJOjljVQHcDcPeyRifxwz0sv9VP
	4dVkKvIlJQtr/eljTfYPFFAw1+gTDDjdhRK5AWRvyHxgB1ONL/ZRd2b7RWj44cM/Q9dLbKA3nHn
	OK2ORutOfaf8sxBvWmY3qcObKA+wlXOWcmKg8mwvwVnv/TKxxvcqz38NMdojM5w3tbIg5IfPFgz
	oQyzp1TOWG87djt8z2BhRdCVcy1TRRO+U/Seo/5iPgA2XtMHrkrblJKqcBKjhvuOO7i4EEi2spp
	k1dy+RRMpHxarNi2Jl7Z9UGMHTYBwxB53omQOLhBvMMB2Hl3XQePi9gQoKM2yuYSO4mdESw9gLD
	K8RXwxoSiVJfvTnXaXm2D9Ui+Fbc14w==
X-Google-Smtp-Source: AGHT+IFM0BhuizvSGrM8aIC8jyhZnnHmeJOOTj7RGleGyz9TtlEnYrHAYdt0G++EzRQ5Sfixgfe7zY0Z8Flx
X-Received: by 2002:ad4:5f48:0:b0:6e6:6505:ceb2 with SMTP id 6a1803df08f44-6e8a0d94c56mr202950906d6.36.1740947648537;
        Sun, 02 Mar 2025 12:34:08 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8976a43d5sm3642416d6.67.2025.03.02.12.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:34:08 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1740947647; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=jdYs+IMB2z/OD3L7SR+H4+d3z2zO49UfjhhuzRZmCjE=;
 b=NJ12VpGgGvJz62nojiQfy0LJlsgbPiupWXZrY+lA5GFQECENGnWHRZzwX7dQYvh84SdVH
 uukQNLnaSq6q0OXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1740947647; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=jdYs+IMB2z/OD3L7SR+H4+d3z2zO49UfjhhuzRZmCjE=;
 b=VCTJ0zLdRrmdy287AFt1EqeqUAFDVCTPLQRVC59ctQ0EBm6uBUje2AYCarP3coqq39EuH
 QnI2Wsq/UctMv9uxA5vTQs9J1ZTsRhAdwUDdc7HEX1bnX2HP9E+PnuMkCJKEWi8KvrkvErQ
 xpkSTwk+4O/NCCFUqj8mrjas1LFD5ZuuShfZ8rj5tRRpiXIx4fLb7wEntSjeczMziFNtxj0
 Cpgd7CdhnrhOvm5PC9VMX7GaxJihp+ASAnyVpGUbLwdBc5XIPCyTt9L3JLyerej59W6MDoM
 XLTHf2wONDmKyrZ8jhtkd/JNrjKDCXMPrrF/5aQQvCxn8dZddJ4zx/ww6Bkg==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z5YZR6vljz10df;
	Sun,  2 Mar 2025 20:34:07 +0000 (UTC)
Message-ID: <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
Date: Sun, 2 Mar 2025 15:34:07 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 2025-03-02 om 09:17 schreef Phillip Wood:
> Hi David
> 
> On 02/03/2025 07:45, David Mandelberg via GitGitGadget wrote:
>> From: David Mandelberg <david@mandelberg.org>
>>
>> Previously, some calls to for-each-ref passed fixed numbers of path
>> components to strip from refs, assuming that remote names had no slashes
>> in them. This made completions like:
>>
>> git push github/dseomn :com<Tab>
>>
>> Result in:
>>
>> git push github/dseomn :dseomn/completion-remote-slash
>>
>> With this patch, it instead results in:
>>
>> git push github/dseomn :completion-remote-slash
> 
> This sounds like a useful improvement and I like the idea, but I think 
> running "git for-each-ref" once for each remote is not going to scale 
> very well for people who have a lot of remotes. I think it would be 
> better to try and strip "refs/remote/$remote/" outside of "git for-each- 
> ref". I've not tested it but I think something like

Good point, I hadn't thought of that. Do you have a rough estimate of 
what "a lot of remotes" is? 100ish, maybe? I'd like to do some testing 
to get actual performance numbers before trying to optimize this, 
because I think the optimization has some drawbacks, see below.

If optimization is needed, another approach is to parallelize the forks:

{
	local fer_pids=
	for ...
	do
		__git for-each-ref ... &
		fer_pids="$fer_pids $!"
	done
	test -z "$fer_pids" || wait $fer_pids
} | sort | uniq -u

That might cause spikes in cpu/memory/disk usage that aren't ideal though.

> local sed_cmd=
> local remote
> # ref names and therefore remote names cannot contain '*?[]^' so we
> # only need to escape '.$/'. Using 'sort -r' means that if there is a
> # remote called "github" and another called "github/alice" we will try
> # and strip "github/alice" first.
> for remote in $(__git_remotes | sort -r)
> do
>      remote="${remote//./\\./}"
>      remote="${remote//\$/\\\$/}"
>      remote="${remote//\//\\\//}"

Just FYI since it took me hours to figure this out myself: I think this 
would break tests on macos because of an old version of bash that 
handles backslashes weirdly. I think removing the double quotes would 
work around that issue, and be safe because word splitting doesn't 
happen in assignments.

>      sed_cmd="${sed_cmd} -e s/^refs\/remotes\/$remote\/// -e t"
> done

Mostly just a note to myself if I end up using this idea: I think a 
space in $remote would break this because bash would split up the arg to 
sed. There's probably some way to fix that with extra escaping though?

> __git for-each-ref --format="$fer_pfx$sfx" \
>      ${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>      "refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" |

This would search for $cur_ in the wrong place because * only matches 
one path component, right? Changing to ** might help, but then it would 
match in places more it shouldn't.

> sed $sed_cmd | sort -u
> 
> should work and means we're only forking three extra processes no matter 
> how many remotes the user has. I'm not sure if it changes the output 
> order when GIT_COMPLETION_IGNORE_CASE is set though.
> 
> Best Wishes
> 
> Phillip


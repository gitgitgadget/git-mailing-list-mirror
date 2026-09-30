Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CF51FCB7
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793110; cv=none; b=F5H0HA0OFXD7m5MroDWu8MB1Cs4cebqL+y/noblo76pSQ0fXcSksy9x6DKLW0lgV0E+63KhObJCT8goOJIorYw4kuyjtF4CAT1yLRh2hLCwtpa66bXNIqGLlGpZSD1LsCTV3jx/+Z58wxMD7F6RkiSpqwouILm/gMttf9xweWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793110; c=relaxed/simple;
	bh=A1h9AOe3gHmYevLsLGtsdOOvBOU3/roAqKU1rJRjlLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CzHKy2Y1axHsz6jyshz5jpdNfeAlGFW5aGCazto5bvLkBF1IrLeLQ6pSV7HZDxXg0mjt/+J+iJ7Qt0JNw18w/VhmyYG2nUOYtCNlHiC9pM5KFJJFKt6uPkVWa6Zs5xtlD6yXQ5L5EzfYTvQ+Ti1TgHkHdyI8GHwomdygg9rQC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cY3YDaRP; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY3YDaRP"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5ce2742fc3dso2975220e0c.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793107; x=1791397907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcCLzkG6zONbgIGQ3R3U2DaVjnNEriFb9u81sNKEkFg=;
        b=cY3YDaRPK/p+hCKrCB5x5+71jNTIPUZpFOJJaT1YCirXCyHdZhZfsRmooCZ7uXo8lM
         vanEP7VQXAh9BqVAnULxg8KRWfYPP4SUbD8apohDJ/cnlMZSgayvs5eTZogbyicj2Kvn
         NcQl7L1efpt5a2lZCR3HnkX0D1G1Ntz4hLDkBWmKXjGQs1YX4buXtGOW//hP10tq17DK
         HRR0tAW/JGvs6KeNGCjX0XaCPHM95gYuro2WiUWm7B3wkEUzfoR7u3ElnpzDhOqS80U5
         2QYjVaPBYwLZHSljtHGLhcrc/KJFwGsNUd4z08VQzlaYjGPbeMiY58pViwwIW8gKZkuV
         2SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793107; x=1791397907;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcCLzkG6zONbgIGQ3R3U2DaVjnNEriFb9u81sNKEkFg=;
        b=xH7ryjuFS5xTeljwGxg6L28N8RrvFICnzRyiObQnwEB8Q/h/YMGlKAbmTRDgw3Txu5
         9dgVg3Tfaymc9orKzeJenB6RF9KGr0QFk4ft7p43zk20u4Wrm5W1XLJh77jr4FiqbMgQ
         13cq2CFZSUq3w26yex8MXXXhU6C+STnPr3AEu1mn/rWLpyVyTVlcfb9FDDoquT77Hx9G
         vE+bjMZ1og4CUj5MI+Lrr7rheZq0l7ZoCmjeOzuoSVB3gXMDcL0Bo+AKKhu1bAdD1UrA
         73Yr2aGNjSSsGeA9E6nGar6g3JTd1Bch+0SfqqdGtsIgm+IYLOWMMQIA2N+8vUM7DvHL
         +S6Q==
X-Forwarded-Encrypted: i=1; AKwUvByHNd526xTHxqryYC7rrPNHd9dTgeMsfscxTCYqGvgJ491YVWUuQJHOI8ZXlTRLi8pITwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDDkvkun5p0UYh9+Aq0+fFJU5wFveuZa60hsBs9IdQuhvT6E8E
	WlQ0ZZaJ+uvEhyvRdhD9E8nd6a24a694iPfCG+65OSkqnuQzMEBP8DvkxaSTiw==
X-Gm-Gg: AYBFou23BOb1Vvu5UFFOk5At0RTpNnDjIG6lXnpjyKK8GyusfzwwCJxdbzTPB5/hg6y
	nPpf9jm//qyAep7EqrMgSxerWN47kuA/wb1RACffz3BYP3pW6I6Kgwq4Ov1SM7rEoYJE1asmQCp
	KnVS4/Kr1GQ44gO307a5p8gGXfTOcdKs26EsJ9gxPU8hEt0kYA4jJi0SraYs1xuyg6pKcaDCY8J
	1PEA+5Ynvf6fV8++ljZsNOWUj8rmdT1QrXJv7nAS0NsHFDLXR2KNUnqlndOOCvW2PgN3s80rvdr
	I+Hvi6e4IFrQAaVoTeLL3VTUbRJ0GCpDVoQyZH58NkI/igeFcK3tij9VbneVkNl1jRer48OS5FK
	Bzz3oK+4h+39VcvEtLehOBk/12cxZ8QRoP0JLyOzp0rlBtnQbHOfYTctoawb9481mHWQKti0Qfm
	k2qgZ5Em729XsH6Ljw/WF01nqpgCMP7XLOPLbObT5dzvO5F0oiFSUNFh62IGfeMX1ju813PE3HK
	EI1RNlkz4d/HiLCdAlMzGbZpp4UsT5WOqdfCZPPyr+4tt6/uMG5pg==
X-Received: by 2002:a05:6122:1781:b0:5c8:c5f:e8fa with SMTP id 71dfb90a1353d-5d67a9c1781mr922917e0c.4.1790793107402;
        Wed, 30 Sep 2026 11:31:47 -0700 (PDT)
Received: from ?IPV6:2606:6d00:11:296d:6500:f703:fed5:ba52? ([2606:6d00:11:296d:6500:f703:fed5:ba52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d7fbc4bdbbsm72502e0c.15.2026.09.30.11.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 11:31:46 -0700 (PDT)
Message-ID: <764b8c2e-cf09-4531-94f2-268f97a889d7@gmail.com>
Date: Wed, 30 Sep 2026 14:31:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] submodule merge tries to read B's commit from A
To: Guillaume CHAUVEL <guillaume.chauvel@gmail.com>, git@vger.kernel.org
References: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>
Content-Language: en-US
From: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: ps@pks.im
In-Reply-To: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Guillaume,

Le 2026-09-23 à 16 h 20, Guillaume CHAUVEL a écrit :
> I ran into two problems while merging a superproject with submodules.
> 
> One problem, involving the repository used for commit-graph lookups, was
> reported in this thread:
> https://lore.kernel.org/git/d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com/T/#m174067937aaf76e9fa844386961b3e9e66c1e4d9

FYI, the above bug was fixed in 700f7b74de (commit-reach: parse commits in 
the given repository, 2026-09-16), which is currently in 'next' but not yet
in master.

> The other problem is that during a merge, Git sometimes tries to read
> from submodule A a commit that exists only in submodule B. I reproduced
> this with Git v2.56.0-rc2, built from source in an Ubuntu 26.04
> container and an Alpine container. The reproducer below triggered the
> issue in all 50 Ubuntu runs and in 43 out of 50 Alpine runs.
> 
> The merge should report a submodule conflict, not look for B's commit
> in A or report A as corrupt. The script checks the OID's presence in
> both submodules and prints the "BUG" line when it finds this case.

Thanks for the reproducer, I confirm I see the same behaviour with v2.56.0-rc2, 
on RHEL 9. With v2.48.1, the merge results in a conflict, instead of aborting, 
although I get a spurious "hash mismatch" message, and the reason for the 
conflict ("commits not present") is wrong:

git version 2.48.1
git merge exit status: 1
error: hash mismatch 2ca9f0f330e976b992fc18633d1d267b8aad596e
Failed to merge submodule A (commits not present)
CONFLICT (submodule): Merge conflict in A
Failed to merge submodule B
CONFLICT (submodule): Merge conflict in B
Automatic merge failed; fix conflicts and then commit the result.

With 2.33.0, which I chose randomly, we get the correct behaviour:

git version 2.33.0
git merge exit status: 1
Failed to merge submodule A
CONFLICT (submodule): Merge conflict in A
Failed to merge submodule B
CONFLICT (submodule): Merge conflict in B
Automatic merge failed; fix conflicts and then commit the result.

I turned your reproducer into a bisection script (~/bisect-merge.sh) 
by tweaking the final 'if':

```
if [[ $merge_output =~ Could\ not\ read\ ([0-9a-f]{40}|[0-9a-f]{64}) ]]; then
    foreign_oid=${BASH_REMATCH[1]}
    if ! (cd A && git cat-file -e "$foreign_oid" 2>/dev/null) &&
         (cd B && git cat-file -e "$foreign_oid" 2>/dev/null); then
        printf 'BUG: OID %s belongs to B instead of A\n' "$foreign_oid"
        exit 1
    fi
elif [[ $merge_output =~ hash\ mismatch ]];then
        [ ${1:-""} = MISMATCH ] && exit 1 || exit 0
else
    exit 0
fi
```

and invoking it in my ~/bisect-git.sh script:

```
#!/bin/bash

make clean > /dev/null
# build but keep the output on one line
if	make -j |& { while read line; do  printf "\033[K%s\r" "${line}" ; done; 
                     printf "\033[KFinished building $(cat GIT-VERSION-FILE)\n" ; }
then
	# run project specific test and report its status
	export PATH="$PWD/bin-wrappers/:$PATH"
	~/bisect-merge.sh "$@"
	status=$?
else
	# tell the caller this is untestable
	status=125
fi

# return control
echo
exit $status
```

Bisecting the merge failure with:

	git bisect start v2.56.0-rc2 v2.48.1 && git bisect run ~/bisect-git.sh

finds bb5da75d61 (commit: use commit graph in lookup_commit_reference_gently(), 
2026-02-16), i.e. v2.54.0-rc0~136^2, which is the same commit from which the 
commit-graph bug mentioned above originates. I CC'ed Patrick, its author.

Bisecting the "hash mismatch" behaviour with:

	git bisect start v2.48.1 v2.33.0 && git bisect run ~/bisect-git.sh MISMATCH

finds 6f1e9394e2 (object: fix leaking packfiles when closing object store, 2024-08-08),
i.e. v2.47.0-rc0~123^2, which is also authored by Patrick.

I did not yet dig further, but I have a few additional observations:

- in contrast to the commit-graph bug, disabling the use of commit-graphs via
  'git config --global core.commitGraph false' early in the script, by moving the 'tmpdir'
  definition to the top and setting GIT_CONFIG_GLOBAL=$tmpdir/.gitconfig, does not change
  the behaviour, neither in the "repository corrupt" case, nor in the "hash mismatch" case.
- On Ubuntu 22.02 under WSL, the reproducer does not trigger the bug on v2.56.0-rc2 (on a dozen runs),
  but it does trigger it on v2.55.0. Funnily on that system with v2.56.0-rc2 I get the correct behaviour !
  (no "hash mismatch" either).
- On a Ubuntu 22.04 Docker container, I get the same behaviour as on RHEL 9.

> An AI analysis identified a likely cause: a delta-base cache entry may
> remain after its pack is closed. If a pack from another submodule reuses
> the same packed_git address and base offset, Git may return stale cached
> data.
> 

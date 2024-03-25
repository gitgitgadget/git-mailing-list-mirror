Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D412883A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377507; cv=none; b=Gu0n1kdiq+ogZOLn7BRZPtSUbS+w5cv8+d+sNgHWeCCqxDIZLMCY3mUx+fQrK5FKunlH73dab3EntF896K/+ey6VYLALYEz6YGMV6AgCdr4+57Gj7IxyrwdgbMpgdMEHSsvbMJWw032dKYciFuftvQaxm8oUw2QXUNWINRgqanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377507; c=relaxed/simple;
	bh=73qUiG3gMnATPSJS0FQ7AHA/HcRsnnBCBQcoc3A6Z2o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n7y3bR4yVTqywacd0e32LD3G0w6WGMuCbmwQfERLTHFmG1+1w5uBT2agbwVSIi+7uHU/JW1VbsrZ28qgz5JgZfK7/DGwc9a/R4ZRV7fKseJI1UB0P0m/7I4lk9ZmxSLm7oVYNNoMehFy/0FQfb/b5VezJtIRW74paIlBtesfK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbNWPgXt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbNWPgXt"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512bde3d197so3111366e87.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711377503; x=1711982303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XcXqTxGRl9zHMyYltBOaeRbSSih8Z0tV958W2rAJ/Cw=;
        b=IbNWPgXtA+8Z59vHUXRVZS8US8Cqo0n0DhZNLxCZP7hsE5KfNJG8t70HwtS0z8rACw
         DAQPQXwpjWooLepGbr8PgGP2lJf0dPtqMIxvMTSe9fuNaR3bxbicizuHvMCKTbKUOAlV
         JOu9SF99re9LP8abk+ttIHvaP3dE1xgdaaT+qg9RZreSYhIPz90gOQZjw4cYqa1cwCZX
         KGa6e6/u+30BzdXLHHw0ZAa6WLbE8FRorRrFdwJlj3vgc3V/MBEmgBHzCf60iw4afawQ
         V33lgAzo/3f1uaKjNQTeZGdYzCygSDcJfbZIWOvOcXPHmbCXMd/EGsLA/aJ3VDDaud1h
         kaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377503; x=1711982303;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcXqTxGRl9zHMyYltBOaeRbSSih8Z0tV958W2rAJ/Cw=;
        b=mL+l9WsJHVJKgKnPdUiGZ3D5K6KuMkCXYXAs8CozLBgLWxBYIjv43oB/mxVpMsJI1H
         O3iFAzIsWN3nYKCAnaR9ItvkkMYh7I5HJ+E3Wh2O4nUOmGXOHd26M7ceNiktrVhfEYqX
         JCVpu3Ocxsh2yfT3MyLa//bvm+LUepsoxZ4bY2hgKVNjdBVf+o9lG/dK4tPacyB9krRj
         Yd59gAxYBjYyOHP6PlrYQL9GbMzK+HkiycEMzG9ocOP2E91ShV3/JY80aPk3UzMsghdn
         LlBVJrxSZ5n5u2ThcpeLvS++Ah9yCZsD/j0HV/bpTPuScx3A/oYWR6eII9Y3J2SR3H48
         jf4g==
X-Forwarded-Encrypted: i=1; AJvYcCUn7i5vNoH5VZdAUaBTONctsd8pOQLSRl2ICluL8GCX8ztNEFQXvHibxGfvCJbB1P1kMWK0Q8wCMTbMnZTRIL3//qnO
X-Gm-Message-State: AOJu0Yw6XZrWqitbosp5L/8omXzZwt76lEAlAVsEsWw8R+fyFWPzDaym
	0UHWPs/JwWyibLcQbiUXOAFj5cb+hcNiMB9aF9c8Te3cX5bHYCnP
X-Google-Smtp-Source: AGHT+IH0sSO756kOsY7RGaGInKtE4xZpdf9kUQhCE5PMSyxsdQF8QXm2s9Zbmj8Sn1RMVAKBGUHTmQ==
X-Received: by 2002:a05:6512:3745:b0:513:db34:7caf with SMTP id a5-20020a056512374500b00513db347cafmr4171693lfs.17.1711377502505;
        Mon, 25 Mar 2024 07:38:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709063c0d00b00a472688a9ffsm3091836ejg.219.2024.03.25.07.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:38:22 -0700 (PDT)
Message-ID: <79c4d09f-fc1b-40d1-9655-3a9e166918cb@gmail.com>
Date: Mon, 25 Mar 2024 14:38:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
Cc: newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240320233724.214369-1-brianmlyles@gmail.com>
In-Reply-To: <20240320233724.214369-1-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 20/03/2024 23:36, Brian Lyles wrote:
> This re-roll contains only minor changes from v3.

Here is the range diff with a couple of comments

1:  5a503a7026 = 1:  5aa3f7cec2 docs: address inaccurate `--empty` default with `--exec`
2:  36278e0d40 = 2:  abb7d7233a docs: clean up `--empty` formatting in git-rebase(1) and git-am(1)
3:  a2f603da50 = 3:  ef8224d286 rebase: update `--empty=ask` to `--empty=stop`
4:  0701f9f9fc ! 4:  21ed2dfb65 sequencer: treat error reading HEAD as unborn branch
     @@ Metadata
      Author: Brian Lyles <brianmlyles@gmail.com>
      
       ## Commit message ##
     -    sequencer: treat error reading HEAD as unborn branch
     +    sequencer: handle unborn branch with `--allow-empty`
      
          When using git-cherry-pick(1) with `--allow-empty` while on an unborn
          branch, an error is thrown. This is inconsistent with the same
          cherry-pick when `--allow-empty` is not specified.
      
     -    Treat a failure reading HEAD as an unborn branch in
     -    `is_index_unchanged`. This is consistent with other sequencer logic such
     -    as `do_pick_commit`. When on an unborn branch, use the `empty_tree` as
     -    the tree to compare against.
     +    Detect unborn branches in `is_index_unchanged`. When on an unborn
     +    branch, use the `empty_tree` as the tree to compare against.
      
          Add a new test to cover this scenario. While modelled off of the
          existing 'cherry-pick on unborn branch' test, some improvements can be
     @@ Commit message
          - Use `git switch --orphan unborn` instead of `git checkout --orphan
            unborn` to avoid the need for a separate `rm -rf *` call
          - Avoid using `--quiet` in the `git diff` call to make debugging easier
     -      in the event of a failure
     +      in the event of a failure. Use simply `--exit-code` instead.
      
          Make these improvements to the existing test as well as the new test.
      
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
      
       ## sequencer.c ##
     @@ sequencer.c: static struct object_id *get_cache_tree_oid(struct index_state *ist
      +	const struct object_id *head_tree_oid;
       	struct commit *head_commit;
       	struct index_state *istate = r->index;
     -
     +-
      -	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
      -		return error(_("could not resolve HEAD commit"));
      -
     @@ sequencer.c: static struct object_id *get_cache_tree_oid(struct index_state *ist
      -	 */
      -	if (repo_parse_commit(r, head_commit))
      -		return -1;
     ++	const char *head_name;
     ++
      +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
      +		/*
     -+		 * Treat an error reading HEAD as an unborn branch.
     ++		 * Check to see if this is an unborn branch
      +		 */

You are only editing an existing comment here and it is not worth a
re-roll on its own, but for one line comments we prefer

	/* Check to see if this is an unborn branch */

     ++		head_name = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE, &head_oid, NULL);
     ++		if (!head_name || !starts_with(head_name, "refs/heads/") || !is_null_oid(&head_oid))

While we don't mind the occasional line that is a little over 80
characters these really are rather long.

     ++			return error(_("could not resolve HEAD commit"));
      +		head_tree_oid = the_hash_algo->empty_tree;
      +	} else {
      +		head_commit = lookup_commit(r, &head_oid);
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'revert forbidden on dirty wo
      -	rm -rf * &&
       	git cherry-pick initial &&
      -	git diff --quiet initial &&
     -+	git diff initial &&
     ++	git diff --exit-code initial &&
      +	test_cmp_rev ! initial HEAD
      +'
      +
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'revert forbidden on dirty wo
      +	git branch -D unborn &&
      +	git switch --orphan unborn &&
      +	git cherry-pick initial --allow-empty &&
     -+	git diff initial &&
     ++	git diff --exit-code initial &&
       	test_cmp_rev ! initial HEAD
       '

Thanks for updating these tests
       
5:  3634da0f70 = 5:  5c16a01056 sequencer: do not require `allow_empty` for redundant commit options
6:  e98b414697 = 6:  3ee057e485 cherry-pick: enforce `--keep-redundant-commits` incompatibility
7:  cc4030d8ec ! 7:  0cd4620ef7 cherry-pick: add `--empty` for more robust redundant commit handling
     @@ Documentation/git-cherry-pick.txt: effect to your index in a row.
      +	you to examine the commit. This is the default behavior.
      +--
      ++
     -+Note that this option specifies how to handle a commit that was not initially
     -+empty, but rather became empty due to a previous commit. Commits that were
     -+initially empty will cause the cherry-pick to fail. To force the inclusion of
     -+those commits, use `--allow-empty`.
     ++Note that `--empty=drop` and `--empty=stop` only specify how to handle a
     ++commit that was not initially empty, but rather became empty due to a previous
     ++commit. Commits that were initially empty will still cause the cherry-pick to
     ++fail unless one of `--empty=keep` or `--allow-empty` are specified.
      ++
      +
       --keep-redundant-commits::

The new wording here looks good

Apart from the minor style issues this all looks good to me, thanks
for working on it, it will be a useful addition to be able to drop
cherry-picks that become empty.

Best Wishes

Phillip

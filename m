Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F44400
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698853; cv=none; b=fzS63yfGHm9x6LO5qxyoFgDYlHyDvPMT0qDcbZ0AqLFR7H/AWcAGA0ZCr1RE6p9Y41L7/Z987uMt3WxZ83fJUPk5Azi8BgyiDxhBDg9kKO2/mz0suK3tLsNkA/yCVltfZQs6BAT3aQDd7ZC6/rdGW04sP6wnjHgzDdE1lzQcE8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698853; c=relaxed/simple;
	bh=zFOn7F03DZZeB4eYuvL5qfLbE6I93Km2iqRHX8e/bvQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsKw2jW6Q45GELWxfNgUiIR2ShtPG6h4e2yeg5ddgwWRjXnDh4NaeD0+uSvH0EG9zpxlxV9J+LN54XJoa6wh0gGU4652jHRJP4ysvPTkEBrtfkH5wp1KN2S03tMcnaVSmiCgU/5ZUZmIYluj0JD2JhSuy1wHqx0NtWV8zMSRaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LF4NPAkO; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LF4NPAkO"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93f64ae67dbso261858241.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767698850; x=1768303650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhTppMwSxPrCeSO725A1177DUoTXhLI3e6UvIqzUi8M=;
        b=LF4NPAkOHJuvglziaKLeUpHfyVjBRLDILAGNvJJVlLcsg/ziA036uUrYnUfbsxk+6W
         otgh3LaO09TpI6WVD54JHk/94HCnEEoYHZ2Ng6J15Qt1u1x6PoUt81iDWpFmyItfbdQW
         +c2XXMOMubLpSbhtS1NqfVdge9h6WgqftTMKSsWbK0grdJefi3V3tTRloWrsUd/RCGOS
         2shqHB1isY5/URuV3iEvNj+fJ0BHdOfsKo+Wd/iY1pl1SnOC4GBsReQ7GQuuWzER+W5E
         wW/keRrb4GLDh0sZax9oxI41SllcUBDCpV+t05n9B4pPl8z6gy6/xA2DwNihYCF77Cnj
         0WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767698850; x=1768303650;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhTppMwSxPrCeSO725A1177DUoTXhLI3e6UvIqzUi8M=;
        b=T+r7M1SXnV57JHTSYc6qW62AGEXV85650KsGevsGdTP1e9WB6MJJtgMZNTO7+J2t9I
         jA09Ra4mGjWxnd8V/JFhpkb2XiELjODSncBboGsqW2DQgPuo47YaLLos3/dyNE343TOU
         OQFbLPTGn7FABfO49x9O2yQF/48x1psuAj9HjTqfNsMDX9uC2CYY/mBYVjl4L1a1Gd7r
         tFbCaj7uaOEtJoeOzzSw+upB+L8QruukKSHXzfAlf8cs9+V8scBLR7UVRF5+F0wG0F4M
         DtEeVMtA3IDks6tb9adTHzO4+SCm+sjHOORGL1m8YvjhIJEz4FuQ1DJpC0ptr40F6QC+
         6ULw==
X-Forwarded-Encrypted: i=1; AJvYcCVHiD7Ok9O+S2JHHScFAm7YG0CVINoAy6MQGjsfV0pVKYpBLdhIHt7/ha0cau+1ewBDinY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYf3yQCrtG4yBT0LD1kahn62rSvkjud6fRmTZsBRuMAPJEuwML
	YssM/Hhi306MpRUq+jsrp+axzRfnf7MRuWOihZ5XdXUlbjoTID1koing/5GWLi3rznx5hGicEjF
	4qNVpglQUUOdDdB80rcIbfcqkzhUXokPaCPCq
X-Gm-Gg: AY/fxX4kTjZzji9/Vsls8CQtzM3pDojbWoJ3lg7NQLLQIl1Xl8aYLUe1Jm7DkHRGUB+
	QbKXRoxpi2aOin7C9IC6Xs+DxH1E96Dj7Pjg6bWqJFkmOAFe808GVrNrS2TCHl5y2yNuWzBG/XJ
	rCjxECwL0wcv2xjq2qGNHKmcJErK/QMjuyAsBjZCNHB1OhTxd5vpawYma3Gp7/ug3IVzyOh2JEo
	g3cml9uafrfu2ALva4gmqVB3Y42yQP/AwTT03I818ULCAGndly1O31AefwvXSyoXm7lP2Pqo2Vt
	3bwfPt9GSVGKIzabkx6S0NdB9PdHiQ==
X-Google-Smtp-Source: AGHT+IEWF6ToUibSlH38UycWihzum/UaREFTjl2aDRVcmPIejLQNLB29soW0iQy+Vk8zbU2uY83bdU99u6FjKmofO5U=
X-Received: by 2002:a05:6102:149e:b0:5de:6dc:22be with SMTP id
 ada2fe7eead31-5ec744ca334mr702433137.36.1767698850015; Tue, 06 Jan 2026
 03:27:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 03:27:29 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 03:27:29 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im>
References: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im> <20251211-odb-related-fixes-v2-1-bdf875ce51fc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 03:27:29 -0800
X-Gm-Features: AQt7F2rElNVxwNrlD3K0BtWD0EUZgLR5mWVhPqohwqLq9-gatRSq8jm7TZfTVHc
Message-ID: <CAOLa=ZSZ9PKCi=vQY8WKhwAHVZT-keA5XOXBMVrB4ZW+u2uNhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] builtin/gc: fix condition for whether to write
 commit graphs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="00000000000006a46d0647b6766a"

--00000000000006a46d0647b6766a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When performing auto-maintenance we check whether commit graphs need to
> be generated by counting the number of commits that are reachable by any
> reference, but not covered by a commit graph. This search is performed
> by iterating through all references and then doing a depth-first search
> until we have found enough commits that are not present in the commit
> graph.
>
> This logic has a memory leak though:
>
>   Direct leak of 16 byte(s) in 1 object(s) allocated from:
>       #0 0x55555562e433 in malloc (git+0xda433)
>       #1 0x555555964322 in do_xmalloc ../wrapper.c:55:8
>       #2 0x5555559642e6 in xmalloc ../wrapper.c:76:9
>       #3 0x55555579bf29 in commit_list_append ../commit.c:1872:35
>       #4 0x55555569f160 in dfs_on_ref ../builtin/gc.c:1165:4
>       #5 0x5555558c33fd in do_for_each_ref_iterator ../refs/iterator.c:431:12
>       #6 0x5555558af520 in do_for_each_ref ../refs.c:1828:9
>       #7 0x5555558ac317 in refs_for_each_ref ../refs.c:1833:9
>       #8 0x55555569e207 in should_write_commit_graph ../builtin/gc.c:1188:11
>       #9 0x55555569c915 in maintenance_is_needed ../builtin/gc.c:3492:8
>       #10 0x55555569b76a in cmd_maintenance ../builtin/gc.c:3542:9
>       #11 0x55555575166a in run_builtin ../git.c:506:11
>       #12 0x5555557502f0 in handle_builtin ../git.c:779:9
>       #13 0x555555751127 in run_argv ../git.c:862:4
>       #14 0x55555575007b in cmd_main ../git.c:984:19
>       #15 0x5555557523aa in main ../common-main.c:9:11
>       #16 0x7ffff7a2a4d7 in __libc_start_call_main (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a4d7) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
>       #17 0x7ffff7a2a59a in __libc_start_main@GLIBC_2.2.5 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a59a) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
>       #18 0x5555555f0934 in _start (git+0x9c934)
>
> The root cause of this memory leak is our use of `commit_list_append()`.
> This function expects as parameters the item to append and the _tail_ of
> the list to append. This tail will then be overwritten with the new tail
> of the list so that it can be used in subsequent calls. But we call it
> with `commit_list_append(parent->item, &stack)`, so we end up losing
> everything but the new item.
>
> This issue only surfaces when counting merge commits. Next to being a
> memory leak, it also shows that we're in fact miscounting as we only
> respect children of the last parent. All previous parents are discarded,
> so their children will be disregarded unless they are hit via another
> reference.

Yikes. So we never go down the path of the first N-1 parents? Does that
inversely mean, commit-graph generation would be slower now in
repositories with lots of merges, since it is fixed to follow all paths
correctly?

>
> While crafting a test case for the issue I was puzzled that I couldn't
> establish the proper border at which the auto-condition would be
> fulfilled. As it turns out, there's another bug: if an object is at the
> tip of any reference we don't mark it as seen. Consequently, if it is
> reachable via any other reference, we'd count that object twice.
>

So if an object is at the tip of N references, we'd count it N times
right?


> Fix both of these bugs so that we properly count objects without leaking
> any memory.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c           |  8 +++++---
>  t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..17ff68cbd9 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1130,8 +1130,10 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  		return 0;
>
>  	commit = lookup_commit(the_repository, maybe_peeled);
> -	if (!commit)
> +	if (!commit || commit->object.flags & SEEN)
>  		return 0;
> +	commit->object.flags |= SEEN;
> +

Makes sense.

>  	if (repo_parse_commit(the_repository, commit) ||
>  	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
>  		return 0;
> @@ -1141,7 +1143,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  	if (data->num_not_in_graph >= data->limit)
>  		return 1;
>
> -	commit_list_append(commit, &stack);
> +	commit_list_insert(commit, &stack);
>
>  	while (!result && stack) {
>  		struct commit_list *parent;
> @@ -1162,7 +1164,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
>  				break;
>  			}
>
> -			commit_list_append(parent->item, &stack);
> +			commit_list_insert(parent->item, &stack);
>  		}
>  	}
>

'append' expects the tail of the list, switching to 'insert' adds the
commit to the top of the list.

Also adding it to the top of the list actually does a DFS like the
function name suggests. While adding it to the tail would be BFS.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 6b36f52df7..a2b4403595 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -206,6 +206,31 @@ test_expect_success 'commit-graph auto condition' '
>  	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
>  '
>
> +test_expect_success 'commit-graph auto condition with merges' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		git commit --allow-empty -m initial &&
> +		git switch --create feature &&
> +		git commit --allow-empty -m feature-1 &&
> +		git commit --allow-empty -m feature-2 &&
> +		git switch - &&
> +		git commit --allow-empty -m main-1 &&
> +		git commit --allow-empty -m main-2 &&
> +		git merge feature &&
> +
> +		# We have 6 commit, none of which are covered by a commit
> +		# graph. So this must be the boundary at which we start to
> +		# perform maintenance.
> +		test_must_fail git -c maintenance.commit-graph.auto=7 \
> +			maintenance is-needed --auto --task=commit-graph &&
> +		git -c maintenance.commit-graph.auto=6 \
> +			maintenance is-needed --auto --task=commit-graph
> +	)
> +'
> +

This doesn't test the fix around double-counting tip objects, no?

>  test_expect_success 'run --task=bogus' '
>  	test_must_fail git maintenance run --task=bogus 2>err &&
>  	test_grep "is not a valid task" err
>
> --
> 2.52.0.270.g3f4935d65f.dirty

--00000000000006a46d0647b6766a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f160cbad4e70ec0a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYzhaOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM1dsQy85TFdhRG9EK1E2UGV6c2p5NWF1d1MxTG5nTwo0WmgzZ2hKa1RT
QTVQMHdlczVSQ2RIeUxFT0oydk1JZXpvT0JUdVU2ejhRRC9Ia0R2aEtQeEdSSVhhRXN5SHhwCnNC
YVptVERrNWh4Q3IrUjVXVE01bXVpbVpyMWRZUmdSZHZzbHo3ZjFnV2xmUzJBYXl3L1dVdk42RU10
Q01mbGIKY3pqQTRnU2loWlpvQ1ZoRGE4Mm1HVkNOWEtqVFE5NDNhOGFuT0xEallqU2dHWmpjZlBp
ME9RSE96SkhqT2NWRAprWVJ4NXVPZTlkemx6aW0yUEsvVExYVjh0djNndWJpQUlIUk8zZkZEYUph
VU41ajY4NXgybllsbFdZcnQ4VkNvCm0rYTRzSWEzem8xNDB2ZDNNdXZzUmc5TWxTcjNoWXFmNlhr
K1VwOE9sMStJRURVV3BCL1YzYnhZNndXV1FEalAKU1lNRVdwbHk1elBWSzBTTUFseU50TEFUbFkr
TlVSclREVEJ3M3l6YXYzTzNUbmg1L0FNRm9Td1dXZUdlN1p1SgpyNCtRQmVENFJBRHM3NzJrZDdB
M0VDOHNNUjZuTHZIVTJsTllqZ0E4TnpKUWc1QVR1SFEvdS9oOVNseWIxeDdpCkRvK0NkOERiMnpM
SnF2R2NQdDZJTGVmVldzTXY3ckZzT1F2VFg3cz0KPWhScG0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000006a46d0647b6766a--

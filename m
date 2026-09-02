Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681938A728
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373439; cv=none; b=RcjvqA4aw/kXFs01TNO/NZqM5wiUD+mKZfifYcxCjgHAtbjjL+LRKR1djC78mxhOrcNi1KJz59s4IQbM9Xz30qvf2t147hiWJY3ZyotNGGmk3v1oHf0nPhyRylmajAOpjF4eheUBoPnpqkZcHAJIb34b/dFd4BjCO0TUsj8yoeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373439; c=relaxed/simple;
	bh=Do+9uG2DBSMD1HIKYvoEmFoUiAA45P+7iGKYVtuvcqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UV0hPOxbRZQmNFHH5TwbHx67v9mRE12luR1xw1RPKe73RJC6pVWYqZgBTJ4yXVZNVKouq0uF+a1NfZ9ljw+NZZgUQ/VBTcEXoJirO7ulqDWRMovJ0jz9EgNcCRu/alxNZ80toaQfrYrO9qK/kkqwjo2ilHhTTtnDDjDRqvTGLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeRZs7wf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeRZs7wf"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90ce08834feso20219106d6.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373437; x=1788978237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jXwEEhtrfSgzkRNvOVNPp41tyJnhVAPFxz8MlOw/jE8=;
        b=HeRZs7wfObIBrIVtNGfB8w/h8sGQAnNWLqh8SDWPU8O5nDGXYjencfoLCboRH8n3qC
         oGntOIWVgTeYdl1oxzOGeV4tCQnTCrVbCrtGPPQsVvG0spcYQGIlxvld1e+T6DtFzeRj
         ZJmUDMJMaVSHHUesadwAN3Czow6368a+UvRDDpo/XI0VYKAly/WMhrRs6K5PtSx+KEOS
         jPQVlQCg3YxG/8xsxiwd9C/eCkaEv21ikO4tyq4g1PFV6F3Q25AnXYXT6BQO+AOkSfhQ
         6b4pO13JnpaoLLNrznM8SUOPz5bj3UjdGzMIce+rD5l8AXOSeryea7QLFGpzAwX38ds4
         IX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373437; x=1788978237;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXwEEhtrfSgzkRNvOVNPp41tyJnhVAPFxz8MlOw/jE8=;
        b=NjGzHF5KD/ZRzBGlvvnutAOieaPAxmnor30nrL2dh3OiLn2r01F0tA1TUHbyVMMkQa
         nEfQHNosDE3/3hpPobEGL7pRWLMSORhFwygIxGILswU5riKaxd5fyej2Z5SzeD1+n3yF
         UOgoTr+0tIHN9jIEPKDxOO0pcU3wiYk2RplYYD4/ia6WybW+x07pCGTTfYXhBe0NGFxS
         ljvn3FaaJhV+WkZaNLDYIfmRpbZHUbzlyCkPML9RqTcfHg9cpoNXbMBMcA82QU2Bc25v
         NvGoipLPdniczvs1k7nOgbyIEkuJS6NTQtvQR3cMmQirAIUmmwxpjbhmtbdBixlYXSAP
         w1EA==
X-Forwarded-Encrypted: i=1; AHgh+Rr8SZultMo2dUqtRCbq+mS66rHAfw5YnL7pZSwO6w6OSXcZUu9RrEnfa0AwoHBmzG/D698=@vger.kernel.org
X-Gm-Message-State: AFuF++nDtbTulvTjNgUSOQOMBX6De0YQ7IKKhsqQ56c7EeD928CWabDP
	gYLSxjBS6leg6BxsyBS5HK5nAcoE0tFCpHVx9JAVIEy3c43jptbTTOgf
X-Gm-Gg: AR+sD13CSRm1a5+ZzGwWv/IQsfTzZxVBZeFb3a4/ClK5OsRZPEy2V5QFAokHYUqRYE7
	bTVxQALEb6X05UluOx45TDO3gA0+LDBsscSAE396ffrQjjV/G9T1yxy6p2mBvl0xo0V3me9i2W2
	0GvhG3yOAiGt1B6X9+vlaXG7Oil3uQ+LztRXX1hfvWhptLl37S7CQDyozrBVdK5wAV71zOos1cw
	CZnghIKE2qVfKFYhVvdRF2bjQ8yERfNpuAD+iwd6cw7iH5G1yeBGsU8y60RWbem9eVYe741G4s/
	/H5AaBBijMlQriU8o0NCJAaVKN8jh96WOVNGWBrQFq+wraezs3SIxhjxgdq7h0FPuhE0pxgA3FC
	LUr9shsJf7t4cvWQ01R9pcauJ65JwIlQlWTRhto1iaMqm7vX+YtrYDrZbvdVgTDofyS4RzF+9XC
	XWiE1GPIoxKpRdwn5s3zYqUCgpSDgwVrm4N66Jkbf8uvqIkvJ+lqa4idryJY1GEqnUpJU+NzMjs
	uvfm8visKIRyLPWRKGlrhn316y+9Gm59G4idXYMMLlCUARJQgBAjh7tRLo+mpSRQPr1W7dayMTF
	HVWVug8qdNmp+QEhQrCdlFmiJ0GzmrHSObLmim9rFgiCMJDHbnkQPXo+0cICt43Z2ALyrAlwD1a
	R8qWYiRITzCBuag==
X-Received: by 2002:a05:620a:1989:b0:937:d6e8:59b0 with SMTP id af79cd13be357-93960de248dmr856178185a.10.1788373436657;
        Wed, 02 Sep 2026 11:23:56 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f398a18sm269332785a.37.2026.09.02.11.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 11:23:56 -0700 (PDT)
Message-ID: <f9de9449-2e32-483d-937d-45b847143b29@gmail.com>
Date: Wed, 2 Sep 2026 14:23:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] send-pack: avoid sending the whole tree when pushing
 from a shallow clone
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <pull.2208.v2.git.1787684776048.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2208.v2.git.1787684776048.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/2026 3:06 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> When pushing from a shallow clone, even if we only have made a small
> one-line change to a tiny file, we often push the entire toplevel tree
> of files.  For large repositories, this could be gigabytes instead of
> kilobytes.
> 
> The reason for this is that the push likely lacks the commits the
> receiver has advertised, so it walks back to its shallow grafts.  Since
> it doesn't know that the server has anything, it sends the entire tree
> for the graft.  It would also send the parents of the shallow graft,
> except the shallow clone doesn't have those by construction.  We thus
> are forced to assume that the server has the parents of the shallow
> graft -- if it doesn't, the server's receive-pack will reject the push.

I was ready to assume this patch was fully correct, but then I asked
an AI agent to review it and it found an interesting subtlety that
puts the entire approach in question. It also presents an alternative
approach that is much simpler and helps improve things immediately.

The gist is that we can attempt to push a shallow object to a remote
that _doesn't have that commit or its parent_. This gets rejected by
the remote as not allowing a shallow update.

The problem occurs when this shallow update is attempted alongside
another non-shallow branch being pushed that also has some "new"
objects reachable, so the "assume the remote has the shallow
commit" condition leads to novel failures due to that other ref
update not having full connectivity.

Here's a test for t5538 that the AI agent generated, and I
massaged into something more understandable/readable:

# A ref that passes the client's checks can still be rejected by the receiver.
# Its shallow graft must not trim objects needed by another ref in the shared
# pack, since a non-atomic push should still allow that other ref to succeed.
#
# The client has two unrelated shallow histories ("x" marks a shallow graft).
# Blob O is present in A1 and is reintroduced by cY on topic:
#
#                 contains O
#                    |
#       A0----------A1(x)---cX          refs/heads/A
#
#       B0----------B1(x)---cY          refs/heads/topic
#                              \
#                               contains O
#
# The receiver has only the B history.  Both of its refs A and B point to
# the same B1 commit as full history. It has neither A1 nor blob O in its
# object database.
#
# The '--force' option lets the force-push of A from client to receiver
# pass the client's checks, but the receiver rejects A because it will not
# adopt A1 as a new shallow root.
test_expect_success 'shallow push does not over-exclude via a remotely rejected ref' '
	# origin: two unrelated histories; only branch A has blob "shared"
	git init remote-reject-origin &&
	(
		cd remote-reject-origin &&
		git checkout -b A &&
		test_commit --no-tag has-shared sh shared &&
		test_commit --no-tag A1 &&
		git switch --orphan B &&
		test_commit --no-tag B0 &&
		test_commit --no-tag B1
	) &&

	# receiver: commit B1 is exposed as both B and A and lacks A1
	git init --bare remote-reject-receiver.git &&
	(
		cd remote-reject-origin &&
		git remote add receiver ../remote-reject-receiver.git &&
		git push receiver B:refs/heads/B B:refs/heads/A
	) &&

	# client: each remote branch tip is a shallow graft
	git clone --depth=1 --no-single-branch \
		"file://$(pwd)/remote-reject-origin" remote-reject-client &&

	old_a=$(cd remote-reject-receiver.git && git rev-parse A) &&
	(
		cd remote-reject-client &&
		git remote add receiver ../remote-reject-receiver.git &&

		# Force makes A pass the client-side non-fast-forward check. The
		# receiver will reject it because A1 is a new shallow root and
		# receive.shallowUpdate is disabled.
		git checkout A &&
		test_commit --no-tag cX &&

		# topic is independently valid but needs the shared blob from A1.
		git checkout -b topic B &&
		test_commit --no-tag reintroduce sh shared &&

		test_must_fail git push --force receiver A topic 2>err &&
		test_grep "remote rejected.*shallow update not allowed" err
	) &&

	# The non-atomic push should reject A without affecting topic.
	(
		cd remote-reject-receiver.git &&
		test "$old_a" = "$(git rev-parse A)" &&
		git rev-parse --verify topic
	)
'

This test passes before this patch, but fails after.

As I was working on this test case, the key step that will fail with the
current patch is the test_grep here:

	test_must_fail git push --force receiver A topic 2>err &&
	test_grep "remote rejected.*shallow update not allowed" err

because the error that will be returned instead is more of a hard failure.
This failure "at grep time" is something I added. If this line doesn't
exist, then the 'git rev-parse --verify topic' fails which shows that we
are able to break the receiver repo with this push, as the second ref
update is accepted even though the packfile isn't complete.

> +static int check_to_send_update(const struct ref *ref, const struct send_pack_args *args);
> +
> +/*
> + * Add the shallow grafts (nr_parent == -1), which are reachable from the
> + * refs being pushed, to the pack boundary ("haves") as uninteresting
> + * (negative) tips so the generated pack leaves out everything beneath them.

This "which are reachable from the refs being pushed" is the key problem,
I think. We need to verify that the shallow commits are reachable from
the refs advertised by the remote.

> + * Walk only from the pushed tips, and only until a graft: using a graft
> + * that does not bound the pushed history could exclude an object we are
> + * genuinely sending (if it is also reachable from that unrelated graft).
> + * Stop early at any commit the peer already has, since it is a negative
> + * the peer can use and the graft beneath it would be redundant.
> + */
> +static void append_reachable_shallow_grafts(struct repository *r,
> +					    const struct ref *refs,
> +					    const struct oid_array *advertised,
> +					    const struct oid_array *negotiated,
> +					    const struct send_pack_args *args,
> +					    struct oid_array *haves)

When I asked the agent to implement something that instead cared about
whether the remote refs could reach the shallow commits, it deleted this
method in favor of having your push.shallowexcludeboundary setting enable
push.negotiate when the local repo is shallow:

	repo_config_get_bool(r, "push.shallowexcludeboundary",
			     &shallow_exclude_boundary);
	if (is_repository_shallow(r) && shallow_exclude_boundary)
		push_negotiate = 1;

That was sufficient to pass the new test, as well as all other tests you
added, except one. I'm not sure if we need a new option or if we should
recommend push.negotiate in more places (plus these new tests).

These new tests are great:

> +test_expect_success 'shallow push only pushes what is necessary' '
> +test_expect_success 'push.shallowExcludeBoundary=false sends full tree' '
> +test_expect_success 'shallow push does not over-exclude for an accepted ref via a rejected one' '

This test that you are adding is hinting at some of this behavior of the
new test I added, except the multi-ref push causes unexpected behavior:

> +# push.shallowExcludeBoundary (default true) omits the shallow boundary
> +# snapshot from the pack, since an ordinary receiver already has it.  The
> +# exception is a receiver willing to adopt a *new* shallow root
> +# (receive.shallowUpdate): it genuinely needs that snapshot, so the default
> +# optimization leaves it unable to graft the new root.  Verify the receiver
> +# rejects such a push (rather than corrupting itself), and that setting the
> +# config to false restores the full snapshot and lets the push succeed.  This
> +# is the tradeoff that motivates the config knob.
> +test_expect_success 'default push to a shallowUpdate receiver rejects a rootless snapshot' '
> +	git init seed-origin &&
> +	test_commit -C seed-origin s1 &&
> +	test_commit -C seed-origin s2 &&
> +	test_commit -C seed-origin s3 &&
> +
> +	# depth-2: a shallow graft at s2, pushing s3 on top of it
> +	git clone --depth=2 "file://$(pwd)/seed-origin" seed-client &&
> +
> +	git init --bare seed-receiver.git &&
> +	git --git-dir=seed-receiver.git config receive.shallowUpdate true &&
> +

Here is the chunk that doesn't work with the push.negotiate approach:

> +	# Default (optimization on): the s2 boundary snapshot is withheld, so
> +	# the receiver cannot graft the new root and rejects the push, leaving
> +	# the ref uncreated.
> +	test_must_fail git -C seed-client push \
> +		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded 2>err &&
> +	test_grep "remote rejected" err &&

but specifically it's because the remote doesn't reject it. The client
makes the appropriate adjustment.

> +	test_must_fail git --git-dir=seed-receiver.git rev-parse --verify seeded &&
> +
> +	# Opt-out: the full snapshot is sent, so the same push now succeeds and
> +	# the new shallow root is grafted.
> +	git -C seed-client -c push.shallowExcludeBoundary=false push \
> +		"file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded &&
> +	git --git-dir=seed-receiver.git rev-parse --verify seeded
> +'
So the diff on your test becomes

-       # Default (optimization on): the s2 boundary snapshot is withheld, so
-       # the receiver cannot graft the new root and rejects the push, leaving
-       # the ref uncreated.
-       test_must_fail git -C seed-client push \
-               "file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded 2>err &&
-       test_grep "remote rejected" err &&
-       test_must_fail git --git-dir=seed-receiver.git rev-parse --verify seeded &&
-
-       # Opt-out: the full snapshot is sent, so the same push now succeeds and
-       # the new shallow root is grafted.
-       git -C seed-client -c push.shallowExcludeBoundary=false push \
+       git -C seed-client rev-parse HEAD^ >expect &&
+       git -C seed-client push \
                "file://$(pwd)/seed-receiver.git" HEAD:refs/heads/seeded &&
-       git --git-dir=seed-receiver.git rev-parse --verify seeded
+       git --git-dir=seed-receiver.git rev-parse --verify seeded &&
+       test_cmp expect seed-receiver.git/shallow &&
+       git --git-dir=seed-receiver.git fsck
 '

Thanks,
-Stolee


Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E144C65B
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502339; cv=none; b=pRJGnDN/tGTKjW/nuIx98frsOO0Okq4nl4t229MZK6DErnDvTwU/khqi9SBGG4Mh7J109hU5n1yaVJgUZ5JwcLOMEjvUjKtpq6wu2O3l/+2fPYq7A1P7Lgyil6xVC8ESqxMhK3Wf9Hmoe3iPEJRxdhZFQHlekyJUe3zqSznBNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502339; c=relaxed/simple;
	bh=FQhnOsmuoEhyGMSSQ+RyB3eiqQUF5AtL5ZMkLG1GoRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQkwdAW0sK0jfQ61dh3z+w/n9CH16NpZkjL0Oq5vor4MiIvPF/pEUMi2ACpwexazjR6aVGHt5nCundmJNu9y8bgSvGDuPBa1jNrB6NESGPqDL/cLmqba0ptCxOY5EYDBZjF6XugMmDuas7M5c1jbboDfnKk20tmG95DRvLz5ATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ohk/qSWT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wFh+5gkH; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ohk/qSWT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wFh+5gkH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B452D1D00199;
	Tue, 15 Sep 2026 15:58:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 15 Sep 2026 15:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789502325; x=1789588725; bh=OQePZL7Ach
	u4VmQMgweFi8QMcTMR+OSMU0G8oTMxXm4=; b=ohk/qSWTdycoYMWFEyyS8X0oPh
	1cRriocKMY4UFE9swkhxOyNPV3t+7NhkC80ZjVEgw3UEBbCyLR2Bead/B17nhXL+
	xN881Gm/UGYsWF+6StPDMpBmdm+95Yl4gNOoSFmDb0fxQafAns95S+hjvOI2R/lB
	keeciCISDsUV2SXUcJl/aRy4R3eweDJRdsjzXkXiYDedjZEcGrKJ4AO1ViZxjdUj
	7wgbwdoV0uO3Oc15nkQVbYbH33Rpr/9VhLotpcrPIJaH60861y4fmOkzKAAndrg0
	xO7rQnjqcmGnu78ujei7YlpVf/HfFfF+eOObfhmBDAhu2fSbUonJUWCe5qPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789502325; x=1789588725; bh=OQePZL7Achu4VmQMgweFi8QMcTMR+OSMU0G
	8oTMxXm4=; b=wFh+5gkHNzH/mtGv+Zyw6/6bRmXR+P3tSa4CpUFh+nbowVvgR/I
	eDWMY6aWoCSIX3Otq9EDKbKX5VYPyNUr9cfl1FibOQ0WaWJxcaHHgJbrFBBMGvWY
	ZHppEfH1V4UcpNeoIcuqaVqL2KnGS1uSNwEALLk21026fb4zsA23FIsCNkXrIwon
	P2Xo7qNNuJ00mGrguAQo0VHjDahlWrlxUvuTJyz+U1Z41JKNxSKl6ccncFw65IKr
	sctp3cwTVGVUSR98NkHtphH87UHVmSIx06nCA7ChRt7f4+/Jj5EFU6kj6rDY2iq3
	ASD3DOiiKcQegX/KHO06CcmQWiPJVeVlTrg==
X-ME-Sender: <xms:daOpamaIhOIk29RLmzJl6ZzCAh_K0jlXCJgturTig6cDp-I6QtaTJQ>
    <xme:daOpag2v02hP1tyK73whHjvqKgDXOI2QYSz6z_bDn8oY4yziyS1Oge37vC3k_geEQ
    tlj_p26nv_T_h4KcV5CNUkcVFdTnzprAoqD-LooIj5x-ZF4KrPgMQ>
X-ME-Received: <xmr:daOpauU-4auChewfYeSeV0IrysoebuJeI5qpsIpLFniXeJja6DJYGH4msbz_WlZO9eg8R_Cb8xgU5p8wjydqEjGZkSwQ19WP9YMZ>
X-ME-Proxy-Cause: dmFkZTGYEJWTHSy94XF/cJMP05qJMeQWy08erIXFGGJ4+vV7n5xpQVxArVNc739l3hv/Hj
    RnjiadjX0ZNlCZM8+3IcIrOWN9tEbgyjwV1eD1tAmLar+vcYK78Y71DIZL1M2HL7Tf2vCJ
    qoEh9HBsV7+5PukdZQwB5pERFSGKskszEf1ecBqOLgsCaxuRE9qinviiIUyl/01Y5tfeJH
    YxqnmwE9pQ5JDJUacChMVd905m7lzu/6iQbZ9nH+fn9O/06jV7JGLjHbGhHZ8qL2qeb/On
    Kv9GTo7sNP8+Up/RmQ4AsauoNWs1esLbgt9qS2ZQqMgMxOq6QCcAaQ2lCricU1Tfv322Ok
    Tf3B5qkjGxrR4SLFwqbNktFeQjd9vuzpV2E7RRj3bbPCjRC/ctRVrovwqNKAW5bWCKCOjp
    R2wniX1Cp5Jzo9udGrnifjiP7ipJ2uaW7SB9M2Smg0U0MrL9IlX5Y6hNua0kEFghSG0A97
    d6qDRsVNGehMIuKPcQQa1Rbi90nfP6pZg0K9n/z4VX12DmdmYz4cbVRB/b1WDFPkRacB1c
    b8xIywBTg/7tizGerY/zbrPaZsHpleigkE5LzJqIW7EiI+EIu3GVwNoVZ92/zT3jRsFAYW
    jyIvBfsNaMphdRsHBdb6ugTv0Hl6URb9aZm3VC7k62ROhI8kQjsYNPzlssrg
X-ME-Proxy: <xmx:daOpaiUJUAdN2RhKJP0IaAXl5cszBgryLAdm4Dj5aGZtpJvlwfrHEg>
    <xmx:daOpaleeyPNCzR8Q4Lrug_3wL7wAIMlm4F-hBBAs9Z6Ym994_8F-Dg>
    <xmx:daOpajUWc3-vWqw_-3I_VsUY7P9z1VGsTPS9Ne3wMV2DBmFcL-xuUQ>
    <xmx:daOpamcco4bRCkKP4U6yiO7bzXZY1BcWl-d65wp9gatK6_zXGgVRzg>
    <xmx:daOpao3LoBWW1RMHfNrChMr6wuyULYgiWyIVN-LowGHDDEX8zDwwJyik>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 15:58:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Royce Remer <royceremer@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] Fix upload_pack_v2 response ordering for
 shallow fetch when server has uploadpack.allowRefInWant=true
In-Reply-To: <20260915193009.222678-1-royceremer@gmail.com> (Royce Remer's
	message of "Tue, 15 Sep 2026 12:30:09 -0700")
References: <20260915193009.222678-1-royceremer@gmail.com>
Date: Tue, 15 Sep 2026 12:58:44 -0700
Message-ID: <xmqqa4piz3pn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Royce Remer <royceremer@gmail.com> writes:

> Signed-off-by: Royce Remer <royceremer@gmail.com>
> ---

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.  

Also see [[describe-changes]] and especially [[summary-section]] in
Documentation/SubmittingPatches.

What is especially troubling in this partuclar patch is that its
title claims that the change is a fix, but it does not explain why
the updated behaviour is more correct than the current code.

The implementations of "git fetch" and "git clone" that come with
currently deployed versions of Git must be happily accepting what
the current implementation of "git upload-pack" gives them (the
missing proposed log message does not say it is broken in any way).
If a new version of "git upload-pack" suddenly swapped the order of
them, would it break existing "git fetch" and "git clone"?  If not,
how?

There may be other questions that naturally come to reviewers'
minds, and a change given in this patch must come with enough
explanation to answer questions like the above.

Thanks.

>  t/t5703-upload-pack-ref-in-want.sh | 18 ++++++++++++++++++
>  upload-pack.c                      |  2 +-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index 249137b467..9e2a090c9e 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -295,6 +295,24 @@ test_expect_success 'fetching with wildcard that matches multiple refs' '
>  	grep "want-ref refs/heads/o/bar" log
>  '
>  
> +test_expect_success 'shallow clone with ref-in-want' '
> +       rm -rf local &&
> +       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
> +       git -C "$REPO" rev-parse main >expected &&
> +       git -C local rev-parse refs/remotes/origin/main >actual &&
> +       test_cmp expected actual &&
> +       git -C local log --oneline refs/remotes/origin/main >log &&
> +       test_line_count = 1 log
> +'
> +
> +test_expect_success 'incremental shallow fetch with ref-in-want' '
> +       rm -rf local &&
> +       GIT_TEST_PROTOCOL_VERSION=2 git clone --depth=1 "file://$REPO" local &&
> +       GIT_TEST_PROTOCOL_VERSION=2 git -C local fetch --depth=2 origin main &&
> +       git -C local log --oneline refs/remotes/origin/main >log &&
> +       test_line_count = 2 log
> +'
> +
>  REPO="$(pwd)/repo-ns"
>  
>  test_expect_success 'setup namespaced repo' '
> diff --git a/upload-pack.c b/upload-pack.c
> index a52856d869..a70d237ad3 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1812,8 +1812,8 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
>  				state = UPLOAD_DONE;
>  			break;
>  		case UPLOAD_SEND_PACK:
> -			send_wanted_ref_info(&data);
>  			send_shallow_info(&data);
> +			send_wanted_ref_info(&data);
>  
>  			if (data.uri_protocols.nr) {
>  				create_pack_file(&data, &data.uri_protocols);

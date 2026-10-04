Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A73DA5D5
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134271; cv=none; b=WGz2okkOSA4Od2VpRC7D13wxKPR0bvnY0icqTPlSRh9LlNhE7eA0R9OyngjPLYXq/q51oEA+g+eCeAZhl+tVqhbUQHGIcd66fMHZMQ22dDSP6hibnXMb9yrIvQ4GYHloXebhrzRUet6th+78NPzRVnXUvNa3kcv2Q72Sh4C5HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134271; c=relaxed/simple;
	bh=rQrVosIZ5aXqImouz0BckbIFUK4OCONh9CEYga7JCFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRK9KODcHNoP2oMly/+iQ6dhw8J4kzr12OIa3lAt2AyzjZKTsx9V/63VaVIOKwtgv4Fe0pK/kvp0kim9QwhFfGIz4gK7tU6p20UMrhJO3nbBElQgIRBkRCLm9GSW2CZoWPRTlSJ3iCjOUy6JYTfI5uNtaSjIO5AucBzucJ08tzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R2yLKU1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8Yk6RB4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R2yLKU1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8Yk6RB4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC3017A0174
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:17:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 04 Oct 2026 13:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791134268; x=1791220668; bh=927uamZ9Ko
	noU0f/Sz74pcnSNNvuqViFK0WFp/6lsLg=; b=R2yLKU1S+LduEMHQ+7eFZW/z5g
	pjmX9nKirsxkbP2q/bx4h7a353fwc53TundXsHGZUP0wcqPBGp7TQsDVY7nVIFJ+
	Sx9fEfWxiOBAZSYzqtM801+b/EZ9b7FJJcOoGUlQNLoZrV5ZsMsLnAFFx6soxpq4
	M+iOaiL5Lz7DmqV2qIuGzbTwOeFmZhRSnk++l4OPcsfCBEy2PJ9GCJbJCRBS9hOx
	iIP45h4/D1UwsrGljoj4YcsOa10qjLyoapX3mY9qEDv9B/XTXr49wUD90WsFZvBz
	Sf4SFGu4HfAut8Ei2le5ReuEWs1KdXNmYm8yJKwKmZXp/EROJJdLi4770qfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791134268; x=1791220668; bh=927uamZ9KonoU0f/Sz74pcnSNNvuqViFK0W
	Fp/6lsLg=; b=H8Yk6RB4dCnu+Ydo4fZZvjE4tz9yyBIAo+CgGs37oTNAAaCpEyy
	z1cUYD4G0SeY2lTJtCZ77/gZ9r7VvrAAz3kF+KEHrsVU5gx0taNgCjoNxs22S0NP
	f94kUPNSbD4x1s7dC+736RvzI3c4cfiTHvTQkPJK/IAbx/hU7BvxHuymNUncU83u
	tZpeFRYbkxXtwgW1s78302NWXkyp1B+wjVMKdsHHtyYKzzqrCpQwGaq4oKdA3GWG
	6qmMzlekMHfIKMdRZS8AsEHDHo/C7kt3Fdk/kZ/X8QWODjphxRJiMlL+8Uu80cTJ
	FnIRgXbIigoOmDPUqtN72Sh+WcsQQmDOQrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791134268; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WWlxHjyC9bTpMSREEqxYn1uSoyhfopm8974H44lQ4Dxw4vH
	SZRzCbkM5LG1syAAKlVdLlK22FsMbhiCJNq5rKrPLT5J65hbPZjk7RK1wKLN4vrg
	wcmUJpW30yDI142aZrU4lBDq8m03d5cFgVRlAOJAsAWY4Oftxh+kPhTwLgkwCWH0
	CQxrkYjZb8tzT2yHoq4QDZzk1jmGrcTEQuWjtdrnjeEQuENKOBkYLunvPrtlP3BK
	l2GXlEqm8/uSgOWPo7uZlfpjXvCqU/pd2D8nzIbA8urR+kBu5rbic7hEj3YCrOQ1
	0o8Lwk6wxYTDZBoWiRaDVYfrvwcdcuqyFx5zC0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hpyJ01E9qfSi9LMC8AQMhVd/SxUYfAmJQeI6JTFyYro=:rQrVosIZ5aXqImouz0BckbIFUK4OCONh9CEYga7JCFc=;
X-ME-Sender: <xms:PIrCaqudB-8wcxEJ5EcxAR1pxzEFDjU9mCEu29oBR4t4Q0EmuefNug>
    <xme:PIrCajIF-ziJlGgTil9s5bVlE4I7H65JNPlyAobKHzntBWlxKECR8hIliDR9pXcNx
    8SVAl2nXYSHVGxZxSlLvKT8u7ewDsmFD5Z3IccKPr0zjBdCYq2Fd30>
X-ME-Received: <xmr:PIrCavl8ZzjMcXeV-cP757mtcp1Bf9ld3WaZq0scgBIE2QwOL_eRlCsoOlCwSuf7Dv5FSdQ_3pnWjNglLofVPEz4Bw3Qkug9xnz6>
X-ME-Proxy-Cause: dmFkZTEFNDLEu+ke1YPHPXvh2jPso38P0cfUKMNAunMpfVhGZmWNR63rm3wNUFGXNh9Lf9
    jO4tOF9ncRO5Dm+AMkcGJj4MmIMYHCVdg6oVP8OKpPtssJNDZ1SZB+YfVcppQ43tP69NKf
    QPCq9qqbVmcwbp3gk2mGjr0jelKrfYYu3avCc4SgJ2S517rGqi4FOPzBXLy7tr+kMvQYkg
    TlBInf/MYy4JdoctVl1+J0u9Zn+y08TMAjhwfCHnIoV8Yp+Z6veuRL87Mb6pcDBiqyWDOY
    yc4hFIyVMpQif8QGWe8RPzpJ8J/oId/8d/Kuo1XoalK8G4i1+wp74N9jd6+nsPi1CBMOhf
    02Q+X1XqXzPAHjrN+hxgZJVxHjAJFmfZlYdyXj+0DALHGiyjqDGw6VFNyysiG5o7Gn2ony
    e2diSxzNQJ+ZkQjVDaVB4ULJgyzifu/e22ukzFkRGXILHEJ/qHCOCKHcEqdO87gFgIF9ZU
    AmVB2zPNIudpPU2OvwlogssDcuWSXdHcyC59NIoxAod9CVpX2ifJ6SfmiAKVmyv+ISfc0Q
    oG/KMb/6gt4UOamJWaOp3xiR6WDu78GoMELjBD2FHlQ7gzll+8o+Mll7xyN982kS8ir9yT
    04g+cU4Jo9LOFhI+aoZ94BOyRSN6IScS1bvZOW9l9DwEldam5AF03LQ9jxXQ
X-ME-Proxy: <xmx:PIrCasJb0QUrBmSfUPy3G-E4eIE6O_f0BAWXZwhEL6HW1BOtBSuyZA>
    <xmx:PIrCas4s4ssqaaAskGrF2kDxOo6Ari2X0MN_Xv_BNTYby5ZejYT2kw>
    <xmx:PIrCao1GpoRzGDWxits3TmiEpI03IYPTL-Pn7OGPimhui3sbpFi9EA>
    <xmx:PIrCaqcuMzykPpo6v08VZ3cYzjG18pcz61YdqtluSmy_EtOmcZweNA>
    <xmx:PIrCanSeyFYFfT5Tzd-mV4gfCjVmPtVzvf9h1dq_uiG-VJj1a3kHY7z4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 13:17:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 0/4] fetch: avoid fetching every branch of a new
 remote in a shallow repo
In-Reply-To: <pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sun, 04 Oct 2026 08:31:20
	+0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v6.git.git.1791102684.gitgitgadget@gmail.com>
Date: Sun, 04 Oct 2026 10:17:46 -0700
Message-ID: <xmqqv77hs7ut.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Avoid fetching every branch of a new remote in a shallow repo.
>
> Changes in v6:
>
>  * Remove leftover reference to deleted default-branch logic in commit
>    message.

Thanks.  I think this is becoming much better, but I see one glitch
and one design question, for which I do not yet know the right
answer.

Before going there, since one of the test scripts added by this
series is called 'fetch refmap', we should have a test or two to
check its more basic use.

When the user configures remote.origin.refmap, the command should
behave as if --refmap were given on the command line, even when the
repository does not yet have a local branch that builds on anything
from the remote.  Attached is my attempt to do so.  It does multiple
things in a single block, which we may want to split up, but I am
sending it here to illustrate what we might want to test and, more
importantly, to present a scenario that exposes both the design
question and the glitch.

The early part of the scenario goes like this:

 * We create a new repository and add ".." as a remote.
 * We remove remote.origin.fetch and set up remote.origin.refmap.
 * When we run "git fetch origin", nothing is fetched because
   nothing yet builds on what we would fetch from them.

If you try to run this with [1/4] alone, however, it errors out with
"fatal: --refmap option is only meaningful with command-line
refspec", which is suboptimal when triggered by a configuration
variable.  Even though our design says that remote.*.refmap makes
the command behave as if the user gave '--refmap' on the command
line, applying that rule here is a bit too strict.

Fortunately, this is rectified later in the series when we begin
tracking which of our local branches build on what we get from them.
Even when the number of branches to fetch is zero, meaning we should
pretend no command-line refspec was given with --refmap, we no
longer get the same error, which is good.

The second part of the scenario explicitly specifies what to fetch
on the command line and verifies that we fetch exactly that.

Then there is the last part, where the desired behavior is unclear.
What should happen if the remote.origin.* configuration defines both
fetch and refmap?  How would we explain our choice to the users?  I
do not have a good answer to this design question.

As for the glitch, the last part of the test below dies with the
"fatal: --refmap option is only meaningful..." message when run with
the current patchset.  We might decide to error out if both are set.
Alternatively, we could ignore .refmap and use .fetch, or ignore
.fetch and use .refmap.  Whatever we decide, the "fatal: --refmap
option is only meaningful..." error is not the right message to show
in this situation.

Thoughts?


 t/t5586-fetch-refmap.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git c/t/t5586-fetch-refmap.sh w/t/t5586-fetch-refmap.sh
index b81fc48cbe..30a8d79c16 100755
--- c/t/t5586-fetch-refmap.sh
+++ w/t/t5586-fetch-refmap.sh
@@ -22,6 +22,35 @@ test_expect_success 'setup' '
 	git checkout main
 '
 
+test_expect_success 'remote.<name>.refmap without tracking (baseline)' '
+	test_when_finished "rm -fr fetch-refmap-baseline" &&
+	git init fetch-refmap-baseline &&
+	(
+		cd fetch-refmap-baseline &&
+		git remote add origin ../ &&
+
+		# without fetch refspec, but with fetch refmap
+		git config --unset-all remote.origin.fetch &&
+		git config remote.origin.refmap "+refs/heads/*:refs/remotes/origin/*" &&
+
+		# nothing tracked, nothing fetched, no error
+		git fetch origin 2>error &&
+		test_grep ! "fatal: --refmap option is only meaningful" error &&
+		git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
+		test_line_count = 0 actual &&
+
+		# nothing tracked, explicit ref on the command line
+		git fetch origin main &&
+		git for-each-ref --format="%(refname)" refs/remotes/ >actual &&
+		echo refs/remotes/origin/main >expect &&
+		test_cmp expect actual &&
+
+		# what should happen when we have both refmap and refspec?
+		git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
+		git fetch origin
+	)
+'
+
 test_expect_success 'clone shallow and single-branch, then add a second remote' '
 	git clone --no-local --depth=1 --branch main --single-branch . client &&
 	(

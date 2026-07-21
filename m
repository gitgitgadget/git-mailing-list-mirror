Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC743E066
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672120; cv=none; b=mf0iVzQxDNSa14N2S3s1YWkhr/R56kIXsPj5CLMxOdu8OPlOfphihl7V2CymMENhaiEypXCnD5ogUfHUcxv5ArlIvwg4qOyjDsRsRVUAAoLsbiy3ZwFpabBsY7DipJzs1NZ3Ze0ZWHz0/8U4ypDQfQ15UkqV4jlDuIgLZk6yGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672120; c=relaxed/simple;
	bh=RIROY0Qdb696x2F3Pa8zVvwUSJD0UD71XQ2f7vcjYNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZVWr/ejprwrC7zX9tlCUBWXfnkbxE8nTTppmz4gIaKOD/wUYAvRp9zz0SvaSlarIGMaPFeI0ZYoCeZNfxGlliVd85KPvFmJTzXYWONcG4suaiZI5VZHY09/fX2ToU10jldZcn5cFTZt7jlqoCwiefZy2s4d+tc2G+sMBVa83Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yx/O+TCi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kCCeLC+b; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yx/O+TCi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCCeLC+b"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 78C081D000E6;
	Tue, 21 Jul 2026 18:15:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 21 Jul 2026 18:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784672117; x=1784758517; bh=DTE+dWHaKb
	dyTMxWKcXAu5Go1VNW5AY++9n5tIrbYLk=; b=Yx/O+TCiuCGa1LgglaA4vFZlGE
	+9KXoWK6v2L7sSJphvrVJNsEnD5o6VMhd9YFAyVA08PxxAYLw5kJ0bW9my2VPyNM
	p0DiHkYiH/8p09ZK3gNyoVzAvAR/IXxRJeH+VrsbnidslbEfkddSk3djctWkZByd
	Yarl5QHRxqxvz3WbgizRf3eWK3E/hRueh7T4QEXlXF6dDrvxS2kUzVZ0c1Ldj5Iv
	GkWymaNzBLA4vHZ6ImBO9BU10cbog4krBt6z9vYE+BJ+tCt3a2nTb7A04ua1pZze
	DLV+z69HHHbEOAVRTZfCT5169w5Gp2rmJ6GkqPBA+LbAcEs9hlTfNBey7uoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784672117; x=1784758517; bh=DTE+dWHaKbdyTMxWKcXAu5Go1VNW5AY++9n
	5tIrbYLk=; b=kCCeLC+bMFQKAoujJEFWJDiMon80Fg6HN3GowNl+ewsNewBkDxQ
	0j6FlEkWBSYvqPin5ZoPMkc4TGDobNt4pWZZ9XsxHHZZmxN6T24l3B8qvIscn/gq
	CRWTeGSPMiDRBoZHkjT5k0+SsqI+UgC93ZJgxqNiqSYPcZAPd1E8Jzj1OuHmbfKI
	ula0D+K7AomEx9qeGbZeEystMMerMaR7RJACf0gpD3HkxSNmiGaEsm7sFu7P4xgA
	uhgFtJtCksAJCyogngkVq0HX/zceT0+uoqj2f1IiyTN9DIRDQ9hMfo7bo8zkRcj2
	6XRBt6OepMsGoAJuNcNRdfvruGXNPqwvQXQ==
X-ME-Sender: <xms:de9fakBNfn2i4bABXeCBarsX6DiRHQuqCph_8cNBVNKBWKrCEqaSOQ>
    <xme:de9fatZKW7ojld8jVcgaEJlV7CbECQn8zgAbKvkbXRcW-AIS5vt3Jty1QCPIfn-xo
    I59A0vV7Uyznad4FUauMCrFO2Lbtniy2Mqpmt_YUMR66FXRJczVag>
X-ME-Received: <xmr:de9fav6zdZL1Sxe5c5AeTel0Zr7U8yN48rbWZj0yi0cj2tCvX-ctrMr2mb3wyPPQYypP-0pYfTQA4hlhyiVAlM_kmv5IJNXMWQ>
X-ME-Proxy-Cause: dmFkZTGDb9manAdN+8hiYZEnI6QJCu1XbyulabQOY2J/3+8XA4S90EF6ofv/hlpU/WX+0q
    gUaX3CbBNbaJrxuqkwElkvBawkICKLT2imgNJAyjywCBg+dbrbohhT/BdbFEXZUeyi8YZs
    WNvamzfro4LwTOGAcOwXidV185gXqfKmvwiod6/Y9Unv+L7JgZy83qRuVjDohK1DmE6vNf
    XdbFLaZaA5oQakZXZWYAWATn9oNpB2PAgY4Z/03RIRVuXWzV9F6vkOESXRuz27C6P2RKRu
    HqNgqUtMK4vs8/ooghEhdeUc9vIeK011QB3Y0nNCX1yI2rXDioCK48sUibN0VGLGNAhMIE
    mj2/qb1xGgvmIYuakFNMi28hX55Tfs8LrPnSyV61ijnYYU++CNwZtiukct30ywFPeRn7Vj
    pjsZwYQfnWYFARPfIuWZ2UZVdIXTJx0PfOkJUDhqE0i1rku7FyVHbHw5f12hmP7e/4Dblx
    WrkaL753cPYcV6hiteAqF7/O6HGAsvePiTIEhy44p9gent3v9TmhNrjod2wj9IomTpHsd8
    6v5i+1VMaIhCobe/zw/c76LJFwuxvhqlSkgq1FXxUL7tN9FG+tLykW7Z0BBbCy7TyUSZz4
    MaGwAira4WONbApdIlBxSutUXg4nvetvSMa5qh1GyeUkFNedCe2DVJDEvuSg
X-ME-Proxy: <xmx:de9famYBndMSfBw8X9I_hSGoKd48K5XID_khszYubP0ot7Xuev2plQ>
    <xmx:de9famj5OBzI9by9YUsH7BkdM3F7vTcDezRGfH2K_kLcGgKETWtveQ>
    <xmx:de9fav_6MVRddgOj59qfJMQnEA2Rquz4HmvLncAazptLQIDIZ3n8gw>
    <xmx:de9fappAFpxIRNI0dZlqoGg-ll0vajqw9Oi9s4LdF5OaIPxtH3zLcw>
    <xmx:de9fahrfXmf4xZ_ijN3IkhhIAM_RTqiaYP-D7BwAiD8l7p7RH-rz0o60>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 18:15:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 2/2] remote: find tracking branches for URL push
 destinations
In-Reply-To: <a343af9d500a598826c5fe9a3abbe9df2f5916e8.1784664859.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 21 Jul 2026
	20:14:19 +0000")
References: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
	<pull.2358.v3.git.git.1784664859.gitgitgadget@gmail.com>
	<a343af9d500a598826c5fe9a3abbe9df2f5916e8.1784664859.git.gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 15:15:15 -0700
Message-ID: <xmqqqzkwt2fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Git accepts a repository URL as branch.<name>.pushRemote and can push
> to it. This branch setting takes precedence over remote.pushDefault.
>
> A branch can be configured with a URL-valued pushRemote before any push
> occurs. If the remotes are later rearranged with "git remote rename" and
> "git remote add", the newly added remote may use that URL. The URL value
> is unaffected by the rename and continues to take precedence over
> remote.pushDefault. The URL and the remote then point to the same
> repository, but Git does not connect them for tracking. Pushing works,
> but @{push} cannot identify the remote's tracking branch. As a result,
> "git status" cannot show the push branch, and an up-to-date push can
> leave its tracking information stale.
>
> When exactly one configured remote uses the push destination URL, use
> that remote for push tracking. Continue to push to the URL so the
> configured remote's push settings do not change existing behavior. Keep
> the current behavior when no remote matches or multiple remotes match.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/config/branch.adoc |   1 +
>  Documentation/revisions.adoc     |   3 +
>  remote.c                         |  34 ++++++++-
>  remote.h                         |   2 +
>  t/t5505-remote.sh                | 124 +++++++++++++++++++++++++++++++
>  transport.c                      |   5 +-
>  6 files changed, 167 insertions(+), 2 deletions(-)

Hmph, the changes since the previous round look a bit incoherent.

> diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
> index a4db9fa5c8..5a85fde8de 100644
> --- a/Documentation/config/branch.adoc
> +++ b/Documentation/config/branch.adoc
> @@ -55,6 +55,7 @@ This option defaults to `never`.
>  	repository), you would want to set `remote.pushDefault` to
>  	specify the remote to push to for all branches, and use this
>  	option to override it for a specific branch.
> +	The value may be the name of a configured remote or a repository URL.
>  
>  `branch.<name>.merge`::
>  	Defines, together with `branch.<name>.remote`, the upstream branch
> diff --git a/Documentation/revisions.adoc b/Documentation/revisions.adoc
> index 6ea6c7cead..78f96fe8b0 100644
> --- a/Documentation/revisions.adoc
> +++ b/Documentation/revisions.adoc
> @@ -127,6 +127,9 @@ some output processing may assume ref names in UTF-8.
>    `git push` were run while `branchname` was checked out (or the current
>    `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
>    the remote-tracking branch that corresponds to that branch at the remote.
> +  If the push destination is a URL and exactly one configured remote has
> +  that URL among its `remote.<name>.url` values, '@\{push}' reports that
> +  remote's remote-tracking branch.

We claim we use remote.<name>.url here.

>  Here's an example to make it more clear:
>  +
> diff --git a/remote.c b/remote.c
> index 0dc36956c3..4a29669443 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1887,13 +1887,45 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
>  	return branch->merge[0]->dst;
>  }
>  
> -static char *tracking_for_push_dest(struct repository *repo UNUSED,
> +struct remote *repo_remote_for_push_tracking(struct repository *repo,
> +					     struct remote *remote)
> +{
> +	const struct strvec *push_urls;
> +	struct remote *first_match = NULL;
> +	struct remote_state *remote_state = repo->remote_state;
> +	const char *check_url;
> +
> +	if (remote->origin != REMOTE_UNCONFIGURED)
> +		return remote;
> +
> +	push_urls = push_url_of_remote(remote);
> +	if (push_urls->nr != 1)
> +		return remote;
> +	check_url = push_urls->v[0];

But we correctly pay attention to both .url and .pushurl, giving
precedence to the latter.

> +	for (int i = 0; i < remote_state->remotes_nr; i++) {
> +		struct remote *candidate = remote_state->remotes[i];
> +
> +		if (!candidate || candidate == remote ||
> +		    !remote_is_configured(candidate, 0) ||
> +		    !remote_has_url(candidate, check_url))
> +			continue;
> +		if (first_match)
> +			return remote;
> +		first_match = candidate;
> +	}
> +
> +	return first_match ? first_match : remote;
> +}

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 6f5e86dede..983aff6552 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -24,6 +24,28 @@ setup_repository () {
>  	)
>  }
>  
> +setup_url_pushremote () {
> +	rm -rf fork.git client &&
> +	git clone --bare one fork.git &&
> +	git clone one client &&
> +	fork_url="file://$TRASH_DIRECTORY/fork.git" &&
> +	(
> +		cd client &&
> +		git checkout -b topic --track origin/main &&
> +		git commit --allow-empty -m topic-change &&
> +		git config push.default current &&
> +		git config status.compareBranches "@{upstream} @{push}" &&
> +		git config branch.topic.pushRemote "$fork_url" &&
> +		git push
> +	)
> +}
> +
> +check_status () {
> +	git -C client status >actual &&
> +	cat >expected &&
> +	test_cmp expected actual
> +}
> +
>  tokens_match () {
>  	echo "$1" | tr ' ' '\012' | sort | sed -e '/^$/d' >expect &&
>  	echo "$2" | tr ' ' '\012' | sort | sed -e '/^$/d' >actual &&
> @@ -1018,6 +1040,108 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
>  	)
>  '
>  
> +test_expect_success 'URL-valued pushRemote without matching remote is not trackable' '
> +	setup_url_pushremote &&
> +
> +	check_status <<-EOF
> +	On branch topic
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +'
> +
> +test_expect_success 'adding matching remote makes URL-valued pushRemote trackable' '
> +	setup_url_pushremote &&
> +
> +	(
> +		cd client &&
> +		git remote rename origin upstream &&
> +		git remote add -f origin "$fork_url"
> +	) &&
> +
> +	check_status <<-EOF
> +	On branch topic
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +
> +	Your branch is up to date with ${SQ}origin/topic${SQ}.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +'

But the test does not seem to exercise remote.<name>.pushURL
anywhere.

> +test_expect_success 'pushInsteadOf URL pushRemote is trackable' '
> +	setup_url_pushremote &&
> +	(
> +		cd client &&
> +		git remote rename origin upstream &&
> +		git remote add -f origin "$fork_url" &&
> +		git config "url.$fork_url.pushInsteadOf" fork: &&
> +		git config branch.topic.pushRemote fork:
> +	) &&

Testing insteadof is a nice touch, though.

> +test_expect_success 'duplicate remote URL leaves URL-valued pushRemote ambiguous' '
> +	setup_url_pushremote &&
> +	(
> +		cd client &&
> +		git remote rename origin upstream &&
> +		git remote add -f origin "$fork_url" &&
> +		git remote add duplicate "$fork_url"
> +	) &&
> +
> +	check_status <<-EOF
> +	On branch topic
> +	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
> +	  (use "git push" to publish your local commits)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +'

So is a test that checks non-unique case where the machinery should
not kick in.

Thanks.

Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077932ABCA
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687245; cv=none; b=bpUbmRYzcJLj4g+xs2QhLRwmDjFPdOMkVCOxqaRZB5oQXx1ZdzylftaTsRuvgK9BfKy9uKbY5pW+E/miGiC7IrBL9NP+p+1wPZRW3u4cY94PoIpdUTFtIgYCMG9Cd8O6UZlNd510YVAwlcxwyIacTpPO4soeuukFgFmht13bF3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687245; c=relaxed/simple;
	bh=Mubad/lcwDwr5e5Clhbwn4UafmYIyqA3X38OIbHcWtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A18s3bhdmz8549SestPp3Bbz1DpNLU3di1pVdpBh7ENBTcO614ME+lRZeNv7q/Z5VIpZZ1JxiMAAueWPQ7NmU9lAF1LP0t+IihPN9ZjqXBPZvljK9rC9tQvRptZmKiED6UAgp029SSi69CZEr3iaIQrxqrP/fr4fX/qJ8rmG8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CreplJaX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ery9fVK/; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CreplJaX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ery9fVK/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BB2A14000E6;
	Tue, 25 Aug 2026 15:47:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 15:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787687243;
	 x=1787773643; bh=BI0wq+jUAm2bz89s3nN0Xkrx8tv8SgptjmlrTeWd8w0=; b=
	CreplJaXEtYncN4PoZRpBfwsQtKq4AdpNMH4vi73EuA1XN91eanlh6h99EOcbVKk
	Hlc+fKUEHjSQY5PjKrgG3OAge3ioZpG2vQ0uQo1vwdfch/UmxNr6Czpwln4JKISs
	n+oFbtJPH9dR85NSIFW48UrRQVdtvPvWPFaQG/oGtnOAsaNdtsjNdjrDk3N1igTi
	TXiNIV5GzhHJHKNo/NBoq9u5WaI3RaqseV/cZcsDkOul5/VpdJ3Kxb2jhsB6oUPm
	5M4RBL0EgeyTznQwUkFQoGNo+Ne1FNtEf959KeM1Qt6/4jbz1sWhvpJxRZxqDSAI
	YiGyrCoPr7gegQfOAI6pbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787687243; x=
	1787773643; bh=BI0wq+jUAm2bz89s3nN0Xkrx8tv8SgptjmlrTeWd8w0=; b=e
	ry9fVK/Dkz81SSlDoFB3ROXp8cn+oBqlyWO1Ox9Em0vpiIq2Oup7RkQToYlFOXq6
	7vInatp3AaHTAetAmkVQrPuw1gcfgxjJFfJCBQJn5IdCdL7T12iM99pQYwKpp5iN
	cWWP2dpY3kbfhtz4lQbJSsil7rrhDUpqjjvZl+MnK77BxBsNyZX4ABMb0iAc0n8e
	AosTUP68WRdHkoLCuheh9iuIrqqplU0nr1npeZG/1GUILot5vjfaORzzVIB08SLb
	KF29S+lDHenU62tgIl/XdVvvJtgBPM9/IFw8K4JcRE45KVjuZcsZz9Bw37gQ/Tld
	+qWtrF0wzch5L7lvr2qhA==
X-ME-Sender: <xms:S_GNavYEW7_YnfagGbsm4jnHPOWlYeMZ-lE9C1eXjw3r0vg2t8uZ1A>
    <xme:S_GNal0Y0Nif06ikeSuvzmoM2jyu7fQDYxS9aISc9zc1d9TBom6RjU_kEd1UfPHx8
    kdQ299fVcNrKop2I-44YglovwPb-ZNPPvgFnx0B82qhAbMXASewyWo>
X-ME-Received: <xmr:S_GNavX1t5Y-UU1Hn-vN8LXZB3bCBz74psoG5L6TPgBQ7jTeANNwXbR0snsrbBmeYcJGUGsywNTnMAomHKhdzeNedUZyC-v1DA>
X-ME-Proxy-Cause: dmFkZTED9GYwDaAxvjyt1aE3KRCDYvuTemqGCAdTrEP5FEWb8oTUwxKTvt6F0ISkZzaDVs
    b+EfkbyK6cCmXKseG4c/+im4jZawQZkkTEc5s3PiofplB4YQo5dNUhixcYLbFQAJUgDpX9
    DtEzI61eyKp8NKs0IF4uJ6cwNIeO5JcrPY+UiKn5qYpCLFtbjqo3vVNEoV/T2rS9uHW/kF
    thwZOkRvhFHWUFPLDBGlOx55/WYYvw18qk8VQVfr6p9J6rT/wwLZaAIxf3ac56ZlaoHeIY
    QvGlP/z0gfDmUgcsSdiM0VrmNueBrUQpm70A5XfldruSKLp3DUiVMyUhnBVnMMMHSeiqYP
    FsvTbuXj6kxHwTPOcOExL0BJBpoTkIgOJ8xcCnkP2P0C6LptiHyeafbcUv4D2Ptczwf8Ta
    OA3tOHJY/FdJC5NoM11CI+y3DiQVfDhYi1t3bwD9HzQyUyZ058/3tax/bk4IVfUFZYoufF
    6qj5LvlbaoyiDiHuA3xBa/m2vZDYF/tMv9qEKS6HpWdasbIXn3ZC4MYbC8w6Blt64rpd5F
    BxiHkDACf/Doi0cmEs5EkU3SoMP8TNRnT2iP28BfEoMgtLmIeuGrJcJJq/r04rn4urJ1rL
    crlMqS9+8a8PAjsEiJuhGVtL0TqQ7vpg3ghEe2y5MoEMIRHnQQ5DYAGRyEHA
X-ME-Proxy: <xmx:S_GNavVa9I81J2AfRPd1rZ0nuoDkoyoW1nvVdSIa6FuW_QIwvfrglQ>
    <xmx:S_GNaudTAI8cf7tVLJfSzDflEy8K40QanICXh8wnTMn6vBR9_VypiQ>
    <xmx:S_GNaoXECuQr9S5P5hLmA8xtb5cYZeV41Jyb5mBIeCxxGJ2TgwqVSA>
    <xmx:S_GNanc0lLNOmCwvkFGwnVTvPBCfWasCT2VYMed_2moc6UTg-_i6kA>
    <xmx:S_GNaieKb8JLTFGdhrg3PA986Mz_7GMGLyJvzoaksPy5pmalaMxyj0tU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 15:47:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] worktree add: trim slashes when deriving branch
 name from path
In-Reply-To: <20260825180350.2099-4-l.s.r@web.de> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 25 Aug 2026 20:03:49 +0200")
References: <20260825180350.2099-1-l.s.r@web.de>
	<20260825180350.2099-4-l.s.r@web.de>
Date: Tue, 25 Aug 2026 12:47:21 -0700
Message-ID: <xmqq33w2m186.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> worktree_basename() sets `n` to the length of `path` without trailing
> path separators, not to the length of the basename.  This matters when
> deriving a branch name from a path with more than one component.  E.g.:
>
>    path: /new/worktree/
>    s:         ^
>    n:    |-----------|
>
> So here xstrndup(s, n) copies up to 13 characters from "worktree/",
> effectively to the end of the string, including the trailing dash.
>
> Path separators are not allowed at the end of branch names, so strip
> them off by calculating the basename length and extracting just that
> part.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/worktree.c      |  4 ++--
>  t/t2400-worktree-add.sh | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)

Hmph, so am I correct to understand that the symptom observable by
end-users of this is that we used to attempt creating "bit/" branch
when they request

    $ git worktree add waffle/bit/

and it wouldn't have worked until they said

    $ git worktree add waffle/bit

instead?  Not allowing a trailing slash when naming a directory is
nasty (it is a good practice to explicitly give a trailing slash
when naming a directory to avoid confusion), and it is a good fix.

It also should work fine with waffle/bit/// even though there is no
strong reason to allow it ;-).


> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index a53e815cc9..01c245778e 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -769,7 +769,7 @@ static char *dwim_branch(const char *path, char **new_branch)
>  	int n;
>  	int branch_exists;
>  	const char *s = worktree_basename(path, &n);
> -	char *branchname = xstrndup(s, n);
> +	char *branchname = xmemdupz(s, path + n - s);
>  	struct strbuf ref = STRBUF_INIT;
>  
>  	branch_exists = !check_branch_ref(the_repository, &ref, branchname) &&
> @@ -878,7 +878,7 @@ static int add(int ac, const char **av, const char *prefix,
>  	if (opts.orphan && !new_branch) {
>  		int n;
>  		const char *s = worktree_basename(path, &n);
> -		new_branch = new_branch_to_free = xstrndup(s, n);
> +		new_branch = new_branch_to_free = xmemdupz(s, path + n - s);
>  	} else if (opts.orphan) {
>  		; /* no-op */
>  	} else if (opts.detach) {
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 280d2e2c07..7e2811fa77 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -298,6 +298,11 @@ test_expect_success '"add" with <branch> omitted' '
>  	test_cmp_rev HEAD bat
>  '
>  
> +test_expect_success '"add" with trailing slash and <branch> omitted' '
> +	git worktree add waffle/bit/ &&
> +	test_cmp_rev HEAD bit
> +'
> +
>  test_expect_success '"add" checks out existing branch of dwimd name' '
>  	git branch dwim HEAD~1 &&
>  	git worktree add dwim &&
> @@ -388,6 +393,14 @@ test_expect_success '"add --orphan (no -b)"' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success '"add --orphan with trailing slash (no -b)"' '
> +	test_when_finished "git worktree remove -f -f neworphan" &&
> +	git worktree add --orphan ./neworphan/ &&
> +	echo refs/heads/neworphan >expected &&
> +	git -C neworphan symbolic-ref HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success '"add --orphan --quiet"' '
>  	test_when_finished "git worktree remove -f -f orphandir" &&
>  	git worktree add --quiet --orphan -b neworphan orphandir 2>log.actual &&

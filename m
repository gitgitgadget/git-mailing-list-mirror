Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B182131E2D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726820; cv=none; b=uBuVOX8WAVgG0SAtiVh7OZ+PAaGvdedqsl7rkwWffaq9mg/7F/kvdc+8QLAhoxGDjzCY9DP2TAuu4NDvoejBTF2AqUdNzzUJm8JAe3mKXn3MZGZl092WSxj/w94qT22MSJlodpPouhJZJ9CxA+G7rKbZ5wPZMiyQ4Kx35kEukv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726820; c=relaxed/simple;
	bh=JW8VxvAWfkProKPC8YJK8XBufzxSY6McNOWY5opiH18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vtjumm+FBo40vLPTOsajIPCcqiJUk2Nr6EkmZ6iuT9qMYsXrKFtmNzX+L2bQIgXpAkA1QJGFTWLx36UMUoZRdnEuAlpGZiE1pwYO5i7nX+KNStuNRRoKBh5kVI9HXzvG/AiMnsr2g73/+W/+PTzYPbhgMjoaA5REtcqbga3jWtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RlPnwuEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l3SvyToO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RlPnwuEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l3SvyToO"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 646F111402A6;
	Mon, 30 Sep 2024 16:06:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 16:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727726817; x=1727813217; bh=l0J+uz1bEk
	C/Wa3UYTjGYnCUkgwGimafXQITPNmLi68=; b=RlPnwuEcGpeuCNnen4ZLZ2t0p5
	Q3rkQbx8qNMx1rYjtLaCC6fgxI1jZcJ2h6zlUzZSLMV9jeYzL0cfaHDH/cLPilWy
	RqLAzRIcaOwZBBqSFDnJUFHCxvwi630NHbaxShusZD/n5xgxUN/Gukhy2aQqlmSG
	qQbp/opFpgOPmyXBYHzNiLscxrrYFu3BSrIY4gAOZ1fgAk9n3SaLJ+XxXQTa4tfw
	GUhJOPquhSkceoUL8usFNRy1fJijWuqVk0c5MRetVuAwWds+PGLgMf3aEcO25jm4
	9iBWJenMls0PAbFjAVrGb+8Y2F4MVSqLWT6/JvVJmzzI76ATX/OxapW+OX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727726817; x=1727813217; bh=l0J+uz1bEkC/Wa3UYTjGYnCUkgwG
	imafXQITPNmLi68=; b=l3SvyToOi04DggTIMRmTdToCknVzaTk8qYEO3A3rjSN3
	mNDkcBF4QdrI8d4DzumvGD+amN58fLcSk46Qhsl9FrwAbTdIJ3EWrdgpuJARWDjM
	mzatb6wr5Eqk9jsLZEdEsnlOUi6X/RTnTE2ZFaAHS1+ccee4vPnEqAHmlUEPFgYw
	nKv+XKKVlNIBYP1RxvX5oRG59pUdAlw+/I3MXd+oaaq3HXwQbotbiJB8ROkOoVUo
	cL0aIZFXB6cAsZoSpBH1UTrocckfRDuLnyFl+SA2rjXdstOCcYAO13jBVtsmkDWY
	9AZzaffjL1XxFPgaxgV2dbiKUX92GujQ28eO/GlUEg==
X-ME-Sender: <xms:4QT7ZqMNvIqv-3STaXbG1jKQ7Bsq9g_fJn53vUjkF9Td8WpnSpVYJw>
    <xme:4QT7Zo9cjDrceyrfTwJAGIGtHcRl0S9tR-fCn1tenWkj4r-SaNXhcwzjyrfAytiKY
    Eo4azRlbiUZZ4NOqQ>
X-ME-Received: <xmr:4QT7ZhQ7IFZsJ36iOKYbMlCJtlBkTRcuvSf0_cHVR2OAGtpOOsNBtnMp0ffx0ZzC6744Y2LQRPlk-D4iLTJzJLCzYQ172qTyAaMcsQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshh
    gvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4QT7ZquLILSJjp1MC7ySO60eWb8aYUkoZWtz7ybn7j2amLE36osbjA>
    <xmx:4QT7ZifePjf3USQP0XnZWqvnH2xtlxKiax5ylxKRrhuZKbglNxFmYw>
    <xmx:4QT7Zu08NiBYhmIbXhJEAwh2T-zKTcmAQAfcNUkh7nft6RxGnCDS0w>
    <xmx:4QT7Zm9w7pQ8eIeE38Wveh06bOYL2AsdRJJHhXvs_4s2eUXHHnpzew>
    <xmx:4QT7ZqQhJKuhrqvA2SCqxlzIixIB1XwI85W-ZyO6Rj3f5BPOkOpq0aj_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 16:06:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 3/4] apply: remove the_repository global variable
In-Reply-To: <d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Mon, 30 Sep 2024 17:40:29
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<d64955a2e277da138146020f6a0cf96f4636a162.1727718031.git.gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 13:06:55 -0700
Message-ID: <xmqqy13852jk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Remove the_repository global variable in favor of the repository
> argument that gets passed in through the builtin function.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/apply.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 84f1863d3ac..d0bafbec7e4 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "gettext.h"
>  #include "hash.h"
> @@ -12,14 +11,14 @@ static const char * const apply_usage[] = {
>  int cmd_apply(int argc,
>  	      const char **argv,
>  	      const char *prefix,
> -	      struct repository *repo UNUSED)
> +	      struct repository *repo)
>  {
>  	int force_apply = 0;
>  	int options = 0;
>  	int ret;
>  	struct apply_state state;
>  
> -	if (init_apply_state(&state, the_repository, prefix))
> +	if (init_apply_state(&state, repo, prefix))
>  		exit(128);

Is this one, and ...

>  
>  	/*
> @@ -28,8 +27,8 @@ int cmd_apply(int argc,
>  	 * is worth the effort.
>  	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
>  	 */
> -	if (!the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +	if (!repo->hash_algo)
> +		repo_set_hash_algo(repo, GIT_HASH_SHA1);

... is this use of "repo" still valid?  We now pass NULL, not
the_repository, when a command with SETUP_GENTLY is asked to run
outside a repository, no?  Shouldn't it detecting the case, and
passing the pointer to a fallback object (perhaps the_repository)
instead of repo?

I _think_ state->repo->index is accessed unconditionally only to
figure out whitespace attributes, even outside a repository (thanks
to the_repository standing in), with the expectation that the index
is empty (because we do not read any) and we find no customization,
when "git apply" is used as a better GNU patch to work outside any
repository.  Maybe I am not looking hard enough, but I fail to see
how the code makes sure that repo being NULL outside a repository
does not lead to a dereferencing of a NULL pointer.

Thanks.




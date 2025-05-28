Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099D221DAD
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470601; cv=none; b=NOIFgXpebhNDVvPWt0XIgBJo8g+FKrquokVRxZOuAMMUpz1HcQCcjEGD3aJhb4hlDnCziE7xlEVowSb3bsQuHCKi1BhOWSWF7wRllW+BI8fFZ6UxFEGCnhuc+P7CfCjYIk5IOmjekG9WKVwdn4vXjO0VFGut02AK70V0qSq2rCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470601; c=relaxed/simple;
	bh=a/dKEHrd9unGIgu0UZI046abibJ01zgdoEXz4EzYqlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+6IjIw/R0BqIgkx3E5MnqHMfFHQbcgH1U9V/vwAD16X8+DfIQx1e3TLqrlSfGXcQ0f1iESQotPyQ1sm68zg1wtKS03ZElyeAWpwaAcm7YK2TZB/dHeOCLdiA0tys4c3jJD24NdTAdin4SPXylXq70x5aYgL3T6ihjLB0znWYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YiUgd96F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jb81TFXs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YiUgd96F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jb81TFXs"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 624731140106;
	Wed, 28 May 2025 18:16:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 28 May 2025 18:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748470598; x=1748556998; bh=s6vz/oa6XK
	CymN+dhrOFvF4Rn9BVI3SetBvWy55/20g=; b=YiUgd96FQTOdA7/ssnaANYYzOG
	oG/uJyTx81I18ZckNLCf5JRLoEyfh30WsbuwYZcTDziaP1gq9WYwyU2zWIoG0CjC
	d+R8rFkUTbi5SyCvTbbVu9PK5UWf5G9QeM7Y+uKvwFiUT0LbptzRFCZaVQTsy3Ru
	5eOGfNZ2iUzh2/GiocECrd6O0HvsxmBLtN1w56iUnJmWK+oBuWV7BZ/eiIam8lg+
	5vSbrk8U2z5LzS8hPz8Q3c6X3yM1wfwl5J6DQ8t6kwcATHrm6SGosORLFPubVFF4
	h68UdX4pYQADd96PXVKx1CmMV4Btgq3I+/rVIA9xuW32eqJx+uD5ACaxN5nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748470598; x=1748556998; bh=s6vz/oa6XKCymN+dhrOFvF4Rn9BVI3SetBv
	Wy55/20g=; b=Jb81TFXsSPw7wo9yQBwlwAgAqBkwRROgb0NlIZU5q0GWjhJZjuq
	wJvM46lEE93lMs8uHOr3yYrKMSZQyyMCv1E5pXvwUI9KZUe22sCkkzWDB7yc5tv9
	vDpwGwQ5HaTDvTCavLmn2/IDGlRIHJK7pQoBF59D4tZu6ZxhpWf/rklSWXCilatE
	zgDUQUErdOEY3vcFv+8gR/JPSQiW2JYnG3C0ZNh4nl3uKdQ0d0+MlmyP6xkWmgcg
	f4asLxT9ZdNytj1w7ZDs29wCYwgCv0rH2g6E3IIzPDZ5RKNGyh96e/bYfHbC+WDp
	5E7NTsf+Ive3dr03iD3oGgNKmYnwDoetreQ==
X-ME-Sender: <xms:RIs3aJvx1QAzI_c3eNp44lr2lDtT97t9g90_RJ286yck0omIgysXPA>
    <xme:RIs3aCc9A__kk59YyaUR1Iy9SfzL8_O4A9esHmv__e6pxL7pIZ6Yv0W0TOjoEwc4E
    MDGHl0AlhqFryfDbg>
X-ME-Received: <xmr:RIs3aMxrpqacGJcryUSnUa0HZ0jLkcY6COb8PyEMblkNxsQToQZN_6hgC7z6hAtfkeREchlzaSGLwFVVwoFcxFHlerXV9XY87P8KnPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopeehtddvtddvgeeffedttdeh
    ieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:RIs3aAOaqAav37ji4IoySG60Ogyv5zpunT7Jrau7mGOMcnwac_7E3g>
    <xmx:RIs3aJ8JMCE77Lem1Rnj7iwKc-z_Sbae-Htp6jNT874f4lEGajbhsg>
    <xmx:RIs3aAWPk4suyBy33AVg9w169QXUKMh4MHJxkbGuZtK_l7TAT6xcKw>
    <xmx:RIs3aKf0i6F7qQ5VdqlU1WeiKx9rF9Xw7wZroI2_AwWBkIyc10UK1w>
    <xmx:Ros3aN1AuxYsAgpTyHIqeJIV0S3BnZIi6yWYUMKAV3K-9_JcavRXXXhF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 18:16:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,
  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] sequencer: replace error() with BUG() in
 update_squash_messages()
In-Reply-To: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Sun, 25 May 2025 10:19:12
	+0000")
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
	<pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
Date: Wed, 28 May 2025 15:16:34 -0700
Message-ID: <xmqqr008peil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In sequencer.c, caller only pass TODO_SQUASH or TODO_FIXUP to
> update_squash_messages(), any other command passed in should be
> considered as BUG. Thus I think `return error('unknown command')`
> should be replaced as `BUG('unknown command')`.

Yup.  The only caller has

	else if (is_fixup(command)) {
	     if (update_squash_messages(r, command, ...) {

and is_fixup() is confusingly [*] defined to return true only when
the command is one of these two values.

[Footnote]

 * And a similarly named is_fixup_flag() only accepts TODO_FIXUP and
   never TODO_SQUASH.  Both of these helpers probably need to be
   renamed.

> diff --git a/sequencer.c b/sequencer.c
> index b5c4043757e..3cd0dd3434e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2139,7 +2139,7 @@ static int update_squash_messages(struct repository *r,
>  		strbuf_add_commented_lines(&buf, body, strlen(body),
>  					   comment_line_str);
>  	} else
> -		return error(_("unknown command: %d"), command);
> +		BUG(_("unknown command: %d"), command);
>  	repo_unuse_commit_buffer(r, commit, message);

BUG() is not end-user facing but programmer facing, and we do not
use _("...") in them.  I see a few existing violators that need to
be corrected.

OK.  Or

	if (!is_fixup(command))
		BUG("not a FIXUP or SQUASH %d", command);

at the very beginning of the function?

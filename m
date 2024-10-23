Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CA13AA2F
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729713222; cv=none; b=Q2kPxJUKv4iO0w8TFxmiHFT71efK6lFMxOnz717fy+xlnFP7JtciTT2wgWpfkRn3/86WSYgz5VqU+hfdeRBR6JvlOMkKc19L/2cyGJqpKFY4siQ57Bzz/C9YR4P3ttUWoAxSA9N1HuHrNvBFZUl7UsOD1Fnb8mVntAOXf8Bw5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729713222; c=relaxed/simple;
	bh=bqCphRhg57We/ZJc5Ms/9oelnmjk9BowQDUbzza7bgM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rQ5Mn6frpHNgMsVR3yEobBqaSG1ieEhJISa/ajcPwtrc/Tplxs0Xa6TqamjBbxQkgQ4L5Vj8sFRKX4/g5BCqNT0rAaNwZCkqCKX0sO5xW2Xll2I/BIz4etFpqS/xfUnImsjW7rhkyO46RMZ+y1MTI6c/5OQo1LL366D3dhczlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Sf2s+vi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ioEU5XBs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Sf2s+vi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ioEU5XBs"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6415713801F2;
	Wed, 23 Oct 2024 15:53:39 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 15:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729713219;
	 x=1729799619; bh=VqBgidO/dQheUWX11iSvIQja4hlCwxTnBp5Kxx4+SyU=; b=
	Sf2s+vi32xPG33PB7ADVSnze7Ps1kMEr5UiGkZ1255Pa4t/xQSypDTJCOm93b5Sj
	jn+y778R3b8t2ZGvtNcJw837I5l+TbJzmhRtnVIMzftpJi+QgkVQQk2ppBVSEFOO
	+FpJtFBhDCMwyO73gIk50x9tUhJPHWq/CpDpI774O0xfT4xJaN6iWCqVthjIX9eF
	j6Zo0kZJv4RxTlQsXcyhhaiHuNjfCG5rOdav2XN9zMte6DIoPMBy+URc6zsOdp43
	oHnGloIeya0vd3NM/SH+dw1wO1qSrYXNuLE4rPGfOfcxL5nJlobUnr3EEOFmySK+
	BjNx6xHexgHJ8IiQEKgzig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729713219; x=
	1729799619; bh=VqBgidO/dQheUWX11iSvIQja4hlCwxTnBp5Kxx4+SyU=; b=i
	oEU5XBsm8CtAKZAAx1j0K5c6uc5ofo20225HFLrh6X8aZ2gXZQrWJtoFO2u98jH/
	UoHu9cff5I3KDA5LLbd54zxhCvF/bSQafFiP94yzNfqfzSI+wk/lKNTvdiwuyjRB
	/VvfRM4WtNGaSrTelMPcaTxBIXRwXaxS+66lPs/xx7K3TmDOmdd7yi6GZ6griZAJ
	LL3kpKt1GAH1PBOmYS5i12en0E8yexxE7dS6xqA9iLAEOk75KZW+AcuwaEo9w3eL
	l/swImQevkiuHwWVF2MfrybCs5JMP7hnGpsh2cjqbbu99WK2auNJnD4vkyfD7sx0
	7H79UJjVgUCuaQlsmP2OQ==
X-ME-Sender: <xms:Q1QZZ4NYnq6K-yojN_sYV8LsSM0aU3q2hXOA98_hMHFRiltfinU2-fg>
    <xme:Q1QZZ-99qxeVWe22LEp9DCdXD4HFY-w5_Oyly0cV5n8mAZirB8UzoRfsW3HQ7HXV8
    0enfjp29nEmoQE5rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q1QZZ_Sw3XhO_FoiOcWxuhDUP5B6CGGtq4_kHrlr6ORV6ABIwYJsVg>
    <xmx:Q1QZZwv8MqF6lRKWthx6GkUc2yKF75zKyFSr5AJAdEaun85Ke7rxZw>
    <xmx:Q1QZZwf3jpF9uumIXffeZ-0XKY1VwUYv40VapTApOE58U6QSV_Iyzg>
    <xmx:Q1QZZ00UKrlKxquPsN47Tcr-oVxMm1zY2NZ7YYeNEWLs1wetYN5JuA>
    <xmx:Q1QZZ47W0ajVq_YrVzR0ILDIuNDA9BbsRrHImU-9l5afteVTdmdPGpCm>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E67F780068; Wed, 23 Oct 2024 15:53:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 21:53:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <20cca28c-cc0f-4bfa-bc1c-6a3dd6bc25a8@app.fastmail.com>
In-Reply-To: <ZxlEJ+44M8z03VOj@nand.local>
References: 
 <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, at 20:44, Taylor Blau wrote:
> Nice find. My first thought when reading was that this was a
> regression from 8b311478ad (config: allow multi-byte core.commentChar,
> 2024-03-12).  But thinking about it for a moment that is definitely
> not true, as this has probably never worked since core.commentChar was
> introduced, and has nothing to do with what range of value(s) it does
> or doesn't support.

Yeah, `%` turns out to be sufficient to reproduce (even though I use a
multi-byte one myself, and when I found this).

>> [=E2=80=A6]
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struct=
 commit *commit,
>>  		/* If the branch is checked out, then leave a comment instead. */
>>  		if ((path =3D branch_checked_out(decoration->name))) {
>>  			item->command =3D TODO_COMMENT;
>> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
>> -				    decoration->name, path);
>> +			strbuf_commented_addf(ctx->buf, comment_line_str,
>> +					      "Ref %s checked out at '%s'\n",
>> +					      decoration->name, path);
>
> Makes sense, but the following command turns up a couple more results
> even after applying:
>
>     $ git grep -p 'strbuf_addf([^,]*, "#'
>     sequencer.c=3Dstatic void update_squash_message_for_fixup(struct s=
trbuf *msg)
>     sequencer.c:    strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_st=
r));
>     sequencer.c:    strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_m=
sg_str));
>
> I imagine that we would want similar treatment there as well, no?

Here is where I got confused.  I tried to make this test appended to
`t/t3437-rebase-fixup-options.sh` yesterday in order to exercise this
code:

```
test_expect_success 'sequence of fixup, fixup -C & squash --signoff work=
s (but with commentChar)' '
	git checkout --detach B3 &&
	FAKE_LINES=3D"1 fixup 2 fixup_-C 3 fixup_-C 4 squash 5 fixup_-C 6" \
		FAKE_COMMIT_AMEND=3Dsquashed \
		FAKE_MESSAGE_COPY=3Dactual-squash-message \
		git -c core.commentChar=3D% -c commit.status=3Dfalse rebase -ik --sign=
off A &&
	git diff-tree --exit-code --patch HEAD B3 -- &&
	echo actual: &&
	cat actual-squash-message
'
```

And the output looked correct, i.e. all-`%`.[1]

I didn=E2=80=99t understand that.  Maybe I exercised the wrong code.  Bu=
t that=E2=80=99s
the point where I dropped that lead yesterday.  Figured that there was
some downstream string magic that I was unaware of.

(I could just change those two and see if any tests blow up)

However there is this one in `sequencer.c`:

```
		if (opts->commit_use_reference) {
			strbuf_addstr(&ctx->message,
				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
```

And that line is supposed to be a comment line according to the commit
(43966ab3156 (revert: optionally refer to commit in the "reference"
format, 2022-05-26)).  But it does just output hardcoded `#` if you
change comment char.  I=E2=80=99ll add that to the series.

>> [=E2=80=A6]
>> +test_expect_success 'git rebase --update-ref with core.commentChar a=
nd branch on worktree' '
>> +	test_when_finished git branch -D base topic2 &&
>> +	test_when_finished git checkout main &&
>> +	test_when_finished git branch -D wt-topic &&
>> +	test_when_finished git worktree remove wt-topic &&
>> +	git checkout main &&
>> +	git checkout -b base &&
>> +	git checkout -b topic2 &&
>> +	test_commit msg2 &&
>> +	git worktree add wt-topic &&
>> +	git checkout base &&
>> +	test_commit msg3 &&
>> +	git checkout topic2 &&
>> +	git -c core.commentChar=3D% rebase --update-refs base
>> +'
>> +
>
> Seems quite reasonable.

In hindsight and with some `cat todo` it seems that the setup isn=E2=80=99t
minimal.  I stumbled upon this by accident while not using worktrees.
And the todo editor seems to comment out two lines, not just one.

Maybe detached `HEAD` would be more lean.

=E2=80=A0 1:

```
% This is a combination of 6 commits.
% This is the 1st commit message:

B

Signed-off-by: Rebase Committer <rebase.committer@example.com>

% The commit message #2 will be skipped:

% fixup! B

% This is the commit message #3:

% amend! B

B

edited 1

Signed-off-by: Rebase Committer <rebase.committer@example.com>

% This is the commit message #4:

% amend! amend! B

B

edited 1

edited 2

Signed-off-by: Rebase Committer <rebase.committer@example.com>

% This is the commit message #5:

% squash! amend! amend! B

edited squash

% This is the commit message #6:

% amend! amend! amend! B

B

edited 1

edited 2

edited 3
squashed
ok 13 - sequence of fixup, fixup -C & squash --signoff works (but with c=
ommentChar)
```

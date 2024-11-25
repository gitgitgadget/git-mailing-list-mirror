Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B819645D
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531972; cv=none; b=phnHSxhAO1eyiZKbmQOvuqzblFrk/VuoSVOjk5SkS5+xGdy7pE//IpCP8aNfk1/DxtEFIeKFAMqz1WVxnFPibaphdcBvjBSqmA0W3k6RQpaCVNW2lxx+5aQomM/sk9W+1JHRNfHTgWjnU69TOyALpPVvNreJNr/f3ZWbIrCK/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531972; c=relaxed/simple;
	bh=U0d4ssCXYbLVE7F9UUKxccMVYMQKcgeKXo0M5TbUta4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=krhu1PegfAaTINMt6R3uUN/FgXXo7C31F7XnKzFDiYV+11TRx0LHH6NtEo6kn86XQy2HBFSo7TfJ42RuxCqHzqioUoPvaVd5IQMxuElKt8ojJN3wBnndE1o191coWO88M2J3d2J1mx0GOdzRypQ0oa5kyw0H3HoD7CfBL7ZNUxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bnpJ6p+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEIM4G4+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bnpJ6p+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEIM4G4+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8A1B254008E;
	Mon, 25 Nov 2024 05:52:48 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 05:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732531968;
	 x=1732618368; bh=pZfA/+CQYqMxCvPmhsXlG6FcrKuvWhtkX/VA3QDlTYs=; b=
	bnpJ6p+I8Xd5iSOq77zSNs+b5OXXEMJcAKKWulRZvwlextU2amw5mIDQxy5nqokP
	ez4CnVrojepUVZKXSaTG5szikl7zUGvMfwaNumu+QkCfwOqYadKI5BmACUDzTh2P
	14fQLdKlrn4hbJAEG29j4o/dZwz8vHEA6bGzylOYMLZ2GXYZ5Oq85HIS87PCaE6t
	uWTbOUxeQi4fYpM0cl8N7W7jwoU6zb9iRwxvF1G4BiUhw2PHbCx+uqbhv3DcmeWa
	EAYo9k42kECVw6WC4XSyduvofvCwj6ojf8Hkb5sp0BqcRnzprLbQQe1ionkcfzCb
	6VcMMKaQuaVBv2QDf2hyMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732531968; x=
	1732618368; bh=pZfA/+CQYqMxCvPmhsXlG6FcrKuvWhtkX/VA3QDlTYs=; b=L
	EIM4G4+PT9KkPMqYsKHJa4Ya3DFIc4Qf3HYn6NG6WDyV8YZgBg3ipxuHK4zq6AO9
	Gy6ozp1axxJ4/0jOcRQ4JmMLoTRw5Oy2QASn31I/gs07ku+jIch3qyJzOG0ROkcQ
	7qEoPUYTaym6kA8Mcw45wTvWWQjTcaoP+6x7/4/YLSoSFd5zusO/BUhKsaX3Kyyy
	1x6TJwrM9ZkMyzUB5skfi4bj6Rm0HzejDMMLTTZlUrTLyPktcw/5YCWg2429UBex
	ocNoRRRX70r4sNydm32oxTGtnKJoTdRdZmkLFT8QmU2giiVWsHq4woObvuxG8qqf
	gLXb9s+rL3WCN6RLwa4TQ==
X-ME-Sender: <xms:AFdEZ11eY-aUlweK4KewwqG-wJ0IsrXzdVbQlPpcnitb3f6iIG_ipvU>
    <xme:AFdEZ8HXyErrMGoqcDrte2lgek8zdlX8B3vqAqJ61gdzyqv-sdmYEXjcDpYrQE_Mb
    gdrdSMTCp9AxV6OfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigfefke
    dugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AFdEZ16bp4RexRTma9fR4-wuRhbIdPLm_xjW73q0eBJtVKZMw3WgYA>
    <xmx:AFdEZy0HfxTUo6FMxPD-2MY4v5JtVnM56_Tr_yYCKMAZwmtWHzN-Cw>
    <xmx:AFdEZ4FASLoHea0vtXGqiJ-RoqLl2_YRdyIgTLifi1YjtgJkbw0Ypg>
    <xmx:AFdEZz_5iRCcicl8bVdSN_H2QKhva49zFHwTOJIdKhLMy23JpFOB8Q>
    <xmx:AFdEZ0iM4_bq1owsl7AlOpjVjnCMcMlPzaDCfzq57HdZ2rHNS7DvO9Kv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 307C0780068; Mon, 25 Nov 2024 05:52:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 11:52:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Derrick Stolee" <stolee@gmail.com>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <3bd7cd08-61b6-4b57-a293-1c94eb3529d7@app.fastmail.com>
In-Reply-To: <7739a6e2-8758-4d0f-b1d6-f0879a89590f@gmail.com>
References: <cover.1731406513.git.code@khaugsbakk.name>
 <cover.1732481200.git.code@khaugsbakk.name>
 <7739a6e2-8758-4d0f-b1d6-f0879a89590f@gmail.com>
Subject: Re: [PATCH v3 0/3] sequencer: comment out properly in todo list
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024, at 11:07, phillip.wood123@gmail.com wrote:
> Hi Kristoffer
>
> Thanks for re-rolling, I've left some comments on the range-diff

Hi Phillip, thanks for the review!

I should be able to fix these and reroll today.

> [...]
> Stray "`"
>
>>      +    that hash3=E2=80=99s commit message should be used for the =
resulting commit.
>>      +    So the user is presented with an editor where the two first=
 commit
>>      +    messages are commented out and the third is not.
>
> I'd perhaps say
>
>     If there are conflicts when applying commit hash3 then the user is
>     presented ...
>
> as we only show all the messages to the user when there are conflicts.

I use `fixup -c` for the third/last commit here.  So I am prompted to
edit the commit message. I tested this on this series:

    git checkout --detach kh/sequencer-comment-char
    git rebase -i fd3785337beb285ed7fd67ce6fc3d3bed2097b40

Which gave me [this] editor without these changes (with
`core.commentChar` set to `%`).

>
>> However this does
>>      +    not work if `core.commentChar`/`core.commentString` is in u=
se since
>>      +    the comment char is hardcoded (#) in this `sequencer.c` fun=
ction.
>>      +    As a result the first commit message will not be commented =
out.
>>      +
>>      +    =E2=80=A0 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c=
] command,
>>      +        2021-01-29)
>>      +
>>      +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>           Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>      +    Reported-by: Taylor Blau <me@ttaylorr.com>
>>           Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Thanks for updating the trailers, they look good to me
>
> Best Wishes
>
> Phillip

=E2=80=A0 this:

    % This is a combination of 3 commits.
    % This is the 1st commit message:

    sequencer: comment checked-out branch properly

    `git rebase --update-ref` does not insert commands for dependent/sub-
    branches which are checked out.[1]  Instead it leaves a comment about
    that fact.  The comment char is hardcoded (#).  In turn the comment
    line gets interpreted as an invalid command when `core.commentChar`/
    `core.commentString` is in use.

    =E2=80=A0 1: See 900b50c242 (rebase: add --update-refs option, 2022-=
07-19)

    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    % The commit message #2 will be skipped:

    % sequencer: comment `--reference` subject line properly
    %
    % `git revert --reference <commit>` leaves behind a comment in the
    % first line:[1]
    %
    %     # *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***
    %
    % Meaning that the commit will just consist of the next line if the =
user
    % exits the editor directly:
    %
    %     This reverts commit <--format=3Dreference commit>
    %
    % But the comment char here is hardcoded (#).  Which means that the
    % comment line will inadvertently be included in the commit message =
if
    % `core.commentChar`/`core.commentString` is in use.
    %
    % =E2=80=A0 1: See 43966ab3156 (revert: optionally refer to commit i=
n the
    %     "reference" format, 2022-05-26)
    %
    % Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    % This is the commit message #3:

    sequencer: comment commit messages properly

    The rebase todo editor has commands like `fixup -c` which affects
    the commit messages of the rebased commits.[1]  For example:

        pick hash1 <msg>
        fixup hash2 <msg>
        fixup -c hash3 <msg>

    This says that hash2` and hash3 should be squashed into hash1 and
    that hash3=E2=80=99s commit message should be used for the resulting=
 commit.
    So the user is presented with an editor where the two first commit
    messages are commented out and the third is not.  However this does
    not work if `core.commentChar`/`core.commentString` is in use since
    the comment char is hardcoded (#) in this `sequencer.c` function.
    As a result the first commit message will not be commented out.

    =E2=80=A0 1: See 9e3cebd97cb (rebase -i: add fixup [-C | -c] command,
        2021-01-29)

    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Co-authored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    Reported-by: Taylor Blau <me@ttaylorr.com>
    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

    % Please enter the commit message for your changes. Lines starting

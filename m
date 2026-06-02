Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988353438B0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401524; cv=none; b=IPuo9OLS13XivLtet5UzaKK84/U42o/vU9wgqKmHJtxzRgCVLnrFJiVjlij7WtoJsiyqElMPfSZ3zYFPcEnDYWWGMnKIKu2UxNJM28hnC57mkoaBuEWmLwifAZqQuHQ5jiKcW9MycHccc1AqFXILekI8phjIq9ElWk0uTlWHS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401524; c=relaxed/simple;
	bh=mJHuXBCwE2QA9OL0EEJ0kczs0INIV9f7uGzoC17u72Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hs22WcKsK9rauiASxaHvgQBZyb5M50HWrevcs1LAbBe4m1S13zbAqIcuNH5ElGCJQyoGRKtRMy9fHsw9rqQYZFjjNjyJNwKmrtnxsPHz16mzCedgb5B0vXoeTCUr4Gpsg3Yb3QJ3ndNWSqxgTh260bVdQB79R84IRTV9mv8adFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qfjjJDTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htTunsxL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qfjjJDTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htTunsxL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB588140023E;
	Tue,  2 Jun 2026 07:58:42 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 07:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780401522;
	 x=1780487922; bh=R2L5JhyoDtrult0mhU+/MbPS7drgNZr1O0SoeaGB18U=; b=
	qfjjJDTlgPnMNlzZ68AQ/t0hxLj9BMUcha9b6adiWAm7ehb76w4lXp2RFvjjryZs
	8FGpDW7NlTOy3p9v0ggfVQSLl9AWeZydHADd4X6JruokYoSq6dGnFqRalOuzY3g6
	Ql0TtobRFhBNZ6crQjTvgdIQDvZzs21bw1NKUE7oLwNABWDQzrjiAqqbHITLkLNJ
	l/XhOp11X5Yf/SBOBW/sFMn7KDE9hxMoUVDalsbsJ65UUsAe7CV9aYafTAZCJPV+
	PhSVB1lAGhckKyPfVcF3Nn6MKFJO/Ygu7A3MNUmwX5ZCWyuSI5UtmaEJdPr3s1o3
	5H6euakjEoHnWhh9QjdDJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780401522; x=
	1780487922; bh=R2L5JhyoDtrult0mhU+/MbPS7drgNZr1O0SoeaGB18U=; b=h
	tTunsxLP+j7WQvuFW7C336Jed5xeTVbRg3NVawuGzv831cGpSYGnbdJGm2s1ber2
	+1uLrGysxn8tPgDLKJD1nX2e2cNOjGy8ozyxqLQJ68Rrtlw8IvWGz1GbF6I4tWRO
	cRWEcW4ySFS/jKm7tOsfSVXnDeTyayUd39UAgKls40m7JGTSL2nrMkmmw7lfaYLu
	35eZtbUQnkaUmmuN3+OqoaNYCYwg3fxTX/CE9GuvlPcFoWq432/zW3V2iDY7BLhX
	t52hBOoffupoGN3eJe0+H/4S4j3fNhOxHN0SX4+ulLfLEX27QqaOdtOpl0s3sXh/
	/fS9zW+E5iyW4EFshzktw==
X-ME-Sender: <xms:csUearCP4l92SE82k1_UL-Lbnd3n149bzYJfOkZCCdivndv_2ZxpCnQ>
    <xme:csUeasUhXlIH36PsfsJARyLnEi1jtjHSjrgb4pNoBawUuRJ9sAJNfLAc9qDFctEuj
    dQwRZpLQxcVYgZtYCvJvt35IebCYREX8vmR0yb-UDj-8XVytgbzrQ>
X-ME-Proxy-Cause: dmFkZTFftFGBgOQ6SNOtV25uFmy0Y4nkRddGQINsHjbYPQQDvHWhS5oSGFT9tfFpCPmG31
    QURwSlxCcecst/VHqhZeYSh1KTCdlAD1RRFPeb+DNxMHmq0Lan8ZmDt63RJBtsBrujbt2K
    wi76hpcZ83OYoy2B3tzaeHBTKjzK7Bg4qD+0gDp9TnewYX1gwwFLfNMV+H7Lvtg4xKrFSp
    dUNDtNUmVAXVXr1lr6r85bymygGOx86xgxwS8x7hiAkk0iQtLuvJy7POgUCwPc03w6TC/k
    0fy515MRJ5fbF+iKnJUegDpaOAVmNdQQKKE/7SabT8IDXR7OlbTnAIePMLPFXOo9LGx8BY
    a0cwAnpKNoazThquvdyddGpEOHLCjTcsF+GyncIcTFh7D1YnJbfapRdbYl3oS2fgmb6j73
    oUqy+ga7aO1DRCG9kieGQZLSTQOadp+FvbhOCcVCbUp2Qy+YxHB2pOSoUZAqiTjo1lKTj7
    apfbaK+VOHlLbyt9QJiJD/yWOETPPzmUQeTB09GxOZI/j8C1bO4GIX9LTe4YaB12XgcJgH
    oe3ezXq1R3GPBXeGPiL6ERl9UpijuDNTIIZdIfxYpmdDMs3ZYQzWF7ILnVKi6lQHOq7/JP
    qHxFgqCw2R8x8Lw852weS6OVLGYBT16uvnFEzIzClTiNLVdxTnSyg1mdRMDg
X-ME-Proxy: <xmx:csUeaofr9sQtrIIHQ9tdsDVmYjLQ-cIc4sAJaoQw3PKKGGEhURYXuA>
    <xmx:csUeah8W_M9CmywhgZ_yESk18R7pIXhfZIvnyGZPlxXjQQ3bMkUsGg>
    <xmx:csUeasnAKrseJwifryk_4v_SQ0UL-FCA0iaUDfE75-X3fxE3O1ZtNQ>
    <xmx:csUear8sRiz_MLsjh_RhOp8XGCgJrK7wOWe3PhUqr7B3UAnPfzftug>
    <xmx:csUeau5BtimUzwIgDO-LDnU4pjRv-rnohpoBg2bEDJI3s7qvd137GMH1>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 94C043020094; Tue,  2 Jun 2026 07:58:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZ4b5WQY_xTJ
Date: Tue, 02 Jun 2026 13:58:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <ace3922d-8f73-4a76-944c-f09dfe311db0@app.fastmail.com>
In-Reply-To: <xmqqy0h0ed7h.fsf@gitster.g>
References: <CV_doc_replay_config.709@msgid.xyz>
 <simplify_replay.refAction.70b@msgid.xyz> <xmqqy0h0ed7h.fsf@gitster.g>
Subject: Re: [PATCH 2/4] doc: replay: simplify replay.refAction description
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026, at 00:37, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>>  replay.refAction::
>> -	Specifies the default mode for handling reference updates in
>> -	`git replay`. The value can be:
>> -+
>> ---
>> -	* `update`: Update refs directly using an atomic transaction (defau=
lt behavior).
>> -	* `print`: Output update-ref commands for pipeline use.
>> ---
>> -+
>> -This setting can be overridden with the `--ref-action` command-line =
option.
>> -When not configured, `git replay` defaults to `update` mode.
>> +	Specifies the default mode for handling reference updates. Either `=
update` or `print`.
>> +ifdef::git-replay[]
>> +See `--ref-action`.
>> +endif::git-replay[]
>> +ifndef::git-replay[]
>> +See `--ref-action` for linkgit:git-replay[1] for details.
>> +endif::git-replay[]
>
> This makes it a bit roundabout for "git config --help" readers who
> wanted to figure out what value to set to the configuration
> variable, because the valid choices are no longer listed here.

That=E2=80=99s a good point. My thought process at the time was

=E2=80=A2 This description list needs to be changed
=E2=80=A2 But I also need to change it on git-replay(1)...
=E2=80=A2 So why not just gesture towards git-replay(1)?

But now I see that this does make it slightly worse. Which is not worth
the saved effort.

I was thinking that a shared file which is included in the config and
git-replay(1) could be used. That file would just contain the definition
list. I could also duplicate it manually and leave a comment about
keeping them in synch. What do you think?

Assuming that they should be equal, which I think right now although I
haven=E2=80=99t started on the next version yet.

>
> Finding `--ref-action=3D<mode>` and its description in the other page
> is straight-forward, so it may not be too bad, though.
>
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay=
.adoc
>> index f9ca2db2833..4de85088d6c 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -211,6 +211,7 @@ to use bare commit IDs instead of branch names.
>>
>>  CONFIGURATION
>>  -------------
>> +:git-replay: 1
>>  include::config/replay.adoc[]
>
> The use of conditional attributes (`ifdef::git-replay[]`) is a neat
> and standard way to tailor the description depending on whether it
> is read as part of `git-config(1)` or `git-replay(1)`. It correctly
> points the reader to `--ref-action` in the latter case, and provides
> a full `linkgit` reference in the former. Clean and correct.

Thanks for the thorough review.

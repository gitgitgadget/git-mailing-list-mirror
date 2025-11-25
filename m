Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255C338582
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764099055; cv=none; b=JrILFVzgAEhorKqm2YfnHTuKtjX1RqcjYJ4TRJ380CQ1ycrrr8hX9fenCsAfKLyI2gOTNjXdAgAisSarV0bZ91WE2Qd8xaOfprTtHl4EgIZTqbdgcYMRcSPYwLE2ts8oLJtN5b6gIL/5aQ4e8MBeyeNDBFdjqS0dMr0VrgCvobY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764099055; c=relaxed/simple;
	bh=sBRVeW3BSyf9HGJLIIPu7Q7DCOYmFV0saiXyz05udpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fLdjfe9PSQ757hw1W9we79VR3mMiOe4Ot8g2rAg13ma0UM6oTXzJM8kWUZiE5IvTd72dS0zlMT807LchxFP6iNwV1uwGqJzlzxvxTsWAEaEg3I7AUQax/AT3fIavs3IIr0X2Z1jc/mgWjx3+vDu7kkxhwT1/broNTNoQ21tezmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=THGYhD2r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xd7TMdEB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="THGYhD2r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xd7TMdEB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 541E0140023A;
	Tue, 25 Nov 2025 14:30:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 25 Nov 2025 14:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764099052; x=1764185452; bh=9nregakLmi
	9juRzepI2EAdAarsCrcEvL75I0O981Yig=; b=THGYhD2rLeHVtBZFCvKiglHxWF
	Bsi4r4K2NMedB2gJxl6cgEZDcYvG4Ej0C4f9XepIrirhP6LSUJdjEfwZHDiW45/j
	bPNkOLLS+9BMuvfsbJAyyfnS4KFTkio8bCy5J+dprD8H5S2JV3McuY+wPnyRO+V5
	cFVypSXgDHE1XzSDmv/5KlIRHMnht9yI3Lr9yLX9uD5kFZUp1Bk/I3/uIvwX0ZoR
	+idJRIol0aN91DQoHBcqStUBAy4aN8IHMr1RCuVgeQOwPuOHmdnaZ8qX1CZxxLSW
	Fq11RogZ8GCnuS3qW8odUAztkQvfNHo5zyILovfoDj/NM1kcBvhU2suWWReQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764099052; x=1764185452; bh=9nregakLmi9juRzepI2EAdAarsCrcEvL75I
	0O981Yig=; b=xd7TMdEB5LXnAmRIbhSwsdtHtAPMEXV6dhmy7jPALEhnEmApqfi
	fjlHDPYlTSXLSLHyq9oTfqGVk4af61WXgD38B6nSCPtXvy/EaY498Kf0UR8jokPU
	F1CZx34hq5jUToQ3vad40OoDO/H0JHMADK2S6mnCgzG9U7b3C+ElaMqDIrSJir6T
	QqPK8PQ2PVIKEdV5iaZMaJje8hmXwrYziZZHF6mLWMagTyrniDh4jKP+a740t/8H
	Ng9z9MOzhoOhweziAa03yDGaI7rK6jPT5V/U3XeAQHBDEd/zwAOSrUrpatFJOS56
	JZSeAOkRiC35RJEQbBzUQaPP28IyGGACa+A==
X-ME-Sender: <xms:6wMmaTnuU1aYrcszGRJDwgKN0nmnk4dA4-CfJCdod0gV6n8ZwIpWgQ>
    <xme:6wMmaRO5hLtwqnKvMuz4ZfAqRu5gP3gYmlC83OaoWeQrSvSmNz2Nr0mZS6pZ5mB7X
    JMPCHNALR5PMb3KG_lbQoj25p97e2SCqJxRXnkGy0INxpgvKDQXZA>
X-ME-Received: <xmr:6wMmafx-FNoJ2qi4H1DufzsZAoso6ae_Wnaj8ZIfilf1sNnNl-zrgYOrtpARbPz3snsQFNeFQExO6df1UKsO6pdchtsyCVAsPri8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefhkeefkeeiveelveekveekkeelgedvvdelgfeuhffhgffgieffjedviedv
    gfegnecuffhomhgrihhnpehsvghquhgvnhgtvghrrdgtfienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:6wMmaWudh_gwqfVkcWUww34bWerjXefe5iJtNbtVc2MKFflEFt-Q8g>
    <xmx:6wMmaaYt-yUl2Na_Z109ITuXL4Gk6XPCRKOUbQctIUdeAj0Kgm1bog>
    <xmx:6wMmad0GqBNCdXDVh8KKMPVNgpZgqPHVgcpBju-L2jnY8-63EfGS9g>
    <xmx:6wMmaUvqVK-uNsVZesbhYSSoFqXX6zotKWwF5ukTR9rkYIV0nN-8pg>
    <xmx:7AMmaRBep9r0NgD82bxU7O06-Yp_qBNsn6do62YcCG7BDNV3JieKfvpX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 14:30:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <xmqqwm3drk6m.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	25 Nov 2025 11:22:57 -0800")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<xmqqwm3drk6m.fsf@gitster.g>
Date: Tue, 25 Nov 2025 11:30:49 -0800
Message-ID: <xmqqo6oprjti.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> In do_pick_commit() where TODO_REVERT command is handled, we find a
> code block that is almost identical to what this patch adds to the
> new helper function; it should be rewritten to call the new helper
> function or perhaps a shared helper function is introduced and
> called from there and also from the sequencer_format_revert_header()
> function, if there is still some impedance mismatch.  If such a
> refactoring is done as a separate preliminary patch in a N-patch
> series, the resulting patch series may be easier to follow (and
> there may be other opportunities to reuse existing code more).
> ...
>> diff --git a/sequencer.c b/sequencer.c
>> index 5476d39ba9..e6d82c8368 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5572,6 +5572,29 @@ int sequencer_pick_revisions(struct repository *r,
>>  	return res;
>>  }
>>  
>> +void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
>> +{
>> +	const char *revert_subject;
>> +
>> +	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
>> +	    /*
>> +	     * We don't touch pre-existing repeated reverts, because
>> +	     * theoretically these can be nested arbitrarily deeply,
>> +	     * thus requiring excessive complexity to deal with.
>> +	     */
>> +	    !starts_with(revert_subject, "Revert \"")) {
>> +		strbuf_addstr(out, "Reapply \"");
>> +		strbuf_addstr(out, revert_subject);
>> +		strbuf_addch(out, '\n');
>> +	} else {
>> +		strbuf_addstr(out, "Revert \"");
>> +		strbuf_addstr(out, orig_subject);
>> +		strbuf_addstr(out, "\"\n");
>> +	}
>> +
>> +	strbuf_addstr(out, "\nThis reverts commit ");
>> +}
>> +
>
> Dedup with do_pick_commit() where this was taken from.  Possibly in
> a separte patch before the main one.

Forgot to attach this at the end.  What I meant was that something
along this line may be a good starting point.

 sequencer.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git c/sequencer.c w/sequencer.c
index e6d82c8368..29909952d4 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -2365,20 +2365,8 @@ static int do_pick_commit(struct repository *r,
 		if (opts->commit_use_reference) {
 			strbuf_commented_addf(&ctx->message, comment_line_str,
 				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
-		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
-			   /*
-			    * We don't touch pre-existing repeated reverts, because
-			    * theoretically these can be nested arbitrarily deeply,
-			    * thus requiring excessive complexity to deal with.
-			    */
-			   !starts_with(orig_subject, "Revert \"")) {
-			strbuf_addstr(&ctx->message, "Reapply \"");
-			strbuf_addstr(&ctx->message, orig_subject);
-			strbuf_addstr(&ctx->message, "\n");
 		} else {
-			strbuf_addstr(&ctx->message, "Revert \"");
-			strbuf_addstr(&ctx->message, msg.subject);
-			strbuf_addstr(&ctx->message, "\"\n");
+			sequencer_format_revert_header(&ctx->message, msg.subject);
 		}
 		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
 		refer_to_commit(opts, &ctx->message, commit);

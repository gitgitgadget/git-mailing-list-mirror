Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048C2C3267
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877614; cv=none; b=VvC4YrTnk9tkdqGpdjzpJOehlZR6FGafcdDGsyyuCjoEle3NWpv4sfSoaH0r1j7FYT4DYBxfc7UUUiExa3IYcZ7Cw6igFEY5HLBc1f1gGt43cY9qvx0fxkoQJBGOJunQ6I3ZvH58QLnDf3/k+rG9VH1nbxy5/ld3crFyVrY8osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877614; c=relaxed/simple;
	bh=mLlT87+fqGpYnYAkzSwJ5FK7LDcwv0rVF7kZccd7MBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pxbBfVylfY03aYYhbnuWmuQXonAQga9sTRSrRLlrGGj3wLCKM4LSPz4N/CcrbppHI1yDI11yLx/Q+1KNSeNMjEPqUll6l6Jpce1kACl3Rcvy+baFCE42ZY9pLjnyGPWREQ/s7svWfOhH+asGC/amDVHimXCK8sc4B8K+aZNP6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cEUpw+9/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9kC3u/o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cEUpw+9/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9kC3u/o"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E5D2138034B;
	Mon,  2 Jun 2025 11:20:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Jun 2025 11:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748877611; x=1748964011; bh=S9++h/fah0
	q0mu/aD/ukIqphSzAyF4eV5GYCn7veMSo=; b=cEUpw+9/nITtzEPP8EuV8JZCy+
	xaoO3h/U3B7y0Di80jjqrvfBPu60oaFkj9TlO9o4lQmeZ+86vvurk5nq0YjNnh45
	ZD6lWlTV5yrmBDLAEkQ8uP0uhsAURMbgy7V4cRUMDRYGOatSOT0yQaNh2Xnv/xoa
	sqKhPogOSSkmfwJuG72ITfOmjaIt5sECTzgOnHQJpDAK+Otluerb+EwXqfwaRZdu
	PdhphvIRJv4IX0F260DWA4PjW+OdQBrJeoRaIHoRMijzCEtewKWMJpF/nie8mjha
	lBZx+k4f+/IzW/Bx3NwnZUbkDPIhKXg2ouTX8/t9U2avL2NNpgoYiuCN31YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748877611; x=1748964011; bh=S9++h/fah0q0mu/aD/ukIqphSzAyF4eV5GY
	Cn7veMSo=; b=Z9kC3u/oESpYTYIh/7v/NRiVxDigFNyrenyHADmL0SH56tJSR20
	fAvKYzre7HHr4cetVO4n89Ic/B4Zen2mWar4uiO2Y52kIN4O69NSP+IXK96uGb3S
	EChVKrEixGCOu9WJLPqdk6F/ExFXqq8mw/EkU2Vzyse+IBaTgUVOMHGrEfkrzBz2
	4U3K0KozbaUwMwPV0661cYi63txlzkswJRexFzwt+T9lztdB38kWVPza4AazN72h
	xzh9tfSIZgEHwUa/PuRxCrczZ/mabzP3bkO0UKZUy/pRT57HUS0meyc7++agIT5F
	mGw73OePt9KXzcn3iqE99toCz6+1QModKQA==
X-ME-Sender: <xms:KsE9aEVI0LRRCGcL9z98vA3QcbW2iRtUpb8PjZikFsVx22GSyEoQEA>
    <xme:KsE9aInfLtsk_rOl6Rx_2QSPj18EaEF4bosJNFFzIXDLZd23V2TWXtiCw60SvLEyF
    TO4ClPthBygfJdbwg>
X-ME-Received: <xmr:KsE9aIabdkfdd4LnBw3Iv5MfGU3QAFkfPik0imO0lAWxZ7wp1RPhpD77ghFK9jLiAY7pgebTjEgd-L1gHNKnHfcFAcjhCNy_qKIb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkedtudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KsE9aDUIptUZ1O7EeNRhiqGSIz4d2ay5rqzs_UWaL26iKbxf7csVHw>
    <xmx:KsE9aOngMOad6Qdzg6y3yGSgTln5E5lzL2IBDuj1T8cBlC2dgw3PaA>
    <xmx:KsE9aIe1k9IvagKZRMAGl5_BvjKd_Z2Mh8Y0gkcbnZPD7DrJIhhgjg>
    <xmx:KsE9aAEmDTu8Sh6NNNX-3RcHsgbYf6H_TEKZZpmjoG9B_vIBWDSA-Q>
    <xmx:K8E9aOL9DYy60nXT1agjALlazaRhlCDcn6sAHgL3NGDLkatP0CV3gBCR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:20:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] receive-pack: handle reference deletions separately
In-Reply-To: <aD2SPsro694yr60Z@pks.im> (Patrick Steinhardt's message of "Mon,
	2 Jun 2025 13:59:58 +0200")
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
	<20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-3-903d1db3f10e@gmail.com>
	<aD2SPsro694yr60Z@pks.im>
Date: Mon, 02 Jun 2025 08:20:09 -0700
Message-ID: <xmqq7c1uuq52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Okay. All of this is unfortunate as ideally the reference transaction
> itself would know to resolve such conflicts.

100% agreed.

> But we're no worse off than
> before because we at most perform exactly two transactions now, whereas
> before we would have performed _at least_ two transactions in this
> conflicting case.
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  builtin/receive-pack.c           | 23 +++++++++++++++++++----
>>  t/t1416-ref-transaction-hooks.sh |  2 ++
>>  t/t5516-fetch-push.sh            | 17 +++++++++++++----
>>  3 files changed, 34 insertions(+), 8 deletions(-)
>> 
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 9e3cfb85cf..7157ced2a6 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1879,6 +1880,8 @@ static void execute_commands_non_atomic(struct command *commands,
>>  	for (cmd = commands; cmd; cmd = cmd->next) {
>>  		if (!should_process_cmd(cmd) || cmd->run_proc_receive)
>>  			continue;
>> +		if (only_deletions ^ is_null_oid(&cmd->new_oid))
>> +			continue;
>>  
>>  		cmd->error_string = update(cmd, si);
>>  	}
>
> Fancy.

Is that a new synonym for "not worth being overly clever to
sacrifice readability"?

This may be a comment for [2/3], but a two-call sequence

	doit(only_deletions = yes);
	doit(only_deletions = no);

looked somewhat iffy for a first reader, as it hints that the second
call would do both non-deletions (i.e. creation and modification)
and deletions, which makes readers wonder "so we delete twice and
rely on that it is not an error to delete something that does not
exist?"


>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>> index 029ef92d58..34eb3a5a07 100755
>> --- a/t/t5516-fetch-push.sh
>> +++ b/t/t5516-fetch-push.sh
>> @@ -744,8 +744,8 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
>>  		EOF
>>  
>>  		cat >update.expect <<-EOF &&
>> -		refs/heads/main $orgmain $newmain
>>  		refs/heads/next $orgnext $newnext
>> +		refs/heads/main $orgmain $newmain
>>  		EOF
>>  
>>  		cat >post-receive.expect <<-EOF &&
>
> Hm, so the ordering does change now as all deletes will now be listed
> before the updates. We don't make any guarantees about how these are
> sorted, but it makes me a bit uneasy to see this change. Can we avoid
> this change in behaviour somehow?

Good eyes.

I was wondering about the "git push -v" reporting and was happy that
the order there follows the order the pushing side listed refs and
the reordering on the receiving end would not have any effect.  The
hooks on the receiving end can indeed observe this change.

They can observe, but can they notice?  If the pusher listed refspec
elements for deletions first before creations and modifications on
their command line, that would be what the hooks see.  They do not
know what the original "push" said so they have nothing to compare
and complain.

Ahhh, but humans that control the both ends may notice and complain.

OK, I think I agree with you that it is worth to at least spend some
brain cycles thinking about avoiding the behaviour change.

Thanks.

Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6B1F9F73
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714941; cv=none; b=PYz40eNBHXVliNpTux+rBA5NTbKEZWcjD2FyEqz42R1lOTnPFITG40tvjbS8zRkJ2HFiqMpsBI2FMDGGfF4nk0N7rgbkpyyQ6Tr3C1OriOTb0Myi297f9Q6rs+Uq7ev9cuLDUS+vQwAWUQGrtFl54O5W/FhXF6Q0XsiA4kVMpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714941; c=relaxed/simple;
	bh=BOCT7s9gMcM2j/74HBPakdWWBlgwBCBouwAlRSZbN58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgYeOb0d3OPQUfDFtIG4CESJBBts4gUjy3Q1VC8q1uIW89mQvtY5YPGyW5j3B3nqDNyrbH50m5AOWzQaAUsUMoty4u1G2KKah57U6rYLiIdAPHizKHv+/4N3HDh/RoC/TrU8bYKUM0st5ZedwbYCZmtSV2hK5EfwkbOT/benQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cg3QgTTf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TH+huder; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cg3QgTTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TH+huder"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B1054EC00B8;
	Mon, 28 Jul 2025 11:02:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 28 Jul 2025 11:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753714937;
	 x=1753801337; bh=fvt1xEsCf9Unx8eP+tyg9XI+2kVtB1XtyLpVRlekAdM=; b=
	cg3QgTTfq+g/JW7yLRHouo5XoCIPYZ8RWTddqx5/m9TXCma1fi4ffcjEh9jiErp3
	OyB/ZRRNnDMmsjSTF6oRJ8dyJlmuXE8IPvti+fm/WCb9TKQ1MIK68DSZii/SrQSO
	1VUGlTU6DcUmNmUcSlD5Z7bcu3CvTWldIWnbnnSm1QCzsSiUbHlBr1dUbyrZuyEO
	26NCYDDo/ISv4vw+M5m2yYtuvC86AsVha83KjBT6gicN9syf3EcQt4TGz5UfL7Ur
	ho4QmORTqyRAWZi/gUJID1s0Kp37Vf+YVWFfmCB5bMm+L61IiBw9xzy5iib3ey07
	LapjRDl79wqQUI/4DnmONA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753714937; x=
	1753801337; bh=fvt1xEsCf9Unx8eP+tyg9XI+2kVtB1XtyLpVRlekAdM=; b=T
	H+hudernAYkqSbgbV81MdGkH5O+H+Uwt5PmuhzaUvfJGCsl/ALsBWi1EV7c5sT9r
	YOM7C2fqeSdMcbu8GE6M5CZ1pHWkcO6qJD4n9f3QMGARMMRWsLedw8yWAd26MSpf
	AXQDxddvDAACClHg3wXVfDp1kU/Md0dEaiISJXguvlkeJbsMm9SmXL9bxznUfiNl
	b+xTVHcRZDMyNDNUsxZoIgpnX+lo8Y+3k9BtjyJiu8jinTr9L/dONZ0Wu8l0e6VO
	ERPQelPcke8HYi67PC148N8lDnrp226CTIt4po1cZJRxBo55HZ2FXOzf2JayHHOI
	PvkQkKwxspT1EFTgy+cxw==
X-ME-Sender: <xms:-ZCHaJjnkg0Y8C9rwCf59N17YmBj5yA4ZgogjNfIPQ6_ewRFsydsmQ>
    <xme:-ZCHaIk5qYFhhlr2PI9IIvhibOJFG_tJVstlf805MHD1BdlemocHrGP2NRKHLoBZt
    MmQsz5mD_at6YmSPQ>
X-ME-Received: <xmr:-ZCHaFqjKvBBbSbhtYXBc42r4tlTJzUCIT7RSy5zv1xlvWXaG7a204JqEQWTAr0swbTU2BFDThmf7qgE5boZafINWemF3SljbSPeShg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghrihgtfhhrvgguvghrihgtkhhsohhnieeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-ZCHaBGfI-Eh1jVMHRfW5JzO7rfRuxzlO5sKZZb1z_1GCF2tyHCIrA>
    <xmx:-ZCHaBxOVo1qDcgEa1i6XY287JtzIGsa8uqd0IilbCRTOI8I4GnAgw>
    <xmx:-ZCHaGp9p4kRxiwg5cZpRV_B9J5XfW0--RUDgGSQo_gh0SNVROFO0Q>
    <xmx:-ZCHaLiI4rvB13WrHO7iIpLO-opJHK1yAPsdlZYQW_Y7pHP99f5RXg>
    <xmx:-ZCHaKeEsW5DgVLKcgOLjCUH3xXVV3RKzEEd0jynZ_yD2WY2k_6E8cpg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:02:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Eric Frederickson <ericfrederickson68@gmail.com>,  git@vger.kernel.org
Subject: Re: A Question from a Hopeful Future Contributor
In-Reply-To: <CALnO6CC+Tn5xFYcHwH-M7kLNt2+gut7Okx7fCuWRdOsQHoDWFw@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Jul 2025 10:21:10 -0400")
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set>
	<xmqqecud145v.fsf@gitster.g>
	<CALnO6CC+Tn5xFYcHwH-M7kLNt2+gut7Okx7fCuWRdOsQHoDWFw@mail.gmail.com>
Date: Mon, 28 Jul 2025 08:02:13 -0700
Message-ID: <xmqq5xfcz7d6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> >> * "git status" on intent-to-add index entries (say "I" in the first
>> >>   column instead of "A" for short status, add "(needs 'git add')" at the
>> >>   end of "new file: $path " in long status).
>> >
>> > I am interpreting this todo message as meaning that the following behavior
>> > should be implemented:
>>
>> I think that was done long time ago.  The entry may have been a wish-item
>> in April 2011, but not anymore.
>
> At least in 2.48.1 and in git version 2.50.0.rc0.48.g74dbe4346c, this
> behavior isn't present. So I wouldn't call it "done"—maybe there was a
> discussion that it shouldn't be done, though? I didn't search the
> list.

I didn't either, so this response may not be adding much value, but
I think the intent of the above entry is so that the output allows
users to tell between already added entries and about to be added
entries.  Perhaps in an ancient version of "git status" did not give
enough information to allow us to tell the status of the index entry
for the path and the status of the working tree file for the path
separately, or something?

In any case, we do not need to add anything to achieve that today.

    $ >P
    $ cp P Q
    $ git add -N P
    $ git add Q

The user expresses an intent to add P and actually adds Q.

    $ git status -suno
     A P
    A  Q

The first column of the output is about how the path in the index
compares with the HEAD, and the second column is about how working
tree file compares with the index.  A file that hasn't been added
(e.g., untracked cruft) is not even known to the index so the latter
is _usually_ only for tracked files.  The fact that P appears as
"_A" is a sign enough that its contents haven't been added to the
index, but only that the index has been made aware of the presence
of the path, which is exactly what intent-to-add is about.

If you further add P, this time for real, the status would become
"A_" (i.e. to the index, new contents added relative to HEAD; to the
working tree there is no change relative to the index), but the
intent-to-add bit is gone once the index has (a version of) contents
for the path P.

Normal output without "-s" is even easier to reason about.

    $ git status -uno
    On branch foo
    Changes to be committed:
      (use "git restore --staged <file>..." to unstage)
            new file:   Q

    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
            new file:   P

P is _known_ to the system but its contents is not added at all, so
it is "not staged for commit", and known as a "new" file.

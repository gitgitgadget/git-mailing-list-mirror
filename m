Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99F3D3B8
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977961; cv=none; b=DDYyMPwLulCYat7ZK6ccLfUFPJXCrp/tZtpwLG80Bc6+ycxgmCtot1MEbL4Bivm7YEHQUCrTsCM9ebPKyzep6WfKI8KMCZ5/NuwyUZBPgE92XL+VujzGk0Nea74+VgffMCk2qxjCMziAY5AetKe8Pg8A9Rt2Nc6txMY87M939kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977961; c=relaxed/simple;
	bh=SpVOOaskgumamnJGzek+PdeBmrC/fvjrjy7Imuete+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6TDKiy6+Q+OuLlBwL/ZBp9+Be0Tr1Q5cC/rnYdQrRC7a+kCvEwTGlbbJea2cw092Iz4vOOYlFFccpXDii7TKC/kdmx/MuKUyXk8b1nIp5R4OOlfeD54ldpOec9D7NQbLc8LSZsNUmibhTPcWEUdp/Jb/ES/LIfGDYu+DCaPhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zDtcphwR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KmDcEGq3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zDtcphwR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KmDcEGq3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 151481380138;
	Tue,  3 Jun 2025 15:12:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Jun 2025 15:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748977958; x=1749064358; bh=XIfQJ951gK
	BgOEq2+VNTZaepC5BSWcKtVRJjVxBbL8k=; b=zDtcphwRpwBufmqlU3uaNqIDxY
	5qxTIPky+bokOYnGVhA1tNGpE/HRp6e94gyZ4mb35WUj+t5sr6LUMNFtzq9dpSvt
	ypjnfxviM4DYkwkh3OOt7/OFbOOGz+jy7trG4rJr+Oq3EDrMaeYME76PKfo8EmR/
	QDFm4QwCiIqnMLSfbIWo5PMvwfUNooB3vgI/On4qz0yQ2HwsrKONfg713N9t6Ylc
	iKulMerZzusOJdByvTTHtDO5b5VIyh5E+74qu3FqIu0+VsbryPh2FIyp3nAukG6t
	kJAQbughDeMLsGs8/+N+pTCVEVe2kydNVcosTXeehwD2fEsm1DuwxlzYDR8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748977958; x=1749064358; bh=XIfQJ951gKBgOEq2+VNTZaepC5BSWcKtVRJ
	jVxBbL8k=; b=KmDcEGq3ZSl8zpG08LBPVCLFBqYUcRrJvQ5iH++EDYGjWYIDEDs
	5RZJEW3GcO1I4PA8mC0aJTmyqEFP/poCzkMq789IvMc2Oq/x+EBL/QV6TF+x77vl
	w9cqlSNJMP29zefzEmWjSlkEjHuE0NRIXrCWeyNCTKWOcfoHN99unjf1Po2lpceh
	h1NfkWccCgRdIZhSoHmjUbZCInRoFRQGe5fE50l1ZJWRT5TTLzMcEKWSu4nolx52
	b0Dna6/0ti7WM35cEqJtKXLd0bNO9e+t4kW5PJdep6qnH7E71+t+WH3NM8Jt3y0p
	c3hE2vVnyS29Kff8mXJ8RFx0GmMheI1TDQg==
X-ME-Sender: <xms:JUk_aO0IZjoPzMKM29DQzpucNXLlTGdzl-eO2wLUCZgjOztrwBGxzg>
    <xme:JUk_aBHX6JEQASeECFc0Adhy5f2WDjeXyClQz01asp_Cv_hLG-cEP2PgXdbNJakea
    wOJmkN_GUt8dkaQ4A>
X-ME-Received: <xmr:JUk_aG4waUqMcs7GDE-90coafzlcHldVKC9shycvooA6iNYDywerZ7O9oHMAlWHLwHdQMTdwQWQay0mGLAyF-09F0sAW6FwIvbwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:JUk_aP3el361_U9gT2CE556YZ9p-we62HKRaKGzySLsUF65cwO_fyA>
    <xmx:JUk_aBEEgYxVNL5exOTORRWubBsf49NvSmQ0lt3Q04C-PSE1ZrBPTw>
    <xmx:JUk_aI-dKLt1slbss57_YrEMp0pPbUGd1RlAT6_uPLDHgOIXehtuxg>
    <xmx:JUk_aGkhS-IWp8D1lBc2QDtw5RhKjinsQ_a8G1JduRY9Mb-CqrfVYQ>
    <xmx:Jkk_aFP9l9Wkx5KkoG45SS8z7ipvD67j0_V0OjplbPzOQ2D5bdJl6als>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 15:12:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Seyi Kuforiji <kuforiji98@gmail.com>,  ps@pks.im,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 06/10] t/unit-tests: convert reftable table test to
 use clar
In-Reply-To: <xmqq7c1uszu6.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Jun 2025 12:33:37 -0700")
References: <20250602122559.208780-1-kuforiji98@gmail.com>
	<20250602122559.208780-7-kuforiji98@gmail.com>
	<xmqq7c1uszu6.fsf@gitster.g>
Date: Tue, 03 Jun 2025 12:12:35 -0700
Message-ID: <xmqqbjr4iqqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/Makefile b/Makefile
>> index 3cccc73073..0227fdb3e1 100644
>> --- a/Makefile
>> +++ b/Makefile
>> ...
>> @@ -3972,4 +3972,4 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>>  	$(OBJCOPY) --localize-hidden $^ $@
>>  
>>  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
>> -	$(AR) $(ARFLAGS) $@ $^
>> +	$(AR) $(ARFLAGS) $@ $^
>> \ No newline at end of file
>
> Can anybody tell, without running "make <something>", what this
> accidental and unintended change breaks?  It may be rather
> surprising ;-)

After dropping the last newline from the top-level Makefile, 

    $ make check-docs

ends like this:

    $ make check-docs
    make -C Documentation lint-docs
    make[1]: Entering directory '/home/gitster/git.git/Documentation'
        GEN lint-docs-manpages
    removed but documented: git
    removed but documented: git-add
    ...
    removed but documented: git-write-tree
    removed but documented: scalar
    removed but listed: git-add
    removed but listed: git-am
    ...
    removed but listed: git-write-tree
    removed but listed: scalar
    make[1]: *** [Makefile:504: lint-docs-manpages] Error 1
    make[1]: Leaving directory '/home/gitster/git.git/Documentation'
    make: *** [Makefile:3829: check-docs] Error 2

This is because of a cute Makefile trick used in lint-manpages
script is not written robustly enough, but that is not much less
interesting than the lesson we learn from this episode.


A more robust and traditional way to use the same Makefile trick is
to apply this patch to Documentation/lint-manpages.sh by the way.

 Documentation/lint-manpages.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/lint-manpages.sh w/Documentation/lint-manpages.sh
index a0ea572382..65758a3159 100755
--- c/Documentation/lint-manpages.sh
+++ w/Documentation/lint-manpages.sh
@@ -2,11 +2,11 @@
 
 extract_variable () {
 	(
-		cat ../Makefile
 		cat <<EOF
 print_variable:
 	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
 EOF
+		cat ../Makefile
 	) |
 	make -C .. -f - print_variable 2>/dev/null |
 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'

Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4B2E11D2
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830843; cv=none; b=r5kX+erdAmw3pscaLMMCGCuZIUOXo+uVfJtOEsjwh9YCCDh9evj/sFVnSoKietw4CA4vm5FdluBxUoVfdHP3CqWsYFs4LbGI3RPcSGsHwGs9f8UCzZljU0B5C3PvgTx5qsEXkj0gqZQcFTcObIMI+QYCoLPAXKN1VZ3wUE5I5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830843; c=relaxed/simple;
	bh=489sO9yIDDJWAJQdlHYhWiATbUfHL3u5HHY3cYKrY/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vgr4uvrRzOcggpr9BY2cv2ZzJff540CX8Tqt9Zz+gNiHUBWxcmpuq3JLRg79KlPHc4Kc5MxKUQNfhMZmYM8XmFq9MZN/cFbw5Nz7J58RprCclH6a+b2K0LX/7zpijfkuwyCph8istSpDdw7nNOwutY4g4OIkFLdfCtrGGjQoVww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OUASMPXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cGWU/waB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OUASMPXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cGWU/waB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 657BF1380396;
	Fri, 13 Jun 2025 12:07:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 13 Jun 2025 12:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749830840; x=1749917240; bh=6MgIaQrFbF
	AH8gyNKoJJF0KAeHPsHs/FFQfGgyo8O4Y=; b=OUASMPXpxLxXvySCerrDVijure
	BJ/7pqJ/ViTStMBYZc1OhJYeYP98wvaYW+vec7decnmVgmfe3SJKmwkg2C42JrIe
	LxzCVTxuPCnielfmDzRxP6lIyqk+oU5F/I9oqYo/CCVGaHvHQPLcVBR/vDsIGbID
	ys1JPZFpjn30DUGTbahZ5AbyuZ4jhIrGnxMebFV3SBDVaxVxYQLEMjxVfet6zskC
	qyOV+QGfly7M0pUpPGumyCvXSUmrVKDERkpS6jW1ODITN+4dS9fgFNwjekRxgF69
	XxH7F+19P9XmiBjhHnDMWqYRJ62gyPXP1BCgbjRjENQ7/upoLyvvlgGnUvfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749830840; x=1749917240; bh=6MgIaQrFbFAH8gyNKoJJF0KAeHPsHs/FFQf
	Ggyo8O4Y=; b=cGWU/waBFFqwm2ZIRUZEweJgk8sNK5L9hgdirjz/U3CXKlU9yk0
	+hzd2bWzdkshVBoATOa6UK3MUCpu/YTllgPnXF9NOlvT8qr3E11kmXwVS3XaSMYR
	XmmQ3ecpw93uw13zDIkWsMTVWqGf3KkeqVoB4cu1i2hK2jWfqmHjYHVM+2/E9Bdt
	GAcGNGU6gp2XY0CfaS0la4KHYp1JAVNoZVSDut0DFmWfRVJatWThhUMLTBkT84V5
	XhQCpGGEmp28rbtzg3j44J+Ldp7URGhm2pD/NtfcWLmqLTKVsuWJ+TAVawRB3PEJ
	2Y9xveVS3QLz8cUCVsAQE26zKBkM+V+rfkQ==
X-ME-Sender: <xms:uExMaKdFiLk2pqGCGLynO84XL8lJO48Nc2PqHNapI8KF-ZWUggvwIw>
    <xme:uExMaEPOg70Oeq6A06yBhAZcWIkq3yIJl5HnKaJNSwc8eC29rAGvfqeyOydSu5H6U
    B2j40_7TajN2WJ5qQ>
X-ME-Received: <xmr:uExMaLhck1MaSH1emkNiiUTAwSA9310FaXE9ds2-IsPpYhCi-9aWgAeqfhhrx87y9c-Gvu_e-fN-76k8CeY43zB4l2RgksqIijX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrggusegtohhmshhthi
    hlvgdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uExMaH82j0lxMNmvre8BmycIrvzBJhN9RUtgc9O_-6WNMxtByqEl8A>
    <xmx:uExMaGsSSJhPRCCfH7zud7wHyVcZgBfPWJ83oNI4AWjZaAMIOnW3FA>
    <xmx:uExMaOGVxtzkB9-DZZZKv-X9bp1CfVjc6d1JaCB0immq97TpVLC8uw>
    <xmx:uExMaFOIPye0Rg--2h0eUAulJI6P8YgnVI_sqNx24gtxkh7V_FetMQ>
    <xmx:uExMaPX123YFfpJHAvOMfNSr-PYA0aWf4x5w0i9D0mPEW1jPOdKXlErg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 12:07:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Brad Smith <brad@comstyle.com>,  Collin Funk
 <collin.funk1@gmail.com>
Subject: Re: build: sed portability fixes
In-Reply-To: <20250613105932.GA1995623@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jun 2025 06:59:32 -0400")
References: <xmqqplf8evr9.fsf@gitster.g>
	<20250613105932.GA1995623@coredump.intra.peff.net>
Date: Fri, 13 Jun 2025 09:07:18 -0700
Message-ID: <xmqqa56baamh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jun 12, 2025 at 10:04:58AM -0700, Junio C Hamano wrote:
>
>>  * This time with a proposed log message.  I may fast-track it down
>>    to 'master' before the release.  I personally am undecided, and I
>>    do know that I hate the style of this particular sed script and
>>    am tempted to fix it before committing, but I'll refrain from
>>    doing so before the release.
>
> The newline-less input is in v2.49.0 already, but the use of "sed -E" is
> new in the 2.50 cycle. So it probably is worth addressing before the
> release. In which case I tried to give the patch a very careful read to
> avoid any brown paper bags.

Yeah, I could split them into two patches, but I do not think it is
worth keeping one half broken for the sake of being bug-to-bug
compatible with a previous version in this case.

>> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
>> index 1047b8d11d..ad3aa59045 100755
>> --- a/GIT-VERSION-GEN
>> +++ b/GIT-VERSION-GEN
>> @@ -82,7 +82,7 @@ read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trail
>>  $(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
>>  EOF
>>  
>> -REPLACED=$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
>> +REPLACED=$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
>>  	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>>  	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>>  	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
>
> OK, makes sense since we now stick the content into the INPUT variable.
> That sometimes comes from a file, but we get it via process substitution
> with $(cat), so the shell will strip off the trailing newline there. So
> we can unconditionally add it back here. Goo.d

Yup, the commit that introduced this sprinkled the same 'printf
"%s\n" used as a better/safer version of echo, feeding a pipe'
pattern and this I think is merely a typo.

>> diff --git a/generate-configlist.sh b/generate-configlist.sh
>> index 9d2ad6165d..75c39ade20 100755
>> --- a/generate-configlist.sh
>> +++ b/generate-configlist.sh
>> @@ -13,16 +13,16 @@ print_config_list () {
>>  	cat <<EOF
>>  static const char *config_name_list[] = {
>>  EOF
>> -	sed -E '
>> -/^`?[a-zA-Z].*\..*`?::$/ {
>> +	sed -e '
>> +	/^`*[a-zA-Z].*\..*`*::$/ {
>
> OK, this is just replacing the use of "?" with "*". I think it is OK to
> be loose here, as we are parsing our own config docs.

Exactly.  Similar reasoning appears in the precursor of this patch,
i.e. https://lore.kernel.org/git/xmqqo6utfvxu.fsf@gitster.g/

> And if somebody
> did write
>
>   ```foo.bar```::
>
> it is probably OK to parse that anyway. ;)

probably ;-).

>> -d' \
>> +	d' \
>>  	    "$SOURCE_DIR"/Documentation/*config.adoc \
>> -	    "$SOURCE_DIR"/Documentation/config/*.adoc|
>> +	    "$SOURCE_DIR"/Documentation/config/*.adoc |
>
> And then this (plus the indentation above) is just non-semantic
> whitespace tidying.
>
> So the whole thing looks good to me.

Thanks.

Will fast-track.

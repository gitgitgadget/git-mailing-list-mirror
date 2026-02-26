Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023A330B2C
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139533; cv=none; b=G6MPoswkQCM0v/0C8uPlVGWViB8RTwSFjvde254dnylcs5AK7fCMftwPB8ausU+qy0+AnrK98QNdIfPPxn2kfShrwY4kP6+YHD/EzWOuFU4Cs77XVHydw7wmd5sOuy2t7z+HXTClcSuv6roKnqkxbr5eX5T6oIru0TVGbv7ottk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139533; c=relaxed/simple;
	bh=V3pNjQ91/3dZUtpNI2fDuUplrzOoi66sDV9JLscRo2c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FA6SJiKQNmStquCBv0UBzxK/5SCblhZqOmeuTeMSY5fov6hv6NlFZueToZ7cW5Prm/RjmVET3Okh7IKase2Zn3ZKiiBVJQ7FZEiK7wKYehCHLmwoMj0jm5+AZGq2u1sdjrHXQIr1mhVUZhra+37uPcehj5miywnoQ8sbzliE5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hKkcjKH2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNFbwZmW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hKkcjKH2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNFbwZmW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 442177A01DA;
	Thu, 26 Feb 2026 15:58:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 26 Feb 2026 15:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772139530; x=1772225930; bh=G1IxahwvKZ
	sFgCi6t5+U1vjf3AOZuIacX+1phqlp3eM=; b=hKkcjKH2dGTgw6Ga56QKajDecN
	BMSSjaQPynVzlsSYB/l7yCnEOW6E4ropzcjDUFJO0RxCAgiXbK3sz+zUeMxsbA6u
	jo6z3VQ8BrKHNSWihGrKy2h7Vd2NNM+OZE5+OtRAzP+Ch2ZVHtj7pR+2GYRie4t6
	0iip1HudrRDAyHMiiMgYYBrUUXw/QKMqadMTkTbcJ4xWkeTCMVGMBrz8t70xqe/8
	oON/Jfcr4d+uXBn5yDvg/abONqblcIJi7VhTRBfSx9jwPupbyEsNErMALrPJUga4
	FjxRUYxMgsM4MC/KiRRcPk8bV3CAEhMZa8vk4if0aCxGviB1RdL4BKGgbf7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772139530; x=1772225930; bh=G1IxahwvKZsFgCi6t5+U1vjf3AOZuIacX+1
	phqlp3eM=; b=PNFbwZmWUZjGHlSk9/aIf8wztlPQSStU4pDDzVGNddRibPVEQy0
	AjuZ6g1/ZnzZjAG6tBaDrhcQj0q/3XbC0xRP+oiPAzhlH+gpLn32wnsG2yzar8/d
	QxMjNdswpWDuqJxtwKXfT5HJIXrzWiVfzPylBKOah8NHE5E32JYXCUG3PEp/35Fd
	AnoA9CiPWjj6FyHWNzruDWRCiaI68jNPW4JdXWfUDImX1hykv7GbXQHIGopGw4Qj
	aaOI4p551Sr0UCttwuYnyWN0vdazpPYScmtN70muDharpxPDzlrDxvbD50MPkYCf
	rTS2SQaI3ew8AkstCsg5kqkeVCKmUiGv+3w==
X-ME-Sender: <xms:CbSgaVN6HT3VwviW6QnpzKYZPmNWSVUelND1TtEmFB-A_dtviecQbA>
    <xme:CbSgabroaDf6zeZG6L23sTUMeWsYZAJAk5yBSqgzwbGVPMY5tL6Xe5uvYEWpAg97a
    Z7PITtLAqjr2htvJacYblAJLRQLvF6SBbBofELbQ2cP9_eLXMYWBQ>
X-ME-Received: <xmr:CbSgaeGN_fh6xs1wm0fjK_ugvWcJJfr3HpsXxzdyzOq5CDwQ65EDfBlXJHymYMlA_CbhR--Uh3ffS14zP6n3YVz2eX2yFOeBwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgedutdekkeefjeffueeggfefhfeuleegfeevteejgeevvefhieekieekudfh
    uddunecuffhomhgrihhnpehsthhrvhgvtgdrtgifnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CbSgaYr-xp61ng1zBJlK5necUroEksVpvRnmekGaPw9qLfITjq0JZQ>
    <xmx:CbSgafYrGB1bqMiz8pb9SCJbHPUANJ9AjfGwvP2CuGqTU6CGAm83zQ>
    <xmx:CbSgaZXawYSVTmqidKPzaGBpB1EtOtNMjzb8xWKRA2Q1HWAWn7t3XQ>
    <xmx:CbSgaQ9mUHYyWl3SJDKdXQo-rXMVcQChxqtv-COjhK5EL8t7XsUd9A>
    <xmx:CrSgadrBBvHCeCnmHUxbAhzGFw5FtQE4V3qfmpXxOwmABR_bOnL4NYl4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:58:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 02/14] strvec: introduce `strvec_init_alloc()`
In-Reply-To: <xmqqh5r31byc.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	26 Feb 2026 12:34:03 -0800")
References: <cover.1771978829.git.me@ttaylorr.com>
	<50efbbb0fe8d897d7c4cd51489af4cb4c4c49d02.1771978829.git.me@ttaylorr.com>
	<xmqqh5r31byc.fsf@gitster.g>
Date: Thu, 26 Feb 2026 12:58:48 -0800
Message-ID: <xmqq4in3xlvb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> When the caller knows upfront how many elements will be pushed onto a
>> `strvec`, it is useful to pre-allocate enough space in the array to fit
>> that many elements (and one additional slot to store NULL, indicating
>> the end of the list.)
>>
>> Introduce `strvec_init_alloc()`, which allocates the backing array large
>> enough to hold `alloc` elements and the termination marker without
>> further reallocation.
>>
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> ---
>>  strvec.c | 7 +++++++
>>  strvec.h | 5 +++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/strvec.c b/strvec.c
>> index f8de79f5579..f7f32a53b56 100644
>> --- a/strvec.c
>> +++ b/strvec.c
>> @@ -10,6 +10,13 @@ void strvec_init(struct strvec *array)
>>  	memcpy(array, &blank, sizeof(*array));
>>  }
>>  
>> +void strvec_init_alloc(struct strvec *array, size_t alloc)
>> +{
>> +	CALLOC_ARRAY(array->v, st_add(alloc, 1));
>> +	array->nr = 0;
>> +	array->alloc = alloc + 1;
>> +}
>
> It is not satisifying that strvec_init() does *not* become a thin
> wrapper around this that says "my initial allocation is for zero
> elements", but that cannot be done easily as a strvec that begins as
> an empty one has a small optimization to avoid one-slot allocation
> only to store NULL.  So, ... OK.

Actually, we should do the same optimization if a caller explicitly
asks

	strvec_init_alloc(&array, 0);

So perhaps we could do this if we wanted to encapsulate the tricky
bits in a single place for maintainability.

 strvec.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git c/strvec.c w/strvec.c
index f8de79f557..cbe72e9411 100644
--- c/strvec.c
+++ w/strvec.c
@@ -4,10 +4,21 @@
 
 const char *empty_strvec[] = { NULL };
 
+void strvec_init_alloc(struct strvec *array, size_t alloc)
+{
+	if (!alloc) {
+		struct strvec blank = STRVEC_INIT;
+		memcpy(array, &blank, sizeof(*array));
+	} else {
+		CALLOC_ARRAY(array->v, st_add(alloc, 1));
+		array->nr = 0;
+		array->alloc = alloc + 1;
+	}
+}
+
 void strvec_init(struct strvec *array)
 {
-	struct strvec blank = STRVEC_INIT;
-	memcpy(array, &blank, sizeof(*array));
+	strvec_init(array, 0);
 }
 
 void strvec_push_nodup(struct strvec *array, char *value)

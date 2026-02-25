Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70230F94B
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052305; cv=none; b=QcEGP8tOnogQ8/wa3xAaP92Crw6OVJIS7lgoDQmXbOj5IBcDM2GviSkgsRH3C8dHzSLxaYMJAB1r9baLxJob5yWMveZhuOSZX4DNHkYOx4TKFEKH1s3gFj6MByAqk6gcKCmc2wJJEgSqSu5QgRwevmS8exQNMq9q2jEbaC36dDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052305; c=relaxed/simple;
	bh=vjEZYG6witns3XRq3FdGkvDLHbwk4KcDvQnm28BzOaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvzT1nxFd4mmRPnZbP5jDfy90wpfLoGFiyKUFSSQd25weKLGfzAojbJiMHntpwnS/dDyjvfrm4CLcJXpKvkuJhtj1RyRPeq+IV2CJmOEULrtbjbhNSfLBvzrof5l6geSh6OgyZ20+VdVpVa4Oikj0lpFvmBWZRxSLHRz5XUXBWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZZaU9yVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A28trUgR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZZaU9yVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A28trUgR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AFAB91400123;
	Wed, 25 Feb 2026 15:45:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 15:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772052303; x=1772138703; bh=6uFPs4agri
	2DYUVGnAhvoZ8dp9UROUHvDyNE/yGldHo=; b=ZZaU9yVuVYNoKhucnvi5VhKYaJ
	wNrOdOqgczPJMEdJe/OGO43WobgTZGZGtq54cBYRxq7XO+nrh8GvE68SHpWdwRIp
	aZrgq53PQBeuOM4e++mBUTEJeHOWALjamk4VDVb7yUdsrGnh62uaDCAeqDgML1RS
	zBnSUFV2+B3kNDHB90II1BMAH8jg8uPewDY4IdHERGnvjusrUcJyQsQWIbinDsVK
	TXRK89fcT+jnvoZOuDM969ptDV2ldOYHWDaMFT5080397rDhFWSIzZFan4pr1nKG
	E7KHbrFJG41SNYKZeszJuAN6/1ZeQIb11wPy9EEmMPPADUAX7I1nxORs6IUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772052303; x=1772138703; bh=6uFPs4agri2DYUVGnAhvoZ8dp9UROUHvDyN
	E/yGldHo=; b=A28trUgRdT3RHSJs+N78XOWzGWUmInxJSb4PIzHARVzAS/DA9sW
	zrLUIQffC9UoZTPnArwh+dgQc/tnoL09vPcd1FDD2xXCH+qnCwHAM00ZH0tnztdf
	d7lt6Xkji0FGuNZ6scCYHz1qYY65FX6eGCmLtwM+QPvBPteB9lStxP9WC0UajKjI
	AhJMeNQjssLFjafbotFivlUsELYUYiwdjt2uOpUjTF3Y9PGzJS9IY9uXuPa6BBO/
	n2PkGPC4wiDRhUPw0419F9gWZtuPP/2WJMeiynYRV8rlXDtKdDAvUQfWnV4Yhgh8
	l7gUZwMV8y4cBWDQZgRELRTixZEd99nuNsg==
X-ME-Sender: <xms:T1-fabaHPqOpK5Z57qI2V9o4HHVfuJWa2cTF7rQiPqmXWs7n5UOkvg>
    <xme:T1-facpQI56PNp8l1zM2UyZ3qlpB9s378wVONq67OpXwG6aMWJJR7jG91VthxrKC0
    z9eCcSs8yaWQ2cHXMiCYY3EaSFH8P5ubd_CKPW8zfGo4R0v75BnGA>
X-ME-Received: <xmr:T1-faQO-GqFPstpOFFtxmlsH0nMfu7ZuS379inhcTgr6Pa1BPsbFwB24u04kEF7Zhv0ZDcQ0hpZVNqGKckES865lOR_9Fkeu-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeguddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefgjeevuedujedvvdeigedtheffueekueetheelfefhueelgfdtffffgfet
    gedvnecuffhomhgrihhnpehgihhtrdgtihenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghtrg
    hnsehjohhnthgvshdrphgrghgvpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghr
    sehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:T1-faXoHjfInB2KEpXU4gNj-fHhROM3YmRnoGyZ_GUpMKkhKMO7xYw>
    <xmx:T1-faVef8PKI92DsVl3xmSByAUl2eQGJEr0XPhvDZsrGBPGRTQdB1Q>
    <xmx:T1-fadRhHUgQsCFDRHjmo75mO_zpeFYi-fZbCuqSXxCeFTfNxA1stw>
    <xmx:T1-faeZ6sZUGLGNegqU4pJwyOZeAVVV-J3HvZQiQAixKpsDlNa2OMQ>
    <xmx:T1-fabL-NSH8Ztx4sff-EoCzJhPnueErhxRn2RN9wClkmyu2sxuDueHt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 15:45:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  <git@vger.kernel.org>,
  <peff@peff.net>,  "D . Ben Knoble" <benknoble@gmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7 1/4] help: use list_aliases() for alias listing
In-Reply-To: <xmqq1pi9epc9.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	24 Feb 2026 14:41:58 -0800")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260218215737.1181147-1-jonatan@jontes.page>
	<20260218215737.1181147-2-jonatan@jontes.page>
	<6953f6f2-22e8-4efb-8169-395e1c52634f@intel.com>
	<xmqq1pi9epc9.fsf@gitster.g>
Date: Wed, 25 Feb 2026 12:45:01 -0800
Message-ID: <xmqq8qcga6ya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> SUMMARY: AddressSanitizer: 1453 byte(s) leaked in 37 allocation(s).
>>
>> This leak occurs because you now copy and store the value of the alias 
>> in the util element, but the call of list_aliases() in list_cmd() 
>> doesn't clean these up, since its string_list_clear passes 0 to the 
>> free_util argument.
>>
>> The following fixed it for me:
>>
>> diff --git c/git.c i/git.c
>> index 744cb6527e06..aeb099ab1162 100644
>> --- c/git.c
>> +++ i/git.c
>> @@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
>>          }
>>          for (size_t i = 0; i < list.nr; i++)
>>                  puts(list.items[i].string);
>> -       string_list_clear(&list, 0);
>> +       string_list_clear(&list, 1);
>>          return 0;
>>   }
>
> Thanks. This looks like one of the right things to do.  I checked
> all list_*() that are called from the loop in this list_cmds(), and
> list_aliases() is the only thing that uses .util member of the
> string_list_item instances.
>
> However, we need to be a bit careful with list_cmds_by_config().  It
> sorts the list accumulated so far, uses remove_duplicates() on it
> without passing free_util=1, so there is also the same kind of leak
> there, I suspect, until we adjust the call there.

FWIW, here is what I tentatively queued on top of these four
patches.  Hopefully we can have a small and final reroll for these
"Fix small issues in alias" patches and merge them down to 'next'
soonish?

Thanks.


diff --git a/git.c b/git.c
index c5fad56813..b5eb740e83 100644
--- a/git.c
+++ b/git.c
@@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
 	}
 	for (size_t i = 0; i < list.nr; i++)
 		puts(list.items[i].string);
-	string_list_clear(&list, 0);
+	string_list_clear(&list, 1);
 	return 0;
 }
 
diff --git a/help.c b/help.c
index 82fb2eaa3f..725e92a195 100644
--- a/help.c
+++ b/help.c
@@ -423,7 +423,7 @@ void list_cmds_by_config(struct string_list *list)
 		return;
 
 	string_list_sort(list);
-	string_list_remove_duplicates(list, 0);
+	string_list_remove_duplicates(list, 1);
 
 	while (*cmd_list) {
 		struct strbuf sb = STRBUF_INIT;
-- 
2.53.0-514-g5fc6f9e594


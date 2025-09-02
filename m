Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AF2DEA64
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830245; cv=none; b=camJFqMZ0R3kxRvdPhOwgF/ATOUgXyEW7y3V9HqByLPRctVyGKePwC42YH7XFYAmCai00B6oz05bUcJG3vJ7vBI2XyQugdi7kKuyouQrwTAJ7LMPuYhQfoHMtMEW3ndmWB+6BH9lIBJo0WowB8+DWWndSAn9h255pv/DXTTZG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830245; c=relaxed/simple;
	bh=gWfXD5n8bq3I84/FOMHp5DO0eZN8TC7ivbdJrmi+948=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlQYk0xxwUFNr/gmqLt50qsYkqvQJe6Y3txw0w0RtEVb8ljuC6VBapCy3n5ZVEtEU/cGMt2wvmdOqKagcStsrggkvLUp5BKKINn+ZkakgN1yZL4a0KUlixyeryvrJ1TAdwILQHLpLmWUJZKvSu2IKuAx/W7FQJbC5UkUcCwQP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=shyWDcbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZcD7FbR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="shyWDcbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZcD7FbR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 949D2EC04B4;
	Tue,  2 Sep 2025 12:24:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 02 Sep 2025 12:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756830242;
	 x=1756916642; bh=KKIhrgV/3MSY+TMKhklIpAnf6D77AlFOZwxvxCENaXM=; b=
	shyWDcbBfR+SteZQBlOMcBiohCOSfCmpDSRL+Y+fpZaOCEBesOFplnxRF3YeMXND
	oI3ITkDSs+bE7LRR80lireyMkxzyFcIWedKCMdAdvLm6t0d/6sNdOw/OedJdlDMu
	XDjyPXPb0uBb/8p3pZw5ZiXMjMmSRnwi7q9j8Hr+5D1+jkGdz5ePRgcktbmflp9r
	MmDkwJ8yOuAN3G58gcDKk6Y5w8++w5mi61we4tlnpqGEKyjgOfL+8NaffKAxNgL0
	1tv2P5yisik2Z8uUIetJOLOmWH++HYMdG4IVJYWloWgNeWS3GFga4DxSs9Gdo0/K
	hwwKTtkCWkek2UbwtxmIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756830242; x=
	1756916642; bh=KKIhrgV/3MSY+TMKhklIpAnf6D77AlFOZwxvxCENaXM=; b=n
	ZcD7FbRNezVW/6nyEKzGaZlp1/dHWkzIjSkCgSZcYAE5Gk6wk4S8HCXiH02geLYH
	q97lmSpMLiIfsBplJyCFudLZEI66nxN0m4WPeRGpKAigOuIb+f8/JsT00jvvJYrb
	xD9cNVD5TVYLsrusCF+VCRA0+L6qdCl1LdCRZ4cW6cP924tgj0ffm53gthofO4pt
	sQA9J3dbvZH/EnGD1Z8SydAd4N4rqe8eJAsDYtoFERPBxZWPGTcPgfuuBmC3mvOW
	J80mEYsrQmZn3oqTVYeF/MOSuJWCAHXfYjOgyCuUb+eauWSiM10BgZVs9XXuqIJ4
	DopI6gKvxeJp1WfGlgjUA==
X-ME-Sender: <xms:Ihq3aLRvWyBANRt-9muu3UleMXpcRgKyWL7EPTFIPnldkFdN_aXZ_Q>
    <xme:Ihq3aITaTKK9lygVdhvT-zwm6b497-HWlWaMkaQ6_7fdOy7WRFCsbjSkr6HNFDq2P
    3nGzr0kZ59tCAND7g>
X-ME-Received: <xmr:Ihq3aHTMXJaJC_IwhG_29lkzHkGW_HMpos_75hVWGZ6rU21Q8gJqKtL4jhihcpmsS18IytCk4qf4eCny0AMUO_uGXGySJc918M4W0ts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepvdfhgeeihedttdefheejieegffeiteeugeeljeeukeeuheduudeifeelhfehtdet
    necuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrd
    grvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkhihlvgeskhgvmhhithgthhgvlhhlrdgtohhmpdhrtg
    hpthhtohepihifihgvnhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ihq3aF4COa0__JglXE2Tb8JcdXI53t1f_AEqeP6h0uGxskVIP8v3rA>
    <xmx:Ihq3aL3PCrA3emG4ICFlQgEZqfpsYnx-gDsTt-GhR5SS8Pwk-1CciQ>
    <xmx:Ihq3aICJs2n8yRvr_4bXS4Ij26CJqD6gPwsEr7DOKknokdlr_QIByw>
    <xmx:Ihq3aOPMawhMu2KGrwwBXVyC5_aLHT4FHk5wM0BNq53RJSSn64Xt2g>
    <xmx:Ihq3aO8c3qdc5JVsyF_0KV3DBIHWbhEdCfiH46Bg2N7VcxTqeoia1GeI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 12:24:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  "Kyle E. Mitchell" <kyle@kemitchell.com>,  Ian
 Wienand <iwienand@redhat.com>
Subject: Re: [PATCH] doc: fix formatting of function-wrap shell alias
In-Reply-To: <2796730.mvXUDI8C0e@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
	"Mon, 01 Sep 2025 21:17:25 +0200")
References: <20250901180419.2212086-1-kyle@kemitchell.com>
	<2796730.mvXUDI8C0e@cayenne>
Date: Tue, 02 Sep 2025 09:24:00 -0700
Message-ID: <xmqqh5xklt5r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> On Monday, 1 September 2025 20:04:18 CEST Kyle E. Mitchell wrote:
>> Add a missed backtick to the end of a code segment so that it will be
>> rendered like preceding examples.
>> 
>> I deeply appreciate the thoroughness of this documentation.  I noticed
>> the formatting discrepancy reading https://git-scm.com/docs/git-config.
>> 
>> Signed-off-by: Kyle E. Mitchell <kyle@kemitchell.com>
>> ---
>>  Documentation/config/alias.adoc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/config/alias.adoc b/Documentation/config/
> alias.adoc
>> index 2c5db0ad84..95825354bf 100644
>> --- a/Documentation/config/alias.adoc
>> +++ b/Documentation/config/alias.adoc
>> @@ -38,6 +38,6 @@ it will be treated as a shell command.  For example, 
> defining
>>  ** A convenient way to deal with this is to write your script
>>     operations in an inline function that is then called with any
>>     arguments from the command-line.  For example `alias.cmd = "!c() {
>> -   echo $1 | grep $2 ; }; c" will correctly execute the prior example.
>> +   echo $1 | grep $2 ; }; c"` will correctly execute the prior example.
>>  ** Setting `GIT_TRACE=1` can help you debug the command being run for
>>     your alias.
>
> Obviously correct.

Thanks, both of you.

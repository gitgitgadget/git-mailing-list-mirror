Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFBA28A41F
	for <git@vger.kernel.org>; Wed,  7 May 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631804; cv=none; b=a2wDgVd9fYSmL/UOPMb/18zQazCN2mOZ5nSn+0onZoXvAZ1lJMsbdDREbNFuHzIeY4sNMHYDs/KNL7HhMzpnSQCznpeWsY1JhKbw6YOAtYsld1KEiXqPjj3j2MthEEtGHWz6UbUa/Rh/Q3kpwQZDZIP6cM3KFoeOfv6IQ8RbJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631804; c=relaxed/simple;
	bh=Br5YH4F0FULTVUpcWWPHUi9Oy1yRkHXGf9WgD/od44c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBg1/9jGi8LaUMbLzXy3YXvvXdZwIaW4pLu3sJKX1b4TtyAzdTw90KpBTJm4I8jHjKzl8glw2kobFH+SaUsin/Dcm5U/bGvP/aVbpQRrw4LSuxxFgs6/CSaXm/0LZbBSha6+2B61XXgi7MQMs7lfwiFFQ9FF1jRtYwjdWb4AmyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZpNqL3pT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJuVZncP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZpNqL3pT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJuVZncP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87A9E1140194;
	Wed,  7 May 2025 11:30:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 07 May 2025 11:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746631801; x=1746718201; bh=N2T5kOEosx
	s7zUrLBDU4+mwIPQW7PgwqTyuDoZzIvuU=; b=ZpNqL3pTHr5quQGkD1jeputsgY
	wu6Og6wBv2edKEiTNkTJ4Atyon/46kW2RGZjaDBb+bZoSnhyhwXAcNEjg1n6TDRx
	FRy0RrI3Np4jzUkjtbm82KBGFFlkR+6LMEN2bmx29SCITOdPwxYu/CvYVPtzdYNs
	46kKX/Ph/tnihsynpiNtzOgJb6sbIiQJgalnXdCRvJIC8Wq3dPkgehh7lfwy5TT6
	cOh+rr6eJis9oQkAzB7XRIDMTQZJuaH+buhhQTTJPNKHOTo2ygxJo8gNKoUxjPl2
	6cyZNdi39tnt7z2f7SvOr34T8oCshIteYzp/4ea2PypwXa9a8xcS9wHM4wgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746631801; x=1746718201; bh=N2T5kOEosxs7zUrLBDU4+mwIPQW7PgwqTyu
	DoZzIvuU=; b=EJuVZncP8thom5hGxMkviHEFelys5bmYiF6WLicR8Sus/xZ+ZKY
	xsOZe3/S5paOyNA6nQY+iHnfZeRocZWsnJbWJl4tv43Ihjn+7abugLseuk2mJsf+
	VZBW38AQ/56udKO9DgYAa4O7M2nTyCJkPxGZGr0jjXOQEBbMjtPS4iFnqcfA4rHU
	BEAbXbBr5zWb9NbrCXFV1kr1HtbDM4GNlxqRwwYELtYAB8cepXEyOicYfnjQ6/yY
	CXTN4ANk4J9KrybwWXsR0NQCqumOnNFdU6FGsOIzFCRplvrR0TQ7/3xORtpMxwHk
	epqVVZ5e+ud8xA2RwdYTvykONlX0v3zr+gA==
X-ME-Sender: <xms:eXwbaDQ6DIUEwjCsJ28Js-mPDqLLC64mCFYECWbZ3LhjweJSQnCbCw>
    <xme:eXwbaEycZaptYWCE4fvsxGsXDjtfa1u81CMzoatDSP8bObE5OfVPom7vNcdjlPeHz
    OBEnwIPzZkW60K7Yw>
X-ME-Received: <xmr:eXwbaI0sIM1hsBbOZog0pazLolUkYsBN1IpJztR9hkJ3tNVBQWN0BS57mLWPzv2eGEviOAtEogXqx7sfY52KGy2KNWoFgi9XXvT_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:eXwbaDASmduHUqY3kUdA9-vBsT7WBcSJxYCTZXLW9G29z5SSWDX94w>
    <xmx:eXwbaMiiB6dbFna7d9FooA01IykgGAXl4s1bt9_zYWUCuGLw4cvbJw>
    <xmx:eXwbaHqbxvsp_P1MVZVMh5wh9v3BxF-SOF3yQ89iwxjAwQIUMsdPoA>
    <xmx:eXwbaHhgVTYI8-MIalYz5jxEKtlGT91BY-kwAo3QUCsilJnknebyYw>
    <xmx:eXwbaHAx4oL9yKWI4G65NhtZXpVJxN-xUaenJSQj0PSISpq9KB_DbA3m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 11:30:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org
Subject: Re: [PATCH] t6011: fix misconversion from perl to sed
In-Reply-To: <aBroM9wh7Oo0xMU2@pks.im> (Patrick Steinhardt's message of "Wed,
	7 May 2025 06:57:23 +0200")
References: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de>
	<xmqq8qn9fj8o.fsf@gitster.g> <aBroM9wh7Oo0xMU2@pks.im>
Date: Wed, 07 May 2025 08:29:59 -0700
Message-ID: <xmqqr010e8w8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 06, 2025 at 03:48:55PM -0700, Junio C Hamano wrote:
>> No, this is not about a quiz on regexp compatibility between Perl
>> and sed.
>> 
>> Back when cdbdc6bf (t: refactor tests depending on Perl substitution
>> operator, 2025-04-03) rewrite many use of perl with sed, the general
>
> s/rewrite many use/rewrote many uses/
>
>> pattern of the original scripts were
>> 
>>     chmod +w some_read_only_file &&
>>     perl -p -e "regexp to munge" some_read_only_file >some_tmp &&
>>     mv some_tmp some_read_only_file
>> 
>> persumably because the author new replacing some_read_only_file with
>
> s/new/knew?
>
>> diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
>> index b6f3344dbf..1dd1e50d21 100755
>> --- a/t/t6011-rev-list-with-bad-commit.sh
>> +++ b/t/t6011-rev-list-with-bad-commit.sh
>> @@ -38,6 +38,7 @@ test_expect_success 'verify number of revisions' \
>>  test_expect_success 'corrupt second commit object' '
>>  	for p in .git/objects/pack/*.pack
>>  	do
>> +		chmod +w "$p" &&
>>  		sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
>>  		mv "$p.munged" "$p" ||
>>  		return 1
>
> Ok, the fix makes sense. Thanks!
>
> Patrick

Thanks for typofixes and sanity checking.



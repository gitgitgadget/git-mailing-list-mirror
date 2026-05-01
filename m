Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3411B3925
	for <git@vger.kernel.org>; Fri,  1 May 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656315; cv=none; b=GVQ5pQzmIaSeTp/p//rEIIwGxDfQ7K5bM4xmgGHKbGRl43Fxx905Y3pa0CTWgFVj/8uDoxBo7ZBQTOLpYusW81+/7jiGmqIBx8MyrJqlvYyDUvd/PV5ANRH3c9jUc42GHBQjLDeq3jb0675e5E76k5pv4GUgZAFlMF42r/ljikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656315; c=relaxed/simple;
	bh=f/Z329ru2ZW6M14qsjEo/yO8aBCvwHRzIEq5a3u8pvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/gCTfNf0zsYC1n/rXlpsouZ0nIg7AZ0KlFfSBIlNquiNNWJOJ4hc5M6pD30U+EuzMQ3w6KV6OJCQD4Eb41VDc4NmsW+2gEHA8MIv+4RoSdUkz5VpBoj/wkARiWuMXJ5pM+0gu+bleaa2apNYLJwNunHKCbNmVKgF5bqxkFiBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EcUPT6Yp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOGzZv5j; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EcUPT6Yp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOGzZv5j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DBF89EC00AD;
	Fri,  1 May 2026 13:25:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 01 May 2026 13:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777656312;
	 x=1777742712; bh=isXpDl2XxBlNzAbhHFURSdgaDAfI3I8jr8n41ys3i9s=; b=
	EcUPT6YpUbVf/OW5410upHdzJDbIh6J0B0aXvCgff4lWSIIeYFP2QUKViO9i0cXz
	e69CJWJg1ePsiRZ+QVXq0WA5bsE1ltal/ZZMVNgRhQDIC1EYuLQj6aN1U//vllFF
	IrmxlYD04P/JjK34v4Pra3qzRRhiu0cEo5Le3E8cxLvL9ogvUBkfqvxsv5pr1tFK
	g0ZEMHesAeSLu7EsRHA0MOqEFfweRiUkL8WL0R4UZ7sjYEc8G81jQOjx9b1zbojY
	MHws7CAc9YWnaH73t4CNb23f0SF5QTYbDGD8zxySi/AUnlH2v6f2mPvgDTOcK0Tc
	8Y40mLE3lTiRm21slhwn1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777656312; x=
	1777742712; bh=isXpDl2XxBlNzAbhHFURSdgaDAfI3I8jr8n41ys3i9s=; b=i
	OGzZv5jlSnlWNMq5PfAi6A3IM3bjpRV4uvAF9y77vG6IMh9APqJZV873Mj/K84GY
	2VLjTHpJ6TIlJgZVl6rHqc/64OuhaYPQbN8s8vVFbiPG7i9dT5SbdsQ6A08AF7KO
	NDRfpER1JJ4i/6iX4AHzzu41dzbpYspeTecp92Jd+br72F/8qqUKGgPSzilWqiDI
	iNm5SIMm9y6Z8JNcbxAI90E2/5Xjzc/lUBqE8vqOjpPxJXHGrcWnXAR/wjM6logw
	0K5aDQTwRsFcXk9wngtOJn/rNyGivp/dcOam+K4dCf7lHLtx0t1RnFxIV5oZpeSY
	zY6DVTsNU5noMH0QQx+KQ==
X-ME-Sender: <xms:-OH0aYuafZf1vabKGMUrOQYFJmarReivr478mEg_ScBTV6s978fZRI0>
    <xme:-OH0aW_ZGOH34joBS7dctqljM4-wXCmahefOVaAEGbxfbXDWcIyFlRN0-0VHSPZ6H
    6Vq2HYd3VXqTlduPbmCC6poC5AszqXII0lhu9nBLstuH1a1IQ4DZ8w>
X-ME-Received: <xmr:-OH0aT0LWBRLaYy5eKXLQTly0_eVeOyyKZLhbh5MjBa64WJDVo5RNtXMyIxb6_IqgPX7jIb8T_XdqBy1OZW9t7AYBndEyzfC1Dl7KWgmRsUBp6MMx_RubUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltdejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeihe
    egfedtudduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:-OH0abDwzQmxzEs0CVaDz02msQWQvMabpVRvrbW-izG0LpYj4YldUw>
    <xmx:-OH0affiZgtgwUbvBOWzKmqz509myS7kFMw-cloNPWW60tWzQlV1Gg>
    <xmx:-OH0aY7O3a8nFjytoLYcrrKBhFFWeGL6iGF97nm7U4TTn9q6Q4m8tg>
    <xmx:-OH0aSXhrwCsyFy8_8U9i74Nsy1NQLE1-1y_zYBsOzw1aRB81KbIDg>
    <xmx:-OH0adSutdy5NpeUfmmG50z9aG-LZ63A6tpDnoZkSCGgayJJCjujuTyY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 13:25:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: phillip.wood123@gmail.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/5] name-rev: factor code for sharing with a new command
Date: Fri,  1 May 2026 19:24:49 +0200
Message-ID: <20260501172450.25037-2-kristofferhaugsbakk@fastmail.com>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <8016697f-9eb7-4c75-be87-d9479186919c@gmail.com>
References: <8016697f-9eb7-4c75-be87-d9479186919c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Phillip. Thanks for taking a look.

On Thu, Apr 30, 2026, at 15:54, Phillip Wood wrote:
>>[snip]
>> @@ -524,25 +543,32 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>>   			const char *name = NULL;
>>   			char c = *(p + 1);
>>   			int p_len = p - p_start + 1;
>> +			struct object *o = NULL;
>> +			int oid_ret = 1;
>>
>>   			counter = 0;
>>
>>   			*(p + 1) = 0;
>> -			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
>> -				struct object *o =
>> -					lookup_object(the_repository, &oid);
>> +			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
>
> It would be safer to restore *(p + 1) here rather that relying on each
> case block to do it.

Yeah, I didn’t want to repeat that bookkeeping but in some iteration it
looked necessary. But it’s good that it isn’t.

>
> 			*(p + 1) = c;
>> +
>> +			switch (cmd->type) {
>> +			case NAME_REV:
>> +				if (!oid_ret)
>> +					o = lookup_object(the_repository, &oid);
>>   				if (o)
>>   					name = get_rev_name(o, &buf);
>> +				*(p + 1) = c;
>> +				if (!name)
>> +					goto start;
>
> The pre-image uses "continue" which will increment p - why the change in
> behavior?

They looked the same to me. So I will need to think about this some
more. Just a lack of C experience on my part.

Replacing the `continue` with a goto at the start of the loop was also
unnecessary. Of course the `continue` breaks out of the loop and not the
switch-block (unlike `break`).

But I didn’t break `t6120-describe.sh`. So I’ll also take a look to see
if there are any holes.

Thanks again.

>[snip]

-- 
Happy May Day

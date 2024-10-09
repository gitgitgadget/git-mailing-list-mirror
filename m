Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3315C138
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495541; cv=none; b=KY+tBSAhqKaQTHww1LgQw9HoZyN6DqGr4Ox/kLPsMJREXdLYIZ9vOOXB+fmDrOsqPJAGmkgyHfz6sXwt5qn//MAgWDho+WR+Thv3QW7Jqc6rQW06cdJtEMKqpo6DjN+6NUICp38mFydzMfP6XMtENQVUKLDyMFOHvAlS/RBC/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495541; c=relaxed/simple;
	bh=72f2UUFX3zwgPrJQrXl7KT7oc/RgRlKxhZh3yxuF6F8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ly2hvb2Bn6QBuaM++1699shPFJtQUM/nfmibwF8nfyam+Y+77RIxUuRJYk3hDLfrBb3CSHBRaXf/qVt5nj8zuaXAE0oclxydFXtWHczJW/WGD31Inl/PHhZjntPRlzb57DSbWNB6mkBDpU5sOJodYwShC2W++ZCI8phzchGdDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sqyv0oiI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EzcG/02A; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sqyv0oiI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EzcG/02A"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D42AA13800E8;
	Wed,  9 Oct 2024 13:38:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 09 Oct 2024 13:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728495538;
	 x=1728581938; bh=aZWiTLnCFEOFOCd+XB8NOGfmzQif3hU30x7bPwEXak0=; b=
	sqyv0oiIm4+KNFtyxIRnRW8xsT3Zsoejj+CbtLCIDnSpIdV3GXtDZWk3EqA+WAlS
	sk0UgEE356V/rhSfVOXhklACMMxgYv2geqb5Ivhl2aVIieyaT6ddCH4316Wq1Hr9
	zT6vNUY+c4HahLUtDze7ZB9fvp5j1X0Lt/49g/sORLqH1RI9SLJBJh8A+oZx2ctl
	SKhzyBsri8k5wdKROpdpkpelE6InOCjkOwh0ojmhD2VJidaBs20m25IUDrFvugp+
	WZVWlHlkOL2cLBwMiOkVx1bH7it6q6YOD34bWAs9NQQ0QXQW8VJcnOtGM19JwLrR
	nVCMcfsVac8PxJts6ZMSHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728495538; x=
	1728581938; bh=aZWiTLnCFEOFOCd+XB8NOGfmzQif3hU30x7bPwEXak0=; b=E
	zcG/02A8B877G8y7INDO7MEs+ZHrAHC4hid7rzPEwEFy4qshvah4LUBKqPaMi4dY
	4nsiiv/st0ZXr8BJTYg/pp9YQPOQZvWIx17WE1Ow2iiKmeqGn8FWZtv6c8JiymDM
	vkVMg68HmC8feuGYegkFvkNw2SlE7sqSTW07JioCvzrG4lxwCBZJSU/dosmvVq4A
	hCVjodYGWbOYPsJRI8HxuzsZT7sXOQ2Fg6b3uWEZsBeqxf4lS4k+ex6N7j/mr0kr
	d3vOw/c4RzgAH35EBobuzJCxu9a17jVq91urJeBFDOWmQz/XqkUPFR0G/EYwhKC7
	dFKM0c0isFoAbvo544bNQ==
X-ME-Sender: <xms:sr8GZxkwSLnaP7wDGZw4tx6FDlAUR9eJvKyThY0H0NifuxY0p1NybQ>
    <xme:sr8GZ80M9QvQnix8eqVPXDvm068B8Fw_ug8wPhmXs1a7f2uVOtdwsaY78UajvhHYY
    iMdF-336JN-BrLARA>
X-ME-Received: <xmr:sr8GZ3r5Msuv1WCHwaaxQDi6Wk0VCbWly8NjCFF9hr70SR5F1ni53dlt4-Gn3RrXSG34r8NUyjudk7k03hNOEw-IoNpFBAtLHKCz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sr8GZxlBM15PBkfi_e4X__DMkmjQ3McJXe4BUnKF4ktt2V-HUW2zmg>
    <xmx:sr8GZ_3xnhXK0hD5JS5JXd9XbwAnT5EqG3ZPoJZ6YrcyNhYKNvG0JQ>
    <xmx:sr8GZwvzOP7ddYsPiY8-bRxNqIOH7gxnOroyijWkzfKrQgUONHpJFw>
    <xmx:sr8GZzXvXHMsxnCGkRcy1UGZevSng1fLU3yLrRWvJcjkB_XiQArPXQ>
    <xmx:sr8GZ5rNdXKEdFJUiVZjB8H3h_x1L_SsmEEMpba6HhJGrqnfdbJ5hfkD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 13:38:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Eric Sunshine" <sunshine@sunshineco.com>,
  "Elijah Newren" <newren@gmail.com>,  "Phillip Wood"
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/2] doc: merge-tree: provide a commit message
In-Reply-To: <e339f796-bb9c-439f-a24c-0c5e79257379@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 09 Oct 2024 18:35:36 +0200")
References: <cover.1728298931.git.code@khaugsbakk.name>
	<cover.1728413450.git.code@khaugsbakk.name>
	<b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
	<xmqqo73uz5qg.fsf@gitster.g>
	<e339f796-bb9c-439f-a24c-0c5e79257379@app.fastmail.com>
Date: Wed, 09 Oct 2024 10:38:57 -0700
Message-ID: <xmqq5xq1uqfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>>> +       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
>>> +           -p $BRANCH1 -p $BRANCH2)
>>>         git update-ref $BRANCH1 $NEWCOMMIT
>>
>> The shell should know, after seeing $FILE_WITH_COMMIT_MESSAGE and
>> encountering the end of line, that you haven't completed telling
>> what you started telling it.  Do you need " \" at the end of the
>> line?
>
> I tried that and got an error: `-p: not found`.

Thanks for trying.  Sorry, but I think I got confused by trying it
with two "echo" (one per line).  The newline still acts as a
inter-command separator.

>> E.g.,
>>
>>         vi message.txt
>>         NEWCOMMIT=$(git comimt-tree $NEWTREE -F message.txt
>>                     -p $BRANCH1 -p $BRANCH2)
>>
>> or something like that?
>
> I’ll do that.

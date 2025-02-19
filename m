Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE92144A0
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988130; cv=none; b=BiVc2m55hE+Brp/51fdQdMzSHXO9v89A6yxF8bDRT6HJ1+Em89NoCD2gx7hocbwlt1kKnOpG7zFuCzoa2f3JMeld2bJaw14JqrPFHq80KXos7oUBrS1FAs6xposiB8uqNpFvyHBb1vknwDc3ef9XfvkudFnHaeBpRFtNIqr9tao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988130; c=relaxed/simple;
	bh=aoqCjm8xYDJhREf3hEWGXI2UI7bMjPZRacR5rpkMfB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XXMc1DGy42zygTeG3DSOOKRiJXWsVjk/vdy9wpNEiU+BH+Q1vrYjfSxJiRXvQshkOtHbpb2z96qSSmIZop2Ngl75xqne7p0ragkZmpj1GVykags8ORFzqPmfQXZOny339yTuG26Jbz/3BEPjZBvCqdR4P9rCyEH8X8SGJenZGnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVRLXILO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJTSvOfV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVRLXILO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJTSvOfV"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A7A113809B9;
	Wed, 19 Feb 2025 13:02:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 19 Feb 2025 13:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739988127; x=1740074527; bh=sD37nRdn69
	9VnNxtAbPuOPxNvttcJLBCCdTDP5yzXv8=; b=kVRLXILOT3HCdo5DfXK5AAKWfw
	4Eg0nUgA3oeglTc7R3rlq7BY6ittCBonLw3UqwaV+LLKL0h0qsfxU5KNamD8JHWc
	F/n3GCNm9k8Pu0RUHt3FE3Bbndf7YUFaXzUHOSdy/zJ5oL2Xim6l8UKhy13FCJfD
	ORdsgpG3HnCg8eIiNJlDatZvq1SUWPPHyc1iDjS+QfLENK4VsWhOjnaFanzobj1U
	fUEo1DAPRhyv4dpsFjTWFfW4pZaUTNjCikShGEZNldDV2EVnInummGO9uasGqhzi
	JRxCSazXKanAFtGgV14ARCG9sYocGIclNqxJW1uYWCrVp+krUqIfK+6lQ72w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739988127; x=1740074527; bh=sD37nRdn699VnNxtAbPuOPxNvttcJLBCCdT
	DP5yzXv8=; b=MJTSvOfVGUTglXVkdsrxP0R7sIwXeF+BK6tTZTPWLeaD8swFpYL
	JloDz2d5K8MtbONFd4MwNNv++JrZeq957FulfriHKSPHC/PLoLSIPYCfAbAVq+TL
	YpcetloWjuVUFsI/t5EQa8NpCe+rAjus3kl9r9qRtzWTuzhwjBUe2Vf46I0lArxV
	uMscpRhcVIMDza1YZzX/uzUfmAEl+vS1U5ZSqYN7OsaBxUT2TakG6zZsW6bwF6rD
	ZZjFyWOEf29XMHns9bMFtPf1ee2Q1+1N3LYwibcmoD3NJV9hhc3pvhGnGHn9wgGl
	sBvri84KipXGeknGoptVVUPwbhAiP5BUqXg==
X-ME-Sender: <xms:nxy2Z3rgCzV5t2rCkmp5ZXUKRrWSps9Bhqt50fou9XbM9ill3MaDVA>
    <xme:nxy2ZxpMKkY3XHEQgEImKdJ7Dj-SCZST07uDymhNuQuR1GXXlDo0SplCjV_drNGyL
    Z1ParpytOIGtjzpUA>
X-ME-Received: <xmr:nxy2Z0Mbuov7gEvZtPo99W-KzdFKGf9iyL3BOjoqmxE3cxhMas_rQPKgGQDzABqBO-33oA2rzzkzi4m2BKXvbWxhw_ibfSue56aMqmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhsthhigiessg
    hsfigrphdrrhhupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrgiiuhhhihhrohdrkhgrthhosehhohhtmhgrihhlrdgtohdrjhhppd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nxy2Z645YzMWAWgzagri9YkSz_fvlxX5s2XdlPgcA690wm-fXjwkUA>
    <xmx:nxy2Z26nvVPnrywunipNxSUAOTjmU3CgU5o2uvpeCaVtQiSQOSfcVw>
    <xmx:nxy2Zyi6e0oYL6JjIzBgFHQLXPAam5jctMFkV73OZIN1s2SkQgOfUQ>
    <xmx:nxy2Z47Ea5-IZnz8x9WXixZGWVfOQ_mb5xAxI1c7Ya3MswE4KG3boQ>
    <xmx:nxy2Zx0XcGuY5d72uIEI0Z_L1hVp6SsIkBei2qiZLG1aEF7EIGbNgLxI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 13:02:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Khomoutov <kostix@bswap.ru>
Cc: git@vger.kernel.org,  Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>
Subject: Re: [PATCH 1/2] Fixing file name encoding issues.
In-Reply-To: <20250219173032.x5gzw6hsvsu4flba@carbon> (Konstantin Khomoutov's
	message of "Wed, 19 Feb 2025 20:30:32 +0300")
References: <pull.1886.git.git.1739918546.gitgitgadget@gmail.com>
	<d33fb3d940cf97bdfe3dc544763a51df4874a5c0.1739918546.git.gitgitgadget@gmail.com>
	<20250219173032.x5gzw6hsvsu4flba@carbon>
Date: Wed, 19 Feb 2025 10:02:05 -0800
Message-ID: <xmqqmsehg6ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Khomoutov <kostix@bswap.ru> writes:

> On Tue, Feb 18, 2025 at 10:42:25PM +0000, Kazuhiro Kato via GitGitGadget wrote:
>
> [...]
>> diff --git a/gitk-git/gitk b/gitk-git/gitk
>> index 47a7c1d29c4..88951ed2384 100755
>> --- a/gitk-git/gitk
>> +++ b/gitk-git/gitk
>> @@ -12379,6 +12379,7 @@ catch {
>>  if {$gitencoding == ""} {
>>      set gitencoding "utf-8"
>>  }
>> +encoding system utf-8
>>  set tclencoding [tcl_encoding $gitencoding]
>>  if {$tclencoding == {}} {
>>      puts stderr "Warning: encoding $gitencoding is not supported by Tcl/Tk"
>
> I'm not sure one should sensibly do this - except to implement some
> well-understood and well-documented kludge, simply because the "system
> encoding" is supposed to be set by the Tcl runtime.
> ...
> In other words, your patch (supposedly) works on UTF-8-based systems
> which is common to Linux-based OSes and MacOS, but I'm afraid it won't work on
> Windows.

In other words, things should work without "encoding system blah"
forcing a particular encoding that Tcl may not agree with?  Would
this mean perhaps in a "curious" repository with paths encoded in
something Tcl does not expect to be used (e.g., on a UTF-8 system
somehow EUC-jp is used for paths containing Japanese characters), it
needs to be possible to specify a "curious" encoding either with an
end-user on-demand action (e.g., menu items) or with an repository
configuration (e.g., gitk.pathencoding = euc-jp)?

Thanks.

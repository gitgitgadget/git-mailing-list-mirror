Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC2245014
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200652; cv=none; b=GGHTgs3AIeW0Hy/Kg6tbJtFXwvZNLtiAnX7bNQL+pnl7ptOdr5ZvyC8irPRzrIbBo177WXJA/Nrbt6N3g1DITyuLOByh6kQVqsWiNh4l8MPDkQNX7FOmDM8FrIOJsPXgbCNwQwrcMs7DMhGmbZImar0FvemEvHwaZcFaHiDZ44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200652; c=relaxed/simple;
	bh=p9J2iCnQ8nPwKTRD8XcHztVsCspiDa9DJe21PPwBUFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0NAxYGIi02L7+5qwSnXhF/OyMSnMcD9+r+MdgnQZH7xt2e5OLkD/glPHbK6NsW+heeXBBxId0QjlxiNKjlAqtYaes+353aYoHr+8ye6cFIX/hQ8n5vJ+7yROA4b38VcjEdi4HKxAR+0bSKX/v+YwNHsZuhEOy3WX3Ej7gS3FFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XIm9cS5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZEkqtnl3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XIm9cS5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEkqtnl3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5184C7A0470;
	Mon,  3 Nov 2025 15:10:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 03 Nov 2025 15:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762200649; x=1762287049; bh=VXqtwK3HLQ
	cEcZppjjSS8xp1P5enBkPBPSBVPogfCKs=; b=XIm9cS5I8eOtXra1QXYImzp5Qm
	f0WjAUjdiy1zpR3lGkoZjfvq8kC9JdbCwrC3/8AKBJG5mEfqB27SWw2kVaOE213d
	g2HH3qeHF8bQBnI3BjKS6CWd1XbeK/V2yzQMccNr9hDgGVnKjqppRg3Z+0lghIKg
	IDzWqCBmP7T9Ey+BT0rsgOjPeivdGyQdU3ubhO0XDx7hX4m2zoowqnOVxyyJypnK
	gV0AdJxcO7tIRd94YwbpR1TixP0DZ9KgC83N+ZolvHc/bawqQJIU9nCkb2wSfmtv
	quSrxzO//se98yoPb4Fyqi6e/mAhZMKOz3OzYjJsLWzb7277ZxNS5QUwCCsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762200649; x=1762287049; bh=VXqtwK3HLQcEcZppjjSS8xp1P5enBkPBPSB
	VPogfCKs=; b=ZEkqtnl3CrjcxqxG0qBalOhrxRGzTv2jkfIQ4P3ciXKouAJwz9v
	O7BIlVtn9w0sTSbeY+NLK8hmzYO8zxUkzqPLZIt7hQpi6otdQi+SGwBaEEKYwmwm
	G3pwsYaEojwwxu4PzNtqTXmSIUDQSw2scWXhWxtgs3BJsogAKK7uVZwvV66z2rmM
	3mf2X8OjwE/1OnlVm4UYM3j4qz0fVDfnKGIXM74EJB/mMPvhDkNsGDdjFFITp8tY
	xVQvfQb8bDmm1RPzJWeHDwx10JY09LQ5lDuSDjCjCSjrCmYjibno3pdK7Ct7beUM
	HP5OfavZ8+HGPhPhwkF5+ypjtlSkf3FjSfg==
X-ME-Sender: <xms:SAwJaeGdyav8fetvs-8OzxDupa3zV8TswzH4OZXNDZujE9gEACx24A>
    <xme:SAwJaWxW7qMzlMLBnbDvUd9VJTGFIdQAoYBk8iWDmYhzRDeewdIKU6hHFAcEXxZZt
    CLqTNLDqEhnOJpnhyOeCyqlCHwv8bXVXlK8MYghrysc6DiLqJ6hNg>
X-ME-Received: <xmr:SAwJaVjcLXYN3_BLQqUBeCLi8K8lA1JNgZsmAap0koaFX5zo2dvoHVtadCQFHvWJcH8Rj-gw1CRSS6aLaSAChOHP7T23_ntDWoQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:SAwJaRxlaN-C8Q164PQ-lCxjKvgmSVEEcwOPoraHx-cy8RwKV7QD4w>
    <xmx:SQwJaYKwe9IpCV2gra0zWGrTkIGAvreJKA8I64t2j17kaPxCmbJzcw>
    <xmx:SQwJaYR0qD3pmSau55QiIuFM1nyYkyrVhVNpI78WPRw7YO7tX-zckg>
    <xmx:SQwJaQo-6-icxAXHNmJcIr2lbLhN8mqa8kqTEwYIUBhGkoyyzQJ5_g>
    <xmx:SQwJaW5qERgE2BLowo_AahyUE8_n_9pazPmL9Xo3rElS4iZXdaSbOu3f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 15:10:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
In-Reply-To: <xmqqh5vbt0sf.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Nov 2025 10:43:12 -0800")
References: <xmqqpla43wcp.fsf@gitster.g> <aQRaRuBtt_r7SamL@pks.im>
	<xmqqo6pjt2wn.fsf@gitster.g> <xmqqh5vbt0sf.fsf@gitster.g>
Date: Mon, 03 Nov 2025 12:10:47 -0800
Message-ID: <xmqq7bw6ubaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Bisect points at 054f5f45 (ref-filter: parse objects on demand,
> 2025-10-23), which is unfortunate, as that is the motivating step of
> the whole topic.

Here is a fairly simple reproduction.  It appears that this does not
require the refs to be packed (i.e., "t7004-tag.sh -i -v" fails
after saying "*** Loose ***" here, without moving to the packed
test).

 t/t7004-tag.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git c/t/t7004-tag.sh w/t/t7004-tag.sh
index 10835631ca..7216a8d21c 100755
--- c/t/t7004-tag.sh
+++ w/t/t7004-tag.sh
@@ -2332,4 +2332,25 @@ test_expect_success 'If tag cannot be created then tag message file is not unlin
 	test_path_exists .git/TAG_EDITMSG
 '
 
+test_expect_success 'annotated tag version sort' '
+	git tag -a -m "sample 1.0" vsample-1.0 &&
+	git tag -a -m "sample 2.0" vsample-2.0 &&
+	git tag -a -m "sample 10.0" vsample-10.0 &&
+	cat >expect <<-EOF &&
+	vsample-1.0
+	vsample-2.0
+	vsample-10.0
+	EOF
+
+	echo "*** Loose ***" &&
+	git tag --list --sort=version:tag vsample-\* >actual &&
+	test_cmp expect actual &&
+
+	echo "*** Packed ***" &&
+	git pack-refs --all &&
+	git tag --list --sort=version:tag vsample-\* &&
+	test_cmp expect actual
+'
+
+
 test_done

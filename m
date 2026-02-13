Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425C26AC3
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002131; cv=none; b=PQYTY88ILNq13Mje0/Tok8uuHMoYI9pe3wF/NV3R9XHSfSPQuTCg97LBBBLyz3QZ15eY9S+QMCPDbUNjUwpq81+/eAT0A0jktCS0gvd1p2md8L+SHhpWT3gyYvVt9W0Ty/CBv4mQolDf7h9h95s8TIOAyFhKbDdkkoaYJe7FHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002131; c=relaxed/simple;
	bh=a65SIPxK/qF2EUQzuRzNIaxvZaTS2g1hBg4SLkjVGug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FD1ujCb1QTlmZeQjld4Tqs/C/U+azg89he6qyJR7D/yrlwngx3cnWqe9iZ5UALSxRBKkMtbsFHo+gKS6jK3sMCpBNuqZirq1y8ZZ8df6hxO9VPl7g9c31IxsLTW/bZFqYwuXE7jzzfIzV6SgPkKgqKgU0w+DDp+S2nMeI10lo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L0zAgBAO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ql2D0aEh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L0zAgBAO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ql2D0aEh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BD53B1D00015;
	Fri, 13 Feb 2026 12:02:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 13 Feb 2026 12:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771002129; x=1771088529; bh=szGUf6JlTf
	VZVtlQBGscAjhLBc2H+A/Zp1ZcRW2rE0o=; b=L0zAgBAOEqC3Zv578EcAUKl08j
	VAg/O4oA4v4QpRo8dB6yvbwQX3EehvWsVjVmunPO2lQeUpB8qckTutnXwl0CFiBx
	EBKQszo7hGBUhUsbxbHUDFLQnnYKYcCZqaOLHcn1ca61+OIRWm0sRnLLIW6hnYka
	PMWpa81I2vGktP0C2mooLQhQDjBJGyQ3FugdwiTfIdlV1aKXZrQhnJDgpgYOpxkB
	QrpDWcx0cAeyUKtI2k7t8XbEinH4tPJQ1N1kuRVZXVHkvHPnNqEm2JZHVJgw0A1+
	yXsNkMaccRb3UTTZ72hdwrHtUnCKHAaZnNgctj+AF7P4vlShMAOSqbvXSN8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771002129; x=1771088529; bh=szGUf6JlTfVZVtlQBGscAjhLBc2H+A/Zp1Z
	cRW2rE0o=; b=Ql2D0aEhsQTS1N7F9jiFH22EUHZufYhl6zHb4M+kpiuugtH1V0R
	av3J8pOjGq/QnvR1O5gz2ZJomV8yiPWjV0azANx102VIEMwJHIp1uPICUQ0bvBsB
	OzMIJ5twkatyNvxHcoxp59JnBHLu/WxD2Qy3C0zRhDfmywZzoaDA1vHlfGdsA+ch
	h99sp+Kefsgm6xJt1kG1328E10N4zk0Ox8O066LW6lmjyyrOm0HIfzd1Lhypa0Qs
	iSf5/wmxO51BbfV7cBUPXkJX0k1unb0qFC/06d6h28hdJ3xl7IJXxUfaTTrNFCbo
	vAoJpVUDqOE8nEtexelEU2lHClK9ICMexZg==
X-ME-Sender: <xms:EVmPaT82DO6Z3zELZqnnPZ3YDEKYQBlH8GHfjSfB1p8pW4nA0ER9OQ>
    <xme:EVmPaXKq1anBIX3djKRywpJyKlGGkrKLr4otvMw7ie7DejlU9TLRrkc2gqCOrOkJC
    xVodPLhy2aez1166gQCHMSI0SYgPiaz70TGe1PY0_lNsXqXX1oX1A>
X-ME-Received: <xmr:EVmPaeYGsng6I0NjE0Yh59patUbHrL1Glv7vyqwjsApr8u7L7q7CKyDxH_IrV5numM6mnbXdvqINGpq34wj036MelMnTDFz3fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:EVmPaZIX0g5StJKqv57Bf-a3HoUwb1EBdrJLWJUjQz_sO_wJFGGO2A>
    <xmx:EVmPacCwmtHNm_WoqO_kzzipKNvkdLE4jAa4AaV365grusidva8H-g>
    <xmx:EVmPaepCO7WRgss3TAbeBBYOSRVYOG85F9IaEEuyVGYxPyBSfVJhsA>
    <xmx:EVmPaXjD5HH0HM5XCkD6BkRVHEjQZwDnyIXUWCUns74cZdVejbLb8Q>
    <xmx:EVmPaXQ5wan8V3lSfI5p1tXUi3xD8cAwJrpsUUfRgzPOiPkc7Wrxc62S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:02:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] builtin/history: perform revwalk checks before
 asking for user input
In-Reply-To: <aY67ycgnisRjeguw@pks.im> (Patrick Steinhardt's message of "Fri,
	13 Feb 2026 06:51:05 +0100")
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
	<20260212-b4-pks-history-dry-run-v1-1-1ce03d631c1b@pks.im>
	<xmqqcy29ohi5.fsf@gitster.g> <aY67ycgnisRjeguw@pks.im>
Date: Fri, 13 Feb 2026 09:02:07 -0800
Message-ID: <xmqq1pioo9v4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 12, 2026 at 12:04:50PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
>> > index 3594421b68..6775ed62f9 100755
>> > --- a/t/t3451-history-reword.sh
>> > +++ b/t/t3451-history-reword.sh
>> > @@ -263,7 +263,7 @@ test_expect_success '--ref-action=head updates only HEAD' '
>> >  
>> >  		# When told to update HEAD, only, the command will refuse to
>> >  		# rewrite commits that are not an ancestor of HEAD.
>> > -		test_must_fail git history reword --ref-action=head theirs 2>err &&
>> > +		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
>> >  		test_grep "rewritten commit must be an ancestor of HEAD" err &&
>> 
>> This ensures that the editor is never consulted?  How?  Running the
>> "false" editor would give us a different error, like "your editor
>> exited with non-zero status, telling us to abort" or something?
>
> Yup, exactly that. We'd see "Aborting commit as launching the editor
> failed." instead of the above error message.

I see at least two people wondered during the review, so perhaps

 		# When told to update HEAD, only, the command will refuse to
 		# rewrite commits that are not an ancestor of HEAD.
-		test_must_fail git history reword --ref-action=head theirs 2>err &&
+		# Use the "false" editor that shows a different error when run
+		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
  		test_grep "rewritten commit must be an ancestor of HEAD" err &&

would help future readers.  Or it might be too much.

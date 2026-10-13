Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DC3BBFD0
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908410; cv=none; b=YMoufGx/G55EZ+NejC/I3eCduIVHCfMRjlBMubrFItyu0+39a9GgjkTt5twJTgOd15eDyH0xHR3NG3ocxU0XuQiugt9NXEVQrM+cZYFOQ9VRKMAUfa041pn+LT5aDrBIKSAiG/RvkPhiiKdE6baAeEufkmxoXWzrpSHuqqOqERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908410; c=relaxed/simple;
	bh=RWMo2AiELDumuje0Neqw+sk03E31e5HldXKErn5CuEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BI6RBjTg1goWBO89aRvodAoOz2F1E6oRJYDGES8H0272r7vLq8Th2mtGtzgTtuWXfC4N9spzKbceWnWsZyAc14cgmnNwrbQ2sFGBREY9hRbszJIGcstUbF0nIAj3WrNo6e/vrKJImDzcI2lsCTCS5MKUbpHYz45+jopfBuzBXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YDoownMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sX6jKdG/; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YDoownMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sX6jKdG/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id AB6FC1D0011A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:20:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 13 Oct 2026 12:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791908407; x=1791994807; bh=Hte172Pfaw
	R43Y935SuJ2B44CaLHQkQixZLSzbeYhJI=; b=YDoownMH/QREDzBTBMmXzO6TCl
	WSG8ozDsYlFKo0ezWn4+lfTpkS+dZjWMbks6fsVn9rwddXBgHGY50T2fDQd3h8cG
	g9UkE5pGdPKsMRewVwZUZB8yT9IQPHF5NLhj7CR22V3iLHYoJgHjouXspyylDur9
	WU1fZb+CWavNsM0zFPHubmlJCzDw8J8yS0b6k5awLau60GX7aPNQ2DQfxQKV1kUC
	BoJNUWXXbuCwWcnMl0a3LdvEeWvi9JDds+APIpw7eDu5xKKxGiAIfPI5TZUkvVCh
	BAJzb4r3dx3I0H/cfLvWA+rPPgn9UgDkyKWg/un3w0jtAZdyKpaVhBkK+l0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791908407; x=1791994807; bh=Hte172PfawR43Y935SuJ2B44CaLHQkQixZL
	SzbeYhJI=; b=sX6jKdG/DGT1RbB3mjoDSidn243nJQjZgdmfUt920WmUVmLOOc/
	k74jYVzfl4bZIeV3ChL/R81KoomiiokXSfAF3NT8jev5ha0B/aU00D/7E1O2TEdM
	C7O0jMryUF3mT+XApLWDLngFNdJ0Fjt9MjSV3HK1qQAPXl1DzKogD7tLRv0awWTe
	+9uL6WwK+VJppmEcFysM27aAoULWLjc7Oy7ULoNsW/2bHdocGR90bSXSSy9cimKk
	L6Vye7HC4m2wfzZ2ciKXVddubG9Eensrl3+15lN+oowo57dbirN23L7stzJSuKqU
	fOoY9Mdl6mONYYvBYShdq/rSWUEeiaF+Rlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791908407; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kMcb5dZAsA8h0lF53wBiOfZGRRljWCQ+jSra6+zEy/1c2bu
	dTcQmSugWSRDuuk5IWJE+PhPrjoqL8z3jAhsroprCkJG9nnNZpBGeRHejwysp64s
	z20jEiuGx69zozWyARfHfLJ4DwWXj/BLdWE7S3Zv3wYVdRirK/qt0bdW0aP8T057
	Nr3cnJBvB1gtNqUsZce7WHsrDo/l+vTCJSDdZSoTBG+INbjRbA8U4wuU/e3wGO8W
	aktYly+cJk+AKeOEluWOzbmtJz5ORovPyoMtpVOb0G5Ejma9JjPgnK3JHqzUWnap
	EUQeY1gMPgAJiKreDgqQ9waFYqDN99m4IpG18Cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WIKyQZQXXtAOP7EKo7JWXhG/4GA2qW5I3B/mj1gi9a8=:RWMo2AiELDumuje0Neqw+sk03E31e5HldXKErn5CuEc=;
X-ME-Sender: <xms:NlrOag9sApF5_-5-5A8NP3EVfqQDDmr-dvJ3Ysvk6oMYDQqi_sAG6g>
    <xme:NlrOapbqoBlmVJcbmM4KSRSWd60EjvBUxjJ4OEfueqWB32gpQ0CW2roXr6u5TXhvx
    baG3lovN2fMrXF-bY5vHCADi1-DJzAFirbs68DrEFouIc5dNtap5uLL>
X-ME-Received: <xmr:NlrOakN6Qxozf1UGCGVJq--lPL-PEXRKzhSVTuUCcZNyQNkAr_7Ap_0XatuqKIe-yGE6WQVbt-qrI0B-G2raMjstSpH-i9RETe21>
X-ME-Proxy-Cause: dmFkZTEa+NAzsrbxshbLd1dA0wyFymgFs1Aw/OT2QuAHCOcjZYUgObnyawob87DtRyUcsz
    yMSEqVTRf8C020myenyRDc4nL4Wmkb+P4kv73vBFEVn1+sZdi2Co6VQnjssr+fy+uOIoOS
    peTs0SG0KU6OWqcbW2ktO/rvQeAZ8Qhxv2v/g8zxDKcqffkeB0RGTQhZ0RnFBMH+qLZ54i
    Vd2U6br6aiXW4bZQwkRSgZvs9BxuOo6RSpWBmU453BhVhy5oO4o9ZFEQsfziU9edEpha3F
    9lIFuHoWss3VSRZO+dI+FWQqOD3z1RkLLjKMzorqsf9GquHP8/oGzpiO9fPrnW4LtfhBXT
    xoSQ8Xo3JocHL7E+1EIQkcPZ6pCL7bJzER5rUUuusXWDQRYYEGu62kgOj+jFNY4HakhMPb
    3T4vlLnOfONkTBAQcY0pdtm0NswD0MrHXxlCRxbWdEBmKO/A9OzmmaCMuOjHwsATH337Cu
    oMRdiBNdUIk5xFu2MfaV6mfWai2GL8J/9SRazpDsuaBfDOsFNTm9UFKzIGyKunVHsPsZob
    /4IJz99Iddb7d8APFTkvHCK8KcmYERZZ8JwYFJxSwreeITKZDvseSP7dG9KoJe8Lo8I5Lt
    FmGGserIAyyP4N+hDhswszOW1CX4nMmtgbr+C/0I1ysC3+TGWAOOOkeTWI9A
X-ME-Proxy: <xmx:NlrOalCgpPANO74e2hTlW_VSv7sWwou_Bugrivx5pe2rmDklC-YTCQ>
    <xmx:NlrOarJ9uvuA602RwMKr0R_pxrp8EkAZQt9sJ1uNK5IuTMgNME2m1Q>
    <xmx:NlrOauNr1oV4CUMy5qIccFdYnw6xgx8Cu8BnVzPZ6_klLq9C_sBChg>
    <xmx:NlrOap6fCoRtFxphFg2FDS2lsA7yVqSGV_nClTUGpmYgcO3Wk525EQ>
    <xmx:N1rOam5eZ7H8hQsba3A3yyMD9A4QahSvSpn2wX869FicwRZqzk1yqW9T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 12:20:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v8 0/2] rerere: wait for MERGE_RR.lock, but not in auto
 maintenance
In-Reply-To: <as4ikRUi0NZv_jKr@pks.im> (Patrick Steinhardt's message of "Tue,
	13 Oct 2026 14:22:41 +0200")
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v8.git.1791893274.gitgitgadget@gmail.com>
	<as4ikRUi0NZv_jKr@pks.im>
Date: Tue, 13 Oct 2026 09:20:04 -0700
Message-ID: <xmqqy0c1zi6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 13, 2026 at 12:07:51PM +0000, Thomas Bachem via GitGitGadget wrote:
>> Changes since v7:
>> 
>>  * The rerere.lockTimeout entry no longer says that the command fails when
>>    the time is up (Junio).
>> 
>>  * The lock tests grep for the "Unable to create" message about
>>    MERGE_RR.lock (Junio).
>> 
>>  * The wait for the background unlocker is now in test_when_finished
>>    (Junio).
>> 
>>  * The rebase --abort test aborts its rebase in test_when_finished, so a
>>    failed check cannot break later tests.
>> 
>>  * The test "merge fails once rerere.lockTimeout is up" never waits, so it
>>    is now called "merge fails on a lock it cannot take".
>> 
>>  * In patch 2, rerere_gc() takes RERERE_NOWAIT again instead of its own enum
>>    rerere_gc_flags (Patrick).
>> 
>>  * The comment about waiting in setup_rerere() now says "by default", and as
>>    in patch 1 it sits directly above the call that takes the lock.
>> 
>>  * A comment in t7900 says why the tests with a held lock create rr-cache.
>
> I think this is in a good enough state by now. Thanks!

OK, thanks for writing and reviewing.  Shall we mark the topic ready
for 'next' now?

Thanks.

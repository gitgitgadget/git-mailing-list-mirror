Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBBA4D9545
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353491; cv=none; b=tGWCVonX9sK0ZfFjF3ggKimApSUruPEGSWC1OUaMYWbon7xN99iMWRUdO/SrY0iHhYvB5MWJJUUkVv/h67xapdRAhHvFrJxwiJmESZv9Q06oJKMiWktrtS3rvjRuodPIAovadlD1RR5e4IChz2UGrMNq9xEaFT+e/MxXpWmWHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353491; c=relaxed/simple;
	bh=qo7YXgxF3LD9MNzD7m3XiThZuZxI6wf6D+iFmlFkrwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FWFyajm8mGBYtZQtr/g7+MaUU5UrRgNmq7j96h8e9yVw3aR9SIL/hVDn0Lvgft0Kw38hfRK5DRJ/2TsHoe1Dt3hLH4Lqy3fPlaS+AS2A6xDeLa/+mbQPQkMmwb9nfWAPy613/42ZLV2bbw0GzIf6Ov5k2niy5zEzw3U5lFJ4/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JSFdmUR0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ViFL7lwF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JSFdmUR0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViFL7lwF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0F8D1400173;
	Fri, 25 Sep 2026 12:24:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 12:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790353488;
	 x=1790439888; bh=QIhCOBOz6L5k9e2XUxlWnzx/rCNboVlAy54KgVSwo6o=; b=
	JSFdmUR0oJfKIT6FlZSZGtUYRmuc73HJoOkd5PVQ62E/WfOgXpHSjAinbGeMHh3S
	/z98j0UsgUoh7aeYuDTCfEm0gs0HvRkix5YnwQtVGKZZbzvTF3Ipwy71GUyOkVzD
	0RAe1yxH3+dyc1X4mXmsSNwd5lkwzmObPxhL+lh/WOMMBQMoSCcJp5RczNX0URXR
	psCoczopc1aUHJMKMywC3Vk8T5pKJTsdqYOqsnWlAsNT0Sc9SQ5QEbfqnaE8OmrR
	ZcEVD/vrAuGvRoHR16HSCvaAao171wnxQ7ygVd+JOYutMbojD+NFHfuTdIuDz+5F
	EWhLtfBU4i4VZDexR6nTkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790353488; x=
	1790439888; bh=QIhCOBOz6L5k9e2XUxlWnzx/rCNboVlAy54KgVSwo6o=; b=V
	iFL7lwF/t4xOXWKrc0JAuXYSr0oL3Sb+XDzMlon6hAZR6UvGRdz4kyEoSqehnkKB
	+v5V3Ni45k9DrdCQetI1IS7ptoA4axoSH4ogm81y6BJg9/uWXrpFH73FpRVw4AaG
	XHhh1s0svm+RhzBaUoHLP2p/SeArYtTfj258bF7/eqlRxiisuPGzZy5QAz29nVmH
	knltOn32xqrtx/srxmiJNFvDXzP+FpnbnDgOL0NBWfqZLfD70vleso0i+f95KsHA
	rgWEw0LDWXl9+wl2qffeFejE5E4nuUVQ6GPJEXNSwa410gLmUrJXwpDwCI9Hvvpt
	uMNhu+hZdEf7yM60Lzbcg==
X-ME-Sender: <xms:T6C2aoudjJCmj1uT8whDlihV1q-Qc1ecioF7BdGpLUA0MKyjk_AnJw>
    <xme:T6C2ar-V-wx1F28TBPxqztxE215XkKeuMz84Ye3QiZRPl5pcHVxW5_eXq7VeG_J7j
    sLGx-dL46yMD13Ewp7zh4lVURciBVaEMg7PWoj4oIh8Usluig1j6g>
X-ME-Received: <xmr:T6C2ahxnptZ74ZMIXCCBQIHyYF2JdrUY3f1l8X-5doRR_KFRFwc-NK4vTSWeca3y5wwVF49eILURvSrkza6bz7Kz5WaoJdnmjEr6>
X-ME-Proxy-Cause: dmFkZTEb2eVJ9fDLN6mrirmpqn4OHq4GB9uI0/ji3zUVV9d8tPRZWQctI0pF5/76ejr83h
    d+5HHHcf4N+OX6ZpGE3yTSp/LUz8PLgLejJkofihZMoRQgNAAH3OIQbJQyWqJsYNrB0TWV
    ulTzcLluTZg/DtivBLAdRS/Djzv3BCiknAd4wQqFt4P4kCLO/BzOC02PvrcE1i0O4r6ifk
    LBzQgvPbv1IvzBBpJim5r8Nq9duITH3my13VhkkJ+SJmx2V6AKP8Pqa0gGVF5Y81qWjpST
    1W0VzYj1o6j7XnOTyNHjaj0lrUldZx0hU5ZnGLDo3LEL75zXUeD3LyaA8JEf7iKPcBIZgD
    WLvQJXdRZzQ3SCa6cp2h9p/JFvsKYztf/RLlWhjzOuoo3CGIl4rr/5KSMTR6W8tbu4o/vm
    QaLAA4NpWZhLRc7C/1CuaUO3palXi1xvGtsfc/fKaYhfc4Ya6J5dn3f0OsfRw1cMq0f0h6
    5ZlvQ7QmdsrMesIyojw26mivIHcjdFY8YKZrbATT5JXkGqKUxRtRT7JI9VHfme1v2WdHbP
    piCmu5gn01eNpMWaLhRr7R/5f/cFxDHHfIA8DfOkQw6PDIQyGREINtPZ7D7XnhUmONOGh9
    5i9Sw1p0uHiFH/O6RlEUl+0WyoAiBWNonJeedrhAWYd1lBXAdbqtR30CXtNw
X-ME-Proxy: <xmx:T6C2at9a90jiE7vnkTXrN5ytNTmiSgDXflMJa8PlRKxW50SYFgjuJw>
    <xmx:T6C2avPtd-6lWHnLgAyLMmye8hVVg6i7ILBO8LDn7zRToxbQnjH3Lw>
    <xmx:T6C2atqVovxFQvP1g-9LYWssMb_sS_6AZzsEdIg_AGSSVKSq1dXN1g>
    <xmx:T6C2am73SpxGX864YYTJYypCsrxBOg01XZEvHH340Xs7qLkfExGwhQ>
    <xmx:UKC2ahEaIgjSKj4Q0tD1qvvmGTm-ypOn3MLzezp_2DpB3Sjs3FbtOS8P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 12:24:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>,  Adam Johnson <me@adamj.eu>,  Victoria Dye
 <vdye@github.com>,  Jeff King <peff@peff.net>,  Derrick Stolee
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
In-Reply-To: <CALnO6CBhoBcVjLXidvii+o_Ump_k9disW177LeSS0118t3oGKg@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 25 Sep 2026 09:00:51 -0400")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<cover.1790168285.git.ben.knoble@gmail.com>
	<e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
	<xmqqse2yz4y4.fsf@gitster.g>
	<CALnO6CBhoBcVjLXidvii+o_Ump_k9disW177LeSS0118t3oGKg@mail.gmail.com>
Date: Fri, 25 Sep 2026 09:24:45 -0700
Message-ID: <xmqqpky1wb76.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Sep 24, 2026 at 5:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Ahh, or perhaps the trees are indeed given in a wrong order, but not
>> in a random wrong order.  merge_ort_nonrecursive(), which is *not*
>> the function you are using, takes head, merge, and merge_base in
>> this order, and that order matches what you wrote.
>>
>> Perhaps the true culprit in this confusion is that the order in
>> which merge_ort_nonrecursive() takes its three trees (head, merge,
>> and common) and the order in which merge_incore_nonrecursive() takes
>> its trees (merge_base, side1, and side2) are different, and if we
>> fix them to match, it would make it easier to work with?
>
> Indeed, the confusion is that simple ;) Shamefully, we don't have
> enough test coverage to catch that regression, so I'm very glad indeed
> you spotted it.
>
>> The new test in the attached patch will fail with this step but if
>> we revert the changes to builtin/stash.c in this step, it passes.
>
> Any objection to me adding this test as a preparatory patch? There's
> no sign-off, so I don't want to mess up the DCO here.

It was written merely as an illustration and is not something I am
proud of.  For example, creating a totally new playpen repository
only for a single piece of test and remove the entire thing when the
single test piece is done was done only to make sure the existing
test that come later can never be affected.  Also the test only uses
the most trivial case (a file is added in the stashed change, nobody
else involved in the stash application has touched the file so there
is nothing to "merge" in the file).  It was enough to demonstrate
that the order of arguments given to the function was wrong, but
we wouldn't catch problems in content-level merge with such a test.

So, I wouldn't mind if you reused that as one in a series of tests,
but I'd prefer to see those who are move invested in the topic to
come up with a bit more realistic scenario.

Thanks.

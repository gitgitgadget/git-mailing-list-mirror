Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB222157B
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734656; cv=none; b=hV8W/vP6VpUsQkVA4u+tlYiVGKSlen7YqGH8QF5RWFXjn8yS08zykGPWB6IEDbggBJy3G2afIJUf3ck1svQDIZXY/6zgfnZH2ljSyb6v6GEQB1G9SeD3nx+4a6L7fmu53NVwF11p74/EhWMJgDlSSHL+PLzzYPI1hGU+7+tz/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734656; c=relaxed/simple;
	bh=mq3bPciCV8KHoEEzkqYUwZ9ZiYrSJKZ6KB6V2K7QCY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPztmcfPZInGjAtxd0skcFjzGJ5vKWuy0dkh0jMxfQCNdtdUClH3LKLaK1HcEbMEZipTK6FJoEWE6V0DAXRHh+YXcVQb8GxpUbl5isg65vw0vaZ45hwWnPrOEJtiv0qHtKs3JJkeHTc82U7pNwkksg3il/BKvcbs1eKUlo3OqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jiDgI7av; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xN8JIrtB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jiDgI7av";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xN8JIrtB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F20F61D000ED;
	Fri, 18 Sep 2026 08:30:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 18 Sep 2026 08:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789734653; x=1789821053; bh=4/wbX1W/On
	fRCGFyrAQS0O+GKkM//U8UeGf3/K89FmI=; b=jiDgI7aviztxdocZSlzs3Dv6GH
	YqUIslpRxMEOBhJ9ub1w4lAvcpG7mlBqkU4A1FXXBS4RKu2RT6RtJtLONSEtLVt+
	RZ3ziBalJycKPYpZEpqqWzC3F1heC3jwF5McVYaLRKJmk2T1Sgar4NnIjWZZl78I
	nIuD/wF6alF2dJIv30WmCfWQrGbdWRnpYT38773v23uOy3xeeNjddyr0G0Sg748j
	PQtDQ1zt1HUhyFoMDzmrP3HQObZwG2fjNOewnjT9aSq22pNQDUAAuiAlqRqN3Ise
	MJirVpPrvGUUDnA7wwswYjQQA5ss96ug8xjWDp3FhMC+l04CFGkx73E12XOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789734653; x=1789821053; bh=4/wbX1W/OnfRCGFyrAQS0O+GKkM//U8UeGf
	3/K89FmI=; b=xN8JIrtBPBM2r0K0sN6GOR2FFN7z+CJqtcJRH7mRk67HblEfidc
	31ndSMS8CzXbRgeYCxBMs86oIGxAz5RgcWH+kz0lJa0hORoVLmxw2kcxNnB+qilp
	lPKQ9n9RKl9djzwF2itbNpqiSRMVrgmPhGu+hvCUo7Jx+BNk7HUwU1LBJL2Ey+2l
	XAOZrXVz3p6lQ1R9faY/Xrr50A3kh4i/wKw/xKULeQG29H+sWh7K1Yd8PVbCFKl1
	Wu3gJkYtEJqROd/+Smpmp1fONcX1yGwYLxhmqqsgtvZbvWHQIaE2utesYmw0cqGE
	WCt3GU8vDY4JafeaKkSl3pYv7WBinL8Jeqw==
X-ME-Sender: <xms:_S6taq55bSvlylbAws4u4yEHsw-O4OsSgCzAfpj8Ybe86oRdGrIfQw>
    <xme:_S6tarUaKZtL8aK8tPLB7qmdBeB4Q8gKhjo2FcMClv6V8qGqgs4bjHV_cKubaZx70
    8qn9S-g3ZLfryT2aAEyckswY0NMLE1cYnBUrw7eaVmrTljsFi_GVwY>
X-ME-Received: <xmr:_S6tam0F2ceo_AsC3-9qNCbI9B_QhH0K7E2m-C_rTQ0-m7l2hbouCGo4SOVGz_tLL6Ra-EytFRgfxdhxT1QSxVepcONHNJFas9pm>
X-ME-Proxy-Cause: dmFkZTGe9TOB+yR0VO3G/hVX9hyOdKwGe9BCv1fyhvA6RN251X6sMZh1TEQ/zkASTvs/Ii
    iRf166QiWmOCDa5kC8VXvFw/j/0636u8zSfvzk5KWqWL6VXc5w1p0fsREe8ZOrSqKQIS+p
    IjhLiOo1aUxFaxcWknDQU6QNb/t78ZPNjZQnw0thH3JKSgoR6YPzCWPb8/SrvMmi4+cv+B
    TmDFiNarKuDD/L4XGD2yPSHNOGazVRKedCCMeFLvGgdJI47N8sjoZTSpENTsYzCyEhiIn5
    p548lV6R68ENcwLwZWAg/2fXPi8x/c5Cfv2VMo+9Y1qvjMzfqTAXYKnmhQW43JKxk2uAZv
    14+OKyfsLgz9h+sJVjpN2oTrzHH5kR9e/0cE5d/VKNJ5ayjkHqH4z/PAEt42Rjrvs5Qery
    fRcPKQdZyWJt+Ova4tB1c7b9XcjXcui9b7R2s1VRuJg/Tt3TTln6ju0QMbwE4mGRAFw7bH
    nHMQsd7kkJlhAf8+g3iB2wa0IXgi3Mvshk9twQkHPTDkm3GRsEmM17wBIZnkKWRWv7vLHa
    RpdxpbCskXXvi5hV/nct9hMxmca7gFxz9meXEeHWDkV5OZ2xl3yoRuKYQ8SsSZubOgcHiG
    9mKm+DfRYx3r64ryCshSTdKesu/SsLZD4aaYuKrkZO4HKprhRXXP3rXJ+Jqg
X-ME-Proxy: <xmx:_S6tag3BjYGl7ltv7AIK9DUfiH_UBhVO-NTx5BkruPrKy4fceZzKWA>
    <xmx:_S6tah9cKi1LskoSFMB8w-gXqPQMkXY9njGHZmj7bwPl2OMJkpOJ3w>
    <xmx:_S6tal2U8iJKQZ_YAcIfIivN42Fv_euHyhUem-6u7WmmSBLh3fdTKA>
    <xmx:_S6tam_DI6xuSloQmKxZskgjsx9p_QUtRyCCBVoJ6f0Naj3VPyzzjQ>
    <xmx:_S6tav_ICjiaxEjUjnm8Dnr53z9ifyoBXwfcTNIHyB8hYLDkhPv3ljaY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 08:30:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mikko Rantalainen <mikko.rantalainen@peda.net>
Cc: git@vger.kernel.org
Subject: Re: [BUG] `rerere remaining` skips consecutive conflicted paths
In-Reply-To: <32062ff9-6dfc-4452-b8f3-66881c3957cd@peda.net> (Mikko
	Rantalainen's message of "Thu, 17 Sep 2026 11:56:49 +0300")
References: <32062ff9-6dfc-4452-b8f3-66881c3957cd@peda.net>
Date: Fri, 18 Sep 2026 05:30:51 -0700
Message-ID: <xmqqwlsioi6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mikko Rantalainen <mikko.rantalainen@peda.net> writes:

> The issue is probably  caused by `check_one_conflict()` in `rerere.c.
> There is currently a loop of the form:
>
> ```
> *type = PUNTED;
> while (i < istate->cache_nr && ce_stage(istate->cache[i]) == 1)
>          i++;
> ```
>
> According to ChatGPT, this is probably intended to skip multiple stage-1
> entries belonging to the same conflicted pathname, but it also skips a
> stage-1 entry belonging to the next pathname.
>
> The loop may need an additional same-path check, maybe
> something like:
>
> ```
> while (i < istate->cache_nr &&
>         ce_stage(istate->cache[i]) == 1 &&
>         ce_same_name(e, istate->cache[i]))
>          i++;
> ```
>
> I have not checked whether `ce_same_name()` is necessarily the
> preferred helper here, so this is only a possible fix rather than
> a proposed patch.

Spot on, I would say, even though I find that it is a bit iffy for
the merge machinery to leave a "delete-delete" conflict in the first
place.

The idea of that function is to return for the current path if we
(1) don't need to do anything as it is cleanly resolved (RESOLVED),
(2) know it is conflicting but we cannot handle (PUNTED), or (3)
know it is conflicting and we are willing to handle (THREE_STAGED).

For (1), we only need to see that the current entry is resolved
(because in istate->cache[], resolved entry for a single path
appears only once) and return, telling the caller that we consumed
only one entry.  For THREE_STAGED, we would want to see a stage 2
(i.e., ours) entry followed by a stage 3 (i.e., theirs) entry, and
the way the code does so is to skip over stage 1 entries for the
same path, and we must see stage 2 and then stage 3 entries after
that.  Again in istate->cache[], by definition more than one stage 2
entries (i.e., "ours") cannot exist for a single path, so we check
if the first entry after skipping over the stage 1 entries (i.e.,
"common") is a stage 2 entry and immediately after that is a stage 3
entry, and the stage 3 entry has the same name as the first entry
we started looking at upon entry to the function.  And to conclude
one iteration, we skip the entries of the same name at the end.

And as you pointed out, the same "must be the same name" check must
be done also while we are skipping over stage 1 entries.  If you
have a sequence of stage 1 entries for different paths, all of them
would probably be skipped over at once.

Note that the low-level merge machinery and rerere machinery are
both prepared to see multiple stage #1 and stage #3 entries for a
same path, even though multiple stage #0 and stage #2 entries is a
sign of index corruption.  The "resolve" merge strategy will use
multiple stage #1 entries when dealing with a criss-cross merges,
where multiple merge-bases exist.  Being prepared for multiple stage
#3 entries is purely for philosophical consistency---an Octopus merge
ought to be representing more than one "their" branches as stage #3
entries, even though the current implementation of octopus merge of
N branches happens to do N pair-wise merges and do not require
multiple stage #3 entries.

 rerere.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git c/rerere.c w/rerere.c
index 1c3745d9e3..296f254c1e 100644
--- c/rerere.c
+++ w/rerere.c
@@ -499,7 +499,11 @@ static int check_one_conflict(struct index_state *istate, int i, int *type)
 	}
 
 	*type = PUNTED;
-	while (i < istate->cache_nr && ce_stage(istate->cache[i]) == 1)
+
+	/* First ignore stage #1 entries */
+	while (i < istate->cache_nr &&
+	       ce_same_name(e, istate->cache[i]) &&
+	       ce_stage(istate->cache[i]) == 1)
 		i++;
 
 	/* Only handle regular files with both stages #2 and #3 */

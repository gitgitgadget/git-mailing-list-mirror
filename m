Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018A360EF0
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919710; cv=none; b=QO+Bdp7cIJNF74wPpIBjXtTQqMjR5/hOyseiiHwsIJvIIiISq9pDbyCHSM5eWymKl5mL62qld8B5SoJhqSMnh24TUX2Q1V+b8rxOcJSvf36B1QF705mN1NG8cdRXz3/IJZ3vKPgnaEHXfvs6RACIPbcXlRkmc8TBVaO1+SA54pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919710; c=relaxed/simple;
	bh=9v9JqvNAT7ILa7T/4vzvQgM4Q5HWQKtMueRQZyLanio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mouogwMEJK2t9pTgzjL1vg0HAo/v/coA0LfB7vGFpDeFnw6e1+YdWJqG57AG+a6zRve5DlaHzt+Ybtk09rwIl/yhdX5CWpoLUAdmdKQpQUBbjS6xl9jr+Rh1C2WLhmwbooKFPm46oGC2Ap95o39m7d+LXLZqXSodUm6wxxBMdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T0rlB7cE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LdPs3IPG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T0rlB7cE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LdPs3IPG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 81762EC0143;
	Mon, 13 Jul 2026 01:15:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 01:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783919706; x=1784006106; bh=/HVLv0gXFw
	HO7W++9lr4NLBlZOBwjGChtHd0B1WqqSI=; b=T0rlB7cEbUjNtIsCzajUPA1x6V
	PpBXjFi7pgzxmvSekeGpcZbIFyTL2uGT1zQIFY9OaDDkzMjIbt3ybVNLowa95rNT
	A5hZbave2bf/1jRt6xENBN0aLD58TJsroFxWRMpFOXNYHydH//3WXZSCBcm68M9X
	/rGu7UDk/llGqj5QkczBG22qWJldhRih5i213hYb2axlfrGWwILTbVFPUC+484cM
	ptvxmLolmHznJ/PXVfps6n+fHgiF2Ci0kp6dVZlU2kD75OBmteNp2a+U4OAB6x/X
	thW2JrlHkOwFMDecpUpIf3ZN7wujZ/61NMM0uREKuGcybkg0T3jM+N2yoLxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783919706; x=1784006106; bh=/HVLv0gXFwHO7W++9lr4NLBlZOBwjGChtHd
	0B1WqqSI=; b=LdPs3IPGIWfHWU1DXuVGgPbqaxhM8GbdXFbutETrHrl7/qqKGml
	skRfp++PaUt/3xu7MaCRmzZA81rsl9RlufpAIiQI5tdrilRut1c/Bef9ChSM2er5
	km16deNKu1D1AWJF4yRejkG8eqyPQ57jTVunm+O89nOYfc6sk9Ux7Er4s1JOlb9l
	PjqnxXJEIlqegqGFfWVdClau9gL3dlZAtp/U4QXkAzERAJEEOU+NDVo2gWJGd4tX
	lR8sjyw8M+zUX7pkzeI3SrwgX39ZRDk0a0L2PsCBhM9IOaD0z7ADzCecfcOY7124
	R4ZWfWCo4hrv7AmkpgORafiVxzalvNaNE5Q==
X-ME-Sender: <xms:WnRUaqTIJK2RpCo4ToX75tvESQdtSIl4VPJ6y5ynrZfX1FBsvR27QA>
    <xme:WnRUanO97qU-cIZbfAKFQzLjjfDOWXy8MaDKFWoNjVl9kMAgTsWJ_2JCxM_PWXRaB
    DJ6HGHoXhxXF4YzWw78F0wFVxgjY0RjYsJJO-yPlOht0YTcOFQWWDY>
X-ME-Received: <xmr:WnRUalMEXrl3pQyISkPToRqou3Nnahdtye7hee6mVa8YAgIgTPGiLF4BlvulN0oFUkhk1HytRj8zzW6wRQQ8-VF41GnviIZkrVMYzFLR>
X-ME-Proxy-Cause: dmFkZTE0iL4wNXjIZY7AbTjFSI7NWXY8Co4hxJBobSCUhBQaCRx2noYtnh1097lFR5VpeG
    lFOTwu6vRRx3on9mwZB/STkugvCafbELkf3cnnQlu3+xtaVFVtNlY8+dkXG48taNdgreNr
    JWYAryRubzntR55DWA7mmW2GNCI/3fKsljIKSgRRVcI2UWIg3epYtimtwW/DahkhFikxxo
    E7p9e6GL/3U+LRcZgAs3sIYJYE0lRdIB4s0QpkOX0Px9lCmBgIxDBPRao0WMAdvrJffwbN
    YsouuDjcMBxglIvVx/k+kL3dget1xyYjURAazLncHdtDVSq28KR59huq3hPv721pSsB6rL
    euIexzggQ+Vod+gdnz5FMMlfKoX/NOHOCUFkd8Qtkepi2R5i90e9xKL708tBz5dYKxghrm
    aKUghxjjPKd3dx7sqkeRw5oGhRRtiMRgRVjhfEF4htg6Ddvwd7sHn7CZ/eVTRRXvEPjmuf
    /BfB8HHSmrtIFSPPTjIHTHTVFAYBz+FzmMH3ELjaRMz2cnhHbl+huPbbOZXqq27tq/XEoz
    JsXiaE+6uhzbAPPhJVCpXZs3Fy7tH9IjrXc+A0oLZEZPttHqwxCwdZnYNkhtbW1ZwFRQoV
    PPWRTEKo0eHRzVT7uTm8G0R/OkZx6pZGBH7lK6ryfKT3ZO3Xcn5vmZj1O5aQ
X-ME-Proxy: <xmx:WnRUavvsOERFNAH05JM-eaR0vYxj2j73hDdbn9sYYpuL6DX22cBAzA>
    <xmx:WnRUanXk67wN4UtwZKb1py4xWJSbCNyTGRFbwVQNlsDaCFee8D059A>
    <xmx:WnRUavvkHnzfsbaoQ9E2K9qYRqYQ_tHufqDQrSBSUvRN82ipBqE6fQ>
    <xmx:WnRUarUKGMryEETQ2Pwv4NMSWPTyk494DmDFdWeun4M_RAKnXakwhg>
    <xmx:WnRUauhXTKkemws9ICjFJBBGvEuf_lzrswdClwke076lx7J9QjIl7yn0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:15:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a6cf924 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:15:01 +0000 (UTC)
Date: Mon, 13 Jul 2026 07:14:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] reftable: fix quadratic behavior in the presence
 of tombstones
Message-ID: <alR0U_OVOiYuFnXh@pks.im>
References: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
 <pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
 <4fdcec84406431d56b7a7e593fd8e843c3b1ad52.1783679767.git.gitgitgadget@gmail.com>
 <alECc90WZ9RPqMaA@pks.im>
 <CAL71e4POhVpQ9FvLmjUc4ex_=T-DuCd7cas1D4uzqzg3RyDw+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4POhVpQ9FvLmjUc4ex_=T-DuCd7cas1D4uzqzg3RyDw+Q@mail.gmail.com>

On Fri, Jul 10, 2026 at 05:03:28PM +0200, Kristofer Karlsson wrote:
> On Fri, 10 Jul 2026 at 16:32, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > > This also requires adding deletion checks to the log iteration paths,
> > > since suppress_deletions applied to both ref and log iterators.
> >
> > Nit: s/applied/applies/
> 
> Language and using correct tense is always the tricky part --
> will fix if a reroll is needed for other reasons.
> 
> > > +     int suppress_deletions;
> >
> > A comment would've been nice, but I don't think this warrants a reroll.
> 
> Agreed, the field name felt self-documenting to me, but I will
> add a short comment if there is a reroll.
> Something like this?
> "boolean: filters out tombstoned/deleted refs early if true"

I'd drop the "boolean: " prefix, but other than that this looks sensible
to me.

> > > -     new_merged->suppress_deletions = 1;
> > > +     new_merged->suppress_deletions = st->opts.suppress_deletions;
> >
> > Yup, this looks good to me.
> 
> Thanks for the quick review.
> 
> Another thing I have been thinking about: should we consider
> suppress_deletions a temporary stopgap, with the goal of
> eventually removing it?

Maybe? I'll update libgit2 as soon as both ps/reftable-hardening and
kk/reftable-tombstone-quadratic-fix have been merged to "master". Once
done, feel free to create a pull request against libgit2 to deactivate
`suppress_deletions` there, and once that's happened we can also drop
the code in Git itself.

Thanks!

Patrick

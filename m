Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164B28DB76
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967582; cv=none; b=Qm8Tc6/Fm3CbzQT8RO51N5MlMpD1kPVwQXHnVkfUKDOr8TjygrsYen42LCp6YqeWeCiaV0/USnqtABJYiC4kMAyE2RsDmvLuuMlcHf+BWHGGHeEE7AT4/clptN9mmutziLluVYm/aIgpTgWyPs6hw4jfqSn6E5yuZ6+HIRQTP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967582; c=relaxed/simple;
	bh=m+5AvF8yPwq7eTHqmentMBOfhr9AOz63xQnSDQFRE2c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LA79WpsEWw4SHUtHVaX4dvHp+GS2doqLmZfz1QKCafZxBZtKSqoNTNBzbakwnVyhcQlWk9WTTuZy8bES2wLmIwR1jUB8BzP8We5J0x7fmJVpnFYWGQTtpE0KBFwdFebrM0Hm5LvzejK6Ap+H9RlHo4bb02qw1pRIo6OJQhBu8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=q8DhsRfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gyKKrPWf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="q8DhsRfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyKKrPWf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B59AC140022B;
	Mon, 15 Sep 2025 16:19:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 16:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757967579;
	 x=1758053979; bh=vlBFnBoau07aaSP88AQPewrhkCtcWvMCeS11CSApF9k=; b=
	q8DhsRfooInoDiKvsWRTnU8JFDrod4ZyD5yCEu01Oju6zLih0IHMkCF+e73k1BEM
	YuP0gRisynEwAxTibs4A+W2F+1zHMLNVyb4/DjnpEMq/k76qcuq2fRJMLs/QbP4P
	jD+iXKpjd1U9DKueNtI5+C+PrE0dLrG589r6khH7pxhzktcwqGIUEnmt10G0qa7V
	jeMqcODrHCMvbqPofKkBE/g9eDujY3PytxXzdORrGBJ8z/tHL8Kb7Zwazuo9wiSx
	YpBSC6+A+ImO3d5Gug0AnZklYFfayekgXcB9du3FKdR3xlzgi0ndlcGuJkmBxZ2q
	+ooGe2LbNv9Ql5A5t3vuBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757967579; x=
	1758053979; bh=vlBFnBoau07aaSP88AQPewrhkCtcWvMCeS11CSApF9k=; b=g
	yKKrPWfQ0V0BJX58p1D7VLj2zl0rowOeV0jTBOKkS3ruAbM25GhLAcwehzrKo+V7
	MQmVrhuDtd13cg2efcxKCUlgIYTPVg1x7k6Oazfa32/p89r8Xr7X96Z/J10wjZvg
	umYSa28HAW2Guq1+F8Pe41ezpKTp/g3CRqDRxqhMGiWYxRAh1PlPQ6UdIWIHtUWj
	IWZFoYfud8YwsVxC36H/Yy8GAXh/KqskE1SpL3WfXp3Rpi5yQ1Z80XmkOxtq5r2a
	LkygMPxKJDc6qN3iBW7zpzBt5n8czeHl++n7q3Ev9dWx1c7Z9mkrQprITafBG45U
	XpSGCAVsatjtvsbdg0mNw==
X-ME-Sender: <xms:23TIaDtblo-HxGq7nWw_pgh7A8J36UjziTwJUG1xKpsarTL_Aq66Kg>
    <xme:23TIaEf2VcWopH6IlAcvUKEcPAaXpsOhlSYQewLm7ZwilYN43WutDQex7ZCdGJCtS
    PiXMx4pCNG6i6sEBlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:23TIaJOGdJ5oSMss-_oVm-lUAD0l_cFT__Qhu0Z4k721EOTTBDwl2Q>
    <xmx:23TIaJEbH-f07FrmA74C8mzHJpppVg2OpByjV6tTPssW3Ek-PkYAeA>
    <xmx:23TIaHRcq4Y11uOsLE5uZPFGwBoAgpWsSlU0gAbFpkWuhJZ5LuZLIw>
    <xmx:23TIaGvdL3WhgJUSgKqJPqjdNktApAPbJpryFSZgD4tTg3W8t2E-pg>
    <xmx:23TIaIe-kl001zLbYk9tVgm0W6xqPFS-yX-DBfTIXkQ72lE-dQycQfXC>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 678EC78026F; Mon, 15 Sep 2025 16:19:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Mon, 15 Sep 2025 16:19:05 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <fbde4659-6191-44ab-a713-7b47f989de96@app.fastmail.com>
In-Reply-To: <xmqqa52zl6ar.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
 <xmqqa52zl6ar.fsf@gitster.g>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 12, 2025, at 5:17 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes-upstreams.adoc
>> similarity index 63%
>> rename from Documentation/urls-remotes.adoc
>> rename to Documentation/urls-remotes-upstreams.adoc
>
> I'd personally recommend against making this rename

Great, it felt awkward to me too. Will leave it as is.

>> +UPSTREAM BRANCHES[[UPSTREAM-BRANCHES]]
>> +--------------------------------------
>> +
>> +Branches in Git can optionally have an upstream remote branch.
>> +Git defaults to using the upstream branch for remote operations, for example:
>> +
>> +* It's the default for `git pull` or `git fetch` with no arguments
>> +* It's sometimes the default for `git push` with no arguments. See the
>> +  `push.default` section of linkgit:git-config[1] for the details.
>> +* `git status` and `git branch -v` will show the
>> +  relationship between the current branch and the upstream,
>> +  for example "Your branch is up to date with origin/main"
>
> Although I would rewrite the second one (i.e. "push") for clarity,
> to be more explicit that we are discussing only about centralized
> workflow in this description, the above is a good write up.  Here is
> my version, including the push one:
>
>     It is the default for `git fetch` (hence `git pull`) and `git
>     push` when no arguments are given, and you are using the
>     centralized workflow.  To use a triangular workflow, in which
>     you fetch/pull from your upstream but you push your work to a
>     third repository, `git push` can be configured to push to
>     somewhere other than your upstream remote branch.

It makes sense to be more specific about `git push`. I like the idea
of pointing out that you can use `pushremote` to make `git push`
push to a different location.

I'm not comfortable with calling this a "triangular workflow" since
there are other very popular ways to set up a sort of "triangular"
workflow -- for example you can pull from one repo on the
"main" branch and push to your personal repo on a feature branch.
In that case each individual branch is set up in a "centralized" way
but the overall workflow is "triangular".
But it should be easy to talk about this without using the term
"triangular workflow".

>     Various commands, including `git status`, `git checkout`, and
>     `git branch -v`, reminds you how many commits you have on top of
>     your upstream, and how many commits they added to your upstream
>     since your branch has forked from it.

This is great, will incorporate.

> When we would upgrade this file with a more detailed description of
> the triangular workflow, we'd remove the "To use a triangular..."
> sentence from above, and leave it to the new section.
>
>> +The upstream is stored in `.git/config`, in the "remote" and "merge"
>> +fields. For example, if `main`'s upstream is `origin/main`:
>> +
>> +```
>> +[branch "main"]
>> +   remote = origin
>> +   merge = refs/heads/main
>> +```
>> +
>> +You can set an upstream branch explicitly with
>> +`git push --set-upstream <remote> <branch>` or `git branch --track`,
>> +but Git will often automatically set the upstream for you, for example:
>> +
>> +* When you clone a repository, Git will automatically set the upstream
>> +  for the default branch.
>> +* If you have the `push.autoSetupRemote` configuration option set,
>> +  `git push` will automatically set the upstream the first time you push
>> +  a branch.
>> +* Checking out a remote-tracking branch with `git checkout <branch>`
>> +  will automatically create a local branch with that name and set
>> +  the upstream to the remote branch.
>> +
>> +[NOTE]
>> +Upstream branches are sometimes referred to as "tracking information",
>> +as in "set the branch's tracking information".
>
> Everything you wrote here looks like a great addition.
> Nicely done.

Great to hear! :)

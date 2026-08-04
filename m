Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CD34963CA
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875309; cv=none; b=C6ejyFrfvQrRjiUEd6lv1CFDCK5IbxDAQiHT5j4ZBs+oVrY3EiqoRjCD6d6Dnv3+vT/dVaYtdBhwyl+V6M7DJXOnldVPA1XadnxptwCi53D6S04zDqYQAML14fsh8du85NPU1Br82ac2StZIblnhRRMCpeFrsEZRPpL59C41Kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875309; c=relaxed/simple;
	bh=R6XmLNPp89GREipNzBjKG+fJ8QaeUho/8QcNvLsazOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lca7mW3K5hT4gUQQRTt/D7ctcCoV8uYZSMu06ka3ynmMma0OKzmiB4cyYuMG3P6AIv1TRsN2c5Ja5C40Uy8WDfhzPjsZtgbNG2sZtomJDv4STBSsay393aypNQ6aYbtIdM2D5JXBMCoTc+tS31qye4RmCdn54wHrpiLtLYoutwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tIyTVU0J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmzFxIzr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tIyTVU0J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmzFxIzr"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FA2B14000F8;
	Tue,  4 Aug 2026 16:28:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 04 Aug 2026 16:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785875305;
	 x=1785961705; bh=7kEeNW7fDA9+55lfxRu/kqDjbxtCXWM4KCw0t9VL020=; b=
	tIyTVU0J9Si/wbryD47bZC09euik0lsvBhpvdhe0SPHHBegFkx6jYeCCJT8snUCm
	MSKiNFhmuX6LryqeEbod4m1tyOi5a1JFtC7y5Wl2jcbDsKJ/LHW+SAYUyUUm0loU
	a3hW6Y2kZJdO4vHzoF2U4eimDg7LmwKhFu5URlW1wJocz2ShQFWLCFinYEQLEMM3
	WaxaTFzT5WxSJ9QwI0OuesgCKiAXEmkJrA4O79s0c4m5m7pp8D8odU4qXA0yBEeb
	lYmlrY9g7ldEOQWzeBvoCbgzSOberKMV3cXLjU8Ut8H0rQVcIXhKS9KyjfuiOJ2y
	vFt8odmIk2WXFyelbonmQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785875305; x=
	1785961705; bh=7kEeNW7fDA9+55lfxRu/kqDjbxtCXWM4KCw0t9VL020=; b=F
	mzFxIzraXf+TTynK7fNy6Zvw6s1Mo7MkWZXAAgTIo47e1IgO19PnoPpDRCOVTyKM
	VkGyvwVTt80AHGHYgN9aXJYWMXkSHaZ1svAGCOMdVTJ1Gx246I5rvBEwNMRc/klK
	EWOxk+CQgt6vrcFCLM7uKEtCaibD1sZKf8D/n8KTUbEtVN/QFbdNFlf2JbFmfSyl
	xixTRWgI7JN4CdkUQzIDv3PVLkERw/fRs41tv6EKv11ImQuyKd6FPLxG/VSxv0/7
	TsZ9ScjSM40a/OUH7p3CdQO3lYli4WjX6VZkprt20UoHhYgESNx8wgxoUTiIaT74
	3/xnsIAiGdd5I4LM4dEPA==
X-ME-Sender: <xms:aUtyajCDg03AyqtF_c0yTZNjiQmXetBAwufXkhfZpDLQju5tUFxXsQ>
    <xme:aUtyaon2hEcXjs4F04HMFGPEqSajBZqDuL_G1p2_0a2ZBsJVlr_j-kAZ52JZiqk0v
    OZx8MWBAOy4IvJ04IvMy1uxr8EoZ8ub--E7DYc3Zu42W4RJc3xmiBo>
X-ME-Received: <xmr:aUtyakzM9JD22G4IEzFYjfgONMA1SfiYEqEocRq8xPiDhzRKi-UmkDt89jp9HV-7YjYfXWOgdFJwQKtCzjwuK0b44U1aMqi9Sg>
X-ME-Proxy-Cause: dmFkZTFGy8+kcjMgCc1TVkVQdoMHffCeaDGyQO7NDIe9KowVWC78XLtP/IjqGu+snBpo7D
    L/PHEtOK8RsK5Qk0d5usNStgl7EvVTnsy+puxRnrrY16eAZx5ubBBtQ3Uf9X2/10GPTpcT
    ljMhwCXQuXfwg+CnP4btsssP2TYFayLi6qYUTVXynPL7pvi4gMITI4RR3Yo19UrJNpIJZ2
    wtOq5akAEQEjvX4gCS7nctNTmaefXjviB9Qqq7XCSCxmVaiJleghsH/1X2n9D2pfYD+ibX
    j5+hlLSFsEy1gwZPj57xvMfMMuNfZKop/tsAHsIL1PjKRGuOLBPiwcMTo5kmbMd/EGm3HO
    GMEaNvHBwwhF+PlrunMtDWztJ1dLpLrDTQVltGIJV2BiH14G1JLVTBU3nSfp8ckTLi29mL
    ttQb7gKZFceA+IzflhWi2gLx6IcDB7gjS4f/LaMJwHEeZJkqPeqq9pZdl2nh+F+Vp8f/Hn
    vyS486mCgfXx5ZYE1nSKfvfeGvdvaSPsyrDRTtLwZpeNC76GU/XLT3zVgcLAI/EnQTj0a3
    3wxEKMoTizTNn19QhzeIgL/L2piOcGIvcz+dfxvji8wvYId/F1m9DOUp3p03a+7e868gFm
    dRm5T/Tr/42WeHZZIPCjEROAR4NIE6fioArkP0lGe3zCCIT0uUBdD6Xd6zrw
X-ME-Proxy: <xmx:aUtyaiRiwFpIEq4NE3WRxttJuPHh1EORTVQv5O8CFoNNgHbCPl2dyw>
    <xmx:aUtyas-vhFWwq-N0JRC81VSJ3GqK2e5xGxpa9yo18Vv_PSgEFmkOVQ>
    <xmx:aUtyagvT_hSibe3RYagxeNQes81D339-gSOKzcKuO_diwHGD2WZycA>
    <xmx:aUtyakMOA33z9q5DopErkK-qPhk5o1dkWri2STg7-LDfFrQvigd7xA>
    <xmx:aUtyavb11eXNIgOcZfC0YcI5nZEZBQ4z2JvbpMaVf3RX2QwI58rxPnz2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 16:28:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: domen@cachix.org,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Patrick Steinhardt <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
In-Reply-To: <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me> (Caleb White's message of
	"Tue, 04 Aug 2026 19:03:19 +0000")
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
	<371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
	<DKGE5DORETW5.1S9NXEX8KMQHH@pm.me>
Importance: high
Date: Tue, 04 Aug 2026 13:28:23 -0700
Message-ID: <xmqqtsp9tyu0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Caleb White <cdwhite3@pm.me> writes:

> On Tue Aug 4, 2026 at 1:14 PM CDT, Domen Kožar wrote:
>> Hi everyone,
>>
>> First, apologies that my earlier reply reached the list as a separate
>> message rather than as part of this thread. This is my first patch series
>> submitted by email, and I am still getting the threading details right. I
>> have made sure this reroll is plain text and correctly threaded.
>>
>> Thanks,
>> Domen
>
> Hi Domen,
>
> I love the idea of having hooks for worktrees, especially now that
> they are becoming more popular for having agents work on tasks in
> parallel.

Before going there, we need to consider if these hooks are necessary
in the first place.  If you _always_ want to perform something
before or after running "git worktree add" or "git worktree remove",
you can instruct your agents to use "git wt" script when they want
to run "git worktree", and install a "git-wt" script on their $PATH,
which essentially would be something like

	#!/bin/sh
	# git worktree [add/remove] ...
	case "$1" in
	add)
		... do whatever you want to do before add ...
		;;
	remove)
		... do whatever you want to do before remove ...
		;;
	esac

	git worktree "$@"

	case "$1" in
	add)
		... do whatever you want to do after add ...
		;;
	remove)
		... do whatever you want to do after remove ...
		;;
	esac

The users would need to write the "... do whatever you want to do"
part as the hook script _anyway_, and unless there are compelling
reason why these _must_ be implemented as hooks, you should resist
the temptation to pile more hooks on the system.

Having said all that.

There are five valid reasons you might still want to have a hook in
a Git command or operation:

 (1) A hook that countermands the normal decision made by the
     underlying command.  Examples of this class are the 'update'
     hook and the 'pre-commit' hook.

 (2) A hook that operates on data generated after the command starts
     to run.  The ability to munge the commit log message via the
     'commit-msg' hook is an example.  You cannot easily prepare
     what the 'commit-msg' hook may produce before you run
     'git commit'.

 (3) A hook that operates on the remote end of the connection that
     you may not otherwise have access to, other than over the Git
     protocol.  An example is the 'post-update' hook that runs
     update-server-info().

 (4) A hook that runs under a lock acquired by the command for
     mutual exclusion.  Currently there is no example, but if we
     allowed the 'update' hook to modify the commit that was pushed
     through a send-pack and receive-pack pair (which was discussed on
     the list a while ago), it would be a good example of this.

 (5) A hook that is run differently depending on the outcome of the
     command.  The 'post-merge' hook conditionally run by 'git pull' is
     an example of this (it is not run if no merge takes place).
     Another example is the 'post-checkout' hook that gets
     information that is otherwise harder to get (namely, whether it
     was a branch checkout or a file checkout -- you can figure it
     out by examining the command line, but that is already part of the
     processing 'git checkout' does anyway, so there is no need to
     force duplication of that code in userland).

If you cannot do an equivalent operation from outside the Git command
for the above classes of operations, you need hooks for them.

On the other hand, if you want to always trigger an action before or
after running a Git operation locally, you do not need a hook.  This
is true even if the action you perform after running a Git operation
depends on what happened (class (5) above), provided the result is
easily observable after the fact.

Of course, one very valid exception to the above policy is when an
action is common enough that the policy effectively forces everyone
to reinvent the same wrapper.  We may be better off adding it as an
officially supported hook in such a case.

But for the hooks proposed in this topic, I do not think such an
exception applies.

Thanks.

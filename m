Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A634E2F33
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778159; cv=none; b=irDtLjfKMmyFnE7CYpvbWX2Jb6hCe5WWPaXkUUNrhLO5Aju9DPSzasaEyZ41/7yCYoYSKMS41R/ZV9ixuKWt/ebduEd/jv1y9K/VBJiRpZfcUxhQZ4bLC9sBbi7imbhRXjv/Wexca1YbjjLZBTonLcEwPWW/pZifj7Ta5NuRKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778159; c=relaxed/simple;
	bh=iHOqEU9To6cOOWYFTNvQz9ssgY7HOTouuDfvGIYSzjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/Wa4ZUB412KJN+MV4H+GvlM3aiItjH922Ngxy+xuZJvxQ53haFT5MolNaZ6jUw1tyKVXGrRxqIu3l/q8DrcxcWlXH4Vfg+kj6pvkk3yh4+M+EgEyQD1NYgQsiTEZNIIkqrzWAbNG+LXW7PdYXFxdInUyHqdeHahfADOuJGAGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MidP3qf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wLRZdVLc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MidP3qf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wLRZdVLc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 802AA1400147;
	Wed, 30 Sep 2026 10:22:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 10:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790778138; x=1790864538; bh=ZpgF1MeANR
	/qt6UmB4u6mk8Dv/gOh831GsPIwdyB0uQ=; b=MidP3qf85PupaB9Nnu96FTYO7O
	0+mnz3QALdAKiI91Eq/YQHngsQjSa6Yb0JB9THAaVwo3IH/wcm2PGRfaseRXyVP5
	S3scqWc5c7sc4G9cdcY9TgbaRT7gEtlRgf1ERLFbEHK9Q4nioHbKYE2RPvb+58dp
	Lpc2ndhI8chIuYft90EecOpdxCrb9GPmpdJ9f6yqbMl2oRDjii7QIh7w1J/zYS7q
	xddenobFCc4T80wlPX/ZTtuc3x/kJP6qmWgdNdMDO5Qw3XWN4SURE/5a3VJG43lu
	sxdJ7f/T1/5EojrZPGxlDsZNjifvwKqhmNldaTCRMksnNoCK0MUGoS9eSTPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790778138; x=1790864538; bh=ZpgF1MeANR/qt6UmB4u6mk8Dv/gOh831GsP
	IwdyB0uQ=; b=wLRZdVLcwG01hEG8pqWzo2vGPcXKvTHQXHKUZ14sB6CkgHkdtlm
	6n7nxE/pZYoW7NSp5vjFqz5fHFLLL15S/7krqlatjvovEd0qdM3ITbxe2JQLNO+y
	M/6n+v2LXk9lN8KGgmzJ3CRBgVi+9v5vD4xUscp5T5zkO+1XDwnX76eQG/lgsKLu
	42hSN/DjEwdeu3Y+Hjdp8FLo2t2a0MgRlJ9Z9p9iuq4BsXjg8JMZ/r67YHok7qkK
	foPym26DNaInEJIP91kyU5A5MwyPF2tL3SbKVYNItDs+6c5TyiWxGK8h2O/IQtJh
	BmPlVGQ8PrU4VgtdXxM28qQnw2/uZRZHc6A==
X-ME-Sender: <xms:Ghu9anZsDOqOkhDZpYRWOBWxhmRbdNSSOBn5JobmeVePkCfOJQ3Sbg>
    <xme:Ghu9atQYsTwRocanc9WCJJBg9pJSqICAPC9ZOST8ErkfHywo8jMwEZw4xxPhdl7Jw
    50Yq-y17l3m5U68IuVwtUufAICGfhe3oIUgrmhdzwhsSSt2y3JxbP3t>
X-ME-Received: <xmr:Ghu9aiSdOFLRdrXDRl3nS1_U25PyLfWn7ujjYK4hxFT-lEF_XCzzBSyWxSTLh_Qt1Ohr6J24SvtDKpH3XTVk8l-n0MGLqP5-i102>
X-ME-Proxy-Cause: dmFkZTGOvux5LrNBETrymGjvxsXf0obVAZP6wH8ty2ectRfjEH2WpgG73XpgmsrsBVR6XR
    1v4JrjJHiOhnM0+r4YEZBCqq/RZiuNY8rD4mbtKHhSTyAKQTxs4BYk9NQW1tx6jmyjFSGD
    B5t77izC9yAnUKG8Ei88pquoRIVQ+hwIzOunzctPPN0ZvRP415PdMVuderPivSm78NL5w4
    GxsNNJ0YAiwCtbaKnpUpOS9ITFoGVMhJp79U1bozfcn0dCA3V/hpwhWUe+bp4eCCYlBBzq
    VgeBVB0lDd1WoumkGaA5hBa3KG53pk5wwuC51q3BIzZ9WZe5aIU+lMEtMqSxw5yPS3JrKq
    U03d3hrpFHgfidQB2W224MBEXx7dWiFRUgCiE9GkFVR3ui9WrhyIfhzzULb388/Rhv1iVT
    trwWEKSL3WNjh06fyT22T+49SAb3H9maEGfWs/paMdV5xYTwfb4uOO+sm2A8r8qk46VSIu
    pPXjERORU7z73CWdyNfnO4id9SDaaM4OPDsPfP0cCG/KKGB9DQA3kMx2hPuTm4df2lV9wk
    QTwtvKFPIPBl33M/x4EkzOm6djILu16wQ7tOO+0T009Oz69dqaJcb03X+c9UV6VMWcVkcA
    7uZ85yGFU5pcNFvEu1/gMI/3OCcxA0die5Av0ZYGLVHB9HZQYTfVtZHtjoVw
X-ME-Proxy: <xmx:Ghu9apRqGnrRQJO824X1o34k5sevXP0i5oPlXjyyiIVVVqWZaY1XVA>
    <xmx:Ghu9av4Vhoa06K_V0K1kCsgAB4Jz4NrrnjwGQUCVc438AJzWPCWCBw>
    <xmx:Ghu9at3q_UxStMQ9sDstIJ-aw-ZkI2T67z-zoWPmuPtKTTlfwAdvIQ>
    <xmx:Ghu9aiDWFGlusEgHia_j_EnvnaLmXBGvGWC8OM70xbJTVCQPdXHsRA>
    <xmx:Ghu9aohWims_rtUl26svwKscLb3CVAvkjnvFHGd_PKdVpEmpM5l_9dV2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:22:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
In-Reply-To: <20260930061524.GNkIK%taahol@utu.fi> (Tuomas Ahola's message of
	"Wed, 30 Sep 2026 09:15:24 +0300")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<xmqqcxtven3u.fsf@gitster.g> <xmqq8q4jelvp.fsf@gitster.g>
	<20260930061524.GNkIK%taahol@utu.fi>
Date: Wed, 30 Sep 2026 07:22:16 -0700
Message-ID: <xmqqtsn6ddk7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

>> Sorry, but there was another.  With this merged, doc-lint seems to
>> fail and breaks 'seen'.
>> 
>>             ...
>>             LINT DOCSTYLE includes/cmd-config-section-all.adoc
>>         no link: gittutorial-2
>>         gmake[1]: *** [Makefile:537: lint-docs-manpages] Error 1
>>         gmake[1]: Leaving directory '/home/gitster/w/buildfarm/seen/Documentation'
>>         gmake: *** [Makefile:4003: check-docs] Error 2
>> 
>
> If we want to build gittutorial-2(7) as a manpage stub but to hide it in `git
> help --guides`, we can squelch that linter error with a merge-fix:
>
> diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
> index d4a1977ba6..db2a54116d 100755
> --- a/Documentation/lint-manpages.sh
> +++ b/Documentation/lint-manpages.sh
> @@ -32,6 +32,7 @@ check_missing_docs () (
>  		git-legacy-*) continue;;
>  		git-?*--?* ) continue ;;
>  		gitweb.conf) continue ;;
> +		gittutorial-2) continue ;;
>  		esac
>  
>  		if ! test -f "$v.adoc"

Great.  Will use that in future integration runs.

How close is your topic to 'next', by the way?  I think we have
already caught a few missing links since it was queued in 'seen',
and that should be enough to prove its worth.  Even so, that is
merely "we saw cases where it was useful" and neither "we know it
will not fire when it should not" and nor "we know it will always
fire when it should" (which is why we want to see a solid review).

What I am wondering is if Julia's topic should be built on top of
the ta/command-list-guides-sync-lint topic.  Perhaps it is a bad
idea and coping with merge-fix would be more flexible.

Thanks.



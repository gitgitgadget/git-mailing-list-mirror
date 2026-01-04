Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6541C63
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767506594; cv=none; b=R5y7EMxbvArXt33tQjN0oXtBi81cxLYK1RVPGbD6bpDym6v4L0Y4JhfAZbtP1UWOZpH+0CoQfe4Wnn6cBTSifZ7I+PHe3nlAlq9NEpl+VSvmhFe5qtpDoztDnkj5CnTkr5HcIjwT2r/ukfMIkk0aaLgELlQ1taVq1ZycCIaj5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767506594; c=relaxed/simple;
	bh=99qDEWCwyRZXePvHj8p3n2ZP48YsGUD7cydAFJQX7O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sPmdSU1Sm3QVBpV0xNUMf2hU4OddpBvU094jGM0i6G5WvCgWsP4F2J4B/qjSBORMRTqONA7phgCUvHNEO4nvBLx977auSzG5zjJXdqLocuT1Bamq5qhX1QxljWY93My1N3LTZsiWsdMgM/el5DOKMuuwhNu0bGeaw1OsgRLocq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqgDixXk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkMY31HY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqgDixXk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkMY31HY"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 29CE21D00085;
	Sun,  4 Jan 2026 01:03:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sun, 04 Jan 2026 01:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767506591; x=1767592991; bh=kwDPA23vlY
	kTl08Qv/QF85O3BaEyU/WFnbFvuQQrW1c=; b=TqgDixXk7dubzyWQCZzeUXvrEP
	jz9Ys4MJ8+9/+bAhIt4BpizGbpNXGHIQyQJb0Ipg+beJKG//Xh36zdo7jQGAwUaC
	etNImHA7ZILUsHsBON/VU1vkDG4Meryaoiw3LtdENIKakoU2Pc0FonGLWlfQPOE7
	2TgDzSZkaUkiOF9PHmtKAvVVBxls7QzDtBKYOvp12kLIOe/NsYwLBpEFMvK0K7ww
	mz39kGf441HXo37VRR+DequTSyL/PZkzc/JY5/r9tjb5sK1GLb8vJrNH2TCszQ6z
	EbUefVZsBhBbT/MPCuPQcFuIk0e6+P8bnooeAGw2H09RsAzLEUXea8CW1oJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767506591; x=1767592991; bh=kwDPA23vlYkTl08Qv/QF85O3BaEyU/WFnbF
	vuQQrW1c=; b=dkMY31HYvfCdFxmbhnSR6Cly8N4fbcO9Pk6V80Bm+RGofz6rBuB
	dl32btN99heanevmxrQh2JUWCbNd1D9CrjHElYT4dHH84P/LsXA6rIz6Dzdgyf1u
	i162q64mVAAyRoeXDSgK+N58EEYfnymhBTpcUcxrL+CwrEtfSl4uyNJORWH+dgVQ
	UXZDB7FjxQCdKK3ZIl4rUi3TXvwIlen4H0lIMzyCcC0tn4JCLN+favDYd7t1AqR1
	h7niC5M20WTQWh5qmHxnS3GYBZ5/pwqVeGuaHNfGNz2WhoOihrd1qFi4kPCo9DEZ
	iZZ/kFSxaEzqV0Q9pbPaGsDLHNznt+pRu9g==
X-ME-Sender: <xms:ngJaaWevatT5F6uXzzx9biHAIJv3LRfBwPl2SajOqv5gjdgfn0WfsQ>
    <xme:ngJaaXEfJGt06-J46mHfDXq8xP6WoBh3D2OHDwtAj3YoH7Ki3YusWDiBdcsfNyHp9
    37ovBX9m070ivp8OUsuVl_Ox0zBe1x0RdH67bAY_8r78z3sZHof>
X-ME-Received: <xmr:ngJaaf1736_ZDvCHtDImwvEfPy7K_QIKCXe37YNukDuM66cIUpOd8xNF07jZGclxNd_5M1QJZQah2ONz_WHQ4BErw3002L7-gh6nZ2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:ngJaaflCauQLhrmIdBY8UJRG2k0irCFECSnREDh3IXLSTUISZysWDg>
    <xmx:ngJaaf_2C5oxjX-oqAufTdTR7mGRrS2m_jDGTAzIiKNAokV-p4YMuQ>
    <xmx:ngJaaUqeETCGLPSlLbhXvBJFBphiRGv9_2e5UEyTaxMcoowySrp_ZQ>
    <xmx:ngJaaYkpKLphh8ptDY2Ui1wjky5Vox8gWkrtAdRWaEFiBwQJMMx2Sw>
    <xmx:nwJaaW22QwHdtjRn5ida9VyZ3VoMKnOyRqaFk2qMU6etKT9_IhJ2KU8n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 01:03:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [GSoC PATCH v3] add -p: show user's hunk decision when
 selecting hunks
In-Reply-To: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local> (Abraham Samuel
	Adekunle's message of "Fri, 2 Jan 2026 19:51:05 +0100")
References: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local>
Date: Sun, 04 Jan 2026 15:03:09 +0900
Message-ID: <xmqqzf6tncde.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> When a user is interactively deciding which hunks to use or skip for
> staging, unstaging, stashing etc, there is no way to know the
> decision previously chosen for a hunk when navigating through the
> previous and next hunks using K/J respectively.
>
> Improve the UI to explicitly show if a user has previously decided to
> use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> This will improve clarity when and aid the navigation process for the
> user.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
>
> Changes in v2:
> --------------
> - Modified t3701-add-interactive.sh for conform to new changes

Here is how "cd t && sh t3701-add-interactive.sh -i -v" ends for me.

expecting success of 3701.50 'print again the hunk (PAGER)':
        test_when_finished "git reset" &&
        cat >expect <<-EOF &&
        <GREEN>+<RESET><GREEN>15<RESET>
         20<RESET>
        <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
        PAGER  10<RESET>
        PAGER <GREEN>+<RESET><GREEN>15<RESET>
        PAGER  20<RESET>
        <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
        EOF
        test_write_lines s y g 1 P |
        (
                GIT_PAGER="sed s/^/PAGER\ /" &&
                export GIT_PAGER &&
                test_terminal git add -p >actual
        ) &&
        tail -n 7 <actual | test_decode_color >actual.trimmed &&
        test_cmp expect actual.trimmed

--- expect      2026-01-04 06:01:25.931220332 +0000
+++ actual.trimmed      2026-01-04 06:01:26.079845771 +0000
@@ -1,7 +1,7 @@
 <GREEN>+<RESET><GREEN>15<RESET>
  20<RESET>
-<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 PAGER  10<RESET>
 PAGER <GREEN>+<RESET><GREEN>15<RESET>
 PAGER  20<RESET>
-<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
not ok 50 - print again the hunk (PAGER)
#
#               test_when_finished "git reset" &&
#               cat >expect <<-EOF &&
#               <GREEN>+<RESET><GREEN>15<RESET>
#                20<RESET>
#               <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
#               PAGER  10<RESET>
#               PAGER <GREEN>+<RESET><GREEN>15<RESET>
#               PAGER  20<RESET>
#               <BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
#               EOF
#               test_write_lines s y g 1 P |
#               (
#                       GIT_PAGER="sed s/^/PAGER\ /" &&
#                       export GIT_PAGER &&
#                       test_terminal git add -p >actual
#               ) &&
#               tail -n 7 <actual | test_decode_color >actual.trimmed &&
#               test_cmp expect actual.trimmed
#
1..50

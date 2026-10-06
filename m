Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D726380FD5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309989; cv=none; b=H2/LT/zrEAhMbaa4NZGJizvuDtU4IK6GXmRuAakn3F+RgToPB0Zy1PI37f11+Nf9NulyY57/7Z2zk4Znp5f+EV2URQCmvte9yA9wMNcvlWvplYY1CBDZuOwkiQ2zVDiXvEq7nb0OdSQQ9+d+wxdrrtwmFr0KR8S4PON0jdasnig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309989; c=relaxed/simple;
	bh=7mysGIFQTSgL+eiCYXzpWnxtuO0fiisAXmcHpZ9Edyg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4YF5zWLyJZ8c3tPX+9kfwYGonbtzvm1yChfqhls0iewDsjT/wK5fLByPxe7CsFhr/s480eYZ56/zimsaj5l6CHMo5v3Mrluk6po7O+vvJ/vTob23iUhi+Lc3IKUX5mlaVGW4y083MHvb/m8IthiqfU+TcyftS52cttqLOeHiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Tqc1TCTT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Tqc1TCTT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5351e6a2230so7075111cf.3
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309987; x=1791914787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWaLL2NsvqixQBf4jjG0DnSopocvNz6aSzON8YQjbGM=;
        b=Tqc1TCTT5RvnB6XNrX7Y7jEQpOKQ/uH2BWYhBlMzsLEr71vXpmdMA3TsbkmCY1cnQB
         iBeZL/KI3PetLW9CRLPfXwg5JBjpb8p5KFkFurpH2/ZLpUDMqIHnzoB8SMXIIsmNFEEH
         BNVX7E0yWtTcBG5pB+zgF2T0XRLBrNDHHeE34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309987; x=1791914787;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWaLL2NsvqixQBf4jjG0DnSopocvNz6aSzON8YQjbGM=;
        b=XoQjzCRQDIDSeoHqVLIgb42L/fyweXVzE1MHZ1VKDezyyoujtsbMP0amIfoD5eySc+
         GFFKOTY5xPlILTu7iiDnnCGo8pSBSr7fCAW04XALfNEHRVRWF2ejt7ZyM7Esu5IRjse9
         BRYFNpcciqTAVDFZWBI5CViSRy8YSk/F4xowC/W2UoYD7tv0qT1zOALk/PwRVy3WY1N9
         tvmo6zWzza05U2zmK2xyGO3By74o8xGNZgs5sIR5Z68sH0yax13KexP2VxDAf/1fDqiE
         woCNOtX0rtyhtPsFtwAsP009Gt2rPjw3HhWDOmnHJSTB74NCwY3VQJOtvH7C8b1skf1b
         YPdA==
X-Gm-Message-State: AFuF++m5Ha31iEvACmw7lqIc9vX7G3z1eUMs6Izq1vgE5SZTvUws3SyX
	++PgsaJyVpxpniWfHonCM+nrte2AYuISKmLBttzg4nEC72Mvo4Mfx8Ahc2YJh9kXtZsrPMuTS/R
	qF1paOY8=
X-Gm-Gg: AYBFou1Q5SHnbeESHemnZQ61vkV4P3dJ7Hi+ad+GAV1II17CxHUsdfuEVEKzZxwq7eO
	NyDLOrQAmyek/wIbdqX2BcUh+FEaLrx1MTjRhvPZzFaOv2WxBsR3jFV2Z502o9Jex8oY4kFZlBs
	VoF20Em4ogpkFRR+Z4aPOPT6H8wWTk5LlPLF2UEYhQbIw7rxCNP4Ss9wC/helXpkm50BZBZjUvg
	ejPf7XhGGDvM15yLT+zwWu1wNZVinlARbqUJ0vxYM478I0MyuI7cORoDVFJk0jm193KHnIMZvio
	mkqU3gcbCd3w3E7f3yYJVeqryh3LPJaL2DeCiIY3Kh2dmoJUwqhIac5h5evmL2Ls9vEgNxw5H2H
	ZgSOIjxxRsT1JWT6Woan5XkPzBeiGHQhgLVsNQRj5m9NYcDhwfWe6fNNxQusa9Jc3m2Ou3DGxHI
	Iq+g9bFJiIwv2PEBqTZTKcRAF56JbQkMEOxqR3SJ7qH5I3tl1sCz6NpoGOG/JYwPO+vbWe5XcQh
	76uhW4bZPPXpRWriTx7Oh9+ewisc76iyfvSjJ+N6OAjS2/UQUQRE0SESHGwiQg5OPvguTaPdEuj
	Xh7CdMZi1Zw=
X-Received: by 2002:a05:622a:4c13:b0:533:3572:250f with SMTP id d75a77b69052e-53566f8ba74mr38296791cf.36.1791309984374;
        Tue, 06 Oct 2026 11:06:24 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535721e3da9sm1373061cf.29.2026.10.06.11.06.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:24 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:21 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 03/07] Documentation
Message-ID: <summit-2026.94e33e9ddf234334.03@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: Documentation

* Julia: There is a big gap between contributors who know Git's concepts
  and users who do not know what objects or the index are. I have been
  working on a website to bridge that gap. We do not explain some basic
  terms, such as "upstream". Some documentation receives hundreds of
  comments. How can we bring that feedback to the mailing list without
  overwhelming it, and improve the documentation with very little
  funding?

* Patrick: Could we expand the funding? This work is important, and we
  are not technical writers.

* brian: We have gitglossary and the Pro Git book, but it would be good
  to have beginner documentation. Many users arrive from university
  without knowing these concepts. I have submitted some documentation in
  this area.

* Patrick: Pro Git may be outdated in places. Scott wants a new version
  and could fund somebody to work on it.

* Emily: We can suggest a huge book to somebody who is new and just
  wants to use Git.

* Peff: The manpages are reference material, so they should be terse.
  Most users also need something less terse. If somebody is interested
  in working on this, we should consider replacing outdated
  documentation rather than preserving it for its own sake.

* Patrick: We should allow iterative work. Review can be nitpicky, but
  perhaps we can be more accommodating so this can move faster.

* Julia: Being able to merge quickly and iterate would help.
  Mailing-list feedback is useful.

* brian: Thank you for working on the documentation. Bad documentation,
  or no documentation, makes software hard to use.

* Patrick: Terse does not necessarily mean accessible. We could learn
  from TLDR and include examples.

* Julia: Examples are useful, and we should update the existing ones.

* Josh: We could consider Diataxis, which separates tutorials, guides,
  explanations, and reference material:
  https://diataxis.fr/

* Julia: The format of the reference manpages makes sense.

* Peff: I did not mean to defend the manpages. New-user documentation
  and manpages are two separate things, and both need work.

* Julia: Git has guides and manpages, which is a useful separation. The
  guides are harder to discover; the manpages are more accessible.

* Patrick: How much time do you have funding for?

* Julia: We have 100 hours split between two people.

* Patrick and others: Perhaps we could use the Git fund.

* Peff: Other companies might also be interested in funding the work.

* [OpenAI, GitHub, and GitButler were mentioned as possibilities.]

* brian / Emily / Mark: We can ask about funding.

* Mark: We have both machine-readable and human-readable material.

* Toon: We are only discussing written documentation.

* Peff: Costs can escalate with video. I am biased toward written
  documentation.

* Patrick: GitButler has resources, and younger users may prefer videos.

* Julia: We could link good Git videos from the website.

* Emily: There are links on Discord that we could include.

* Julia: We do not have a good entry point on the Git website explaining
  how to learn Git.

* Peff: The site had one, but it gets outdated. We should refresh it as
  we go.

* Julia: Some documentation says "see section XYZ" without linking it.
  We cannot link to subsections of manpages.

* Peff: I spent some time generating subsection links.

* Julia: We have links to other pages, but not to subsections.

* Peff: References in the text need the linkgit markup. This could be an
  incremental project.

* Julia: I added a cheatsheet to the website. Do we want to move away
  from ASCII diagrams?

* Patrick: Could we use different sources for different outputs, with
  SVG for HTML and ASCII for manpages?

* brian: We could do that.

* Patrick: Perhaps Mermaid would let us keep a plain-text source and
  choose the output format.

* Julia: It should be possible. We have CI scripts that Johannes worked
  on, and we used Graphviz.

* brian: There are extensions, but they are not packaged for
  distributions.

* Peff: We support both AsciiDoc and Asciidoctor. Would it help to get
  out of that dual world?

* Patrick: Traditionally this was for migration. AsciiDoc was thought to
  be unmaintained, but it is maintained now.

* Peff: We could move to Asciidoctor.

* brian: Fedora still uses AsciiDoc. Asciidoctor is well maintained,
  written in Ruby, and reasonably portable. It depends on how much we
  want to support. I do not know whether Fedora is still an obstacle.

* Peff: Who would object to moving, and how strongly?

* Junio: We could include it in Git 3.0 and add it to BreakingChanges.

* Josh: Some documentation already renders poorly with old versions of
  AsciiDoc.

* Peff: Send those bugs to the list; somebody may be interested in
  fixing them.

* Josh: We could use this to fix the build pipeline and move away from
  AsciiDoc.

* Patrick: Fedora does have Asciidoctor, version 2.0.26.

* Peff: I tried Asciidoctor on Debian, and it works well. There are some
  rendering issues, though it mostly gets things right. Julia, would you
  be interested in using doc-diff to compare the outputs?

* [Patrick created an issue during the discussion.]

* Emily: Do we have traffic metrics for git-scm.com?

* Taylor: Some high-level metrics in Cloudflare.

* Peff: We had Google Analytics, but were not comfortable with it and
  removed it.

* Emily: It would be useful to know how many users read the
  documentation.

* brian: It would be useful to know which manpages people read, while
  being mindful of privacy as an open-source project.

* Taylor: Could we self-host metrics, or use a third party that supports
  this?

* Mark: Fathom is one privacy-focused option:
  https://usefathom.com/

* brian: Even webserver logs would be useful for getting some numbers.

* Peff: On Heroku, the caching layer meant we did not see accurate
  numbers.

* Patrick: Will AI scrapers drown out the useful signal?

* Toon: I opened an issue about this some time ago:
  https://github.com/git/git-scm.com/issues/2054

* Taylor: We enabled it, but did not see useful information.

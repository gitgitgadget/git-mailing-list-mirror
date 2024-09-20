Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161F17B4FE
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842168; cv=none; b=S9beLu8+CjIGKK+nBIcB8YL/FtFh/mY7+ZJa32oDih7jO6khgw4a9rM0p94SfGptV5E8zahvMiYh4HV55kiOWDzV8aEpfg8kaRHfhEysT2O7bQYpUwBbal+aAM4xPPemFjHH7otkttc+YcHck8UtgD2xySRvSmnYnm7nECqBqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842168; c=relaxed/simple;
	bh=yMQlYh8bQN/rHUZoXJ/k6U8Ltnf7686yGE2xwXcVPZg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOyGZV0hOBmhWOfpMtiFmPMREIlWSkAaU5ujvTcNqK4BeMT1ELt6bOEoJxamcyVOxNoUfUglah7plYzZdiFBQ7R+BjuET41y8xcOKUMdS0QJ4DgRT51L+gBdz6DrZDz6xh1dwrF5SueOZAzqfBCVUJwLZOJyQBQpddo1lCelZcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yTUSQtkM; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yTUSQtkM"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0cbc08b38so2826925ab.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726842165; x=1727446965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhWneDaB2kNNIjdyfO3BcIFx3maYR5g2uDZCn1RcWdk=;
        b=yTUSQtkM0QhDRfMeaM9Jb55FhMYWJ7HETgaR0TpmmwJX0cGtl4nm7aRJTcm3eW2n3W
         gG+FAbqoMgaEZJlouB5WDEOgd3+Fu8fzGoe5KIk1I/GqwlT7qNc0bC18WHk3jlzh7X4J
         sq5tI90jndxl6oRa3Pnhrp0zflnCxfWMYcmRrxsJDFnXtbHv+MmwSNNNrz/WlDTHfi34
         PKrk6JdaVxJA4Pye212XxFeY2P+eiSJNMadQonB090UnLdkqHwA3C9eCbC1yNpb1Av5F
         I88n5modde/VOMk82wYRFTiLWRSL2XynD7Vb5nkulWg1d9aFa4BccW8I+17GN/QePJ5L
         1flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842165; x=1727446965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhWneDaB2kNNIjdyfO3BcIFx3maYR5g2uDZCn1RcWdk=;
        b=Uloys/nWXGsjf6xO1M3fhqgHd/obp6qzQ+UZZe8JcA3+BYYzhJvrWtAXmA3YxJL5Cl
         aHYOMc6JEqaG+Irrp98/0yrtk5iy/bmcVFO+kKJqhP9plDpu3P2NQ6Oew9oF0IKhP/ah
         IqzRZEj2f+0R11Ei43OfJz/VJlZjMfH9u4rBcYEmJcF0HwKAvFolFu8wUPdej8u274ub
         Eo9ZTLFitVD98DYyQFcf9VidDmuSsTxej3t2GQxRYJ9R4oH4Fv9IkN2lmYpsuOHCDMLB
         WaWc+eJT1PxzTcfULuWNcIJ/GSTyUCwhuc3otuf1Mq88LdxziYJmqK3zHHCYA4YQWCJ7
         glKA==
X-Gm-Message-State: AOJu0YzF3aG72/GcNMB366NOfYP96YwLDze3A5pjy47XHuhBbfHnNQZ/
	3l1JZMw+qYMjVPMIwhirAZ9xvg735/bk2yJsLq4eEEydFzvr7z4NvJKp3kijG83fupuCQofDawi
	5IrDzTw==
X-Google-Smtp-Source: AGHT+IHKy5Nh3kCwj4xLVO6l/T1RQsZ90n9++Ttv4nI0KsbtS2gTkbmBfzWNq8rsRVoAKiqqomW0ig==
X-Received: by 2002:a05:6e02:180f:b0:3a0:98b2:8f3b with SMTP id e9e14a558f8ab-3a0c8ca77d2mr32856585ab.7.1726842165124;
        Fri, 20 Sep 2024 07:22:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e7171asm42215235ab.56.2024.09.20.07.22.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:22:44 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:22:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 10/11] Project Tracking
Message-ID: <Zu2FMQnLCKQ2skkM@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

Project Tracking
================

(moderator: Emily, Patrick; notetaker: Taylor)

* Emily: Patrick and I were talking about roadmap-like things sometimes
  this week. It would be nice if we had a list of projects that the
  community has agreed are good ideas. For e.g., “generally we are
  working on getting rid of ‘the_repository’”.
* Emily: We have agreed that libification is a good thing, so anytime
  that someone sends a patch in that area it isn’t up for discussion
  whether or not the patch is fundamentally going in the right
  direction.
* Emily: It would be cool to have a list of agreed-upon things. I also
  think that we should get better at figuring out what we agree on.
  I.e., the status-quo is argument on the list until quorum, and would
  like some kind of more structured way to determine when we are in
  agreement.
* Jonathan: When you say “predictable process”, what does that actually
  mean? Python has PEPs, they have a very clear state machine that
  stringently dictates the process.
* Emily: probably not something that strict, but would like to generally
  be able to tell “is it going in the right direction?” And
  approximately, “Approximately when will we be able to tell when it’s
  done?”
* Taylor: how do we quantify that? A lot of what developing consensus
  looks like is developing patches and then sometimes throwing them away
  if/when we find a fundamental design bug, etc.
* Patrick: “Are we going to do it?” is when something like a brief RFC
  is merged.
* Taylor: Is the Git 3.0 deprecation doc a good example?
* Patrick: Yeah.
* Patrick: We would also want to have a document with a little check
  mark indicating when we are going to do small things like clean up
  memory leaks.
* Jrn: The pain point is being able to know when making a proposal how
  much support they have.
* Taylor: Sometimes implementation clarifies one’s thinking.
* John: We have some tribal knowledge on what is accepted in which
  areas. Can we codify that?
* Patrick: The BreakingChanges statement says that we can change things
  on the document if there is new information. I’d like to see that this
  statement is echoed elsewhere.
* Taylor: It feels like it would be more useful to have a discussion
  based on a WIP or PoC (e.g. UNLEAK() and FREE_AND_NULL()).
* Peff: I don’t want people to produce patches, say, if we blessed unit
  tests, and then consider that discussion immutable. That doesn’t give
  us the opportunity to make changes to the fundamental design. I don’t
  want to use it as a cudgel to shut further discussion down.
* Jonathan: “I guess I am going to argue in favor of cudgel.” Taking
  unit tests as an example, if someone later says “I don’t see any value
  in unit tests”, that’s not very productive. If they say “I see the
  value of unit tests, but not at this cost”, it’s a more worthwhile
  conversation.
* brian: Maybe we can only use that as an argument for 4-5 weeks. Having
  some disagreement is fine, just don’t want to make it indefinite.
* Peff: On PEPs. Often someone will say “I’m going to go in this
  direction”, and I’ll feel mildly negative about it. That’s very
  different from voting against something.
* Emily: Sure, there can be more voting options than just
  yes/no/abstain.
* Jonathan: Apache does a nice job with +/- 0, +/- 1
  (https://www.apache.org/foundation/voting.html#expressing-votes-1-0-1-and-fractions)
* Emily: we should be better about saying generally how we feel about
  things at the end of the series).
* Taylor: Taking a step back for a moment, what are some examples of
  things that are going wrong that need to be changed? What is wrong
  with the project here?
* Emily: things are taking too long.
* Emily: Goal-posting moving, etc.
* Johannes: Yes, that can be very frustrating and cause a lot of
  friction.
* brian: When you do creative work, you get feedback and sometimes you
  take it and sometimes you don’t.
* Taylor: at the risk of repeating what brian said, it’s hard/impossible
  to please 100% of reviewers on 100% of series. At some point you have
  to step back and let the maintainer evaluate.
* Jonathan: I think the point of Patrick’s proposal is “how do you go
  about navigating this with a 10-series long project?” Then you’re in
  trouble. The proposal would allow you to check in a bullet point, or a
  design doc, and go through that process and navigate to the point
  where you get the maintainer’s blessing and the conclusion is checked
  in.
* brian: Maybe a bullet point is too small for some things.
* Taylor: so it’s a continuum, sometimes you are going to save time by
  just writing the patches, sometimes you are going to save time by
  writing out what you are doing (over a multi-series effort) first.
* Patrick: discoverability!
* Mark: could we encourage newcomers to email one of a few people for a
  particular effort (like libification) and have them comment on it?
* Taylor: you might not want to centralize that much power.
* Toon: How about structured errors? We agree it’s a good idea, but not
  on the mechanism of implementation.
* Patrick: Sure, sometimes that just takes time. We don’t have to
  document how to fix them (maybe how to find them, but I digress).
* Patrick: For structured error handling, it should be more involved. It
  makes sense to have an RFC or design document that documents how it’s
  supposed to look like.
* brian: or an initial patch series that comes up with a design.
* Peff: In our project, the formalism of voting is “is it merged to
  ‘master’ in Junio’s tree”.
* Emily: I want to have the process of getting from discussion to merge
  be less fuzzy.
* Peff: So in brian’s example, let’s take SHA-256. The process by which
  the maintainer decides that is inherently fuzzy.
* Emily: Sure, but I would like to be obvious to someone besides the
  maintainer.
* Jonathan: (to Peff) you mentioned sometimes you have a mild negative
  feeling about something and you’re good about expressing it on-list,
  but for a lot of contributors that will cause some discomfort and it
  will cause them to stay away from that thread. If we’re a little more
  clear about what’s expected, then conversations can get stalled less
  often - e.g. when a thread needs a comment from a refs expert, getting
  that comment that supports forward progress.
* brian: I just gave Taylor feedback on the SHA-1 series that he wrote,
  saying that I didn’t love it. But others felt OK about it, so we moved
  forward.
* Emily: strawman doc:
  https://github.com/nasamuffin/git/commit/54079ab00002c6dfa7ac1a33d9810792978d2cce
  - maybe it's bad enough we can poke holes and salvage something we do
  like
* Peff: it’s important to leave at the end of your review the way you
  feel about something instead of just having a few comments.

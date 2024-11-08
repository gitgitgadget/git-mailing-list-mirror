Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287C21E2603
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063231; cv=none; b=JPegjf4V6AFv2khvPNUsT8HUeM4UEGS74hb0I9y0HAXTgWb+cCbbpTHPmml57qZwMxpPlpKy89FA48vbK+pi9dAWLtmrpk9Mnws/ey9C5DpcPMmlhLPYsHMkllk50ujm2relYrt99XTG4/c1ElmR/QUUq/z9PuPXRNG6EXRpDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063231; c=relaxed/simple;
	bh=Q1Pq9JLX+thEIo+BNsR3yHZ9XsIpmQ90ZKOBZSEzJKQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R6GKif1+JMUSUAztIwY1ZODkMFPJsF3j4RVvcV2o9BsbBwQgsJv59Z2T7ySP5QtqMBznHgoG0EcUywu4k9PlFw2Ai9ERrdbphyUspbeI7bW794orMuhITh8qm6jw/VDtGy5DrrpyILxmmXnSTBLezv5K3Be9yvP4El0iGNk9bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=gpX8use3; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="gpX8use3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731063225; x=1731668025;
	i=johannes.schindelin@gmx.de;
	bh=dFx7XUyl4REHft3WPncS4lVYjltlKiRg4r/B4GVUo/I=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gpX8use3DmaldGobpkoaDQMKbPUof8m+5y7Ly4++fuTy84u1acKOPli6tSossTGB
	 /HLVuXL65Plum0U1hyowD+wO1Ny3n/qdyn2PFOQrQCZiwNjga/kAewWDAwpFhHvpK
	 Yu6E0L13DcDpdQe1x2Hg/7V71hhVbCEJsxSJrR6f6nNehqm3ek+Uor8tIbhiN76NU
	 NeWnY76D8UqlYH1w7iJDVWzhOR9leWkJyN7GM77+v7Hu1S+fefTUptY272tRXHTzI
	 4jBAaOw3frW+1YOkJ957HV1W+oSwssN4WN5Eih2zVeSFqQVWsIXm+W29MjbfdeCvZ
	 F4JWu7teD8v7Q2u8pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.65]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1tc4eY1EIl-00k1Q0; Fri, 08
 Nov 2024 11:53:45 +0100
Date: Fri, 8 Nov 2024 11:53:44 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
In-Reply-To: <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
Message-ID: <af576487-5de2-fba3-b341-3c082322c9ec@gmx.de>
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com> <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ly/IyD+aKCspx/xEdH9sXYGNHdFSMxJ9557JEQlDn8riwHIggGF
 N/hBvBKhQ033vNEWJnFmEisH65JqSBYT9mtUbVydN4scY3U5u/EpBq67LBRKxxniiT+8JCt
 W0RtF4dyi7stK9w5Jmnq2MsbnnAKQb+JBMYqgc/1KcPj7xOVoDfdSG2pGUtUt1JLqbL/dfu
 SjQXRcxoy9fePcqpEgc2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gDi3xvZe59w=;iB4XdcL9ZRVr2eyVUq7OtbKTOYB
 qhNf2Tpx1xhYJXNKv4j4bxpt8yu7r0zBhJrNHZOjwNMWyTGhQORbeWXWyF35UW+n6hs6fV6gB
 FU9bocPx3SOB690J21cjHIsTLpQCp5c7Z23iWT++rop73SbotGAIn71wdgD5KW93I49dWQsF5
 uaiJvH+6GvOnc8kiTW5tjeLlxJxMxEXh1EeljHdqJjCC4uicxE+dYHiU5DBFYsl+7ILdb/hQ1
 DE3JZSOFCIAwVhtTHo9mRZoIFv+8p/Byzvz0rAosqD5KThEZojnwUd6kC8CINzXywn95uocnW
 4gm2TpmHSSHMtVkPNvzt7EWNB0Znu8We5+90pDCSprkF66nO5gpj2SxD19L66MwAlMUX3l3T7
 orCDhB37VBjD6129jSGRFVqpGn/tIKIT6kWQInT7HYkeiHbnr6Ep/aVH7bF2XBHxP7DFA4XGr
 0CBc6L2jjUvBSH+RCVjjblm9vJDOh2Vb20xNnBQ+ndPSQ91aRG7fQ01BuuX6xar9YM0WELNyF
 2j4Hw7FrQ1YZ+xKocyBbUOyCYRsugcuEVCPvtviBTdwtiTeOoAzYONUZ977OkBM0jDnNZCY5r
 5pqDsOxrMA0Dhaemajnb7xBXmQoE45o3jNi3KIBRKuKbj37gV6FxBBIozbt6Qlb0vILUcQmF9
 5TmiS30ieeRzvI/8MbUCjzmVB9Fc+z6gvjCdYzgr1qsYq9TU1SquJuB6qkTdHdgHgq8T39tGj
 rgUtfVxRnhprHZWFxEq4dMm02/jc7IsWnKrNPQu/Ksp3qyks1yN8LqRo0OUDz7hTLtAHIfGtH
 hjx3dJf/3Su2+mV/u1lPEpnw==
Content-Transfer-Encoding: quoted-printable

Hi Hannes

On Fri, 8 Nov 2024, Johannes Sixt wrote:

> Am 07.11.24 um 18:20 schrieb Johannes Schindelin via GitGitGadget:
> > +--diff-merges=3D<format>::
> > +	Instead of ignoring merge commits, generate diffs for them using the
> > +	corresponding `--diff-merges=3D<format>` option of linkgit:git-log[1=
],
> > +	and include them in the comparison.
> > ++
> > +Note: Some of the formats supported by linkgit:git-log[1] make less s=
ense in
> > +the context of the `range-diff` command than other formats, so choose=
 wisely!
>
> Can we please be a bit more specific which options are usable or which
> are not usable?

There are a couple of reasons:

- Most importantly: I had not even studied that question in depth when I
  wrote the original patch, and not even when I submitted the first
  iteration.

  In my reviews of branch thickets, I used `--diff-merges=3D1` and it serv=
ed
  my needs well. Therefore I can speak to this mode, but not really to the
  other modes.

- Which options are usable or not may lack a universally-correct answer.

  One person might find `--diff-merges=3Dseparate` confusing while the nex=
t
  person may find it quite useful.

- If the documentation points out an unsuitable mode, then an obvious
  follow-up wish would be to reject this mode in the command, with an
  error message. Some users might, however, need precisely this mode, so
  I am loathe to do that.

Maybe this compromise: Change the "Note:" to recommend the `first-parent`
mode, with a bit more explanation why that is so (it is consistent with
the idea that a merge is kind of a "meta patch", comprising all the merged
commits' patches, which is equivalent to the first-parent diff).

> Perhaps you even mean to say that 'first-parent' is the only one that
> makes sense?

I would not go _so_ far as to say that.

Before submitting the patch yesterday, I played a little with a few
modes, using the commit graph as per the new t3206 test case.

What that test case range-diffs looks like this:

 - * - changeA - changeB ------------
     \                     \          \
      \                      conflict  \
       \                   /            \
         rename - changeA - changeB ----- clean

In other words, the main branch modifies a file's contents twice, the
topic branch renames it first, then makes the same modifications.

The clean merge simply merges the topic, which makes the main branch
tree-same to the topic branch.

The conflicting merge misses the tip commit of the topic branch, i.e.
changeB on the renamed file. The result is tree-same to the clean merge
because changeB on the non-renamed file is already part of the main
branch.

Out of habit, I used `--diff-merge=3Dfirst-parent` in the new test case,
whose output reiterates what I just said: both merges introduce the same
first-parent diff (renaming the file, no other changes):

	1:  1e6226b < -:  ------- s/12/B/
	2:  043e738 =3D 1:  6ddec15 merge

What about `separate`?


	2:  043e738 =3D 1:  6ddec15 merge
	1:  1e6226b ! 2:  6ddec15 s/12/B/
	    @@
	      ## Metadata ##
	    -Author: Thomas Rast <trast@inf.ethz.ch>
	    +Author: A U Thor <author@example.com>

	      ## Commit message ##
	    -    s/12/B/
	    +    merge

	      ## renamed-file ##
	     @@ renamed-file: A

This might look confusing at first because there are two merge diffs on
the right-hand side, but only one on the left-hand side. But that is all
good because the diff of the clean merge between merge head and merge is
empty and therefore not shown. And the `range-diff` demonstrates that the
conflicting merge had to recapitulate the tip commit of the `renamed-file`
topic branch.

The `combined` and `dense-combined` modes produce identical output to
`first-parent` in this instance, which is expected.

Now, let's use `remerge`, which should be illuminating with regards to
"evil merges" [*1*], as it shows what was done on top of the automatic
merge:

	1:  1e6226b < -:  ------- s/12/B/
	2:  043e738 < -:  ------- merge
	-:  ------- > 1:  6ddec15 merge

Huh. That is a bit surprising at first. Let's use a higher creation factor
to ask `range-diff` to match correspondences more loosely (I used 999,
which kinda forces even non-sensical pairings):

	1:  1e6226b ! 1:  6ddec15 s/12/B/
	    @@
	      ## Metadata ##
	    -Author: Thomas Rast <trast@inf.ethz.ch>
	    +Author: A U Thor <author@example.com>

	      ## Commit message ##
	    -    s/12/B/
	    +    merge

	      ## renamed-file ##
	    + remerge CONFLICT (content): Merge conflict in renamed-file
	    + index 3f1c0da..25ddf7a 100644
	    + --- renamed-file
	    + +++ renamed-file
	     @@ renamed-file: A
	      9
	      10
	      B
	    +-<<<<<<< 2901f77 (s/12/B/):file
	    + B
	    +-=3D=3D=3D=3D=3D=3D=3D
	     -12
	    -+B
	    +->>>>>>> 3ce7af6 (s/11/B/):renamed-file
	      13
	      14
	      15
	2:  043e738 < -:  ------- merge

(Note that if you repeat this experiment, you will see something different
due to a bug in `--remerge-diff` that I will fix separately.)

Hold on, that looks wrong! It is actually not wrong, `range-diff` just
finds the changeB a better pairing than the merge commit with an empty
diff...

So: This mode can be useful to detect where merge conflicts had to be
resolved.

In short, I think that in `range-diff`'s context all of these modes have
merit, depending on a particular use case. It's just that `first-parent`
is probably the most natural to use in the common case.

> At a minimum, we should mention that it is the one that makes most sense
> (if that is the case).

Yeah, I'll go with that and drop saying anything about other modes.

Ciao,
Johannes

Footnote *1*: We should really find a much better name for this than "evil
merge". There is nothing evil about me having to add `#include
"environment.h"` in v2.45.1^, for example. It was necessary so that the
code would build. Tedious, yes, but not evil.

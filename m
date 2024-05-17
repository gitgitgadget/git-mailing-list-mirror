Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CE20B3D
	for <git@vger.kernel.org>; Fri, 17 May 2024 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978150; cv=none; b=XqLkTg5F0n5g6AmhP3lvtrUpghljPvte7V12kQjkIfQCafxEjRNrOYsE4U5ZUyFq1jD2x8cRkXQ2C/oCBploG8iopc33Yt+lrIGDrNs1Yw9j6muIq62AmxY6ss7U7YaNWiy3KVoDo8brWp5OTHqHzkM9DE03qSouNmtnyRhaN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978150; c=relaxed/simple;
	bh=p3JzMS4u5lgjUNGgzqfyYdQf39iEt4Rxd10tlRlCj8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9zy0sAk0kE0edabXHjlxDCRQa/CQOF4z7kHaezfqUv55u3J18e63iP9Fgn8D7G2EF6d+hrOWDf4GXWyiqQxuWKz6/s1H1nmNGUsaX3sNJhdBMJk6rF69vK90LoW1aPILYcS+NICt/qDvz45SLrgif++CEVN32A//9GPgz7fEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWRMihsa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWRMihsa"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de610854b8bso16615830276.0
        for <git@vger.kernel.org>; Fri, 17 May 2024 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715978147; x=1716582947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGCeH7842+7f+rBKgjPfG28f5OaIs6dxbnWoIVDwH80=;
        b=fWRMihsaYJfbgTHB9CrMulGNhF1V6PK6EkL0pGQvXhFEQORxR9FQ9WASB9to0s6hDR
         RQn2IrbksOju9VvFDjUnCQWAESczv3QNNa4mNz3QvJZJ/NhZoFaOvFZDpPs+XYEI9/Ma
         tMy0l+AkvWvyKz4LwFFVRcyCNCZE8A/N9y+keCOgLPRd6DO1/rJu82ftUX8xrtuIfsLe
         +coID0tqNFy2Z99+uiCYFPJ0ZjDyJSF8clsyYytSE7mBdfm2weXcTAfCLhkeldMBSdhj
         VKZEbfJD0MXb4AnPjL61v3hkvDd/c84NND/ogpxhPolCjQiKb7SLyOvmfNxHeecBubB3
         VYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715978147; x=1716582947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGCeH7842+7f+rBKgjPfG28f5OaIs6dxbnWoIVDwH80=;
        b=rj9n2RGp3ggu8DdfwhqZiBBLZIgd8QwIzgfZpGj2FS3Qap5FJC5LMYbVXxlX1nyExS
         d6qvkpXvQHLsK0BKR+xtr/mvPxSogQJQQcz1SMwIrYFSBOLi1C9hhXzSrnDfQ8PQcI98
         mt/WAGt/97BpYpkN+VeD03BCSvzGzJYO6XOOhyOzaXpyCIVhenZwKi16QmV9eS5gOSUk
         iAD6O/9drsKZC1ZuCrLnC7m+BA7TwrDXZFef9IW5FG0WRQWatkdjr8yevyvA2Hc49T4X
         aGqsbhojfVE6NoO6jD+k/++xR6zgK9yxbLhYTXU5/yWmHhOOQAfr5KnTx+NUy4UXHkTj
         PLNw==
X-Gm-Message-State: AOJu0Yzxxn9/Ay920n5V4VfUjqdcC9+fl8OufRqYzlS3jr1zIHck11kW
	LH+htlw9ZyhQlgvnEaKcdmjWktZ0kHqij/VWf6b1aR+YLNMMAIO8c82rSw/YGl03lJduyZCutwA
	eHBTUo/N/nGUeVwL6CxFfQawga9bq0+RpxpekWJF/j18gOuqwSQQ5RSPoo2w70tXlEogP9kwE2M
	u/MS+MPLA+3t2nCcTp4GUQsYGQ1XqRtk8umdzuOKQ=
X-Google-Smtp-Source: AGHT+IGgLo6oN4ldTGEaLGCvLODfW3mw8BUZufwbmupXs4ZZ3Ud4U0yDSrKDfMOB0IKAQYwRdOdNlW/B5ZhfRQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:a727:f495:f5ea:38b8])
 (user=steadmon job=sendgmr) by 2002:a05:6902:708:b0:dee:6802:dc48 with SMTP
 id 3f1490d57ef6-dee6802ea13mr1758547276.2.1715978146656; Fri, 17 May 2024
 13:35:46 -0700 (PDT)
Date: Fri, 17 May 2024 13:35:44 -0700
In-Reply-To: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <10f217915600eda3ebec886e4f020f87c22e318a.1715978031.git.steadmon@google.com>
Subject: [PATCH v4] doc: describe the project's decision-making process
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com, ps@pks.im, emrass@google.com, 
	nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"

The Git project currently operates according to an informal
consensus-building process, which is currently described in the
SubmittingPatches document. However, that focuses on small/medium-scale
patch series. For larger-scale decisions, the process is not as well
described. Document what to expect so that we have something concrete to
help inform newcomers to the project.

This document explicitly does not aim to impose a formal process to
decision-making, nor to change pre-existing norms. Its only aim is to
describe how the project currently operates today.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---

Changes in V4:
* Minor wording cleanups to be more emphatic and to clarify "other
  specific implementation" phrase.

Changes in V3:
* Squash in Junio's suggested patch to remove discussion of small-scale
  patch series.

Changes in V2:
* Split doc to treat patch series discussion as the general case, with
  larger discussions (with or without patches) as special situations.
* Add links to example discussions for certain situations
* Add link to contributor summit notes
* Add link to Code of Conduct doc
* Add justification for keeping discussion on-list
* Add paragraph about explicit negative consensus
* Minor reword of advice on when to CC experts
* Minor reword of doc intro to avoid indecisive text

Range-diff against v3:
1:  5446ca49e0 ! 1:  10f2179156 doc: describe the project's decision-making process
    @@ Commit message
         describe how the project currently operates today.
     
    -    Co-authored-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/DecisionMaking.txt (new) ##
     @@
    @@ Documentation/DecisionMaking.txt (new)
     +Larger Discussions (without patches)
     +------------------------------------
     +Occasionally, larger discussions might occur without an associated patch series.
    -+These might be very large-scale technical decisions that are beyond the scope of
    -+even a single large patch series, or they might be more open-ended,
    ++These may be very large-scale technical decisions that are beyond the scope of
    ++even a single large patch series, or they may be more open-ended,
     +policy-oriented discussions (examples:
     +link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
     +or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving submodule UX]).
    @@ Documentation/DecisionMaking.txt (new)
     +For larger discussions without a patch series or other concrete implementation,
     +it may be hard to judge when consensus has been reached, as there are not any
     +official guidelines. If discussion stalls at this point, it may be helpful to
    -+restart discussion with an RFC patch series or other specific implementation
    -+that can be more easily debated.
    ++restart discussion with an RFC patch series (such as a partial, unfinished
    ++implementation or proof of concept) that can be more easily debated.
     +
     +When consensus is reached that it is a good idea, the original
     +proposer is expected to coordinate the effort to make it happen,

 Documentation/DecisionMaking.txt | 74 ++++++++++++++++++++++++++++++++
 Documentation/Makefile           |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/DecisionMaking.txt

diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
new file mode 100644
index 0000000000..dbb4c1f569
--- /dev/null
+++ b/Documentation/DecisionMaking.txt
@@ -0,0 +1,74 @@
+Decision-Making Process in the Git Project
+==========================================
+
+Introduction
+------------
+This document describes the current decision-making process in the Git
+project. It is a descriptive rather than prescriptive doc; that is, we want to
+describe how things work in practice rather than explicitly recommending any
+particular process or changes to the current process.
+
+Here we document how the project makes decisions for discussions
+(with or without patches), in scale larger than an individual patch
+series (which is fully covered by the SubmittingPatches document).
+
+
+Larger Discussions (with patches)
+---------------------------------
+As with discussions on an individual patch series, starting a larger-scale
+discussion often begins by sending a patch or series to the list. This might
+take the form of an initial design doc, with implementation following in later
+iterations of the series (for example,
+link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com/[adding unit tests] or
+link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com/[config-based hooks]),
+or it might include a full implementation from the beginning.
+In either case, discussion progresses the same way for an individual patch series,
+until consensus is reached or the topic is dropped.
+
+
+Larger Discussions (without patches)
+------------------------------------
+Occasionally, larger discussions might occur without an associated patch series.
+These may be very large-scale technical decisions that are beyond the scope of
+even a single large patch series, or they may be more open-ended,
+policy-oriented discussions (examples:
+link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
+or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving submodule UX]).
+In either case, discussion progresses as described above for general patch series.
+
+For larger discussions without a patch series or other concrete implementation,
+it may be hard to judge when consensus has been reached, as there are not any
+official guidelines. If discussion stalls at this point, it may be helpful to
+restart discussion with an RFC patch series (such as a partial, unfinished
+implementation or proof of concept) that can be more easily debated.
+
+When consensus is reached that it is a good idea, the original
+proposer is expected to coordinate the effort to make it happen,
+with help from others who were involved in the discussion, as
+needed.
+
+For decisions that require code changes, it is often the case that the original
+proposer will follow up with a patch series, although it is also common for
+other interested parties to provide an implementation (or parts of the
+implementation, for very large changes).
+
+For non-technical decisions such as community norms or processes, it is up to
+the community as a whole to implement and sustain agreed-upon changes.
+The project leadership committe (PLC) may help the implementation of
+policy decisions.
+
+
+Other Discussion Venues
+-----------------------
+Occasionally decision proposals are presented off-list, e.g. at the semi-regular
+Contributors' Summit. While higher-bandwidth face-to-face discussion is often
+useful for quickly reaching consensus among attendees, generally we expect to
+summarize the discussion in notes that can later be presented on-list. For an
+example, see the thread
+link:https://lore.kernel.org/git/AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au/[Notes
+from Git Contributor Summit, Los Angeles (April 5, 2020)] by James Ramsay.
+
+We prefer that "official" discussion happens on the list so that the full
+community has opportunity to engage in discussion. This also means that the
+mailing list archives contain a more-or-less complete history of project
+discussions and decisions.
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f2383a12c..a04da672c6 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -103,6 +103,7 @@ SP_ARTICLES += howto/coordinate-embargoed-releases
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
 
+TECH_DOCS += DecisionMaking
 TECH_DOCS += ReviewingGuidelines
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk

base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


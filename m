Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE4EAD4
	for <git@vger.kernel.org>; Thu,  9 May 2024 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715212894; cv=none; b=NpMimE2yW5SWomWHg5CptM6LUZl2onr936t9pEYLxKTp4OD+sTVITkj5few+re9iGyiHGr0jFDEMws0RJ/sJQESFxmgBHV1Rl98nQTNB/dAsXMXeiNLL3Vb/0q1SH+eOdS6NO+mHPWRdu/Az8vItjVUlVuGIJUKk48j0e0MSSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715212894; c=relaxed/simple;
	bh=ZC4nZZHBp3JO+0fCDuCm54DC7FQLpAR8UWX28HPD5mw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bMF2ybv8hW7uifOW1mujdqu8YyYK47t2ccsgUGRjquBeN6tdU6j+elStykyXAYXC4I5mxNJmnW03y5UTQqvEE27GAeVnaTVEwoSSjZo30TMz4HG1IBUBVKTMZPGNJMLv/QTVA9TiUJ6PpAnpYPfm2wTij0i71/5VOcSMA7QD5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8VU2Fx8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8VU2Fx8"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be621bd84so5617487b3.1
        for <git@vger.kernel.org>; Wed, 08 May 2024 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715212892; x=1715817692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NRZzIDZeMgyWPt5dFoqa0pq/vuLVvqgsjHry9ftrUg=;
        b=u8VU2Fx84ZuErl60tkIL+8uLby1t+pGGu552snEUxA0v39t8PJ1CZsNbj1a4oYblDz
         ME0tRCd/FOs1937y5LCsFECCIYJ/LDtuWfe8ybQshS8NFU4J6buomf5IIOV/wFf+8G8d
         vM2B6XGdaCe7HqdxQVJskV2yV57I0KB9vg98JdjpU3DR/rBb/+QuANmfzp9DjveBuzzv
         Wpx1y1r+beJ9XCLKlyWMI1e47KquPliKsd2+cSW9MQncV/5IxyeLMyHEQuIILfmBzLoa
         a8RKoG+MSznbbI17QEMtxQVKq5tpvRzR+ARDre/I+1tS9npWCZ2PZ6LGtrhrXO5xGypn
         Tr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715212892; x=1715817692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NRZzIDZeMgyWPt5dFoqa0pq/vuLVvqgsjHry9ftrUg=;
        b=pmlVHjKEZSJ/zF8FcprBR7tX4MluWVGBO5XsL35fckj5p10OfO+9sN8rkiQe1+7Fl6
         5AcUIrJ8JQuMq+/AwHgLzMjOA/9Xw9kQ2yPYYR5zb+luSJp5yFR1wmh9UWj0Ckg3sq4y
         KTtigr5NEmxig8nzvN5gXmY45iP+5bwdsyQrcyIftzUU8QZyiqHpL9cO0BD/EYiCNbGX
         phvFyGTyw9Jz9v64Jw/QOWCFR8EpG3mr8YO7jKVxGeZiAHtSXlcaJlrzgALtu46w8oQr
         hJExJYJ8AO6BUosJMSF+fIADzKl+TCh8MSNumsItAk5tAgnWQYWgBO6ydIuba1io8qw5
         ao+w==
X-Gm-Message-State: AOJu0YwY99QQbrBgpfHzDm/dlw1PTh5+WlMMUXYWOgqS/vfRhoTorujg
	atT80eIJMmfrespT1hmx9RhWc/YOx+f9cv/m7htPh8cplH/DJL9A8+8Y6MFHgNdIxW786j0e55O
	WMw8LOej1k2FnHYD6LAA/8muMVXweFdWhxt7Th8hXtv1BXn/bogpJ+xuK1T7XQbuDhXBLHMM++r
	gK16T3QUIPvgakrBLdlzAW/W51RjoTiOIKsFECFik=
X-Google-Smtp-Source: AGHT+IEbTvkV3CAs+SWujT+nDiCqwqvM77Jg8K6SaNMle7uxcVrE9HanwrTDStWpzMmZgDBJbWa2L6e9auVvcw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:fee2:6c72:4e8c:72e7])
 (user=steadmon job=sendgmr) by 2002:a81:6cd5:0:b0:61b:e253:31ad with SMTP id
 00721157ae682-62085b46abcmr9538217b3.8.1715212892134; Wed, 08 May 2024
 17:01:32 -0700 (PDT)
Date: Wed,  8 May 2024 17:01:30 -0700
In-Reply-To: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <4a829792bf16973799bf3b3db0dd8b49a1ef3815.1715212665.git.steadmon@google.com>
Subject: [PATCH v2] doc: describe the project's decision-making process
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, me@ttaylorr.com, ps@pks.im, emrass@google.com, 
	nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"

The Git project currently operates according to an informal
consensus-building process, which is not currently well-described.
Document what to expect so that we have something concrete to help
inform newcomers to the project.

This document explicitly does not aim to impose a formal process to
decision-making, nor to change pre-existing norms. Its only aim is to
describe how the project currently operates today.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---

Changes in V2:
* Split doc to treat patch series discussion as the general case, with
  larger discussions (with or without patches) as special situations.
* Add links to example discussions for certain situations
* Add link to contributor summit notes
* Add link to Code of Conduct
* Add justification for keeping discussion on-list
* Add paragraph about explicit negative consensus
* Minor reword of advice on when to CC experts
* Minor reword of doc intro to avoid indecisive text

 Documentation/DecisionMaking.txt | 122 +++++++++++++++++++++++++++++++
 Documentation/Makefile           |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/DecisionMaking.txt

diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
new file mode 100644
index 0000000000..55fa3e2185
--- /dev/null
+++ b/Documentation/DecisionMaking.txt
@@ -0,0 +1,122 @@
+Decision-Making Process in the Git Project
+==========================================
+
+Introduction
+------------
+This doc aims to describe the current decision-making process in the Git
+project. It is a descriptive rather than prescriptive doc; that is, we want to
+describe how things work in practice rather than explicitly recommending any
+particular process or changes to the current process.
+
+Here we document how the project makes decisions for general patch series, and
+for larger-scale discussions (with or without patches).
+
+
+General Patch Series
+--------------------
+
+Starting a Discussion
+~~~~~~~~~~~~~~~~~~~~~
+For most changes, discussions are started by sending a patch series to the list.
+There is rarely any need to discuss or ask for approval prior to sending
+patches; the merit of both the general idea behind your change and the code to
+implement it will be discussed at the same time.
+
+NOTE: For general guides on creating and sending a patch series to the list, see
+link:SubmittingPatches.html[SubmittingPatches] and
+link:MyFirstContribution.html[MyFirstContribution]. The remainder of this
+doc will focus more on what to expect from the list discussion.
+
+Because members of the Git community have a wide variety of experience,
+backgrounds, and values, series are expected to include as much context as
+possible.
+
+If the proposer is aware of individuals with an interest in the subject of the
+change, it is helpful to CC them on the proposal to increase the likelihood of
+receiving constructive feedback.
+
+Engaging in Discussion
+~~~~~~~~~~~~~~~~~~~~~~
+Once a proposal has been made, the community will discuss it on-list. While the
+maintainer will often participate in discussions, it is not the maintainer's
+responsibility to guide discussion; the proposer and any other interested
+parties are expected to stay engaged in the discussion and ensure progress is
+made.
+
+Anyone with an interest in the topic is welcome to discuss the matter. It is
+expected that all discussion will adhere to the link:../CODE_OF_CONDUCT.md[Code
+of Conduct] rules.
+
+Finalizing a Decision
+~~~~~~~~~~~~~~~~~~~~~
+If the maintainer judges that positive consensus has been reached on a topic,
+they will merge the series, usually to the 'next' integration branch. After a
+suitable period of time for testing by the community, changes are merged from
+'next' into 'master', from which official releases are tagged.
+
+If consensus has not been reached, discussion may continue, or the proposal may
+be abandoned if no one continues discussion. More rarely, explicit negative
+consensus may be reached if the community feels that the series is not suitable,
+in which case the series should be dropped and discussion ended.
+
+There are no strict guidelines used to judge when consensus has been reached,
+but generally we expect all points of feedback to have been addressed with
+either a fix or an explanation on why no change is necessary.
+
+
+Larger Discussions (with patches)
+---------------------------------
+As with discussions on a general patch series, starting a larger-scale
+discussion often begins by sending a patch or series to the list. This might
+take the form of an initial design doc, with implementation following in later
+iterations of the series (for example,
+link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com/[adding
+unit tests] or
+link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com/[config-based
+hooks]), or it might include a full implementation from the beginning. In either
+case, discussion progresses as described above until consensus is reached or the
+topic is dropped.
+
+
+Larger Discussions (without patches)
+------------------------------------
+Occasionally, larger discussions might occur without an associated patch series.
+These might be very large-scale technical decisions that are beyond the scope of
+even a single large patch series, or they might be more open-ended,
+policy-oriented discussions (examples:
+link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
+or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving
+submodule UX]). In either case, discussion progresses as described above for
+general patch series.
+
+For larger discussions without a patch series or other concrete implementation,
+it may be hard to judge when consensus has been reached, as there are not any
+official guidelines. If discussion stalls at this point, it may be helpful to
+restart discussion with an RFC patch series or other specific implementation
+that can be more easily debated.
+
+If consensus around a decision has been reached but no implementation provided,
+it is not the maintainer's responsibility to implement any particular decision.
+For decisions that require code changes, it is often the case that the original
+proposer will follow up with a patch series, although it is also common for
+other interested parties to provide an implementation (or parts of the
+implementation, for very large changes).
+
+For non-technical decisions such as community norms or processes, it is up to
+the community as a whole to implement and sustain agreed-upon changes.
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


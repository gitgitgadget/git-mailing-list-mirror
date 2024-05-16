Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8A147C74
	for <git@vger.kernel.org>; Thu, 16 May 2024 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715894458; cv=none; b=OAF0BSQCgQw2Qy6VH6zwPIJoxxN0QBXCKlwBpnOslWnmTtz+DYpMB8+okyBTFRo9z2RXdKffHxwDvKiPJ9/z/Gwl6ToeNdbkCDiOwtKrYsdE2nZxYiR6MvDZLPoeoLGkbjDe1Qjjfj+AOlYw2U5A9Dny7dlhE3PPQ9O3w1+5OKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715894458; c=relaxed/simple;
	bh=Ml3z4iMojkrDkDEiIgod2U7nP6c2CUuaFvoylh/6LLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tzkrW80igETtOAqjUfpH2B5IIUyHpVCBt7WyW0VxJXW4Vp+mrULLkFWFry/Qt8S7ZdTauZY2XbCCtne5KrB/kFoHQ+61l4Y4itwgS7TxUgK/0D109dwe7rUb2YBpWS9rwPu5sQruUQeopfT76k/FDIO23X3NnlFHyTkm9uL5yBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOSeUwgj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOSeUwgj"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-622cd439764so109033637b3.3
        for <git@vger.kernel.org>; Thu, 16 May 2024 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715894456; x=1716499256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=euiRlpZvPx7XKyDDno4k3xUTq56nngO3HZs4tkdqAk4=;
        b=dOSeUwgj1Dy/uQPkgxFs5uf+V7y605yzvGrJ+3d6L8j8ztAWotRkQxOX3dnGD1HwEa
         0wfY9jEKQMa0z2UfPMfoEKBfnoc38LJtF25iPtND3wkb85ntqnArxzhneHlCJU1YzuJa
         BfwvabS22+qCWWofUNNI0o+Of3azUvUIJJfQgomZ0L0MRhV1BaIKaOngK06glPTEgJ3F
         yM7LHgqs70aUA7HrcftXIuxD6jEBi5G8ntAFaSK/EotIZNrryjLQYUwNVPDcQd8uBE36
         I8op8VjjFfSS1fJFJFyD5+JRJgbIff5np8kvmBeK+XfF/Evo6cg0sIA7oln6uL06Y3iT
         i78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715894456; x=1716499256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euiRlpZvPx7XKyDDno4k3xUTq56nngO3HZs4tkdqAk4=;
        b=K8dcl1Y0BNXAzZABLt+9JxfGBNsJiUdrH7HaQLpM/RvqM/gTuACWMMjgs+n/bNm0mZ
         Epbk6B4BZX2yxotzSLvCV4ymlySjh4O6vXIEPCMuvHrw1Bbtoeq9KPsu9e30JqmU16Ub
         PVvmlle8ZybCZsZZejxz1Jb0C5dsyAvxUdW95eiZr2BiMlgMevFsoXAFvPTJHvJYG0Uo
         SDn2N1Hr6AEQ9Pt2Gcsv+HzP9VTwSl/G3eAGJZVRWyCm9VUtWuzGUy0Bb7b0OOC5pnsS
         FTv2ePKl9GzbWzmf8ZX+sOgIG0sNK704kXKbx4xEbz5cv96PSKJK50f4gUdiubtZxqtM
         0aOg==
X-Gm-Message-State: AOJu0YwwYdfDSN+6t5NGP4GyBD9JU60acL/0rC3T1lTcSqBT0dXuvGdl
	KVtKYENmKhx49qc8Z0LNBQ9QMNDnvWe6IcIAdaAuuTmNyHki32S3jPVK4n4fq8lD7wtXIhmTdnD
	v0KYcXJHBTkO/lgwEsTSrhWuyKX0jylS9eJxaAdQRMp+qM1JVKG5h0X8FyvKk1NWZnHVUsMlhhe
	KZssYJnG3CuW2hdVq4uWFMDQ8MTUoWkj/i2Zq84k0=
X-Google-Smtp-Source: AGHT+IFupj+nG5MVSHztLoztdqFauFRXZA7cY/W0rSZ6fIM0NUijfbYfDtLu5/K4quk/Jr6t2yQtcjsCn5SbQg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:d3ef:7837:777f:7951])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1372:b0:de4:5ce2:7d2 with SMTP
 id 3f1490d57ef6-dee4f2de0edmr5045607276.4.1715894455658; Thu, 16 May 2024
 14:20:55 -0700 (PDT)
Date: Thu, 16 May 2024 14:20:53 -0700
In-Reply-To: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
Subject: [PATCH v3] doc: describe the project's decision-making process
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com, me@ttaylorr.com, ps@pks.im, 
	emrass@google.com, nasamuffin@google.com
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

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
doc: describe the project's decision-making process

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
* MInor reword of doc intro to avoid indecisive text

Range-diff against v2:
1:  4a829792bf ! 1:  5446ca49e0 doc: describe the project's decision-making process
    @@ Commit message
         doc: describe the project's decision-making process
     
         The Git project currently operates according to an informal
    -    consensus-building process, which is not currently well-described.
    -    Document what to expect so that we have something concrete to help
    -    inform newcomers to the project.
    +    consensus-building process, which is currently described in the
    +    SubmittingPatches document. However, that focuses on small/medium-scale
    +    patch series. For larger-scale decisions, the process is not as well
    +    described. Document what to expect so that we have something concrete to
    +    help inform newcomers to the project.
     
         This document explicitly does not aim to impose a formal process to
         decision-making, nor to change pre-existing norms. Its only aim is to
         describe how the project currently operates today.
     
    +    Co-authored-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/DecisionMaking.txt (new) ##
     @@
    @@ Documentation/DecisionMaking.txt (new)
     +
     +Introduction
     +------------
    -+This doc aims to describe the current decision-making process in the Git
    ++This document describes the current decision-making process in the Git
     +project. It is a descriptive rather than prescriptive doc; that is, we want to
     +describe how things work in practice rather than explicitly recommending any
     +particular process or changes to the current process.
     +
    -+Here we document how the project makes decisions for general patch series, and
    -+for larger-scale discussions (with or without patches).
    -+
    -+
    -+General Patch Series
    -+--------------------
    -+
    -+Starting a Discussion
    -+~~~~~~~~~~~~~~~~~~~~~
    -+For most changes, discussions are started by sending a patch series to the list.
    -+There is rarely any need to discuss or ask for approval prior to sending
    -+patches; the merit of both the general idea behind your change and the code to
    -+implement it will be discussed at the same time.
    -+
    -+NOTE: For general guides on creating and sending a patch series to the list, see
    -+link:SubmittingPatches.html[SubmittingPatches] and
    -+link:MyFirstContribution.html[MyFirstContribution]. The remainder of this
    -+doc will focus more on what to expect from the list discussion.
    -+
    -+Because members of the Git community have a wide variety of experience,
    -+backgrounds, and values, series are expected to include as much context as
    -+possible.
    -+
    -+If the proposer is aware of individuals with an interest in the subject of the
    -+change, it is helpful to CC them on the proposal to increase the likelihood of
    -+receiving constructive feedback.
    -+
    -+Engaging in Discussion
    -+~~~~~~~~~~~~~~~~~~~~~~
    -+Once a proposal has been made, the community will discuss it on-list. While the
    -+maintainer will often participate in discussions, it is not the maintainer's
    -+responsibility to guide discussion; the proposer and any other interested
    -+parties are expected to stay engaged in the discussion and ensure progress is
    -+made.
    -+
    -+Anyone with an interest in the topic is welcome to discuss the matter. It is
    -+expected that all discussion will adhere to the link:../CODE_OF_CONDUCT.md[Code
    -+of Conduct] rules.
    -+
    -+Finalizing a Decision
    -+~~~~~~~~~~~~~~~~~~~~~
    -+If the maintainer judges that positive consensus has been reached on a topic,
    -+they will merge the series, usually to the 'next' integration branch. After a
    -+suitable period of time for testing by the community, changes are merged from
    -+'next' into 'master', from which official releases are tagged.
    -+
    -+If consensus has not been reached, discussion may continue, or the proposal may
    -+be abandoned if no one continues discussion. More rarely, explicit negative
    -+consensus may be reached if the community feels that the series is not suitable,
    -+in which case the series should be dropped and discussion ended.
    -+
    -+There are no strict guidelines used to judge when consensus has been reached,
    -+but generally we expect all points of feedback to have been addressed with
    -+either a fix or an explanation on why no change is necessary.
    ++Here we document how the project makes decisions for discussions
    ++(with or without patches), in scale larger than an individual patch
    ++series (which is fully covered by the SubmittingPatches document).
     +
     +
     +Larger Discussions (with patches)
     +---------------------------------
    -+As with discussions on a general patch series, starting a larger-scale
    ++As with discussions on an individual patch series, starting a larger-scale
     +discussion often begins by sending a patch or series to the list. This might
     +take the form of an initial design doc, with implementation following in later
     +iterations of the series (for example,
    -+link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com/[adding
    -+unit tests] or
    -+link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com/[config-based
    -+hooks]), or it might include a full implementation from the beginning. In either
    -+case, discussion progresses as described above until consensus is reached or the
    -+topic is dropped.
    ++link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com/[adding unit tests] or
    ++link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@google.com/[config-based hooks]),
    ++or it might include a full implementation from the beginning.
    ++In either case, discussion progresses the same way for an individual patch series,
    ++until consensus is reached or the topic is dropped.
     +
     +
     +Larger Discussions (without patches)
    @@ Documentation/DecisionMaking.txt (new)
     +even a single large patch series, or they might be more open-ended,
     +policy-oriented discussions (examples:
     +link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
    -+or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving
    -+submodule UX]). In either case, discussion progresses as described above for
    -+general patch series.
    ++or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving submodule UX]).
    ++In either case, discussion progresses as described above for general patch series.
     +
     +For larger discussions without a patch series or other concrete implementation,
     +it may be hard to judge when consensus has been reached, as there are not any
    @@ Documentation/DecisionMaking.txt (new)
     +restart discussion with an RFC patch series or other specific implementation
     +that can be more easily debated.
     +
    -+If consensus around a decision has been reached but no implementation provided,
    -+it is not the maintainer's responsibility to implement any particular decision.
    ++When consensus is reached that it is a good idea, the original
    ++proposer is expected to coordinate the effort to make it happen,
    ++with help from others who were involved in the discussion, as
    ++needed.
    ++
     +For decisions that require code changes, it is often the case that the original
     +proposer will follow up with a patch series, although it is also common for
     +other interested parties to provide an implementation (or parts of the
    @@ Documentation/DecisionMaking.txt (new)
     +
     +For non-technical decisions such as community norms or processes, it is up to
     +the community as a whole to implement and sustain agreed-upon changes.
    ++The project leadership committe (PLC) may help the implementation of
    ++policy decisions.
     +
     +
     +Other Discussion Venues

 Documentation/DecisionMaking.txt | 74 ++++++++++++++++++++++++++++++++
 Documentation/Makefile           |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/DecisionMaking.txt

diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMaking.txt
new file mode 100644
index 0000000000..274ddfa62c
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
+These might be very large-scale technical decisions that are beyond the scope of
+even a single large patch series, or they might be more open-ended,
+policy-oriented discussions (examples:
+link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducing Rust]
+or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improving submodule UX]).
+In either case, discussion progresses as described above for general patch series.
+
+For larger discussions without a patch series or other concrete implementation,
+it may be hard to judge when consensus has been reached, as there are not any
+official guidelines. If discussion stalls at this point, it may be helpful to
+restart discussion with an RFC patch series or other specific implementation
+that can be more easily debated.
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


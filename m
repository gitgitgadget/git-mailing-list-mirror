Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA20175A6
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360184; cv=none; b=VRgxmzz33WmQbbl+j8D29r7M+oa0WJ5A1P87n8j4skcrH9Ac4n5n5xaKJS4CTfqq7gVB60VAz5DrpXaqY64snZRNWhB4Mu56voe7hD3P+w/ubPGJDBStJU+sdVmFWL5rwadYyUT5DXu9RySLrvMSjLZvST8TXUsJLPWoxSXdDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360184; c=relaxed/simple;
	bh=SgocUhG4dPCBi+vled7jUb9NrXC5F7AuQK+9rxf1i0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s97g0NkNk6IHxGYhizFCZVo2XU+NcvnuTDbAGf3ga6g8UnHn6TCeKcgAmiGu54rVllJ8AGW1yVJgBhpsAHtHfk+BLyhq5QSME03FGYhDlkWKEA8/t/dQN3y8yHgmelbhzc1Hn1coL7eS61hlUiJ52RwcbEyFk4AsvHbt+KUL5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lmEcFiJA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmEcFiJA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E1C419BB7;
	Fri, 10 May 2024 12:56:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=SgocUhG4dPCBi+vled7jUb9Nr
	XC5F7AuQK+9rxf1i0c=; b=lmEcFiJAFeIY8rG1aBdj2+0qgUwHtv2S2b3NROkCu
	HWG11rYdWkcpat+cEKaMPVQuaIgoj8QngTI9vDNo41AYUezjL49ztD1xAl8RySfU
	NtAENbBNds0rB7hy7EdNtucSK/1oPRC86FiUOxFI1auDjExA+BFTE0ShsieXkl5x
	wc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 25FA419BB6;
	Fri, 10 May 2024 12:56:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F5C519BB2;
	Fri, 10 May 2024 12:56:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>
Subject: [PATCH] decisions: focus on larger scale issues
Date: Fri, 10 May 2024 09:56:17 -0700
Message-ID: <20240510165617.1412642-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-119-g0f3415f1f8
In-Reply-To: <20240510165526.1412338-1-gitster@pobox.com>
References: <20240510165526.1412338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 389E30B0-0EEE-11EF-AFD7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Remove "General Patch Series" section, as its contents should be
fully covered by the SubmittingPatches document, and make this new
document primarily about decisions at a larger scale.  Adjust a few
sentences that used to refer to an earlier description on patch
discussion to refer to the SubmittingPatches document instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/DecisionMaking.txt | 86 +++++++-------------------------
 1 file changed, 19 insertions(+), 67 deletions(-)

diff --git a/Documentation/DecisionMaking.txt b/Documentation/DecisionMak=
ing.txt
index 55fa3e2185..274ddfa62c 100644
--- a/Documentation/DecisionMaking.txt
+++ b/Documentation/DecisionMaking.txt
@@ -3,79 +3,27 @@ Decision-Making Process in the Git Project
=20
 Introduction
 ------------
-This doc aims to describe the current decision-making process in the Git
+This document describes the current decision-making process in the Git
 project. It is a descriptive rather than prescriptive doc; that is, we w=
ant to
 describe how things work in practice rather than explicitly recommending=
 any
 particular process or changes to the current process.
=20
-Here we document how the project makes decisions for general patch serie=
s, and
-for larger-scale discussions (with or without patches).
-
-
-General Patch Series
---------------------
-
-Starting a Discussion
-~~~~~~~~~~~~~~~~~~~~~
-For most changes, discussions are started by sending a patch series to t=
he list.
-There is rarely any need to discuss or ask for approval prior to sending
-patches; the merit of both the general idea behind your change and the c=
ode to
-implement it will be discussed at the same time.
-
-NOTE: For general guides on creating and sending a patch series to the l=
ist, see
-link:SubmittingPatches.html[SubmittingPatches] and
-link:MyFirstContribution.html[MyFirstContribution]. The remainder of thi=
s
-doc will focus more on what to expect from the list discussion.
-
-Because members of the Git community have a wide variety of experience,
-backgrounds, and values, series are expected to include as much context =
as
-possible.
-
-If the proposer is aware of individuals with an interest in the subject =
of the
-change, it is helpful to CC them on the proposal to increase the likelih=
ood of
-receiving constructive feedback.
-
-Engaging in Discussion
-~~~~~~~~~~~~~~~~~~~~~~
-Once a proposal has been made, the community will discuss it on-list. Wh=
ile the
-maintainer will often participate in discussions, it is not the maintain=
er's
-responsibility to guide discussion; the proposer and any other intereste=
d
-parties are expected to stay engaged in the discussion and ensure progre=
ss is
-made.
-
-Anyone with an interest in the topic is welcome to discuss the matter. I=
t is
-expected that all discussion will adhere to the link:../CODE_OF_CONDUCT.=
md[Code
-of Conduct] rules.
-
-Finalizing a Decision
-~~~~~~~~~~~~~~~~~~~~~
-If the maintainer judges that positive consensus has been reached on a t=
opic,
-they will merge the series, usually to the 'next' integration branch. Af=
ter a
-suitable period of time for testing by the community, changes are merged=
 from
-'next' into 'master', from which official releases are tagged.
-
-If consensus has not been reached, discussion may continue, or the propo=
sal may
-be abandoned if no one continues discussion. More rarely, explicit negat=
ive
-consensus may be reached if the community feels that the series is not s=
uitable,
-in which case the series should be dropped and discussion ended.
-
-There are no strict guidelines used to judge when consensus has been rea=
ched,
-but generally we expect all points of feedback to have been addressed wi=
th
-either a fix or an explanation on why no change is necessary.
+Here we document how the project makes decisions for discussions
+(with or without patches), in scale larger than an individual patch
+series (which is fully covered by the SubmittingPatches document).
=20
=20
 Larger Discussions (with patches)
 ---------------------------------
-As with discussions on a general patch series, starting a larger-scale
+As with discussions on an individual patch series, starting a larger-sca=
le
 discussion often begins by sending a patch or series to the list. This m=
ight
 take the form of an initial design doc, with implementation following in=
 later
 iterations of the series (for example,
-link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac6=
5.1688165272.git.steadmon@google.com/[adding
-unit tests] or
-link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@goo=
gle.com/[config-based
-hooks]), or it might include a full implementation from the beginning. I=
n either
-case, discussion progresses as described above until consensus is reache=
d or the
-topic is dropped.
+link:https://lore.kernel.org/git/0169ce6fb9ccafc089b74ae406db0d1a8ff8ac6=
5.1688165272.git.steadmon@google.com/[adding unit tests] or
+link:https://lore.kernel.org/git/20200420235310.94493-1-emilyshaffer@goo=
gle.com/[config-based hooks]),
+or it might include a full implementation from the beginning.
+In either case, discussion progresses the same way for an individual pat=
ch series,
+until consensus is reached or the topic is dropped.
=20
=20
 Larger Discussions (without patches)
@@ -85,9 +33,8 @@ These might be very large-scale technical decisions tha=
t are beyond the scope of
 even a single large patch series, or they might be more open-ended,
 policy-oriented discussions (examples:
 link:https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/[introducin=
g Rust]
-or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improvi=
ng
-submodule UX]). In either case, discussion progresses as described above=
 for
-general patch series.
+or link:https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/[improvi=
ng submodule UX]).
+In either case, discussion progresses as described above for general pat=
ch series.
=20
 For larger discussions without a patch series or other concrete implemen=
tation,
 it may be hard to judge when consensus has been reached, as there are no=
t any
@@ -95,8 +42,11 @@ official guidelines. If discussion stalls at this poin=
t, it may be helpful to
 restart discussion with an RFC patch series or other specific implementa=
tion
 that can be more easily debated.
=20
-If consensus around a decision has been reached but no implementation pr=
ovided,
-it is not the maintainer's responsibility to implement any particular de=
cision.
+When consensus is reached that it is a good idea, the original
+proposer is expected to coordinate the effort to make it happen,
+with help from others who were involved in the discussion, as
+needed.
+
 For decisions that require code changes, it is often the case that the o=
riginal
 proposer will follow up with a patch series, although it is also common =
for
 other interested parties to provide an implementation (or parts of the
@@ -104,6 +54,8 @@ implementation, for very large changes).
=20
 For non-technical decisions such as community norms or processes, it is =
up to
 the community as a whole to implement and sustain agreed-upon changes.
+The project leadership committe (PLC) may help the implementation of
+policy decisions.
=20
=20
 Other Discussion Venues
--=20
2.45.0-119-g0f3415f1f8


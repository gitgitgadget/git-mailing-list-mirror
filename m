Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XM28uQqJ"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE02693
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701863536; x=1702468336; i=l.s.r@web.de;
	bh=HVOrGBTAAv8zt2YGOOrWM95SylDKWq1BwkEdTa3klPE=;
	h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
	b=XM28uQqJ8+TyxbfppqlREVofg9jyyGZo8Zg+AKGz46tdkn3VaUjVK8EWMTSClSQq
	 KFI2z5/pCmlz7PnMRU/kSygviYYo1NblBbsWnJRBofp2RnvFv8s2dKIfwnHf89oAR
	 n2Q2lG/+Ev601QnqnZiWXYDon0LYRxnAgsh7/3VcPiRBbuVJHDR3Vt5vaWohItjqU
	 AHQ8y6WQR8URrp8HxM78lE5l5g8oHKPbdGjmLCiCHGFY32ikJnQKs4wmvdZN1asKq
	 08IN64x6AQZZVk50sTvZywCb2+M+iQvkAZ0X4tq6ytdI1tO/ED4aRoAy2QwCsF9hj
	 ArpsbQtW7BAlv+MpoA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from Mini-von-Rene.fritz.box ([79.203.29.38]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MSqXM-1qoCxK2xlm-00UMXP for <git@vger.kernel.org>; Wed, 06 Dec 2023 12:52:16
 +0100
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Subject: [PATCH 3/7] revision: use die_for_incompatible_opt3() for --graph/--reverse/--walk-reflogs
Date: Wed,  6 Dec 2023 12:51:57 +0100
Message-ID: <20231206115215.94467-4-l.s.r@web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206115215.94467-1-l.s.r@web.de>
References: <20231206115215.94467-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WvkXJGfs5yqDmIqY47lq1GJiYFAf6y55axTU/N+AHSdJaoT4XBn
 23dC9gkq0qW5y7LvYP2TIqnf4hV4EAUyO4n1u55lkUQwt0oDkHW4VyoTDusQA6QumPi6Bfn
 CZlrhz1dJ1CYp6dFZYOEDKrEwB7J3Za2+fl4XhdGsNS9FeAzJgSPTkMEltPB/WLOf5qnSbU
 iJCCzsJUs3U6fISy+N+Sg==
UI-OutboundReport: notjunk:1;M01:P0:BHXpB25+Pu4=;Ot72ymAP9ojVy6EkIFl2AC4lr3K
 hel2ENkflSSAsWg5hB23TnnXHDOIRkGPuWG6ba6cKTo/70/Q4ryY6y6t5Mqp65Gj4sxQ0M6s4
 fSKbCjgS3xsP3Sdtl0KXMWu8CWndY13Mw27Te4QlPxNv6Mjt0rUS8Yaik2nf38Ys8WayE5C8B
 wApgPUSItqEiJDgbCBB8HsGSBrdAOWRb3gofr8siH7VG+E5HtpP5TGD8kPJKSWcmYlPLJN5P7
 nEsY7oLvAJAzUUKrKt1D4P5f6xX3J9RjR74B7MAAbpORxBWZ2AyJuZjLCay8YqNFDuQKE8J7z
 OTlbJjCK+oXXB3q+q2SQJ+7uXtf+MNDgAGBgsXnk2f4eUHgGVYfgBN+XHNG6Hi9w+WKLlK8te
 0e1iW3yLOMR5OFyeJTbFkocrH/hEGWis9ZZ1IQ0WmefKPmEVe391Wmbyj0z0ZmdKZDZi9qk3W
 qSKGs4L4Pn3RNar53kDbnfWT/BuCoOX3+x+wPpTMzsiDaZOCGNq9XsE4SCizH0b/287A5K5hj
 q6sDTdUiIMcqbqw9tGCnqd6QgfogsuArNIL/YhMpZnOvHIQRvuJTIrQZVxp+5AVCMdTQJI6IU
 B5BtDTWHyW7TrhtK/VI7278eU24xfdv90meaZ9IRfOmEsaNTKzcnv0bxlM1OvbFoHUK9HMtJU
 dhwkDPiS2xy8VFHRHs3vPNt6h5YbMA14lp/6uvMJkBouY9Bc89jb1kNJmh/w5jGmsEDnc3GIh
 qsTkBbL+YIldrcZLqy9O+ZwYwKihhsKXHPh0na9VRtHbz9iVdM2poAnI3nszf2GWvEQBZ0DdK
 My6t3Qw80GXCORBFmDX9913G81Q5TvrS6FYg6Ujy3TVRIKcKydCAA22AsqI8CT23Pw8SLmn/L
 76onbD0+p2uO3c39RAfPCFm8PZntAiiJrg7y6sVUMskl5geLDWpYriOUiJzSqw5L3Wh0I62cx
 terjfA==

The revision options --reverse is incompatibel with --walk-reflogs and
=2D-graph is incompatible with both --reverse and --walk-reflogs.  So they
are all incompatible with each other.

Use the function for checking three mutually incompatible options,
die_for_incompatible_opt3(), to perform this check in one place and
without repetition.  This is shorter and clearer.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index b2861474b1..1b7e1af6c6 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -3036,8 +3036,6 @@ int setup_revisions(int argc, const char **argv, str=
uct rev_info *revs, struct s
 		revs->grep_filter.ignore_locale =3D 1;
 	compile_grep_patterns(&revs->grep_filter);

-	if (revs->reverse && revs->reflog_info)
-		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "-=
-walk-reflogs");
 	if (revs->reflog_info && revs->limited)
 		die("cannot combine --walk-reflogs with history-limiting options");
 	if (revs->rewrite_parents && revs->children.name)
@@ -3048,11 +3046,10 @@ int setup_revisions(int argc, const char **argv, s=
truct rev_info *revs, struct s
 	/*
 	 * Limitations on the graph functionality
 	 */
-	if (revs->reverse && revs->graph)
-		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "-=
-graph");
+	die_for_incompatible_opt3(!!revs->graph, "--graph",
+				  !!revs->reverse, "--reverse",
+				  !!revs->reflog_info, "--walk-reflogs");

-	if (revs->reflog_info && revs->graph)
-		die(_("options '%s' and '%s' cannot be used together"), "--walk-reflogs=
", "--graph");
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "-=
-graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
=2D-
2.43.0


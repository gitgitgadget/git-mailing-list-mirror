Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294AECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiIOOyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIOOyk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:54:40 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8623BD4
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253673; bh=0DmODq5CW63AawTZKOweHBZvRZATF7KtSszSW2ChbWM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=HE63Tn6eBGPOTVIft4aBDJohWY8W5LyGwc26hAxYeOI4Bj9jHZB8t7J4oqHAxgKwY
         0aL6EdQdsBfpdQeOsS5Zu2S8KvgAXx3PaN6gnN0Gny380okmidVmQj6tLjWkYJTQOS
         BnrHEbBvyBv0s4cLc7J/M+RmVuAQp6KI7piHO74WRfNQQUZGi9YltewwjGzVBkmLgg
         zCfi/sYGgW7Mr50xIAfvJFw6DOkiNBN8GqyZ6BrqECfy4gxJBmymNHFv9USLnpZd50
         jGsb0xxuCm7GodF1xv6lUcL0PNEsVkQmIk8Pf94R3Ca6fu04gwr1I1ECxeu4LAV2Py
         xlIJsiQ7sQwrw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSqTE-1okPmp27Yc-00Ujmy; Thu, 15
 Sep 2022 16:54:33 +0200
Message-ID: <73e1e0e2-d6a4-3d1b-4303-f9e8984eaa79@web.de>
Date:   Thu, 15 Sep 2022 16:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH 5/6] revision: rename add_parents_only() to add_nth_parent()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:34dA66nXNF9fyUYBRXSWbkrjNmh0FWwKuUMskIIZ6zI7+Vp/4PR
 NiiEGhLpsQXqxVSJejT59kEw0jOkAt9+ZR9tUpENKj672iL7/pKGeWgS7C3G3eijN+NjDXB
 QJNKsKHy4DkyQlOkyIRdb8JmYmxsl2uOvQ1bWZGcoe7NshCpMwcwf29atVHiZNBBE2F4rQT
 ibYmA4oVzgoK/J7/p7pkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gikb3xIv0hg=:R/itht+HphEI9BrfAA7etI
 XrppnBxylafYDfkSFhEezk7vXub+DJJo2Vz/eGwN/HOzv5gTvYNvT6+coaFAKrVEB8xqBSe0V
 0a+ouU593Ztm44rZbwUISIQCdxosYUfl1cJKoCxqWJCRQBGQXS0l2ZMbB5eyrCpegB6FBSP7F
 EACOlyzMQ3pt1XTM3kn+PwoSNNCRvUCHuagFJngDiN8PAKbeONpvTzTB+uurS6TMox8zPfwi4
 E65Z14nbOT8ENJCCeNLsLhPWGfwBKhJxKh7X9/WM71sR+toxNK7aeKfBtXTp9P5nhXAGBbX6K
 MZ0+Ou0jKdrYN3lxjPXsaLBuUfNT8uk8MGGhH2FEmNmV1Sax2fgktWNUsHOd5lIL+g2lG1tjp
 n7Y1JJ1RhCO5WSUoYZBFDPBC3Wy6K8U1fqs23RGK7vS98ZWdK6ab2qYHVAJHDd/6YBS+Yix67
 5i/oeq1Phs71w7vIbPJh4E24A5AkQkCsAiiVG+dRzYTrJV7YQcglTjR1oQXo/ktIVZRoyrDL6
 mIcOKeZKhTcW0Yk3zlb1WG4LilxG2fedIhcNs0vpExQ1cYJEyep1fQTdCr3PKYwoHFgOi/B0N
 xA/CBONZsLaREvrvlpPkCBRjPS55/8U6IC8d/zFQV71Ev92ULC/R7iU7zfZXeFDDVx6FCRD/J
 2wNeBRMIh+4daRmQIUR0aJS4P+QMEAD3RxSip4B2nAWgv+Oe53eM3YtVsG2OoRX07RZF3zOey
 rcY6wGh2AoOkDCC9Y7VRxVNJ0j9JlMR4YYsJp9IfMXAS5HTyiIJSW5AbT/SK/HOM25vrddYKf
 pkiu2/FAVhl4MpOMTZEkgzr6mm352l2VUiT7uGPhrm3PJKCqbRD7ntnYecFLOQ84+tVu2KGhX
 65M7A5cwX0TmicUoAa3Z3epsH/SYebUwIDZfVkRRNF7WMtab/XP2RKZYuXkWpLZHv4MQBMlGw
 DCE4aF7v1p1GGtIBel/JMlGLJnxxlrJSMXvT8HvwEI9PXrqJCvw+L3NfbwrlNVRrxaFnvJJ72
 wFmxtKnOnf9voBooXFhHMmQqwZAEXoXF4PolWBdMFPSVQw1oGthyApEl3rkxVxDBP/ryJDo9m
 L1Pu+rMLmO58M5JsAClChM1GCsbFA1eKiRG8uuqPAmEiF+FpVSQR3zY5KFutuDgF5I+TWAXRi
 Q9mFQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the handling of !exclude_parent to the two callers that pass zero.
This allows checking the validity of the child separately from adding
its parents, which we'll make use of in the next patch.

Rename the function to reflect its changed purpose, now that it
requires exclude_parent to be given and only adds at most one parent.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Created with --inter-hunk-context=3D1 for easier review.

 revision.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 284393a146..5e756b76aa 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -1868,19 +1868,15 @@ static void add_parents(struct rev_info *revs, str=
uct commit_list *parents,
 		add_parent(revs, &parents->item->object, arg, flags);
 }

-static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
-			    int exclude_parent)
+static int add_nth_parent(struct rev_info *revs, const char *arg_, int fl=
ags,
+			  int exclude_parent)
 {
 	struct commit *commit =3D get_commit(revs, arg_);
 	struct commit_list *parents;
 	int parent_number;

 	if (!commit)
 		return 0;
-	if (!exclude_parent) {
-		add_parents(revs, commit->parents, arg_, flags);
-		return 1;
-	}
 	for (parents =3D commit->parents, parent_number =3D 1;
 	     parents;
 	     parents =3D parents->next, parent_number++) {
@@ -2127,15 +2123,26 @@ static int handle_revision_arg_1(const char *arg_,=
 struct rev_info *revs, int fl

 	mark =3D strstr(arg, "^@");
 	if (mark && !mark[2]) {
+		struct commit *commit;
+
 		*mark =3D 0;
-		if (add_parents_only(revs, arg, flags, 0))
+		commit =3D get_commit(revs, arg);
+		if (commit) {
+			add_parents(revs, commit->parents, arg, flags);
 			return 0;
+		}
 		*mark =3D '^';
 	}
 	mark =3D strstr(arg, "^!");
 	if (mark && !mark[2]) {
+		struct commit *commit;
+
 		*mark =3D 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
+		commit =3D get_commit(revs, arg);
+		if (commit)
+			add_parents(revs, commit->parents, arg,
+				    flags ^ (UNINTERESTING | BOTTOM));
+		else
 			*mark =3D '^';
 	}
 	mark =3D strstr(arg, "^-");
@@ -2149,7 +2156,7 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 		}

 		*mark =3D 0;
-		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), excl=
ude_parent))
+		if (!add_nth_parent(revs, arg, flags ^ (UNINTERESTING | BOTTOM), exclud=
e_parent))
 			*mark =3D '^';
 	}

=2D-
2.37.3

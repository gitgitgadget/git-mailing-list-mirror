Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C4EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGUMm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGUMm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:42:26 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A899830EC
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943321; x=1690548121; i=l.s.r@web.de;
 bh=k3nQ4il1Ah5l6JvtSlJ8ieSywZN78pEaLVZ4UyA9KHY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LreTqCQaukuCUHw1opCU0En/YHHQYUtyS3z1j3vthQN3eWxPF2xPVLAoKp5rvtD3zzQ51q/
 rWbH9j790xo8aNzcsF/ZwyCql8j5nGZVav3cDr6ZXtojegIgtFuzplx5s50FcQuTE8gS05Sb6
 sPokXIH7bxVmc/di7DaVYI32tAAuIcwmAOrC+WhTjrcTGO+10ja1yLI5cKwLmElqivNaQvCLv
 SUTWC+PLDUyTgRu2wKSMMULGjefchBOKF21R/7U//lkAOSDZPEqyZRbioxVy1frIwnWDVdxmo
 UC/smApVFXMvOHL9QjtgQGb3q9wCURh4CSvu2Fc15/ndbk36RBNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQxs3-1qalR82X7n-00O66B; Fri, 21
 Jul 2023 14:42:01 +0200
Message-ID: <bf273082-4a33-8855-a928-5fff2c7e5ef4@web.de>
Date:   Fri, 21 Jul 2023 14:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] branch: disallow --no-{all,remotes}
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MgljEkgN5cGZyRLqh+8E3sEf20a+AvrQQxAcnc74UU868rJZuT4
 jwW41zXoE/nhwSnirRbYZpb6GtGW7R4C+e9x1lRuD6VnhEylcej+mKMyaEKp18nwccTA5uU
 QKKTs+QbN3b/9Hv7u9ygOH3Vfia3PoGcTpT9Cs5gPu3580eaur4fWk6ohd6F1EUKlz9WG4T
 c+ek+9mZqgfhAvBcUScgQ==
UI-OutboundReport: notjunk:1;M01:P0:dHQMgWCVhNY=;zycpGxfWpBUGGwGZoSwlqBacbAU
 LBJURPYvBhnmWoulUSOCBhLc5BfFCcIu2GFrdzguLV10n4HStIGZr1lv568iOrr24ctZWIABF
 gi+FfTyAyQ7apdkjEJ0WOFBEY+gBvhiyEZUU/iPegTF6xoIwLC1BOTUvslUMHBgcZHeuaJfZf
 S8jsYBsDtwZ5Xg75BFbCVj/s6bGzfvxuoP9QyLG2wWI7IxcsaJOrF17+rp88GnwXMeTL/Po6W
 krgmBlD95mHrp5AUw2WVzieC/iPyMObaMH3o4tUoCn7iGB16kz8FLbTI22PgbOE0bBBkj9kUx
 vVekVWHt0UwzqVKPhg9vHDBZHaGRjCNLOk04FaqoLMb53lolIHAxv9zvbMeOHKIHFbkVgS4Zr
 XbuZbFSBSHOz8Obi9FUClpvLVtFfjp5vOOKRtg2JWKh3+wLpi20/2K9ICYenMAR6wh7WaWuDm
 mp1/+JIb8KruFiBJLxMkrcMxbHtHMfIxx6phBmtLyJU21SZiDwuzlIfQSdR2bG8u/VYFpQMYc
 GOCuT8ep7I48koQ/4vBilwDbmzNAjQA31X4IQZUjaCs+8iMAbz0QqF54dC7Fq1IdJp3BQIWHy
 5JH2x4/EsyPzS0rP4DkQYN0Fkehgspasy0phpWFu80We7CAqeIfq4dlyzkK5WPoGYFZ96QO35
 CK8X6dseXFTiDvs5rN6DDXuOEW3YIR+eV/+g/r57AGlMtC/yAJlvx3yUJKhxd0kFCS0GxPYQ8
 iMsw3u4xHKMtO+NoznUwkLt21aHnUJxu8ZHksaq4M6BsFdJOkY97n+yd5ZAS+qRQet1SfEord
 pViZqPXVq6aWx5tSAN3xV2XNlv0VLsy46ZChlfizjN/ngczYTh7GhMubyae1+rBZvGB9G9Kz4
 MZzC6VG/5Y5cntyF/ABvxgI3fzF9RaheGXROinbBFU9gwmLOoYpHcH4BZF5UBgPKmLJe7IOc8
 m2G/hjcgiMSItc9eGITPOPlrcxQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 171edcbb49 (git-branch: introduce missing long forms for the
options, 2011-08-28) git branch accepts --no-all and --no-remotes, but
fails in both cases, reporting "fatal: filter_refs: invalid type".
Disallow the options --all and --remotes to be negated in the first
place.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/branch.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a27bc0a3df..1bfd85f4d8 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -720,8 +720,10 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("c=
hange the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("unset the upstream i=
nfo")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
-		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-trackin=
g branches"),
-			FILTER_REFS_REMOTES),
+		OPT_SET_INT_F('r', "remotes", &filter.kind,
+			N_("act on remote-tracking branches"),
+			FILTER_REFS_REMOTES,
+			PARSE_OPT_NONEG),
 		OPT_CONTAINS(&filter.with_commit, N_("print only branches that contain =
the commit")),
 		OPT_NO_CONTAINS(&filter.no_commit, N_("print only branches that don't c=
ontain the commit")),
 		OPT_WITH(&filter.with_commit, N_("print only branches that contain the =
commit")),
@@ -729,8 +731,10 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 		OPT__ABBREV(&filter.abbrev),

 		OPT_GROUP(N_("Specific git-branch actions:")),
-		OPT_SET_INT('a', "all", &filter.kind, N_("list both remote-tracking and=
 local branches"),
-			FILTER_REFS_REMOTES | FILTER_REFS_BRANCHES),
+		OPT_SET_INT_F('a', "all", &filter.kind,
+			N_("list both remote-tracking and local branches"),
+			FILTER_REFS_REMOTES | FILTER_REFS_BRANCHES,
+			PARSE_OPT_NONEG),
 		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1),
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2=
),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog")=
, 1),
=2D-
2.41.0

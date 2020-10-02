Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F35C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964B4206C3
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 13:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CIbyHPNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbgJBNwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 09:52:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:41491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBNwx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 09:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601646765;
        bh=U2N+wsmXFFtfuM8aH1znCziKxguiTgv6MNx9H6EXSy0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CIbyHPNTwdG1DHbDxG/eKS8jbhaW9cx7+n0tA/tpcBPrz+tEAUR3FyxsdpC+wOEDw
         0vrnWUcRSK5txE3/Vi561/wXc3iFx2We6Okb6OMcFKrNwZrGBQ0wQAY7O25uG/PpvA
         s8IQ7TVZHOtW5V3UR4Wix5M1sPHByc/PC9T0RVdk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.114]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1k7NfH2zUc-00LX5e; Fri, 02
 Oct 2020 15:52:45 +0200
Date:   Fri, 2 Oct 2020 15:52:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v9 1/3] push: add reflog check for
 "--force-if-includes"
In-Reply-To: <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com> <20201001082118.19441-1-shrinidhi.kaushik@gmail.com> <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L7YG83sEtLJFFTmmW1ZlpRXQpjmXcA2kWhhtNgqhu2o77Dq5GqT
 87wbc3805cAQ4e/27bxLjdWSDTRMvKy4nVYml4g/9DW29WuN18oYonFJszf04apLC0hQ3aC
 Q5fyaLKssJk9eD6TVnw0+hGhJXRzoRP2RGBqVzTLfv+1SFEUKcMdjurZw2DCcJTXRPcukq4
 9AwT+EAG3Wh+sp8IiB6Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i7xjJ1KvKQY=:YxCM65Ple3mezXx69A4Lar
 l8DST1wi+pdooBJb+l/yb05Lce9Ma7s24omt7oc/9rhgfowRjdaaaCH9b3fqvavr+/VjhJBmZ
 1cWlj09fGUIQo3aE1HufNVAi0xTEj1UkkLuO9hI62UXOwWOn0c2VsmJdiDUM7Us8NodhNlfZQ
 72vBygtoT8/NWI3uTGyIETX3ekIw4/jyRcjl11Ot4BjpwvbVUDMKEWFD7mW4Rvf8C5o78x+86
 ACs6asUlpVH8UNwWKvlCRLLmebsf/49jlsL1Jcb5F56Oycsg9lE+HgDy1yxmW6PR5uCme95Po
 WJu7vjKEX1mIgI2ogQZOMOo8BDYepcDW8WV24xE3GJ10UQowZ/zBWeWcB9Ae/arcseKhxx0kV
 04NmO/xM8RZTEHqFUT2PvpX2IWwoyZmpmzaI5nm0U5ixYyjmOgk1g+43QqQUJ9RQPl/omE54B
 RYL6jaozTorCy45t74yy7uFSqm/RHqcDdoaoTtz9tQJXfBdDczhDOt2/BV/M3/8nheV3pKBRX
 UNsWESLUA6p9+J8HRUQTTQEvEjWs03DCrsDb3GBOe1jyx2Tjkwv09jUjTIC0IEbX54udIfSGM
 oSp15obhcvp3wFnVu1cjcqJ+GaGYPLJfk8XlBLV+jgXpaesC+kRRuy1MzaWrNEloTS+BYTgz6
 D0aRWNd38dGK7gKlKDHli9ybI7d5Or/WiPpbWN+Ah6SqvllkPqZyg1R5fOecG0rDoBkvJuCQp
 XStNRCyGqcvV55tR6dD1+zGHp8xj4aP+Fu+7F8qoS3iQt5dqQCkObikCTqPFr3UcVnVtpBpq5
 xHFnvNHuNY9OZ7yZUCeW8qED/mDDqI3grnmOkhXFklHr/8Lisdd5a+DLN5+eRtQy4jwPTWaSL
 KqgpQ+19HzdVKJrtBVI1/s3BmM06F2Y05zmXYPIQaiV8/5lLOIjXE7R1P0k1vyCj1mwLSbq+Z
 mW5Qg55GYk7tIjeNerToDRIK/EXpmfZGfdpi5UQSQsAzLiigy2Uq+F9tLPDeRq0KoavTigNc3
 6YmRsdN5+Ihtnd8KV8Ml7IIByyoyHNtzK18uabNbsRsifV2JLoGegb2SgLuaN0mVnRvI1224n
 bpjObvFou0+Yo8aXAqOXRULjC2/Rk1cDlurteLDEAN/xFrt9F/Zi/tsyxovzVstFC73CK0puN
 jF/DVeH8R0DFaCqdVJtb3au78Q3v+S4A6TQLJSAGG45t8knvEH7uOvoW7KmnJ7DLjgwBT9xYu
 7DvE6b2zwj3CufPY6pkrHLVxnItjR8fBpRoLs5Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,


On Thu, 1 Oct 2020, Srinidhi Kaushik wrote:

> Add a check to verify if the remote-tracking ref of the local branch
> is reachable from one of its "reflog" entries.
>
> The check iterates through the local ref's reflog to see if there
> is an entry for the remote-tracking ref and collecting any commits
> that are seen, into a list; the iteration stops if an entry in the
> reflog matches the remote ref or if the entry timestamp is older
> the latest entry of the remote ref's "reflog". If there wasn't an
> entry found for the remote ref, "in_merge_bases_many()" is called
> to check if it is reachable from the list of collected commits.
>
> When a local branch that is based on a remote ref, has been rewound
> and is to be force pushed on the remote, "--force-if-includes" runs
> a check that ensures any updates to the remote-tracking ref that may
> have happened (by push from another repository) in-between the time
> of the last update to the local branch (via "git-pull", for instance)
> and right before the time of push, have been integrated locally
> before allowing a forced update.
>
> If the new option is passed without specifying "--force-with-lease",
> or specified along with "--force-with-lease=3D<refname>:<expect>" it
> is a "no-op".
>
> Calls to "in_merge_bases_many()" return different results depending
> on whether the "commit-graph" feature is enabled or not -- it is
> temporarily disabled when the check runs [1].
>
> [1] https://lore.kernel.org/git/xmqqtuvhn6yx.fsf@gitster.c.googlers.com

I can verify that the multiple calls to `in_merge_bases_many()` lead to a
problem, and I intend to debug this further, but it is the wrong function
to call to begin with.

With these two patches, the tests pass for me, and they also reduce the
complexity quite a bit (Junio, could I ask you to put them on top of
sk/force-if-includes?):

=2D- snipsnap --
=46rom 0e7bd31c4cb0ae08ad772ac230eea2dd7a884886 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 2 Oct 2020 15:33:05 +0200
Subject: [PATCH 1/2] fixup??? push: add reflog check for "--force-if-inclu=
des"

This follows the pattern used elsewhere.

Maybe we should also rename this to `commit_array`? It is not a linked
list, after all.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 remote.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 37533cafc44..2c6c63aa906 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -2441,6 +2441,7 @@ struct reflog_commit_list {
 	struct commit **item;
 	size_t nr, alloc;
 };
+#define REFLOG_COMMIT_LIST_INIT { NULL, 0, 0 }

 /* Append a commit to the list. */
 static void append_commit(struct reflog_commit_list *list,
@@ -2514,7 +2515,7 @@ static int is_reachable_in_reflog(const char *local,=
 const struct ref *remote)
 	struct commit *commit;
 	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
-	struct reflog_commit_list list =3D { NULL, 0, 0 };
+	struct reflog_commit_list list =3D REFLOG_COMMIT_LIST_INIT;
 	size_t size =3D 0;
 	int ret =3D 0;

=2D-
2.28.0.windows.1.18.g5300e52e185


=46rom 10ea5640015f4bc7144e8e5b025e31294329c600 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 2 Oct 2020 15:35:58 +0200
Subject: [PATCH 2/2] fixup??? push: add reflog check for "--force-if-inclu=
des"

We should not call `in_merge_bases_many()` repeatedly: there is a much
better API for that: `get_reachable_subset()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 remote.c | 43 ++++---------------------------------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/remote.c b/remote.c
index 2c6c63aa906..881415921e2 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -2513,10 +2513,9 @@ static int is_reachable_in_reflog(const char *local=
, const struct ref *remote)
 {
 	timestamp_t date;
 	struct commit *commit;
-	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
 	struct reflog_commit_list list =3D REFLOG_COMMIT_LIST_INIT;
-	size_t size =3D 0;
+	struct commit_list *reachable;
 	int ret =3D 0;

 	commit =3D lookup_commit_reference(the_repository, &remote->old_oid);
@@ -2542,61 +2541,27 @@ static int is_reachable_in_reflog(const char *loca=
l, const struct ref *remote)
 	 * Check if the remote commit is reachable from any
 	 * of the commits in the collected list, in batches.
 	 */
-	for (chunk =3D list.item; chunk < list.item + list.nr; chunk +=3D size) =
{
-		size =3D list.item + list.nr - chunk;
-		if (MERGE_BASES_BATCH_SIZE < size)
-			size =3D MERGE_BASES_BATCH_SIZE;
-
-		if ((ret =3D in_merge_bases_many(commit, size, chunk)))
-			break;
-	}
+	reachable =3D get_reachable_subset(list.item, list.nr, &commit, 1, 0);
+	ret =3D !!reachable;
+	free_commit_list(reachable);

 cleanup_return:
 	free_reflog_commit_list(&list);
 	return ret;
 }

-/* Toggle the "commit-graph" feature; return the previously set state. */
-static int toggle_commit_graph(struct repository *repo, int disable) {
-	int prev =3D repo->commit_graph_disabled;
-	static int should_toggle =3D -1;
-
-	if (should_toggle < 0) {
-		/*
-		 * The in_merge_bases_many() seems to misbehave when
-		 * the commit-graph feature is in use.  Disable it for
-		 * normal users, but keep it enabled when specifically
-		 * testing the feature.
-		 */
-		should_toggle =3D !git_env_bool("GIT_TEST_COMMIT_GRAPH", 0);
-	}
-
-	if (should_toggle)
-		repo->commit_graph_disabled =3D disable;
-	return prev;
-}
-
 /*
  * Check for reachability of a remote-tracking
  * ref in the reflog entries of its local ref.
  */
 static void check_if_includes_upstream(struct ref *remote)
 {
-	int prev;
 	struct ref *local =3D get_local_ref(remote->name);
 	if (!local)
 		return;

-	/*
-	 * TODO: Remove "toggle_commit_graph()" calls around the check.
-	 * Depending on whether "commit-graph" enabled or not,
-	 * "in_merge_bases_many()" returns different results;
-	 * disable it temporarily when the check runs.
-	 */
-	prev =3D toggle_commit_graph(the_repository, 1);
 	if (is_reachable_in_reflog(local->name, remote) <=3D 0)
 		remote->unreachable =3D 1;
-	toggle_commit_graph(the_repository, prev);
 }

 static void apply_cas(struct push_cas_option *cas,
=2D-
2.28.0.windows.1.18.g5300e52e185


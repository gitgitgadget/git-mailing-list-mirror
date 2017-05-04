Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDF1207B3
	for <e@80x24.org>; Thu,  4 May 2017 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbdEDK7x (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 06:59:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:59081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751799AbdEDK7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 06:59:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lpspj-1dkGSs0sul-00fi4n; Thu, 04
 May 2017 12:59:21 +0200
Date:   Thu, 4 May 2017 12:59:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 12/25] split_commit_in_progress(): fix memory leak
In-Reply-To: <8a0a2230-239e-b6c8-f7c0-8192e6cec7ec@web.de>
Message-ID: <alpine.DEB.2.21.1.1705041231270.4905@virtualbox>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de> <8cc59c706934134294e91a99062f7dcc0bda17db.1493740497.git.johannes.schindelin@gmx.de> <8a0a2230-239e-b6c8-f7c0-8192e6cec7ec@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1091732336-1493895561=:4905"
X-Provags-ID: V03:K0:Rv6r2iLDxu8Jy4K/WMxuxGPbNhvsVxrvAxgjNMKDLNO6RKSbzc0
 QgKm8VwgvqvZ/kKd9WQght2EewAvDMsNFz7GYxlfsfL9xjeuI4PuEGEDksZKAIb7vfTZo0O
 dla6XkXxriVexAfu+XgnU3O6QFficKiGQC4mlblQhhZW1aOLh7PJ+84nrJpiHLgJnulXvUa
 za9DKXiGIzTTtpytIM/7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MO8dIuhAogw=:KQApSsDt4NptwsP3AondPS
 7yWVfjJwrV3SYMVPTGjr+ZXgpZxnTizS6jsoUDCrzr3lGCue37+HefzLuEXUHn2TGCw5Z6xvj
 wOzHtANYxo3EE6KAGbR7N9UlYGd2JVLzpDVfjpMyywX8YOmZq0BhCH2+R1xgHpJp106Q/QKXF
 b4DSHbR24UpcAbbMq8tWgf+sq7cyBaOtTgJjAKbXEhf7PRPjVd1KvyNpja1FaFQfw/kJ2XR2t
 IZuHDGuGWwgafM75UFmu1q3t7zgpsK5iZIv8nLMy8GW6mA+uMztrQt9j0+JwU1UV7UKPr/7ht
 X0+B0JfaNPCaii/7uERrx/ybhRO0LnXnT8iCcmA5OvoM6rPL56rZcRFsbBip7J9qchsJJbSBx
 0AeqB9ZG7K05/hq+kYFovHfwBbFJ2W/37Zx0iyuXTBKP4trRTV0p/vx3fux3rBEa+UP887G6U
 QpWLpKP6sh7v+OL+0Hr3zgaTG5Yeu5ozCo63GSBUl6pi+6CyX9oZEud3C756bVkBjWNJ9Hcu/
 Ld/z2v3A8Ekg6f1iGToE/Cb9t+EaSs4lsyqhA2Ta+AzVRSMa/SJpWHxXAAkpBk5epGEAjdhxi
 9QE76kO4Gjw5shBL3CMKeS2Rfv5BFzR7XdM22UNCl8sa+yAtCSM4Y4fBFiXSUauiJ8LXjwVSJ
 u38IxWoAQ854Bk3l4sKn1Nzy9lCzuBWXhpazLNAwZF+e9WCw+b9C3TB6pQi1QHDWattgd++OQ
 S6sajSHEQdZQ5HCoVvWJukkqSHcU/iaszJpm5NuWEhqldxfMZTTJYvp/ieXj0dSZUmJYWImVs
 LNzikjK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1091732336-1493895561=:4905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Wed, 3 May 2017, Ren=C3=A9 Scharfe wrote:

> Am 02.05.2017 um 18:02 schrieb Johannes Schindelin:
> > Reported via Coverity.
> >=20
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   wt-status.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/wt-status.c b/wt-status.c
> > index 0a6e16dbe0f..1f3f6bcb980 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1088,8 +1088,13 @@ static int split_commit_in_progress(struct wt_st=
atus
> > *s)
> >    char *rebase_orig_head =3D
> >    read_line_from_git_path("rebase-merge/orig-head");
> >  =20
> >   =09if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
> > -=09    !s->branch || strcmp(s->branch, "HEAD"))
> > +=09    !s->branch || strcmp(s->branch, "HEAD")) {
> > +=09=09free(head);
> > +=09=09free(orig_head);
> > +=09=09free(rebase_amend);
> > +=09=09free(rebase_orig_head);
> >   =09=09return split_in_progress;
> > +=09}
> >  =20
> >    if (!strcmp(rebase_amend, rebase_orig_head)) {
> >     if (strcmp(head, rebase_amend))
> >=20
>=20
> The return line could be replaced by "; else" to achieve the same
> result, without duplicating the free calls.

True. It is much harder to explain it that way, though: the context looks
like this:

static int split_commit_in_progress(struct wt_status *s)
 {
        int split_in_progress =3D 0;
        char *head =3D read_line_from_git_path("HEAD");
        char *orig_head =3D read_line_from_git_path("ORIG_HEAD");
        char *rebase_amend =3D read_line_from_git_path("rebase-merge/amend"=
);
        char *rebase_orig_head =3D read_line_from_git_path("rebase-merge/or=
ig-head");

        if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
-           !s->branch || strcmp(s->branch, "HEAD"))
+           !s->branch || strcmp(s->branch, "HEAD")) {
+               free(head);
+               free(orig_head);
+               free(rebase_amend);
+               free(rebase_orig_head);
                return split_in_progress;
+       }

        if (!strcmp(rebase_amend, rebase_orig_head)) {
                if (strcmp(head, rebase_amend))
                        split_in_progress =3D 1;
        } else if (strcmp(orig_head, rebase_orig_head)) {
                split_in_progress =3D 1;
        }

        if (!s->amend && !s->nowarn && !s->workdir_dirty)
                split_in_progress =3D 0;

        free(head);
        free(orig_head);
        free(rebase_amend);
        free(rebase_orig_head);
        return split_in_progress;
 }

So as you see, if we make the change you suggested, the next if() is hit
which possibly sets split_in_progress =3D 0.

The thing is: this variable has been initialized to 0 in the beginning! So
this conditional assignment would be a noop, unless any of the code paths
before this conditional modified split_in_progress.

After you fully wrapped your head around this code, I am sure you agree
that the code is unnecessarily confusing to begin with: why do we go out
of our way to allocate and read all those strings, compare them to figure
out whether there is a split in progress, just to look at bits in the
wt_status struct (that we had available from the beginning) to potentially
undo all of that.

What's worse, I cannot even find a logical explanation why the code is so
confusing, as it has been added as it is today in commit 2d1ccebae41
(status: better advices when splitting a commit (during rebase -i),
2012-06-10).

So I think this function really wants to be fixed more fully (although I
feel bad for inserting such a non-trivial fix into a patch series
otherwise populated by trivial memory/resource leak plugs):

-- snipsnap --
Subject: [PATCH] squash! split_commit_in_progress(): fix memory leak

split_commit_in_progress(): simplify & fix memory leak

This function did a whole lot of unnecessary work, such as reading in
four files just to figure out that, oh, hey, we do not need to look at
them after all because the HEAD is not detached.

Simplify the entire function to return early when possible, to read in
the files only when necessary, and to release the allocated memory
always (there was a leak, reported via Coverity, where we failed to
release the allocated strings if the HEAD is not detached).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1f3f6bcb980..117ac8cfb01 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1082,34 +1082,29 @@ static char *read_line_from_git_path(const char *fi=
lename)
 static int split_commit_in_progress(struct wt_status *s)
 {
 =09int split_in_progress =3D 0;
-=09char *head =3D read_line_from_git_path("HEAD");
-=09char *orig_head =3D read_line_from_git_path("ORIG_HEAD");
-=09char *rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
-=09char *rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-h=
ead");
-
-=09if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
-=09    !s->branch || strcmp(s->branch, "HEAD")) {
-=09=09free(head);
-=09=09free(orig_head);
-=09=09free(rebase_amend);
-=09=09free(rebase_orig_head);
-=09=09return split_in_progress;
-=09}
-
-=09if (!strcmp(rebase_amend, rebase_orig_head)) {
-=09=09if (strcmp(head, rebase_amend))
-=09=09=09split_in_progress =3D 1;
-=09} else if (strcmp(orig_head, rebase_orig_head)) {
-=09=09split_in_progress =3D 1;
-=09}
+=09char *head, *orig_head, *rebase_amend, *rebase_orig_head;
+
+=09if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
+=09    !s->branch || strcmp(s->branch, "HEAD"))
+=09=09return 0;
=20
-=09if (!s->amend && !s->nowarn && !s->workdir_dirty)
-=09=09split_in_progress =3D 0;
+=09head =3D read_line_from_git_path("HEAD");
+=09orig_head =3D read_line_from_git_path("ORIG_HEAD");
+=09rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
+=09rebase_orig_head =3D read_line_from_git_path("rebase-merge/orig-head");
+
+=09if (!head || !orig_head || !rebase_amend || !rebase_orig_head)
+=09=09; /* fall through, no split in progress */
+=09else if (!strcmp(rebase_amend, rebase_orig_head))
+=09=09split_in_progress =3D !!strcmp(head, rebase_amend);
+=09else if (strcmp(orig_head, rebase_orig_head))
+=09=09split_in_progress =3D 1;
=20
 =09free(head);
 =09free(orig_head);
 =09free(rebase_amend);
 =09free(rebase_orig_head);
+
 =09return split_in_progress;
 }
=20
--=20
2.12.2.windows.2.800.gede8f145e06

--8323329-1091732336-1493895561=:4905--

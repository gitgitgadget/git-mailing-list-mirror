From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] =?UTF-8?Q?fsck=5Fhandle=5Freflog=5Fsha=31=28=29?=
 =?UTF-8?Q?=3A=20new=20function?=
Date: Mon, 08 Jun 2015 09:18:53 -0500
Organization: gmx
Message-ID: <b3e391d36b36b67aca1fa5db4350f219@www.dscho.org>
References: <cover.1433769878.git.mhagger@alum.mit.edu>
 <1c6f5540fe974016c1547163c7b891707019154d.1433769878.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:19:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1xtj-00030i-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 16:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbbFHOTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 10:19:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:52348 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbbFHOTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 10:19:09 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MYbFe-1YXlpl3YKg-00VMBC; Mon, 08 Jun 2015 16:18:55
 +0200
In-Reply-To: <1c6f5540fe974016c1547163c7b891707019154d.1433769878.git.mhagger@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:SoOz9Xf+12Ene7SCrsb9gu3Jl3HJtEOZJqFTaWOMMd5F5Op4dGc
 oPKVG2Br5q49A4KnmNehE/LUIYMoFN8BD5USaWp9MWv410ozjhdygTO87D36EGxxktIXfSQ
 r13+5IgWMRI3hYgb5COCUDU5TazegkVtQe2tm9hGz/Jnccaitox3qppW/nxbBK5hO4Dvo8X
 5AHpJOPD6IEZrd93uY8DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iKXYfrHhIQc=:rxtwnDUdUD3+13PxcWho6x
 J4K8E97hDIGnGhrViBQmRUIBMPik11SmJANSuDQcCWRZpOb5KsV9mlH5a/F5KWpIFvssX01KR
 6zgLbCTgU+B5dgK5DxzEFvs1WZO20dKJOUDLGRXhxauOTNCNDkJ2FE43QdV5SXyhs3aSFE5lS
 FAELTjqZ0VS3hptmu5MxbMBWnzHS7NqXBGyyYzHqhNX2qSWvpdyjlXJjzxsfPYJZ5wEvI4/e+
 gIMQklkdbRaDz4dcJK+OjZ39C830tE7w17LO5c6m9zfsbjhzGf0h3wFhJRY7QqLKzm8WoRI5j
 65nDuqS7eo1PA2pufe28+sIe1EeuQJXsU+z3TqPI2OgIqxcTZGdi84+kI++OOO84Nngohk6xw
 IquJfR5+YppK8SpliEKSMYLMLX+F6P4xMiByo/UTwK7o9sV8R6o26ISvaym8l2+0I72Mq9Und
 5HvwBSshAmZOFIC9Iq8joSvGUXGzM/57H0AilEkVHfLoB0GEfPdgAyZBa4U74awHYsaPLcmJL
 VleG14gj9gDHq2GwmLvWO0XuaCFQFabkbau6V9o2WRLBTMoBygW0hT9jJYPdktopbiEFTBtWg
 GZAOWNmWJuLwM8GJxEDeMy9kssctruHeAXS+zSUSEYsD2G96tkvKzXeZwgM/V/E0Xe5zbkzea
 Xr9coGhKUV7QWsF/y/JOigg9KzzLW3mgzbpbwc9HuUc2ZFbQjZpTz8Cpl3npmpW5ytrw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271034>

Hi Michael,

On 2015-06-08 08:40, Michael Haggerty wrote:
> New function, extracted from fsck_handle_reflog_ent(). The extra
> is_null_sha1() test for the new reference is currently unnecessary, as
> reflogs are deleted when the reference itself is deleted. But it
> doesn't hurt, either.

This patch is probably easier to read with the `--patience` flag (at least I find the patch obviously good in that form):

-- snipsnap --
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4e8e2ee..b1b6c60 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -451,28 +451,29 @@ static void fsck_dir(int i, char *path)
 
 static int default_refs;
 
+static void fsck_handle_reflog_sha1(unsigned char *sha1)
+{
+	struct object *obj;
+
+	if (!is_null_sha1(sha1)) {
+		obj = lookup_object(sha1);
+		if (obj) {
+			obj->used = 1;
+			mark_object_reachable(obj);
+		}
+	}
+}
+
 static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct object *obj;
-
 	if (verbose)
 		fprintf(stderr, "Checking reflog %s->%s\n",
 			sha1_to_hex(osha1), sha1_to_hex(nsha1));
 
-	if (!is_null_sha1(osha1)) {
-		obj = lookup_object(osha1);
-		if (obj) {
-			obj->used = 1;
-			mark_object_reachable(obj);
-		}
-	}
-	obj = lookup_object(nsha1);
-	if (obj) {
-		obj->used = 1;
-		mark_object_reachable(obj);
-	}
+	fsck_handle_reflog_sha1(osha1);
+	fsck_handle_reflog_sha1(nsha1);
 	return 0;
 }
 
-- 
1.8.5.2.msysgit.0.4.gd08ed18

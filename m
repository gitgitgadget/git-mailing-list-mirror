From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 08/24] add documentation for the index api
Date: Sun, 18 Aug 2013 16:50:54 -0400
Message-ID: <6EE9A533-F8A7-444C-AFEC-0D8F9E6BCFF9@sunshineco.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-9-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com,
	ramsay@ramsay1.demon.co.uk
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 22:51:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB9wV-0003Ls-GM
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 22:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307Ab3HRUvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Aug 2013 16:51:11 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:48854 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab3HRUvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Aug 2013 16:51:08 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so4471134oag.26
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 13:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cTcZwEnNNNocLkrlLNx/w6hq7heud88VAcG0zYMzNSw=;
        b=rwFNXmILlyl4tS/RN8AOivII7JQ5Q2uoJrUNKKen9Ck6rtK7fp53+ViTiIEs+yPl4w
         rG6aS3kH9BI/5oAs/wofoxk9EQgjv4y2ifrGV7KHZmtn/Ju05blFLQk8DS4/UhrWOfHO
         HikGT/VwkTYmAZkKWuswkrJAGKfgh8XPPqP3JCJ1/n5KN0OCOJgQwu1zDwNsM62eXkSh
         7bQk2JMheA/y1AgqFO2Ijq/5E3M6Ej7LQs5ZaBHHBw6SzgFhJZwkDNB3Pxu7yDLspXur
         FEBt1i+BUnsys/7RjFlW4o+qE+lNkbsUV0UHX6fKyvtT98Tfpfa8ztxAQMuXINo66lcX
         zSAw==
X-Received: by 10.60.62.101 with SMTP id x5mr9396999oer.24.1376859067629;
        Sun, 18 Aug 2013 13:51:07 -0700 (PDT)
Received: from [192.168.1.2] (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id fk3sm10771187obb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 Aug 2013 13:51:06 -0700 (PDT)
In-Reply-To: <1376854933-31241-9-git-send-email-t.gummerer@gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232517>

On Aug 18, 2013, at 3:41 PM, Thomas Gummerer wrote:
> Add documentation for the index reading api.  This also includes
> documentation for the new api functions introduced in the next patch.
>=20
> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> Documentation/technical/api-in-core-index.txt | 54 ++++++++++++++++++=
+++++++--
> 1 file changed, 50 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/technical/api-in-core-index.txt b/Document=
ation/technical/api-in-core-index.txt
> index adbdbf5..9b8c37c 100644
> --- a/Documentation/technical/api-in-core-index.txt
> +++ b/Documentation/technical/api-in-core-index.txt
> @@ -1,14 +1,60 @@
> in-core index API
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +Reading API
> +-----------
> +
> +`cache`::
> +
> +	An array of cache entries.  This is used to access the cache
> +	entries directly.  Use `index_name_pos` to search for the
> +	index of a specific cache entry.
> +
> +`read_index_filtered`::
> +
> +	Read a part of the index, filtered by the pathspec given in
> +	the opts.  The function may load more than necessary, so the
> +	caller still responsible to apply filters appropriately.  The

Grammatical nit: "...the caller is still responsible for applying=E2=80=
=A6"

> +	filtering is only done for performance reasons, as it's
> +	possible to only read part of the index when the on-disk
> +	format is index-v5.
> +
> +	To iterate only over the entries that match the pathspec, use
> +	the for_each_index_entry function.
> +
> +`read_index`::
> +
> +	Read the whole index file from disk.
> +
> +`index_name_pos`::
> +
> +	Find a cache_entry with name in the index.  Returns pos if an
> +	entry is matched exactly and -1-pos if an entry is matched
> +	partially.
> +	e.g.
> +	index:
> +	file1
> +	file2
> +	path/file1
> +	zzz
> +
> +	index_name_pos("path/file1", 10) returns 2, while
> +	index_name_pos("path", 4) returns -3

A couple of these entries won't format correctly. You may want to squas=
h in something like this (sans whitespace damage):

-->8--
diff --git a/Documentation/technical/api-in-core-index.txt b/Documentat=
ion/technical/api-in-core-index.txt
index 9b8c37c..d2518c8 100644
--- a/Documentation/technical/api-in-core-index.txt
+++ b/Documentation/technical/api-in-core-index.txt
@@ -18,9 +18,9 @@ Reading API
 	filtering is only done for performance reasons, as it's
 	possible to only read part of the index when the on-disk
 	format is index-v5.
-
-	To iterate only over the entries that match the pathspec, use
-	the for_each_index_entry function.
++
+To iterate only over the entries that match the pathspec, use
+the for_each_index_entry function.
=20
 `read_index`::
=20
@@ -30,16 +30,18 @@ Reading API
=20
 	Find a cache_entry with name in the index.  Returns pos if an
 	entry is matched exactly and -1-pos if an entry is matched
-	partially.
-	e.g.
-	index:
+	partially. e.g.
++
+....
+index:
 	file1
 	file2
 	path/file1
 	zzz
-
-	index_name_pos("path/file1", 10) returns 2, while
-	index_name_pos("path", 4) returns -3
+....
++
+`index_name_pos("path/file1", 10)` returns 2, while
+`index_name_pos("path", 4)` returns -3
=20
 `for_each_index_entry`::
=20
--=20
1.8.4.rc3.500.gc3113b0
-->8--

> +
> +`for_each_index_entry`::
> +
> +	Iterates over all cache_entries in the index filtered by
> +	filter_opts in the index_state.  For each cache entry fn is
> +	executed with cb_data as callback data.  From within the loop
> +	do `return 0` to continue, or `return 1` to break the loop.
> +
> +TODO
> +----
> Talk about <read-cache.c> and <cache-tree.c>, things like:
>=20
> -* cache -> the_index macros
> -* read_index()
> * write_index()
> * ie_match_stat() and ie_modified(); how they are different and when =
to
>   use which.
> -* index_name_pos()
> * remove_index_entry_at()
> * remove_file_from_index()
> * add_file_to_index()
> @@ -18,4 +64,4 @@ Talk about <read-cache.c> and <cache-tree.c>, thing=
s like:
> * cache_tree_invalidate_path()
> * cache_tree_update()
>=20
> -(JC, Linus)
> +(JC, Linus, Thomas Gummerer)
> --=20
> 1.8.3.4.1231.g9fbf354.dirty
>=20

From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 5.5/22] Add documentation for the index api
Date: Mon, 08 Jul 2013 22:54:23 +0200
Message-ID: <871u78rcw0.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com> <87pputqowr.fsf@gmail.com> <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 22:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwISI-0004i3-Rk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab3GHUyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 16:54:38 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:50037 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab3GHUyh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 16:54:37 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so4748215pbc.15
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=wVMiViSDFBGNTFILqeLpK2uLPvocqZsAGigAJW/ULy4=;
        b=QDWcmte2mOWJC6ZVoMsSs0osSBc0fk066S1szDaUdMKDRVDR5wqyIFKlHBcIXSUxwR
         zK+WNEqyORFk18vjgnBGw+ELhYwOf8W1m6pKQLTXlPO86sj4uDSCD7yFZDt3078cLwwo
         UDvCfZ9JRTjvZYn+fGNjBznUtbwfu0Co01k3G5DKdPgwBTAFvZkz4/jOgKYaMCC7+rIM
         b4NWHaVKj0aZI+9M9GrxfNXD4coxTIYmGibM8OGP1ecHrUD4eJLfY24LtlhbYZs6sSIl
         su1C5xNRciYh5hkk/1MoYQZtBp0ufhL5DakgEW+7206+FQO3Fqu1AETCEeT7xFlfdFMz
         UDUA==
X-Received: by 10.66.119.74 with SMTP id ks10mr24846747pab.179.1373316877436;
        Mon, 08 Jul 2013 13:54:37 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id sq5sm25958965pab.11.2013.07.08.13.54.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 13:54:36 -0700 (PDT)
In-Reply-To: <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229892>

Document the new index api and add examples of how it should be used
instead of the old functions directly accessing the index.

Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Duy Nguyen <pclouds@gmail.com> writes:

> Hmm.. I was confused actually (documentation on the api would help
> greatly).

As promised, a draft for a documentation for the index api as it is in
this series.

Documentation/technical/api-in-core-index.txt | 108 +++++++++++++++++++=
++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-in-core-index.txt b/Documentat=
ion/technical/api-in-core-index.txt
index adbdbf5..5269bb1 100644
--- a/Documentation/technical/api-in-core-index.txt
+++ b/Documentation/technical/api-in-core-index.txt
@@ -1,14 +1,116 @@
 in-core index API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

+Reading API
+-----------
+
+`read_index()`::
+	Read the whole index file from disk.
+
+`index_name_pos(name, namelen)`::
+	Find a cache_entry with name in the index.  Returns pos if an
+	entry is matched exactly and -pos-1 if an entry is matched
+	partially.
+	e.g.
+	index:
+	file1
+	file2
+	path/file1
+	zzz
+
+	index_name_pos("path/file1", 10) returns 2, while
+	index_name_pos("path", 4) returns -1
+
+`read_index_filtered(opts)`::
+	This method behaves differently for index-v2 and index-v5.
+
+	For index-v2 it simply reads the whole index as read_index()
+	does, so we are sure we don't have to reload anything if the
+	user wants a different filter.  It also sets the filter_opts
+	in the index_state, which is used to limit the results when
+	iterating over the index with for_each_index_entry().
+
+	The whole index is read to avoid the need to eventually
+	re-read the index later, because the performance is no
+	different when reading it partially.
+
+	For index-v5 it creates an adjusted_pathspec to filter the
+	reading.  First all the directory entries are read and then
+	the cache_entries in the directories that match the adjusted
+	pathspec are read.  The filter_opts in the index_state are set
+	to filter out the rest of the cache_entries that are matched
+	by the adjusted pathspec but not by the pathspec given.  The
+	rest of the index entries are filtered out when iterating over
+	the cache with for_each_index_entries.
+
+`get_index_entry_by_name(name, namelen, &ce)`::
+	Returns a cache_entry matched by the name, returned via the
+	&ce parameter.  If a cache entry is matched exactly, 1 is
+	returned, otherwise 0.  For an example see index_name_pos().
+	This function should be used instead of the index_name_pos()
+	function to retrieve cache entries.
+
+`for_each_index_entry(fn, cb_data)`::
+	Iterates over all cache_entries in the index filtered by
+	filter_opts in the index_stat.  For each cache entry fn is
+	executed with cb_data as callback data.  From within the loop
+	do `return 0` to continue, or `return 1` to break the loop.
+
+`next_index_entry(ce)`::
+	Returns the cache_entry that follows after ce
+
+`index_change_filter_opts(opts)`::
+	This function again has a slightly different functionality for
+	index-v2 and index-v5.
+
+	For index-v2 it simply changes the filter_opts, so
+	for_each_index_entry uses the changed index_opts, to iterate
+	over a different set of cache entries.
+
+	For index-v5 it refreshes the index if the filter_opts have
+	changed and sets the new filter_opts in the index state, again
+	to iterate over a different set of cache entries as with
+	index-v2.
+
+	This has some optimization potential, in the case that the
+	opts get stricter (less of the index should be read) it
+	doesn't have to reload anything, but currently does.
+
+Using the new index api
+-----------------------
+
+Currently loops over a specific set of index entry were written as:
+  i =3D start_index;
+  while (i < active_nr) { ce =3D active_cache[i]; do(something); i++; =
}
+
+they should be rewritten to:
+  ce =3D start;
+  while (ce) { do(something); ce =3D next_cache_entry(ce); }
+
+which is the equivalent operation but hides the in-memory format of
+the index from the user.
+
+For getting a cache entry get_cache_entry_by_name() should be used
+instead of cache_name_pos(). e.g.:
+  int pos =3D cache_name_pos(name, namelen);
+  struct cache_entry *ce =3D active_cache[pos];
+  if (pos < 0) { do(something) }
+  else { do(somethingelse) }
+
+should be written as:
+  struct cache_entry *ce;
+  int ret =3D get_cache_entry_by_name(name, namelen, &ce);
+  if (!ret) { do(something) }
+  else { do(somethingelse) }
+
+TODO
+----
 Talk about <read-cache.c> and <cache-tree.c>, things like:

 * cache -> the_index macros
-* read_index()
 * write_index()
 * ie_match_stat() and ie_modified(); how they are different and when t=
o
   use which.
-* index_name_pos()
 * remove_index_entry_at()
 * remove_file_from_index()
 * add_file_to_index()
@@ -18,4 +120,6 @@ Talk about <read-cache.c> and <cache-tree.c>, things=
 like:
 * cache_tree_invalidate_path()
 * cache_tree_update()

+
+
 (JC, Linus)
--
1.8.3.453.g1dfc63d

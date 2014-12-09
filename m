From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 14:49:50 -0800
Message-ID: <20141209224949.GB16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 23:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyTbT-0007j3-PT
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbaLIWtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 17:49:55 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:52009 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbaLIWtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 17:49:53 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so1999500iga.8
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 14:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GAYwVX/WDIEi2qcOnsuIzhN3SbKN3NOlClqiAp6twl0=;
        b=njpoguL7hZyIfRIH0gjOhdu2U1dFioKOBgLYPTeo+U4SYD2dUrIizkFsV/M+1BVUPJ
         E3UUELEQ1437WdV6flkyacwhMrrLkSMtpnHXDhFbWTEBXb1narGAEy5to8dmG+hOgtFb
         oYhUcHkoekHqXeaRh62qmHDpZsRip+T0vdyq3Ls5w3BeUMs2T7KOZpW8RmhzBbfIT5Te
         GhEL9e8v2aFrGgwDkCBeL+pAxKAm67ZMxW+JzCfBtXYtdkwDpBczH4Jad8HCDQ1SkyML
         nLAVZShOsLX/NGUyBb8Lvueuxx6l55ma292pmdAojudHjIpxMobanJbWQXrlednz7W0d
         E64g==
X-Received: by 10.107.154.10 with SMTP id c10mr950592ioe.78.1418165392613;
        Tue, 09 Dec 2014 14:49:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a4ec:4fac:afb2:e506])
        by mx.google.com with ESMTPSA id ck2sm1581613igc.15.2014.12.09.14.49.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 14:49:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141209201713.GY16345@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261172>

Jonathan Nieder wrote:
> Stefan Beller wrote:
>> On Tue, Dec 9, 2014 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:

>>> Perhaps the API doc that currently says "Free" is the only thing
>>> that needs fixing?  And perhaps add "See $doc" at the beginning of
>>> the header and remove duplicated comments we already have in the
>>> file?
>>
>> The reason I wrote this patch originally was because I seem to forget we have
>> more than one place to document our APIs. If there are comments in the header
>> I seem to have thought it were the only place where we have documentation.
>
> How about this patch?

And another:

-- >8--
Subject: put string-list API documentation in one place

Until recently (v1.8.0-rc0~46^2~5, 2012-09-12), the string-list API
was documented in detail in Documentation/technical/api-string-list.txt
and the header file contained section markers and some short reminders
but little other documentation.

Since then, the header has acquired some more comments that are mostly
identical to the documentation from technical/.  In principle that
should help convenience, since it means one less hop for someone
reading the header to find API documentation.  In practice,
unfortunately, it is hard to remember that there is documentation in
two places, and the comprehensive documentation of some functions in
the header makes it too easy to forget that the other functions are
documented at all (and where).

Add a comment pointing to Documentation/technical/ and remove the
comments that duplicate what is written there.  Longer term, we may
want to move all of the technical docs to header files and generate
printer-ready API documentation another way, but that is a larger
change for another day.

Short reminders in the header file are still okay.

Reported-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/technical/api-string-list.txt | 12 ++++++-
 string-list.h                               | 56 ++---------------------------
 2 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index d51a657..a85e713 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -185,7 +185,17 @@ overwriting the delimiter characters with NULs and creating new
 string_list_items that point into the original string (the original
 string must therefore not be modified or freed while the `string_list`
 is in use).
-
++
+Examples:
++
+----
+string_list_split(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
+string_list_split(l, "foo:bar:baz", ':', 0) -> ["foo:bar:baz"]
+string_list_split(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
+string_list_split(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
+string_list_split(l, "", ':', -1) -> [""]
+string_list_split(l, ":", ':', -1) -> ["", ""]
+----
 
 Data structures
 ---------------
diff --git a/string-list.h b/string-list.h
index 494eb5d..e6a7841 100644
--- a/string-list.h
+++ b/string-list.h
@@ -1,6 +1,8 @@
 #ifndef STRING_LIST_H
 #define STRING_LIST_H
 
+/* See Documentation/technical/api-string-list.txt */
+
 struct string_list_item {
 	char *string;
 	void *util;
@@ -35,20 +37,9 @@ int for_each_string_list(struct string_list *list,
 #define for_each_string_list_item(item,list) \
 	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
 
-/*
- * Apply want to each item in list, retaining only the ones for which
- * the function returns true.  If free_util is true, call free() on
- * the util members of any items that have to be deleted.  Preserve
- * the order of the items that are retained.
- */
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
-/*
- * Remove any empty strings from the list.  If free_util is true, call
- * free() on the util members of any items that have to be deleted.
- * Preserve the order of the items that are retained.
- */
 void string_list_remove_empty_items(struct string_list *list, int free_util);
 
 /* Use these functions only on sorted lists: */
@@ -59,30 +50,12 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
 struct string_list_item *string_list_insert_at_index(struct string_list *list,
 						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(struct string_list *list, const char *string);
-
-/*
- * Remove all but the first of consecutive entries with the same
- * string value.  If free_util is true, call free() on the util
- * members of any items that have to be deleted.
- */
 void string_list_remove_duplicates(struct string_list *sorted_list, int free_util);
 
 
 /* Use these functions only on unsorted lists: */
 
-/*
- * Add string to the end of list.  If list->strdup_string is set, then
- * string is copied; otherwise the new string_list_entry refers to the
- * input string.
- */
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
-
-/*
- * Like string_list_append(), except string is never copied.  When
- * list->strdup_strings is set, this function can be used to hand
- * ownership of a malloc()ed string to list without making an extra
- * copy.
- */
 struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
 
 void sort_string_list(struct string_list *list);
@@ -92,32 +65,9 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 
-/*
- * Split string into substrings on character delim and append the
- * substrings to list.  The input string is not modified.
- * list->strdup_strings must be set, as new memory needs to be
- * allocated to hold the substrings.  If maxsplit is non-negative,
- * then split at most maxsplit times.  Return the number of substrings
- * appended to list.
- *
- * Examples:
- *   string_list_split(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
- *   string_list_split(l, "foo:bar:baz", ':', 0) -> ["foo:bar:baz"]
- *   string_list_split(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
- *   string_list_split(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
- *   string_list_split(l, "", ':', -1) -> [""]
- *   string_list_split(l, ":", ':', -1) -> ["", ""]
- */
 int string_list_split(struct string_list *list, const char *string,
 		      int delim, int maxsplit);
-
-/*
- * Like string_list_split(), except that string is split in-place: the
- * delimiter characters in string are overwritten with NULs, and the
- * new string_list_items point into string (which therefore must not
- * be modified or freed while the string_list is in use).
- * list->strdup_strings must *not* be set.
- */
 int string_list_split_in_place(struct string_list *list, char *string,
 			       int delim, int maxsplit);
+
 #endif /* STRING_LIST_H */
-- 
2.2.0.rc0.207.ga3a616c

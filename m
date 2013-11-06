From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cat-file: fix output when format string contains no variables
Date: Wed, 06 Nov 2013 10:00:57 -0800
Message-ID: <xmqqsiv98l5y.fsf@gitster.dls.corp.google.com>
References: <1748846.6BAMC5enOx@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Sven Brauch <svenbrauch@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 19:01:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ve7Pl-0008Vv-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 19:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab3KFSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 13:01:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483Ab3KFSBC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 13:01:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EABA4FC5D;
	Wed,  6 Nov 2013 13:01:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yUdMESRHnmrSs/PcsbMaaNnAhac=; b=aJIbD5
	YmBsLbs6pwSWVimE2KkdJ669Kv1tHJ2qixjaKE9lYKA+bzo/nvbhAoVPZo0nGQWJ
	H9uOlMMXcToKsbc3u9heT4u38x3k4f76aaSAHNcfO6MmeppBuvKG7W7wv2xRVr6Y
	oL3qL3hE7j+5/3wL/dD4Lb6puN3f4NO9/dWXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lw/N+55wj9kbDrze14lvov5/RyRntIdl
	5lH45ruvCy8q0AkoKXEPXxFEmz+BzGdNrJwRi+01H2ZV5EeYL5Im9eddxqlNHm2g
	Ta6l/C2BGHh/Y6ypDxuT0ddHs00x23ttgS+o/s1OedHYi9dfhnr0BcyGKIofOC5R
	4FRU+0CoLFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EABA94FC5C;
	Wed,  6 Nov 2013 13:01:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FC674FC59;
	Wed,  6 Nov 2013 13:01:01 -0500 (EST)
In-Reply-To: <1748846.6BAMC5enOx@localhost.localdomain> (Sven Brauch's message
	of "Tue, 05 Nov 2013 21:03:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65541372-470D-11E3-A0AD-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237360>

Sven Brauch <svenbrauch@googlemail.com> writes:

> From 2e7b5aed771faeff654a447346bb0b57570d9569 Mon Sep 17 00:00:00 2001
> From: Sven Brauch <svenbrauch@googlemail.com>
> Date: Tue, 5 Nov 2013 20:06:21 +0100
> Subject: [PATCH] git-cat-file: fix output when format string contains no
>  variables

Thanks; first some procedural issues:

 - Omit the first line "From 2e7b..."; that does not belong to any
   patch submission (it is a separator used between messages in the
   mailbox formatted file "format-patch --stdout" produces).

 - The second line "From: Sven..." records exactly the same address
   as the e-mail you are sending out, so it should be omitted as
   well.

 - The third line "Date: ..." is not the time we the general public
   sees your fix for the first time, which is what "Date: " of your
   e-mail header already records, so we do not need it either.

 - And the last one "Subject: ..." is redundant; we can see it in
   your e-mail header.

In general, the latter three lines are produced by format-patch to
help you fill header fields in the MUA of your choice by cutting
(not copying) and pasting. Unless there is a valid reason to have
values different from what recipients would see in the e-mail header
(and there often isn't, unless you are forwarding somebody else's
patch, in which case you may want to use "From: ", or you are
responding to an ongoing discussion with a patch, in which case you
may want to use "Subject: "), please remove them after copying them
out to your e-mail header.

> When the format string for git-cat-object --batch-check contained no
> variables, the function would not actually look for the object on disk,
> but just verify that the hash is correct. Thus it would report no error
> if asking for objects which did not actually exist on disk if the SHA hash
> looked ok.
>
> Example of buggy behaviour:
> echo "XYZ" | git hash-object --stdin | git cat-file --batch-check="found"
> would report "found" although the manpage claims it would report an error.

An excellent log message.  It would have been even better to add a
new test to t1006 based on this reproduction recipe.

> Signed-off-by: Sven Brauch <svenbrauch@googlemail.com>
> ---
>
> Notes:
>     This fixes a bug where git-cat-file --batch-check would erroneously tell
>     that objects exist while they did in fact not in case the argument to
>     --batch-check was just a constant strig (i.e. no %(...) variables).
>     The reason was that calling sha1_object_info_extended while requesting no
>     properties of the object would not even verify this object existed, or more
>     exactly, sha1_loose_object_info would not do that.
>     
>     I'm entirely unfamiliar with the git codebase; the suggested fix ensures
>     that always at least one property is requested. If there's a better way
>     to fix this issue, please let me know.

I think the real problem is that sha1_loose_object_info() is called
by sha1_object_info_extended(), when it does not find a cached or a
packed object, and the callee assumes that it is asked to fill in
only the requested pieces of information while the caller does not
even bother to check if such an object actually exists.

How about doing it like the attached instead?

-- >8 --
Subject: sha1_loose_object_info(): do not return success on missing object

Since 052fe5ea (sha1_loose_object_info: make type lookup optional,
2013-07-12), sha1_loose_object_info() returns happily without
checking if the object in question exists, which is not what the the
caller sha1_object_info_extended() expects; the caller does not even
bother checking the existence of the object itself.

Noticed-by: Sven Brauch <svenbrauch@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Oh, by the way, there is this one iffy bit in batch_one_object():

          if (get_sha1(obj_name, data->sha1)) {
                  printf("%s missing\n", obj_name);
                  fflush(stdout);
                  return 0;
          }

  At this point, the object _may_ be missing, but the obj_name may be
  malformed, so saying "missing" is not strictly correct.  If, for
  example, you misspelled the name of the master branch, you would get
  this:

          $ echo mastre | git cat-file --batch-check=foo
          mastre missing

  I however doubt that it is a good idea to reword this message by
  adding a logic to tell misspelled object name and missing object
  name apart.  The users of "cat-file --batch-check" are not
  expecting to be able to distinguish these two classes of errors
  anyway.

 sha1_file.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7dadd04..00220a4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2486,12 +2486,11 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * need to look inside the object at all.
 	 */
 	if (!oi->typep && !oi->sizep) {
-		if (oi->disk_sizep) {
-			struct stat st;
-			if (stat_sha1_file(sha1, &st) < 0)
-				return -1;
+		struct stat st;
+		if (stat_sha1_file(sha1, &st) < 0)
+			return -1;
+		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
-		}
 		return 0;
 	}
 

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Fri, 11 May 2012 05:31:22 -0500
Message-ID: <20120511103122.GA19573@burratino>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <20120312071121.GA17269@burratino>
 <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 11 12:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSn8M-00044i-Bf
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 12:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab2EKKbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 06:31:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40074 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2EKKbc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 06:31:32 -0400
Received: by yhmm54 with SMTP id m54so2407825yhm.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1NIaQU8EjyiGvb8bmutmK7jM09EZzXb9phgtMiuKms0=;
        b=kv7KKo9dyhtsAl8U0il9St3pCSpL/TkRYKnmHL2aZBoa8VzhNCSsHJJdNd0IjQtgMB
         bzDdTJ2jQRm3OyqNF+12TELMUhdUZUjrZbO4voWLeUp1QHJ0bJogZ7SW9ytd/7dpE0gk
         GoPpWYDPE7aqVjSbMMI6iPw/pMvGF3+6I0/VTAilDGVFF6hTmIDWDWlqdbg677XWsja3
         k4B5VC/fgHUWkMsuERrEJ1vXYIIamzAlmRJeZgGTJG55vhSYupOpANJGAgcI6i3t6pjN
         HgVBVtZKdc+yrQ3IFVMpwa/37gnHK+/EIR1fDJiVjAP+NIt5UE9JGRtRXf9Ri1ClxLDz
         4hHg==
Received: by 10.50.212.37 with SMTP id nh5mr1303291igc.63.1336732291746;
        Fri, 11 May 2012 03:31:31 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nh8sm7442795igc.1.2012.05.11.03.31.28
        (version=SSLv3 cipher=OTHER);
        Fri, 11 May 2012 03:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vipi9mfhx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197663>

The new "credit people" feature in fmt-merge-msg changed the format of
a typical "merge --log" message from

	Merge branch for-upstream of git://git.example.com/subsystem

	* for-upstream: (51 commits)
	  foo: bar baz

to

	Merge branch for-upstream of git://git.example.com/subsystem

	By C O Ntributor
	* for-upstream: (51 commits)
	  foo: bar baz

The message feels more natural with a line of breathing room before
the list of one-line descriptions headed by the branch name, like
messages already get when attached to a merge by "fmt-merge-msg -m" or
automatically incorporated during a merge of an annotated tag.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi again,

Junio C Hamano wrote:

> I'd hold making that judgement for a several weeks until my eyes get
> used to if I were you.

Turns out my reaction is pretty much the same as before.  I still like
the idea and still am distracted by the spacing.  After the small
patch below, the log seems peaceful again and I am totally fine with
it.

	Merge branch for-upstream of git://git.example.com/subsystem

	By Fred the Clown

	* for-upstream: (51 commits)
	  foo: bar baz

Hope that helps,
Jonathan

 builtin/fmt-merge-msg.c  |    5 +++++
 t/t6200-fmt-merge-msg.sh |    9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 1bc6b8b8..8f228781 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -264,6 +264,8 @@ static void add_people_info(struct strbuf *out,
 			    struct string_list *authors,
 			    struct string_list *committers)
 {
+	size_t pos = out->len;
+
 	if (authors->nr)
 		qsort(authors->items,
 		      authors->nr, sizeof(authors->items[0]),
@@ -275,6 +277,9 @@ static void add_people_info(struct strbuf *out,
 
 	credit_people(out, authors, 'a');
 	credit_people(out, committers, 'c');
+
+	if (out->len > pos)
+		strbuf_addch(out, '\n');
 }
 
 static void shortlog(const char *name,
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 9b50f54c..d39417ba 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -104,6 +104,7 @@ test_expect_success '[merge] summary/log configuration' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left:
 	  Left #5
 	  Left #4
@@ -151,6 +152,7 @@ test_expect_success 'merge.log=3 limits shortlog length' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left: (5 commits)
 	  Left #5
 	  Left #4
@@ -168,6 +170,7 @@ test_expect_success 'merge.log=5 shows all 5 commits' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left:
 	  Left #5
 	  Left #4
@@ -192,6 +195,7 @@ test_expect_success '--log=3 limits shortlog length' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left: (5 commits)
 	  Left #5
 	  Left #4
@@ -209,6 +213,7 @@ test_expect_success '--log=5 shows all 5 commits' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left:
 	  Left #5
 	  Left #4
@@ -240,6 +245,7 @@ test_expect_success 'fmt-merge-msg -m' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* ${apos}left${apos} of $(pwd):
 	  Left #5
 	  Left #4
@@ -273,6 +279,7 @@ test_expect_success 'setup: expected shortlog for two branches' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left:
 	  Left #5
 	  Left #4
@@ -398,6 +405,7 @@ test_expect_success 'merge-msg two tags' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* tag ${apos}tag-l5${apos}:
 	  Left #5
 	  Left #4
@@ -428,6 +436,7 @@ test_expect_success 'merge-msg tag and branch' '
 
 	By Another Author (3) and A U Thor (2)
 	via Another Committer
+
 	* left:
 	  Left #5
 	  Left #4
-- 
1.7.10.1

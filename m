From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incorrect man page for git-diff
Date: Tue, 18 Dec 2012 11:32:57 -0800
Message-ID: <7vehinf95i.fsf@alter.siamese.dyndns.org>
References: <50D0AA78.5090603@gmail.com>
 <7vwqwffcxp.fsf@alter.siamese.dyndns.org> <50D0BF8D.5050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:33:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2ul-0004x1-Q2
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab2LRTdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:33:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab2LRTdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:33:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEF6FA5EE;
	Tue, 18 Dec 2012 14:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MAQXleDqtqd2mg+6INopVj9zd7w=; b=WSEzMO
	C1XZpw3eUVnufppfqmNRogW4Gdu+ADljVdxikVJXcfe2939wjUEVIA9GDOD9dnXe
	LXhC1ZLeZ+9WejGIHaY/ia1jIAec4MxzMyyi3g98oCOLXGOsGXrBDjFq6KwymdPX
	sWCjKrjfNynNNsOW9rVTPp03x60JtFSUqzH2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HW2N/NMLJhR8i/JWqpPYV+8fnbi/glZq
	res18RitVDjhqH7K3wRNgr1+gTaIHNsdDQW9zS8PRdHO7SQ4HkiNQigQxyYU7Xye
	DoDvsCLzubeVzi/GsgKaPKKLhqS9alvGLx9vPT4JWCNl05Gtpa+rlW2Wvl8UQlF/
	Fd3XuplTB9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9AAEA5EB;
	Tue, 18 Dec 2012 14:32:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F6F6A5E7; Tue, 18 Dec 2012
 14:32:59 -0500 (EST)
In-Reply-To: <50D0BF8D.5050004@gmail.com> (Manlio Perillo's message of "Tue,
 18 Dec 2012 20:10:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAEC48B2-4949-11E2-8DBA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211779>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> I'm not sure the man page is wrong and should be changed:
>
>   -- usage: git diff [<options>] [<commit> [<commit>]] [--] [<path>...]
>   ++ usage: git diff [<options>] [<commit> [<commit>]]

Comparison of two blob objects works entirely in different way (it
is not even recursively comparing two tree-shaped things).

I do not think this mode is common enough to deserve to be in the
short help text, but it should be in the documentation, perhaps like
this patch, I think.

 Documentation/git-diff.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-diff.txt w/Documentation/git-diff.txt
index f8d0819..f8c0601 100644
--- c/Documentation/git-diff.txt
+++ w/Documentation/git-diff.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git diff' [options] [<commit>] [--] [<path>...]
 'git diff' [options] --cached [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
+'git diff' [options] <blob> <blob>
 'git diff' [options] [--no-index] [--] <path> <path>
 
 DESCRIPTION
@@ -55,6 +56,11 @@ directories. This behavior can be forced by --no-index.
 	This is to view the changes between two arbitrary
 	<commit>.
 
+'git diff' [options] <blob> <blob>::
+
+	This form is to view the differences between the raw
+	contents of two blob objects.
+
 'git diff' [--options] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the previous form.  If <commit> on
@@ -72,8 +78,7 @@ directories. This behavior can be forced by --no-index.
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
 in the last two forms that use ".." notations, can be any
-<tree>.  The third form ('git diff <commit> <commit>') can also
-be used to compare two <blob> objects.
+<tree>.
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].

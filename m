From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git-diff: Clarify operation when not inside a repository.
Date: Wed, 28 Aug 2013 15:16:49 -0700
Message-ID: <xmqq38pt8nqm.fsf@gitster.dls.corp.google.com>
References: <201308211734.r7LHYwNh008859@hobgoblin.ariadne.com>
	<xmqqwqneuc69.fsf@gitster.dls.corp.google.com>
	<201308222031.r7MKVL6O028293@freeze.ariadne.com>
	<xmqqioyxqwdr.fsf@gitster.dls.corp.google.com>
	<201308231811.r7NIBeH9027848@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Thu Aug 29 00:17:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEo2x-0005ey-Pj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 00:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab3H1WQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 18:16:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141Ab3H1WQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 18:16:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE223DA72;
	Wed, 28 Aug 2013 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sRTU40wqO+RTwa0E5NmUNbIdnKY=; b=IPU82A
	mhNSS7utrH21C628+zpASlRaZEzS7ECEuA5dVKljeFdv5VtrmBbxDRK9X92uX5N9
	gDyZVMZx7bHW7pe8wuxhcAb91SjUWVjlC/h/ok71g27QbdmtYRN4lBuKwaKbshuz
	kYVpq+XM+pqh6p7IdYJh9fq5E6/ikaSw/kfao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jfogIQhEl6s/edwNhttGXFAsA9pGaZOS
	uDsSZS0iYFv3Xf1QUBSXPO+59bfMbHkJED20xyIqN9hS84zVo2OKLfk37YQ1ef1D
	sEJs/d2lwZ4Fr54akxKv79m4jwnApWa79/25qOUp1YKjv6KwNcHPNb+fZ/wKLe2o
	47QLHqpqEn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58F3C3DA6E;
	Wed, 28 Aug 2013 22:16:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F32B3DA64;
	Wed, 28 Aug 2013 22:16:53 +0000 (UTC)
In-Reply-To: <201308231811.r7NIBeH9027848@freeze.ariadne.com> (Dale
	R. Worley's message of "Fri, 23 Aug 2013 14:11:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8B1A4528-102F-11E3-B047-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233225>

worley@alum.mit.edu (Dale R. Worley) writes:

>> For now, I'll queue your version as-is modulo style fixes, while
>> waiting for others to help polishing the documentation better.
>
> It'd difficult to figure out how to describe it well.  In my
> opinion, the problem here is the DWIM nature of the command,
> ... My preference is ... But that's not how git-diff works.

So given the constraints, I think this is the best we can do.  As nobody
seems to be helping to polish the text, here is my attempt, on top
of your patch.

 Documentation/git-diff.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index b1630ba..33fbd8c 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -28,11 +28,15 @@ two blob objects, or changes between two files on disk.
 	words, the differences are what you _could_ tell Git to
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
-+
-If exactly two paths are given and at least one points outside
-the current repository, 'git diff' will compare the two files /
-directories. This behavior can be forced by --no-index or by
-executing 'git diff' outside of a working tree.
+
+'git diff' --no-index [--options] [--] [<path>...]::
+
+	This form is to compare the given two paths on the
+	filesystem.  You can omit the `--no-index` option when
+	running the command in a working tree controlled by Git and
+	at least one of the paths points outside the working tree,
+	or when running the command outside a working tree
+	controlled by Git.
 
 'git diff' [--options] --cached [<commit>] [--] [<path>...]::
 

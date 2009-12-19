From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is
 required
Date: Fri, 18 Dec 2009 20:53:47 -0800
Message-ID: <7vfx77lg2s.fsf@alter.siamese.dyndns.org>
References: <4B274BDE.8000504@viscovery.net>
 <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com>
 <7veimsvz8a.fsf@alter.siamese.dyndns.org>
 <200912182304.27656.j.sixt@viscovery.net>
 <m3d42cc4i8.fsf@localhost.localdomain>
 <7vr5qrsv4g.fsf@alter.siamese.dyndns.org>
 <20091219122509.6117@nanako3.lavabit.com>
 <7veimrmv3r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 05:54:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLrKu-0006Ol-IM
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 05:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148AbZLSEyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 23:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZLSEyM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 23:54:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49736 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180AbZLSEyK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 23:54:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80389896CD;
	Fri, 18 Dec 2009 23:54:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GuQrnjE4W+embP+2BGy2c6tY6jE=; b=ohz4A+
	UG1bpeBVCg50X3AGlb1VYeKgzbEZ8w0BUebu7RW+D3fk+cKvLwzA6ZKfViSry+2l
	+GdfBc4nJBOfm7knQcwi4a25oktg5qN1O1umd9j4/umTkXAaOEgBynFkHfrfKgzR
	fMsvWSK59D76pfUq/XyOuit4EgYuoH1TvMAzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WZBvAdkaGA+mgmmCA/sl35Ki4Ev68dyZ
	/8zr4UmlklOL8Y3+h0/nqF0siNIV8V8Lpsgsa6pwpJqYTB/AKQ7qDTyVH4i7Ot2K
	qvecFjoMvlEB1N8CAVNjXb+DpIYkwJHyKPYx6KbmaJHys20xEdkdQkW1tGBUXh3W
	1DSsHkafqzk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0552896CB;
	Fri, 18 Dec 2009 23:53:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4BC8896CA; Fri, 18 Dec
 2009 23:53:53 -0500 (EST)
In-Reply-To: <7veimrmv3r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 18 Dec 2009 20\:43\:52 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85838D38-EC5A-11DE-8208-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135462>

Junio C Hamano <gitster@pobox.com> writes:

> As read-tree is a very basic and low-level Porcelain, if somebody were
> using it to empty the index in an existing script, this change would
> appear as a regression and hopefully will be caught eventually, and
> updating such a script can be made reasonably easy if we want to be
> helpful (the error message can suggest running "rm $GIT_DIR/index", for
> example).

IOW, I would prefer to queue something like this in the upcoming version,
and then later make it die().  I do not think anybody relies on it, but we
have been wrong before.  If the warning doesn't trigger for anybody, that
is also fine as well.

 builtin-read-tree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 2a3a32c..311c489 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -111,6 +111,9 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
 			     read_tree_usage, 0);
 
+	if (!argc)
+		warning("running read-tree without argument to empty the index is deprecated.");
+
 	newfd = hold_locked_index(&lock_file, 1);
 
 	prefix_set = opts.prefix ? 1 : 0;

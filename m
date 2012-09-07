From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Fri, 07 Sep 2012 13:49:15 -0700
Message-ID: <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA5Uj-0002Bd-BS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab2IGUtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 16:49:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab2IGUtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 16:49:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D00BE9BD6;
	Fri,  7 Sep 2012 16:49:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wdJeUuzkw9IFYvdCftMXS9+y6GA=; b=yXQ00t
	VT7snx1AVin0T3c9B4rxHmzN78VnifpCLucXk/cZulkPMM4vpY4ZvQjvwPMZa80F
	lq8UXQkd3xtyMABl9+Ie8N9t5TFcf4V4QlLLt/5Ryyw5Sz4h2eanNuk4RMu+gXZ2
	uR+M6U98anPrfY8st4On1knhlNRw7C3HeSfIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QqpcTUS0+N4TzPOkS3vmpriHjFEVlVqC
	wMWtKtmNlhjSUXMfzDcNWuD68qdxusgzv4GHJSTK01Dl8GLc6QgECrQA95SODmSc
	zcGyM3ufIogk64ku4opQIo6Y2Fr4f/ZXN8g05zXixMl6IAJF4KkN2gJbFKYSW8lN
	ppjsC4E5E3E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEA1A9BD5;
	Fri,  7 Sep 2012 16:49:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04F5B9BD4; Fri,  7 Sep 2012
 16:49:16 -0400 (EDT)
In-Reply-To: <7v8vcpdat2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 04 Sep 2012 09:15:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D628FCC-F92D-11E1-961F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204997>

Junio C Hamano <gitster@pobox.com> writes:

> But that is not what is happening at all.  What goes on is far
> simpler than that.
>
>  - the shell sees '*', matches it against working tree files, to
>    obtain "f1" and "f2";
>
>  - the shell tells "git" to "checkout e6f935e -- f1 f2";
>
>  - "git" looks into the tree of e6f935e to find paths that match
>    "f1" and "f2".
>
> When "git" is run by the shell in the last step, it has _no_ clue
> that the end user typed "*" from the shell.  It only sees "f1" and
> "f2" on the command line.  There is no "set T" to be intersected
> with "set W", so stop thinking in those terms, and you will be fine.
>
> Now the question is, _you_ will be fine, but can the documentation 
> be updated in such a way so that it will help _others_ to also stop
> thinking about "intersection between set W and set T"?  I do not
> have a good answer to that.

Let's do this.  I do not want a shell tutorial in "git checkout"
documentation, but this would fit better in the documentation for
the CLI convention.

-- >8 --
gitcli: contrast wildcard given to shell and to git

People who are not used to working with shell may intellectually
understand how the command line argument is massaged by the shell
but still have a hard time visualizing the difference between
letting the shell expand fileglobs and having Git see the fileglob
to use as a pathspec.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index ea17f7a..220621b 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -38,6 +38,22 @@ arguments.  Here are the rules:
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
 
+ * Many commands allow wildcards in paths, but you need to protect
+them from getting globbed by the shell.  These two mean different things:
++
+--------------------------------
+$ git checkout -- *.c
+$ git checkout -- \*.c
+--------------------------------
++
+The former lets your shell expand the fileglob, and you are asking
+the dot-C files in your working tree to be overwritten with the version
+in the index.  The latter passes the `*.c` to Git, and you are asking
+the paths in the index that match the pattern to be checked out to your
+working tree.  After running `git add hello.c; rm hello.c`, you will _not_
+see `hello.c` in your working tree with the former, but with the latter
+you will.
+
 When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
 disambiguating `--` at appropriate places.

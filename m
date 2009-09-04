From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .git and retrieving full source tree for own project(s)
Date: Fri, 04 Sep 2009 13:04:31 -0700
Message-ID: <7viqfyfpdc.fsf@alter.siamese.dyndns.org>
References: <981b72360909041252i29551a5chb8b3a2a5c6444ee3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "armencho\@gmail.com" <armencho@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 22:05:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjf20-00088F-B4
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 22:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbZIDUEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 16:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757277AbZIDUEh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 16:04:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757262AbZIDUEh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 16:04:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B3B925C4C;
	Fri,  4 Sep 2009 16:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m9BdjqMBYZvgv9a0ZWX7jfQTj6o=; b=B3f6OJ
	490XTRo5dvdL7uYijsCOcl1pwDTLxdAWoQKuYaPiw7HhZCy66gtmwPpuqoTeBHOG
	m4pQbQRAND1Fs+DEu1/gyqYCb2lUO6Xz+Z9Ts5KbpmLxrs1XDna0nMCJGnkAG2yC
	CR7eKXgG7ygliZcRkWJPVqNp4xTrYgwGTis5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6bIZVZhJKcDzrM8Dn0QAGaVWQvUOQym
	9YpaxOWc4rioS3Lc9jNpL9iZnZNbBltLox1Xpg8WXwm6jMBXZpiW+hIQ0ZG6Dt6T
	e7hfNxlR3sfRq9L6UFF2d6q19dfuF/ZbsmTLwBc3zTaXYRnv+qZScSKHlyWu5T8i
	htBMvj9ZjCk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDCAD25C4B;
	Fri,  4 Sep 2009 16:04:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E36725C47; Fri,  4 Sep
 2009 16:04:33 -0400 (EDT)
In-Reply-To: <981b72360909041252i29551a5chb8b3a2a5c6444ee3@mail.gmail.com>
 (armencho@gmail.com's message of "Fri\, 4 Sep 2009 21\:52\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B507BBA-998E-11DE-ABEB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127765>

"armencho@gmail.com" <armencho@gmail.com> writes:

> What I am wondering about is, what is gits identity for a repository?
> I don't share or publish the source directory anywhere, and just for
> testing I removed everything but the ".git" directory and tried "git
> checkout" and "git checkout master".

"git checkout" is a short-hand for "git checkout HEAD" which is to request
"switch to the branch denoted by HEAD, i.e. the current branch, while
keeping my local changes to the work tree and the index".

"git checkout master" is a request to "switch to the master branch, while
keeping my local changes to the work tree and the index".

In this case, your "delete everything" is your local change, and git did
its best to preserve it while switching branches.

If you want to "copy this and that files and directories out of the
commit at the tip of the current branch and deposit them in my work tree
and index", you would say

    $ git checkout HEAD this that

so a request for checking everything out would be a natural extension of
the above that would be:

    $ git checkout HEAD .

If you want to "copy this and that files and directories out of the index
and deposit them in my work tree", you would say

    $ git checkout this that

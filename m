From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Subtree in Git
Date: Fri, 04 May 2012 21:25:27 -0700
Message-ID: <7v8vh78dag.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
 <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
 <87fwbgbs0h.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herman van Rink <rink@initfour.nl>, dag@cray.com,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Sat May 05 06:25:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQWYq-0004Dl-Ez
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 06:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139Ab2EEEZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 00:25:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab2EEEZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 00:25:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D87386FB;
	Sat,  5 May 2012 00:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yRhMgk9MzFhuVEAukX48GsP4xJo=; b=nbCvo9
	g0cyURGHoDMU8qqfvNo0j9aBJA33uswzyNDeqNDhFhnFykykQLo7XBb3hkSWUObx
	zdTu0fvGotqrtg47hnXgNZC0OKC6pqP+vgyBz8gXvnJxrujNMu0qqZG9pSnpJEdf
	71wPkjNvBILm+Ca3vaKgW6spYJ+PU+o4iJUkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f+JhPtyrxy6YCCqZGJYz6pIDl9JtFT51
	LGN0fKHeygVmou64ACCDIvNHzzEx4sO4Mk0yZvAPUODKUitjHykzzpDyjhADZSis
	jwg/JIcTj41LRR+bZMjQWJErlVxjO7hugO9Fhpi5ecVmfN8+n0r3qY3azXFVVpYx
	rIE8OELxevs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 639A386FA;
	Sat,  5 May 2012 00:25:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCEE386F9; Sat,  5 May 2012
 00:25:28 -0400 (EDT)
In-Reply-To: <87fwbgbs0h.fsf@smith.obbligato.org> (greened@obbligato.org's
 message of "Thu, 03 May 2012 21:26:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5840C93C-966A-11E1-B01F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197091>

greened@obbligato.org writes:

>> I basically did a: git subtree merge --prefix=contrib/subtree <my
>> git-subtree branch>
>>
>> The work in progress in on: https://github.com/helmo/git (the
>> subtree-updates branch)
>
> This branch seems to have a bunch of commits from master or some other
> branch:

Isn't the confusing shape of the history a direct result of what Herman
said he did above, i.e. use of "subtree merge"?  I thought that we agreed
not to do any more subtree merges for further updates when we slurped the
subtree history to contrib/ early in this cycle, so if that is the case,
Herman needs to rebase his work so that the integration will not need any
"subtree merge" into git.git, perhaps?

I looked at various branches found with ls-remote in that repository but I
couldn't quite tell which is what, with too many cross merges, among which
there are unnecessary duplicated commits (e.g. 90275824 and b9a745f7 seems
to be two equivalent commits) and questionable changes from the overall
project's point of view.

For example, it renames git-subtree.txt to README.md at a4416ee; while I
find the idea of departing from asciidoc somewhat attractive (perhaps this
is only because I haven't been burned by markdown yet), if "git subtree"
wants to live in the git.git repository, that change is a regression.
Later the file is renamed back to git-subtree.txt (README.md is lost) at
9ffdeb, a commit with a single-liner "fixing typo" log message adds the
README.md file with full contents of git-subtree.txt again at d9ccd03b,
and then later merge of the branch at 8861de28 finally decides to revert
that to have a shorter README.md that the history originally had, or
something.  In short, it is a mess.

Not very impressed, but I have this suspition that the history I was
looking at was not what was meant to be sent to me and an older
incarnation of the project before Herman cleaned it up for public
consumption, or something.

Confused...

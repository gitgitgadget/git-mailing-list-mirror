From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Status of all files (was: Re: How can I tell if a file is
 ignored by git?
Date: Sat, 10 Apr 2010 12:07:15 -0700
Message-ID: <7vsk73w2ho.fsf@alter.siamese.dyndns.org>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
 <j2z8c9a061004082110se894f925i80c1389cd4e247f@mail.gmail.com>
 <20100409113248.GB27353@thyrsus.com> <864ojkx1un.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, Jacob Helwig <jacob.helwig@gmail.com>,
	Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sat Apr 10 21:07:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0g1m-00056Y-Bf
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab0DJTH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 15:07:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0DJTH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 15:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6B73A9C68;
	Sat, 10 Apr 2010 15:07:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o2GaEDQQDlUF3ROLE66Kaczs5pg=; b=pFS4/t
	Jxb7lZ/IxtIMw96/uivqk2KNJNx0QI7BTCSeaX72tU4mHM5LZ7l7rYOGKnt1JiUk
	jGrx0k+64u6AurZxxFZJwXfK/1f18DsQEZk8WL3DeGUaWAY4Hc1q5P3WAzpszGZU
	kLQOASzWa3SADuSZrK6+6ACaORAbY4iVR4CxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V7NYfHDnlLRsJvMhSUQNDsKqhaKZM0n8
	j0Ngz3XFkXEFoBz/9ntOizh/fnVdoDH/mQsJZHdLioZBfSDYQdbHe2eMDLRjbk2x
	WQay8o2H61NV4AHeOFsbffwCVo4duB6Amzw/MRBWy5sQj3LFCG1ry+JwX7nu/X/a
	3LLGh7t+990=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 855BAA9C67;
	Sat, 10 Apr 2010 15:07:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D412A9C65; Sat, 10 Apr
 2010 15:07:16 -0400 (EDT)
In-Reply-To: <864ojkx1un.fsf@red.stonehenge.com> (Randal L. Schwartz's
 message of "Fri\, 09 Apr 2010 05\:11\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4AEC8F9E-44D4-11DF-B94F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144578>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> A lot of these don't make sense for git and other DVCS.

I agree with you in principle, but not with the details in the example.

> For example:
>
> Eric>   'needs-update      The file has not been edited by the user, but there is
> Eric>                      a more recent version on the current branch stored
> Eric>                      in the master file.
>
> This makes sense only with a file-based VCS, not a tree-based VCS like
> git.

This isn't about file vs tree, but more about centralized vs distributed.
In DVCS workflows "needs-update" as a concept does not even exist when you
are working on a topic branch to perfect one thing and one thing only.
You do not want to update only because somebody else did some work that
may be totally unrelated to what you wanted to achieve on the current
branch.

I presume that many people use git in centralized workflow where they use
only 'master' branch and "git pull ; work ; git commit; git push" are the
only things they do.  In that setting, "needs-update" may make sense.  The
VC backend implementation has to do "git fetch" to see if the origin has
advanced.

Almost the same comment applies to 'needs-merge', but the VC backend not
only needs to worry about "file has been edited", but also "commits that
touch the file has been made locally".

> Eric>   'removed           Scheduled to be deleted from the repository
> Eric>   on next commit.
>
> Not useful in git.

Isn't "git rm removed" exactly "scheduled to be deleted"?

> Eric>   'missing           The file is not present in the file system, but the VC
> Eric>                      system still tracks it.
>
> Not available in git.  (If it's not a real file, it can't be tracked. :)

Isn't "rm missing" exactly this?

> Eric>   'ignored           The file showed up in a dir-status listing with a flag
> Eric>                      indicating the version-control system is ignoring it,
>
> Eric>   'unregistered      The file is not under version control.
>
> These two would be identical in git.

Ignored is a subset of Unregistered, no?  Neither exists in the index
(i.e. not tracked); ignored ones are covered by .gitignore and you need to
force "git add" to start tracking them.

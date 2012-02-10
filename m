From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Thu, 09 Feb 2012 18:27:21 -0800
Message-ID: <7vsjijs9rq.fsf@alter.siamese.dyndns.org>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tbushnell@google.com, tytso@google.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 03:27:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvgCv-0004sm-EO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074Ab2BJC1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:27:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380Ab2BJC1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:27:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D87C07B02;
	Thu,  9 Feb 2012 21:27:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:cc:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6CPYse6cfXmWpLyxBpQEVTEqeE8=; b=LFWfMd
	RYZmd2SoF2W5a1WhaWS/d1DdVu1/vISBOUhd6Am6Y/CIg1PVfMhgj5z7yvSr9Leg
	0BPpS0+XMYkWbhOzUUEAw75Wsi/PFqFwzDKU98J5ps6WvjWTb69M6QNcJ72+8IBg
	gduducLRmmpmh6KJLLE6IRg754bTGjedm8TOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:cc:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvtPjm+uAiJLOshSwnrAfJ8uPps0hnOe
	6HcsxRUq3G4gM5iizcxdou0jTsEaVwnDBpVX6apwYGJSKcUDVmwBGCpWj+S6DeR4
	W+EVZI591ScYLgmFgduijxOxK93e7RHPZhHKMwv1LkBNoVU8bdSRGxVexszoq0eu
	H5BiOBL0mvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D015A7B01;
	Thu,  9 Feb 2012 21:27:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65B997B00; Thu,  9 Feb 2012
 21:27:23 -0500 (EST)
In-Reply-To: <7vlion3tr5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 31 Jan 2012 23:19:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3DC4AB4-538E-11E1-93F8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190370>

Junio C Hamano <gitster@pobox.com> writes:

> What's cooking in git.git (Jan 2012, #08; Tue, 31)
> --------------------------------------------------
> ...
> [Graduated to "master"]
>
> * nd/clone-detached (2012-01-24) 12 commits
>   (merged to 'next' on 2012-01-26 at 7b0cc8a)
>  + clone: fix up delay cloning conditions
>   (merged to 'next' on 2012-01-23 at bee31c6)
>  + push: do not let configured foreign-vcs permanently clobbered
>   (merged to 'next' on 2012-01-23 at 9cab64e)
>  + clone: print advice on checking out detached HEAD
>  + clone: allow --branch to take a tag
>  + clone: refuse to clone if --branch points to bogus ref
>  + clone: --branch=<branch> always means refs/heads/<branch>
>  + clone: delay cloning until after remote HEAD checking
>  + clone: factor out remote ref writing
>  + clone: factor out HEAD update code
>  + clone: factor out checkout code
>  + clone: write detached HEAD in bare repositories
>  + t5601: add missing && cascade
>
> "git clone" learned to detach the HEAD in the resulting repository when
> the source repository's HEAD does not point to a branch.

It turns out that this series, as a side effect, fixes a long-standing bug
that the --branch option cannot be used with the --mirror option.

I am tempted to merge it also to 1.7.9.1 maintenance track. The issue is
minor (you can always clone with --mirror and then switch the branch with
"checkout") and it does not look like it warrants further backpointing to
1.7.8 and older releases, though.

Comments and/or objections?

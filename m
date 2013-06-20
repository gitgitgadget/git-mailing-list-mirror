From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 16:22:02 +0200
Message-ID: <87hags6ewl.fsf@linux-k42r.v.cablecom.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
	<aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>
X-From: git-owner@vger.kernel.org Thu Jun 20 16:22:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upfkc-00007J-B2
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 16:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965604Ab3FTOWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 10:22:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52737 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965509Ab3FTOWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 10:22:07 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 20 Jun
 2013 16:21:54 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 20 Jun 2013 16:22:02 +0200
In-Reply-To: <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Thu, 20 Jun 2013 15:06:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228506>

Thomas Rast <trast@inf.ethz.ch> writes:

>  if test -z "$orig_head"
>  then
>  	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
> -	git read-tree -m -u HEAD || exit 1
> +	# Two-way merge: we claim the index is based on an empty tree,
> +	# and try to fast-forward to HEAD.  This ensures we will not
> +	# lose index/worktree changes that the user already made on
> +	# the unborn branch.
> +	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> +	git read-tree -m -u $empty_tree HEAD || exit 1
>  	exit
>  fi

I just noticed that I broke the && chaining here, so don't apply this
just yet.  I'll resend once we settle on the best strategy to generate
conflicts (or not).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

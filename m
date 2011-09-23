From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/6] A handful of "branch description" patches
Date: Fri, 23 Sep 2011 10:56:47 +0200
Message-ID: <4E7C49CF.60508@drmicha.warpmail.net>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org> <1316729362-7714-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 11:55:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R72TY-0007al-QL
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 11:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1IWJzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 05:55:16 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43318 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752734Ab1IWJzO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 05:55:14 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 969232AFA7;
	Fri, 23 Sep 2011 05:53:55 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 23 Sep 2011 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=EZZObTQXCVsxmbk6VElu7H
	Miy/M=; b=EnDt9fgWUf/2DsmSLmlXjR6MTcVay+VG2zvcPyt4PtCSq4fCUqdzGV
	JKCVxNygNUa7Q/ZwzH2XuLZVCHFiW8JRTvGv9Iz2M7CJU4OpD2LkJdkpTT7NLUrX
	GNcBPbW1QPfFxvlebFMBha+sQuxc84hAKpRrp6gDbeFPP2mYsR3oU=
X-Sasl-enc: hyTwAO697w2NtHxvazFgu9UatKkjGe3vsBJYoGJVa4Xa 1316768210
Received: from localhost.localdomain (p5485951A.dip0.t-ipconnect.de [84.133.149.26])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B56EA820931;
	Fri, 23 Sep 2011 04:56:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181953>

Junio C Hamano venit, vidit, dixit 23.09.2011 00:09:
> Here are a few patches that I have queued in 'pu', redoing some of the
> patches I already sent out to the list, around "branch description".
> 
> The original motivation was to make the push/pull workflow appear more
> robust by allowing human-to-human communication to leave audit trail that
> can be verified when it becomes necessary. Namely:
> 
>  * request-pull message carries the SHA-1 of what is expected to be
>    merged; and
> 
>  * "signed push" leaves the SHA-1 of what was pushed to the remote,
>    cryptographically signed.
> 
> Linus's reaction, as I understood him, was "if we are spending efforts to
> add more information, the end result should be more informative to humans
> not just to machines", and I agree.  An example of piece of information we
> often talk about is branch description---what a particular branch is meant
> to achieve. Both request-pull messages and declarations of what was pushed
> are good places to record that piece of information.
> 
> So here is a partially re-rolled series to get us closer.
> 
>  * The logic to read from an existing branch description was in
>    builtin/branch.c in the original series, but the first patch separates
>    it out into branch.c as a helper function;
> 
>  * The second one is a digression; the branch description describes what
>    the topic aims to achieve, so it was natural to use it to prime the
>    cover letter while preparing a patch series with format-patch;
> 
>  * The third one that adds "branch --edit-description" is basically
>    unchanged modulo small leakfix from the original round;
> 
>  * And the remainder of the series for request-pull is the same as the
>    last round.

I'm afraid I've missed the first installment of the series, or rather the fact that it was about more than just signed pushes. I've been working at (and with) branch and tag annotations for quite a while now and should have probably pushed the WIP rather than just dropping the occasional note. So I'll describe briefly what I have (the branches are in any of my repos[1]), which is notes based:

  mjg/vob/branch-notes [mjg/vob/virtual-objects: ahead 4]
    Annotations for branches and tags
    
    Show notes for branches and tags when "branch" resp. "tag" is called with "--notes".
    The "--notes" argument can take on all usual forms.

  mjg/vob/format-patch-branch-note [mjg/vob/refrev-hash: ahead 1]
    Cover letter from notes
    
    Fill in the cover letter from a note to ref:HEAD if --notes is given.
    TODO: The current branch may not be the one the format-patch arguments refer to.

  mjg/vob/refrev-hash [mjg/vob/virtual-objects: ahead 2]
    Pseudo revs for refnames
    
    Introduce "ref:foo" to denote the (virtual) refname object for the ref named
    "foo". This is handy for now (editing branch and tag notes) but should
    become obsoleted by a better ui, such as "git branch --edit foo" or
    "git notes --refname edit foo".
    
    Introduce "ref:" as a shortcut to "ref:HEAD" which is the refname object
    for the current branch.

  mjg/vob/refrev-pretend [mjg/vob/virtual-objects: ahead 1]
    Pseudo revs for refnames
    
    An alternative implementation using pretend_sha1...
    Currently unused.

  mjg/vob/virtual-objects [origin/next: ahead 2, behind 10]
    Virtual refname objects
    
    For each existing refname, introduce virtual objects corresponding to a blob
    with the refname as the content. "virtual" refers to the fact that these
    objects are not written out but exist for all other purposes, such as
    attaching notes and keeping them from being pruned.

  mjg/vob/virtual-refs-for-rnos
    Virtual refs for refname objects
    
    For each ref, pretend that the corresponding refname object is referenced
    to keep it from being pruned. This still requires branch note code to
    write out these objects.
    (Unused earlier approach.)

  mjg/vob/virtual-refs-pretend-all
    Virtual refs for refname objects
    
    For each ref, pretend that the corresponding refname object is referenced
    to keep it from being pruned. This still requires branch note code to
    write out these objects.
    (Unused earlier approach using pretend_sha1....)


Yes, the above is (with added newlines and removed top commit info) the output of 'git branch -vv --notes --list mjg/vob\*' :)

Open questions:
* Should the refname object for ref "foo" really be identical to a blob with content "foo"? Or content "ref: foo? Or...?
* Should ref (branch and tag) annotations use the same default notes tree as commit notes?
* How best to view annotations on remote branches? This is connected with open questions about notes sharing and the ref namespace structure.

I do think that config based descriptions are a quick solution, but a very non-distributed, non-versioned approach when compared to the notes approach.

Michael

[1]
git://github.com/gitigit/git.git
git://gitorious.org/~mjg/git/mjg.git
git://repo.or.cz/git/mjg.git

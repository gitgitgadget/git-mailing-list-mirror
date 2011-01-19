From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Wed, 19 Jan 2011 12:17:50 -0800
Message-ID: <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino> <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino> <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 21:18:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfeTr-0002oO-IL
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 21:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1ASUSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 15:18:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab1ASUSE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 15:18:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD91931FF;
	Wed, 19 Jan 2011 15:18:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QUjQlFPy9Ezba8MTEEioBO7b9hM=; b=r26nvN
	ql68QqLLtfjMzgdfFQ2RpvjKju4hZrrlZCTvumKkHVdnIt9z5HmeGMmzLWl9XZoO
	MsjEQOWH+9wzQxi2iGg6DSfnNR+PZOPSh0kI7g5/q+odZUS6CIyND2VxmKDVi60z
	ReBZiVbMf+5PL20w/+4hM7SDlPxuHW5i0pWGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ViLwluNXToisBzj40fing1QQMB9wA6ub
	2+6+g6TnKwCBsUSGuCzru8olT2edjq5kCk56Aghj7hkJX53WdFwr32g7F+57Z/ui
	4oqxvdo2tB6+4z1zG7+oyx0o+r5/iTBN6nWj3H0FrE9w70olmCx2hinI0t/kflUh
	VtLbhzGvBjI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A9AF31FE;
	Wed, 19 Jan 2011 15:18:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A8DF431FA; Wed, 19 Jan 2011
 15:18:37 -0500 (EST)
In-Reply-To: <20110119193116.GB30618@burratino> (Jonathan Nieder's message of
 "Wed\, 19 Jan 2011 13\:31\:16 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 507A7C0E-2409-11E0-AEA1-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165291>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maaartin wrote:
>> On 11-01-19 13:42, Jonathan Nieder wrote:
>
>>> Unfortunately the existence of GIT_WORK_TREE makes it tempting to
>>> use without setting GIT_DIR.
>>
>> Maybe I'm asking nonsense, but why should I always use both?
>
> That is, why do we want to discourage setting the work tree without
> GIT_DIR in the first place?

I read that one quite differently.  Maaartin was always at the root level
and did not need GIT_WORK_TREE, and in such a case there is no need to use
both.  Only GIT_DIR is needed.

    This is a tangent, because I just said what Maaartin said is
    irrelevant to the question "Why do I have to set GIT_DIR when I want
    to set GIT_WORK_TREE?", which is what you are discussing, but I
    suspect Maaartin was not getting the correct output from diff commands
    by having two sets of "working tree" looking files, chdir'ing to their
    root level and having a single GIT_DIR, and was not noticing it.  It
    should _not_ work: think "index".

The answer to your question might be your question itself, though.

Having said that, thanks for a nice summary.

> 1. Previously there was some confusion about what path the worktree
>    is relative to.  Now setup_explicit_git_dir makes it clear:
>    + GIT_WORK_TREE and --work-tree are relative to the original cwd;
>    + the "[core] worktree" setting is relative to the gitdir.

Good.  I earlier said that relative GIT_WORK_TREE does not make much
sense, but I wasn't (and I am not) opposed to the above definition.  It is
just that

	GIT_DIR=/some/where; export GIT_DIR
        cd /some/other/place
        GIT_WORK_TREE=. git reset --hard
	cd onelevel
	edit edit edit
        GIT_WORK_TREE=.. git add file
        cd twolevels
        edit edit edit
        GIT_WORK_TREE=../.. git add file
	...

would be a much more cumbersome thing to do compared to:

	GIT_WORK_TREE=/some/other/place; export GIT_WORK_TREE
        cd $(GIT_WORK_TREE)
        git reset --hard
	cd onelevel
	edit edit edit
	git add file
        cd twolevels
        edit edit edit
        git add file
	...

> 5. The interaction with core.bare and implicit bareness are not
>    obvious.  Clearly core.bare should conflict with core.worktree,
>    but can GIT_WORK_TREE override that?  Maybe
>    check_repository_format_gently is the right place for this check
>    (rather than the setup procedure).

IIRC, we on purpose added support to allow GIT_WORK_TREE to tentatively
lift bareness of a repository so that people can

	cd /var/tmp
        GIT_WORK_TREE=. git --git-dir=/srv/git/jgit.git checkout -f

to get a snapshot easily.

> (1) and (2) have been resolved by your work (nice!), (3) seems like
> a case of "don't do that, then", and (4) out to error out in
> setup_nongit (though my patch doesn't take care of that).  Given an
> answer to (5) we could wholeheartedly and consistently support
> worktree with implicit gitdir, as a new feature.

As long as we really can support it _consistently_, I wouldn't see a big
problem in resurrecting the historical accident as a feature.  You earlier
said gitolite also misuses the interface, but does the usage pattern it
has the same as the one in the debian script you had trouble with, and do
they expect the same behaviour?

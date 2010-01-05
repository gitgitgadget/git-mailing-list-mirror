From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 10:31:26 -0800
Message-ID: <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
 <4B421F90.4090402@web.de>
 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
 <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
 <4B43292C.5060106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:32:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSECF-00046g-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241Ab0AESbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 13:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889Ab0AESbt
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:31:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745Ab0AESbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 13:31:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C61638E22C;
	Tue,  5 Jan 2010 13:31:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1zk0MukDbpTqM9lHKzi9QtzXXLk=; b=MNGtZV
	AIgq3PJs5bwJuRDn0KQjeE+aNwFJqal1IWhifaQCnZYQm4C2M6DcxGxzx10g/v7K
	AnNtwIO+BbTt0CiKEoRNmgPSx4feZl/xKfOFcPms3VNIG2chBWMAsANcifB6jxmn
	R0McUwI8ThgVJZ2jcz2IhPFiYGyiy3vDQ217I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZxzSS7vYgMqvAt//SJ/usa6H2XWKHstY
	8lkXSe1e7SAeTvZNrvsJ8plRgaWDJjvMeJyaxeJwiHzZPVw6xv+Gp0XdhijW6M6W
	tSz1ZwIkPNsE4fXeKIP1vEEOCFmj1rAvrihYF5SBplDhYrVXDgTD/65SWFvmG2oS
	VmjZCvrqAVI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C3728E228;
	Tue,  5 Jan 2010 13:31:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAB5E8E226; Tue,  5 Jan
 2010 13:31:27 -0500 (EST)
In-Reply-To: <4B43292C.5060106@web.de> (Jens Lehmann's message of "Tue\, 05
 Jan 2010 12\:57\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8EFB2BA6-FA28-11DE-8DC6-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136200>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> The only thing we show right now are the differences between submodule
> commits and what the superproject has in its index and in its commits.
> Missing are:
>
>   a) modified files
> ...
>   b) new unignored files
>      IMO these files should show up too (the superproject doesn't show
>      ignored files, the submodule state shouldn't do that either). But
>      OTOH i don't see a possibility for loss of data when this state is
>      not shown.

I don't know if we are talking about the same scenario.  What I had in
mind was:

    cd sub
    edit new-file
    tests ok and be happy
    git commit
    cd ..
    git status
    git commit

forgetting that only you have sub/new-file in the world.  It is not loss
of data, but still bad.  Forgetting to add a new-file and committing in a
project without submodule doesn't lose data, but the resulting commit will
be seen as broken by other people.

>   c) a detached HEAD not on any local *or* remote branch
>      This can be fatal when doing a reset, revert or checkout, so it
>      should be shown. Alternatively when applied on a submodule, forcing
>      could be disabled to let the command fail instead of throwing stuff
>      away.

Sorry, I am lost.  Are you worried about "reset/revert/checkout" in the
superproject?  What destructive things do these operations do that you
consider "fatal"?  I am especially puzzled by "revert", as "commit",
"cherry-pick", and "merge" would have the same "fatal" effect as "revert",
but I don't get what "fatality" you are talking about here.

>   d) a detached HEAD not on any remote branch
>      AFAICS this is only important for a push, and could just error out
>      there.

Likewise.

>> I think "clone" has a chicken-and-egg problem.  If all of your project
>> ...
>> what kind of participant you are.  It has to become two-step process;
>> either "clone" going interactive in the middle, or you let the clone to
>> happen and then "submodule init" to express that information.
>
> Yes, we can leave it that way for now (first "clone" and then "submodule
> init <the submodules you need>"). We can migrate to the "group mapping"
> functionality later (which would then allow to force certain submodules
> to always be populated because they appear in every group).

Even with group mapping, you need to clone the superproject first, before
seeing the mapping (which I would assume comes in the superproject).  And
you need to see the mapping to decide what group you belong to.  After
that you can finally drive sub-clone to continue (e.g. I work in the
documentation area, and the group mapping has 'docs' that lets me pull in
submodules for doc/ and common/ directories, without src/ submodule --- I
can only learn that the submodules I am interested in are called 'docs' by
group name or doc/ and common/ subdirectories _after_ I get the clone of
the superproject).

I don't know if "this appears in all groups so let's always sub-clone it"
is very useful in practice, but some sort of mandatory clone/checkout
mechanism would be handy.

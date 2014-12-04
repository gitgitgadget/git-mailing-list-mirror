From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature
Date: Thu, 04 Dec 2014 13:11:15 -0800
Message-ID: <xmqqk327ruh8.fsf@gitster.dls.corp.google.com>
References: <54809802.6030609@whonix.org> <871tofuw7h.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Schleizer <patrick-mailinglists@whonix.org>,
	git@vger.kernel.org, Whonix-devel <whonix-devel@whonix.org>
To: Mike Gerwitz <mikegerwitz@gnu.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwdgM-0007gn-QU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbaLDVLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:11:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752093AbaLDVLS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 16:11:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B8A924879;
	Thu,  4 Dec 2014 16:11:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sYRpsKjJDG/BGcbmJcyaSJ8svQQ=; b=E7/aMb
	pohL+tO/JHHIj+MYhP6MautwEfiDoEoj2Z6ykmKPAaefNZiCsz5FpLYLZ7DEmJHP
	p2XR8OitV/UhW44fVl53LSuh+5Xgtri7lq5N8nWYvexXgZxnJWqN/Egk1B8yX3dR
	43eGPYrOTG7K0lghqZ8v2qchhGldS2oGaD1uY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jRazo3fcvO4Dx9cgCaNaNYTfL2qrcZPq
	ILSGKamPQoG1L7a3T68JnpSNwBtOzTy0QIJNvpwmO9zBlDT4yYh+uPqpYnClj/3J
	JdgDzlh2T8BpHBTcFDIaGt+U7r305SoLmruBSqM7Rhgc7AAQPzWL7ZCtOLJkn9Hu
	B0PX6HQjm1Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E8A3324878;
	Thu,  4 Dec 2014 16:11:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7385524877;
	Thu,  4 Dec 2014 16:11:17 -0500 (EST)
In-Reply-To: <871tofuw7h.fsf@gnu.org> (Mike Gerwitz's message of "Thu, 04 Dec
	2014 13:05:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1657651C-7BFA-11E4-9614-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260801>

Mike Gerwitz <mikegerwitz@gnu.org> writes:

> It has since improved; I'm looking for the time to update the article,
> or write a follow-up.

Thanks for an amusing read.  We also let you merge a signed tag
these days, so that in a variant of your merge scenario #2, your
merge commit can carry your GPG signature, made when you do the "git
merge -S $other_history" to merge $other_history you obtained from
your trusted colleague, as well as the signed tag your trusted
colleague made with her GPG signature.  That way, upon seeing that
merge, a third-party can verify that the merge was made by you, and
also the history of the side branch integrated to your history with
that merge is vouched by your trustred colleague.

I am however not quite sure what conclusion you are trying to drive
at by contrasting approaches #2 and #3.  The perceived problem of
approach #2, if I am reading you correctly, is that the merge is
what you vouch for but the commits on the side branch are not signed
so there is no way for you (as the merge creator) to point fingers
to when the result of the merge turns out to be problematic.  The
argument for approach #3 would be that it would give you (as the
merge creator) somebody to point fingers to if you forced others who
ask you to pull from them to sign their commits.

But I am not sure if that is the right way to look at the bigger
picture.

Imagine you are working on a project with two branches, maint and
master.  The policy adopted by the project is to use the maint
branch to prepare for the next maintenance release, which should
never add new features.  New features are to be merged to master
for the next feature release.

And imagine that you made a mistake of merging somebody else's
branch that adds a new feature, which happens to be perfectly done
and introduces no bug, to the maint branch.  Your merge is signed by
your GPG key.

Does it absolve you from blame if you can say with certainty (thanks
to GPG keys on them) that those commits on the side branch that adds
unwanted (from 'maint' policy's point of view) new feature were made
by somebody else, because the project used the approach #3?

Not really.

How would that case be any different from the case where the side
branch you merged were buggy or even malicious?  After all, your GPG
signature carries more weight than "Yes, I did this random merge but
I did so without thinking about what damage it causes to the history
by pulling in other peoples' changes".  Or at least it should carry
more weight to your users who trust a history having your GPG
signature.  "This history is coming from Mike whom we trust" is what
your users expect, no?  When you sign your merge with "merge -S",
you are vouching for the contents of the whole tree, not just "I
made this merge, but I don't have anything to do with what it pulled
in."  It does not really matter to the end users where the changes
came from.  You are certifying that "git diff HEAD^ HEAD" after
making the merge is what you are pleased with by signing the merge.

Having said that, what approach #3 (or merging a signed tag) does
give you as the merge creator is a distrubution of trust.  You may
not have to be _so_ careful verifying "git diff HEAD^ HEAD" of the
merge when you know you can trust the side branch you are merging
into your history was done by somebody you trust.

But ultimately, the responsibility lies on the person who creates
the topmost merge and advances the tip of the history the users of
the end product of the project considers the authoritative one.

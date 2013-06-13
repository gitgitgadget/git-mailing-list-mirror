From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Refactor useful notes functions into notes-utils.[ch]
Date: Thu, 13 Jun 2013 10:24:32 -0700
Message-ID: <7vsj0lvs8f.fsf@alter.siamese.dyndns.org>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<7vzjuv14ir.fsf@alter.siamese.dyndns.org>
	<CAMP44s3jnyds45UGfbig1=evbqP-rztcn7GTZ8puVa2zzA7HGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jrnieder@gmail.com, pclouds@gmail.com, artagnon@gmail.com,
	john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	torvalds@linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 19:24:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnBGP-0007tY-JM
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 19:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab3FMRYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 13:24:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42258 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758670Ab3FMRYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 13:24:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0692D27B8F;
	Thu, 13 Jun 2013 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GOaiT2X3lMHhnbRfKzOnBduYybk=; b=lAJjRg
	h+xJzUWUW1oqyce6J7YgwJLPrJvNWvE728xjwH6KFS/IpjADT1Xd7BgRtHsy5TBA
	CY9+CuGoyAwrf0eonhwxODeMpoSTuYTR4UmmrJ7ulPfenHYmunwRY3dqABtrvgYE
	MMYU1QaNet/NS7denHHa4GIcGTZiUbE1znq7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PhfX3okHKExQCKFuF/ay0KBQD3T4Fl19
	JisYVFQuLTFWQHfid3Uqmf2g8TyXQiCMiKCVzoi2bFSG7Qurr8WZiNievUauueOG
	9y0XdLmftPbjTqhZ/KWh7VZX06Vhh8Gqaj/jhLy/QC6uqWdm14s4dT9gc17YjHDo
	XEiuJGnnxic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC20E27B8E;
	Thu, 13 Jun 2013 17:24:34 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E79227B8B;
	Thu, 13 Jun 2013 17:24:33 +0000 (UTC)
In-Reply-To: <CAMP44s3jnyds45UGfbig1=evbqP-rztcn7GTZ8puVa2zzA7HGg@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 12 Jun 2013 15:11:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D3F92AA-D44E-11E2-9D13-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227750>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Jun 12, 2013 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> The proposed patch was rejected on the basis that it was organized
>> the code in a wrong way.  And your patch shows how it should be
>> done.
>
> In your opinion.
>
> The fact that nobody outside of 'git' will ever use
> init_copy_notes_for_rewrite() still remains. Therefore this
> "organization" is wrong.

That is a fact?

It is your opinion on what might happen in the future.  

And you ignored external projects that may want to link with
libgit.a, and closed the door for future improvements.  Johan's
implementation has the same effect of allowing sequencer.c to call
these functions without doing so.

Anyway, I have a more important thing to say.

You sometimes identify the right problem to tackle, but often the
discussions on your patches go in a wrong direction that does not
help solving the original problem at all.  The two examples I can
immediately recall offhand are:

 (1) a possible "blame" enhancement, where gitk, that currently runs
     two passes of it to identify where each line ultimately came
     from and to identify where each line was moved to the current
     place, could ask it to learn both with a single run.

 (2) refactoring builtin/notes.c to make it possible for sequencer
     machinery can also call useful helper functions buried in it.

but I am sure other reviewers can recall other instances in the
recent past.

Your patches were wrong in both cases, but that is not an issue.  If
you are not familiar with the area you are trying to improve, it is
understandable that initial attempts may try to solve the right
problem in a wrong way.  That is perfectly normal.

That is what the patch review process is there to help.

Reviewers who are more familiar with the area (either the code flow
and data structure used in blame, or how the object files are laid
out in the source tree and the build procedure is designed to link
them to which binary) can point the contributor in a direction that
would take us to a better result in the end.  During the discussion,
it may turn out that reviewers have overlooked issues that also need
to be addressed, or there may be further adjustments needed that are
initially overlooked by everyone.  The solution to these problems is
for contributors and reviewers to _collaborate_ to come up with a
better end result, which is often different from both the original
patch and the suggestions in the initial review.

When it is your patch, however, we repeatedly saw that the review
process got derailed in the middle.

The reviewers tried to reach a good end result in the same way as
they interact with other contributors, i.e. by showing a way they
think is better, trying to make the contributor realize why it is
better by rephrasing and coming up with other examples.

This iteration takes a lot of resources, but the reviewers are
hoping that we will see a good result at the end of the review and
everybody wins. They are trying to collaborate.

If there is no will to collaborate on the contributor's end,
however, and the primary thing the contributor wants to do is to
endlessly argue, the efforts by reviewers are all wasted. We do not
get anywhere.

That is how I perceive what happens to many of your patches.  I am
sure you will say "that is your opinion", but I do not think I am
alone.  And I am also sure you will then say "majority is not always
right".

But the thing is, that majority is what writes the majority of the
code and does the majority of the reviews, so as maintainer I *do*
have to give their opinion a lot of weight, not to mention my own
opinion about how to help keep the community the most productive.

And I have to conclude that the cost of having to deal with you
outweighs the benefit the project gets out of having you around.
Therefore I have ask you to leave and not bother us anymore.

Goodbye.

From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: PUSH_HEAD, was Re: disallowing push to currently checked-out 
	branch
Date: Tue, 17 Feb 2009 12:29:53 -0500
Message-ID: <76718490902170929v3ed9e3c2tb2f7fb1bfc01b3ab@mail.gmail.com>
References: <7veixybw7u.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
	 <76718490902161048i3c19bb43h30b1cfc62dd9a61e@mail.gmail.com>
	 <alpine.DEB.1.00.0902162102180.6289@intel-tinevez-2-302>
	 <76718490902161312j2aee999bga00d95231fa85647@mail.gmail.com>
	 <alpine.DEB.1.00.0902162215200.6289@intel-tinevez-2-302>
	 <76718490902161428k7d252a02i3e79e4f197608891@mail.gmail.com>
	 <20090216225226.GB23764@sigill.intra.peff.net>
	 <76718490902162153m6a524b2dv335be66a0f0294ca@mail.gmail.com>
	 <alpine.DEB.1.00.0902171200250.6185@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZTnA-00063A-Nv
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbZBQR3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 12:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZBQR3z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:29:55 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:27845 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZBQR3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:29:54 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2100794rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RNufQWdPQUFQxoFY03tnsLA+LKzzzgVl91X4O9JJ5/E=;
        b=XHV0VdC/Gik5LAg9AiWXAGPIPLO8HL8fUjt6TW/sM1v/EoqoYx/wgqC2xHU4+WX1LA
         qVDmr+31vqDd74rOtJYtaDM413Aq4ZNvVa5HeHRS8J9COUgNTM7/WfeVXveX48Dwv89R
         BDKcPQC4eJyuL0riN0bTBn9oxCRV/dYdv6jnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OJ5CF0jGg0RYkVvJY0JhwW9fuNMjYToy+AVF2WtE2fH5qCpW2q78F/SoZmKfOPi3DN
         ZKgk04/t4Y/V3ZATfolpuWk/BXQGIzW4G8MumSo9/v+ZNx7WSHnocH+mj+BRbwPj9OfM
         IlKuwzM9ikwW2qSmM9XLenjAt8OMpOUrAnnfA=
Received: by 10.141.177.2 with SMTP id e2mr32422rvp.266.1234891794011; Tue, 17 
	Feb 2009 09:29:54 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902171200250.6185@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110418>

On Tue, Feb 17, 2009 at 6:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> receive.localBranches = (refuse | allow)
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78065
>
> In the meantime, we have receive.denyCurrentBranch, which is much superior
> to the localBranches design: it tackles the _real_ issue -- the only
> reason why a current branch cannot be updated lightly is that it might
> have a working directory which would be forced out-of-sync.

Hmpfh.

So both you and Junio have changed your mind since that thread then.
Because in that thread, you propose  receive.guardCurrentBranch, which
was quite similar to today's receive.denyCurrentBranch. Junio then
argues that treating just the checked-out branch as special, as
opposed to all local branches is not the right thing to do:

--- snip ---
http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78062

Step back a bit and think _why_ you wanted to prevent current branch tip
from getting updated in the first place.  There are two issues:

 * Why is it _current_ branch, and not _these branches_, that can be
   configured by the user to be protected from a push from sideways?

 * Why is it undesirable for the work tree and the index to go out of sync
   with respect to the branch tip to begin with?

The latter is simpler to answer, so let's deal with it first.  The reason
why it is bad is because allowing a push to the current branch interferes
with the work actively being done in the repository, using the work tree
contents.  There is a person, you, who is actively editing the work tree
in order to advance the tip of the branch by making commits.  If the
branch tip moves without your knowing, that destabilizes your working
environment.  Your work tree wanted to make a new commit on top of some
known state, but that state was moved underneath you.  Not good.

When you are using the repository for real work (i.e. advance the tips of
its branches), you want a stable environment.  You do not want its HEAD
bobbing around outside your control, and silently detaching to cause your
later commits to go to unnamed branch without your knowing is just as bad
(which you already correctly objected to).
--- snip ---

And you end up agreeing:

--- snip ---
http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78062

> Now think.  What if one of these operations you do in the repository to
> advance the tip was to merge from one of _your_ local branches?  Yes,
> you end up merging something you did not expect to merge if you allowed
> a push from sideways to affect that local branch, only because the
> branch happened to be un-checked-out and you implemented this protection
> to forbid only to current branch.  Allowing a push from sideways to any
> local branch destabilizes your work environment, not just the current
> one.

Okay, I am starting to see the light.

How about

	receive.localBranches = (refuse | allow)
--- snip ---

Then the thread died, with receive.localBranches going into TODO, but
never got an implementation. Sometime later, receive.denyCurrentBranch
came along, which is the original idea you proposed, Junio argued
against, and then you agreed.

So, I'm not sure what happened in the intervening time between the
receive.localBranches proposal and the receive.denyCurrentBranch
implementation that suddenly what is basically guardCurrentBranch
became a good idea.

But, I happen to agree with Junio's argument in gmane 77955.

j.

From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH 2/3] checkout, commit: remove confusing assignments to
 rev.abbrev
Date: Wed, 28 Jul 2010 11:01:44 +0100
Message-ID: <1280311304.2378.64.camel@wpalmer.simply-domain>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
	 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
	 <20100725221539.GA21813@burratino>
	 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
	 <20100726190448.GA32367@burratino>
	 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org> <20100727182942.GB5578@burratino>
	 <20100727183706.GD5578@burratino> <1280261936.4462.6.camel@walleee>
	 <20100727210908.GA11317@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 12:02:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe3SW-0007zX-JC
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 12:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab0G1KBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 06:01:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47026 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab0G1KBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 06:01:50 -0400
Received: by bwz1 with SMTP id 1so3832929bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 03:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=DFsXzhpB+mADmz9qGzvdIQxZXKtndwkSjmU7hGtAIkY=;
        b=Bidu1b1Geg+JzNEe+2WPBz9os74khFUAtxn/LjJrkhffqgAWdrDe9slmDSlUrCYeig
         mUkFlXkKENpXPo9m2jD297gTVw5kS6b6KEfm9uRRnkD3LnF8ToO/wAgRJXhmpMlNpFEN
         tkC9RFFjdl5n0lhhuuy6hwAD7eQaw+iKaDv0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=iPzsFJJfuSZRd2OiFdro9zC2z6DAqeBV4d8AZgU2aH5kh1Twxm61KIi8jhsBwyorUY
         tR2+ssIWYac1aTUXY6Xp9KF3RmNhDHqVFD5tPgiPhm6dweiRsem/TqTwCREdoywpS4DX
         +kUK4VGuE9tbmTErQfIcRN4bHbsNUJjgbaNz4=
Received: by 10.204.59.134 with SMTP id l6mr7604138bkh.103.1280311308846;
        Wed, 28 Jul 2010 03:01:48 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id g11sm4641480bkw.10.2010.07.28.03.01.45
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 03:01:47 -0700 (PDT)
In-Reply-To: <20100727210908.GA11317@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152068>

On Tue, 2010-07-27 at 16:09 -0500, Jonathan Nieder wrote:
> Will Palmer wrote:
> 
> > the purpose of the patch was to respect --abbrev instead of always
> > abbreviating to a minimum of 7 characters. /Not/ to respect abbrev
> > "instead of always abbreviating".
> 
> Sure, though it had that added effect.
> 
> One goal of that series was to be able to write formats like this:
> 
> 	%C(commit)commit %H%Creset
> 	%M(Merge: %p
> 	)Author: %an <%ae>
> 	Date:   %ad
> 
> 	%w(0,4,4)%B
> 
> to replicate the effect of --format=medium.  With diff-tree (and
> rev-list before v1.7.0.6~1^2) that is not possible if %p abbreviates
> by default.

Not sure I understand what you're saying here.

However, just to note and throw a little unfinished code around: while
the series it came from was indeed intended to allow user-defined
formats which exactly match the output of built-in formats, it was one
of the few "useful enough on its own" patches which got sent along prior
to the main work being finished. The patch to allow user-defined formats
which match built-ins exactly is much more complicated (probably much
more complicated than it needs to be) and leaves plenty of wiggle-room
for minor differences in formats.

It's currently stalled (mostly due to lack of time to think about git,
combined with most of my git-related time being spent thinking about
git-remote-svn) but the very-unfinished very-broken
very-doesn't-do-enough-to-justify-itself proof-of-concept can be found
here:

http://repo.or.cz/w/git/wpalmer.git/shortlog/refs/heads/pretty/parse-format-poc

or (specific commit) here:
http://repo.or.cz/w/git/wpalmer.git/commit/eac1527aaf7a839bb7b60ed66a7da502b890e8b0

> 
> Of course, v1.7.0.6~1^2 illustrates that no one seems to have been
> relying on the format of Merge: lines, anyway, so I am not saying that
> to make diff-tree --format=medium abbreviate by default would be a bad
> change.

I expect that no one should be relying in scripts on the format of
anything log produces which is not specified explicitly. For example,
I'd expect any script which wanted the information --format=medium
provides to do so by listing out an explicit format-line such as the one
you gave.

> 
> > Perhaps armed with that phrasing, a
> > more general solution, such as equating "0" with "DEFAULT_ABBREV" rather
> > than "no abbrev", could be applied?
> 
> Maybe.  If so, one would have to deal with the other callers that
> explicitly set abbrev to 0.

Doing a simple grep for "abbrev" shows many places using "0" to mean "no
abbreviation" while many other places use "40" to mean "no
abbreviation". That seems bad enough, especially considering --abbrev=0
will wind up setting abbrev to MINIMUM_ABBREV.

Here's what I propose:
 - #define NO_ABBREV 40
 - replace all instances of revs->abbrev = 40 and revs->abbrev = 0 with
revs->abbrev = NO_ABBREV

That will at least make it explicit and consistent.

Meanwhile, what does abbrev = 0 actually mean? Once abbrev = 0 has never
been explicitly set, its meaning becomes obvious: undefined. And an
undefined value should (I think obviously) be interpreted as
DEFAULT_ABBREV, since that's what the word "DEFAULT" actually comes
from. I think it's safe to assume that no code-paths which explicitly
want an unabbreviated value (eg: %H) will actually bother to call
find_unique_abbrev, especially without explicitly setting either
revs->abbrev = 0 (that would be revs->abbrev = NO_ABBREV) or
revs->abbrev = 40 (same here)

> Hope that helps,
> Jonathan

-- Will

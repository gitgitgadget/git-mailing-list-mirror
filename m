From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Thu, 08 May 2014 09:56:19 -0700
Message-ID: <xmqqa9as5hvw.fsf@gitster.dls.corp.google.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
	<20140501024042.GX9218@google.com>
	<CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
	<xmqqa9aug4my.fsf@gitster.dls.corp.google.com>
	<CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
	<xmqqbnvaehm3.fsf@gitster.dls.corp.google.com>
	<CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
	<xmqqzjita0sn.fsf@gitster.dls.corp.google.com>
	<CAO8RVvfzP_nc9=nwr6JSK9s6u7DEctMpdn_5yca9h7G4TOd2Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 18:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiRcT-0004wL-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 18:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbaEHQ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 12:56:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59446 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbaEHQ4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 12:56:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4EAA1406D;
	Thu,  8 May 2014 12:56:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rqqa6NmRtLob/VRgtipxLrR23Uc=; b=WxiKfJ
	PviVxOapWlcUIlYN6O7Gx5xkgz3TAJDpgXT/AEqh2JXbH/Y5vIB3qloWgS/5DbaO
	MB+Cn2q1m1XhXhs+lNHmh9iOjyN0kDdCItUHhkClRIRpRsJmZy3SY2+nLrxJAmm4
	vUAh1d5rnFOJdt9+RZPdd3SG3MPzvgDfNPFRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OQ7FSksCOpon8npZdKk37PwuS+sURxIm
	ea/0fQ4TPbC+vuyHdQPaj4zkxcXFVPw5AFO60KudluHQlQJhEkRMN1TEb5x9j4MM
	VUgTcrR448ZPhtPjrEFCi7DIi2lDHUBPymATIhnwfOBt2d19PWvHaqNBAYffvAkN
	rdaP2lDapWM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B94FA1406A;
	Thu,  8 May 2014 12:56:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0328414069;
	Thu,  8 May 2014 12:56:21 -0400 (EDT)
In-Reply-To: <CAO8RVvfzP_nc9=nwr6JSK9s6u7DEctMpdn_5yca9h7G4TOd2Bw@mail.gmail.com>
	(Nathan Collins's message of "Wed, 7 May 2014 16:39:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AECA259C-D6D1-11E3-817F-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248421>

Nathan Collins <nathan.collins@gmail.com> writes:

>> What would you propose to make clickable in a renaming diff, though?
>
> Your 'Index' header looks good, and I would expect a renaming diff to
> have something like
>
>   Index: foo -> bar
>
> as in 'git status',

Heh, please don't call "Index:" *mine* --- It is a CVS abomination
;-).

For renames and copies, we do have separate "rename from" and
"rename to" in the extended header part, so there is no reason to
worry about them at all.  I would suggest showing the name _after_
the change (unless it is a deletion---instead of showing /dev/null
to signal that it was deleted, show the original filename) for
consistency so that users can do "show -p | grep '^Index: ' to see
what resulting paths there are without missing the renamed ones.

> but I just realized that a "clickable paths"
> option already exists in some sense! There is a '--patch-with-raw'
> option...

I do not think that would be useful (neither --stat which would be
more commonly used for other reasosn), because these come at the top
and by the time you see individual patch, they may be long scrolled
off the top of the screen.

Of course, the CVS "Index:" or "rename to" would be the same thing
if a file is heavily modified, so it may not be too big a deal, but
as I said, I never felt any need to double-click, so I wouldn't be
the best judge.

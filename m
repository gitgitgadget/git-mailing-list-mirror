From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 10:58:05 -0800
Message-ID: <7vaayazb2a.fsf@alter.siamese.dyndns.org>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
 <76c5b8580911250838x361ae081n271fcee2d1234703@mail.gmail.com>
 <6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:58:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDN4J-0002ps-RO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 19:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbZKYS6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 13:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759098AbZKYS6K
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 13:58:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbZKYS6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 13:58:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 059DEA1E76;
	Wed, 25 Nov 2009 13:58:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aTHsV1Cyhu6X2OpNedvMU8i4vl8=; b=asOZNO
	t7TpaPd3KKs8wPAiBubTeHA07LCZyZ/jKAOiVWuIGSqqjSk3xprhuc/xNpL+BlzN
	rOvyavY12EHaCKl8UdOWVSVx8ducJkrb3N2+IAXbW8g5nQIEsKgBULy+2sFMqnmi
	dU+59HOdpG6hXFk3ZE76Yd6UeCWQYMB/NsdXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QhEDA4qq+9ttvuW6LLXFenclokKoiIml
	Ax2axYyzHOqFcHF0CzJkgxlc0XSirVmuo1dEXFfr/b2i0xrs4Aaf3hYfqPWLCXDi
	tmaPtY3KWDMZNhWrocUsr990+06dIvN28YGD720kxWv1g1suVxy0OH5J23cRbT6D
	j8CJbbq5ht4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C7571A1E75;
	Wed, 25 Nov 2009 13:58:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 60D5EA1E74; Wed, 25 Nov 2009
 13:58:07 -0500 (EST)
In-Reply-To: <6b4a562b0911250847x59116687iba1d1640ca6c3887@mail.gmail.com>
 (Mike Jarmy's message of "Wed\, 25 Nov 2009 11\:47\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7A7912B4-D9F4-11DE-89FC-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133659>

Mike Jarmy <mjarmy@gmail.com> writes:

> I guess I didn't explain it too well, I made it sound like v3, v4 and
> v5 were still more-or-less the same.  What I'm thinking about here is
> a case where we have switched to git a while back, and then done a lot
> of work on the various different branches, so that v3, v4 and v5 have
> diverged very far from each other.  In that case, we would never want
> to merge them together.

I take it to mean that even though v[345] have diverged, the area that the
particular change you have in mind has to touch haven't changed since they
forked.  Otherwise you wouldn't be able to apply the same change to all of
them in the same form and instead would be making the logically same
change in physically different ways per branch, and you won't be asking
this question.

        o--o--o--o--o--o--o--o v4
       /
    --o--x--x--x--x--x--x--x v3

If you implemented your change at the tip of v3 branch and merge the
result to v4, you will pull _all_ of 'x' into v4 that may not be desirable
if the branches diverged a lot, of course.  

        o--o--o--o--o--o--o--o-------M v4
       /                            /
    --o--x--x--x--x--x--x--x       /
                            \     /
                             Y---Y your change(s) == v3

But nobody tells you to do this.

Instead, you can fork such a topic from the latest common.

        o--o--o--o--o--o--o--o v4
       /
    --o--x--x--x--x--x--x--x v3
       \
        Y---Y
            your change(s)

and merging this to v3 and v4 will have the desired effect.

        o--o--o--o--o--o--o--o---------M v4
       /                              /
    --o--x--x--x--x--x--x--x---M v3  /
       \                      /     /
        Y---Y----------------.-----.
            your change(s)

The merges will incorporate this particular change alone without dragging
anything else.  When you merge it to v4, none of the unrelated 'x' will be
merged into it.

In general you shouldn't fork a topic from the _tip_ of the oldest branch,
if the branches are not meant to be merged as a whole.

Of course, if this becomes cumbersome, you would adopt a better branch
management to keep the numbers of 'x' that shouldn't be in later branches
to the minimum.

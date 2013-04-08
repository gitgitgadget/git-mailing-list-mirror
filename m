From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 08:06:48 -0700
Message-ID: <7v1ual12pj.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
 <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
 <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin>
 <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
 <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
 <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
 <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:33:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF0S-0003oz-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020Ab3DHPGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 11:06:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965002Ab3DHPGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 11:06:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D4061459F;
	Mon,  8 Apr 2013 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+FQ63Ye3tqA1oTujxL4V2aIyf1I=; b=h2sZ8S
	NXG7xnuECQnM2UdzvusHEAinfC6Be3adFUiMSIOa/kymDTB3h+ifwhP2WBBHIH3L
	azFI04kBVL4fp1g75BOuH2nNS5XNf9eTiRgNr67ioneQ7YcpTwVXgRFXdAGKqyY3
	C1B0hG4IxxvblXRDvl+aYIJZd5f6gPcL7uG/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GlBSY/dWMqYh+J/jQ9Iy+XQ0MJFg89LA
	yfbaeiYHTE00e9Phlk3TiT5oMAZSxMzvd32Gu8g/5099mAyQTQ93oP9dkUrKhK/U
	TqoO4BpUyYZkh78+6ub/UjgLsPQRAV1BkmY4ZacLD++c+CdtvEc/N87zMKxZYz11
	igbv/N+ZpVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1457E1459E;
	Mon,  8 Apr 2013 15:06:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38BB814598; Mon,  8 Apr
 2013 15:06:50 +0000 (UTC)
In-Reply-To: <CALkWK0m93ZzWVJVUxgVQGUTK8t2pTEaDAPs7vW-tcgiewjOLwA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 8 Apr 2013 17:23:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F095160E-A05D-11E2-B6E0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220430>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> As far as I can tell, I'm completely unbiased: I have no vested
> interests in either implementation,...
> ...
> Frankly, I was hoping that atleast one or two people on the thread
> would take my side of the argument (or atleast tell me that I'm not
> deranged), but that hasn't happened.

Aren't these two quite contradicting?

After listening to what others tell one with an unbiased mind and
finding that nobody agrees with what one initially proposed, an
unbiased person would step back, take a deep breath and think again,
before insulting the intelligence of others with a "dissapointed",
like this:

> I'm already prepared for the worst case: I'll be forced to dump all my
> work and be disappointed with the git community.

Would it be possible that (at least some part of, or possibly all
of) your ideas had some merit, but with all your hostility against
the current system and the work that went behind it, you did not
communicate well enough to make others understand you?

What I found very hard to read in this thread was that your messages
all went like this:

 1. In the current system, I have to be at the top level of a
    submodule to work in it (or some other problems).

 2. I will fix it in a more "elegant" way.

 3. I have to have a new object at the submodule path, not the
    current "submodule is a commit bound at the submodule path, and
    information about the submodule is in .gitmodules".

There was very little concrete explanation on how #3 leads to #2,
i.e. the overall design of your new system and how it will work,
other than you would read what we currently write in .gitmodules
from a new kind of object.

When an alternative solution was suggested, all your responses were
full of subjective "inelegant" and "ugly", and at least I couldn't
read much substance in it (here, the usual me might add "maybe
others differ", but after reading this thread, I strongly suspect
that others share this problem).

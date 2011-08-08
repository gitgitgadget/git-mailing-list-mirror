From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 16:39:50 -0700
Message-ID: <7vipq7tqux.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org>
 <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
 <7vliv3v8cx.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com>
 <7vhb5rv7x0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ioxeZUCnn-fFKuiT-6eVzVoph8eQE2j0hEbAxtDZzGnQ@mail.gmail.com>
 <7vy5z3trwu.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hO-MYC_kXZZhoqXhTRvVhCDfTT4EHPoYDyHjGtRiSB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZQM-00078h-73
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab1HHXjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:39:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab1HHXjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 748324922;
	Mon,  8 Aug 2011 19:39:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EYRRZilT2OCH3y4uM3wmeZt5OWI=; b=Qci+lx
	Qf1pA+MFJuL4rdbPj43WHgSTPODjESxiZ46TW9RtDlOQEPJMnUDihhc9JB68tgyF
	rOfslHSB0Wj4sQwTEEKpHaAFJP3abAx+F4PfNqpeMwxWb+59pOxC12qrAGyKsfcT
	BWJ2pP0uTRbsAURmKOlK/yOzVOxdaNSZN4WP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2h4kBbdJrNzELTgWEB/r7tswX1wKHyh
	l5StMuFTrPPUDu2cKbpz4gFj1N86blipFcYKXcU4YOCymwJpphd9GgR7L2hJ6l+p
	UqeBfIyuR/S/cG7Z40YiRt+eC+poKX0cCz72eE2S9DjuEwpIDtCgvI8S8h6IH+cw
	x2UmsLU8j5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ABCD4921;
	Mon,  8 Aug 2011 19:39:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6C0B4920; Mon,  8 Aug 2011
 19:39:51 -0400 (EDT)
In-Reply-To: <CAGdFq_hO-MYC_kXZZhoqXhTRvVhCDfTT4EHPoYDyHjGtRiSB9g@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 9 Aug 2011 01:25:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B64FFA84-C217-11E0-B37A-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179011>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Ok, knowing that, I am somewhat more inclined to have a look at this.
> I'm still not sure that I know how to implement the design you
> described though. I mean, I understand the general concept, but I have
> no idea in what places it would need to hook in to make it work (ditto
> on how to fix the diff bug).

It is entirely possible, as Dscho hinted in his response, that your "flag"
word may be sufficient to encode "where did this object (whether it is
marked as uninteresting or interesting) come from? what did the user want
to do with it?" information for all practical purposes, even though I
doubt one bit would be sufficient. So how about ignoring "diff A...B" vs
"diff ^C A B" in the meantime and see if your change to revision.c is
applicable to the same issue in "git bundle" as a starter?

I would imagine that "diff A...B" vs "diff ^C A B" case would be solved by
the former (^C is the common ancestor between A and B) add a flag
COMMON_ANCESTOR to pending object array entry that holds ^C,
SYMMETRIC_LEFT to the one with A and SYMMETRIC_RIGHT to the one with B,
while the latter would stuff one SINGLE_NEGATIVE (^C), and two
SINGLE_POSITIVE (A and B), and the caller would tell between the two, or
something like that.  And "bundle master^0..master" (and similarly your
export stream) would note the RHS of the dot operator with SYMMETRIC_RIGHT
so that "master", even though the commit object gets marked as
uninteresting at the end, can be recovered to be of interest to the end
user.

I am not suggesting the exact flag word names above, but just trying to
enumerate how many kinds would be needed). Your single-bit in the patch
would be SYMMETRIC_RIGHT in the above ugly notation, but you can call it
REF_INTERESTING or whatever.

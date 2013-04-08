From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 11:10:16 -0700
Message-ID: <7va9p8yjuf.fsf@alter.siamese.dyndns.org>
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
 <7v1ual12pj.fsf@alter.siamese.dyndns.org>
 <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGWd-0003Qp-WC
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935264Ab3DHSKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:10:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53549 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935219Ab3DHSKT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:10:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 918F914973;
	Mon,  8 Apr 2013 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=frQF02O0D2aUB83sFITnx0JqvL8=; b=RbKn5H
	Dqnw7RvvmCwRzl/qYm0UPUaBEqrmNpJbgviSsPtJt0PpAkQO+rdHiCWrI0vlRjGS
	4l2QI/wAqUntg/GabmwtvO7Z1FZ48lTSbzMObI7wQQdPPUeOuVnmVYz4k0Bk0p91
	bEnpsKqFyJkl+LOh1I38Z7charu5ClqTJuCPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9NaktQ+JAi+AyHe/sskqMBq7H1kn1YK
	qzST2tzoP/OShYiHKqtH/VNsXDOlguzUE9GwjKq60T9KkpRBlSAVLT/ZaJiYSp4J
	A0WjsEhqK8nytjm/gX5cfE+FhXO1vIyyiO/mWE6K2mxQBwoqYi/DNnl0W8FDddjC
	w4WEkSwPzoc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8716914972;
	Mon,  8 Apr 2013 18:10:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B333F14971; Mon,  8 Apr
 2013 18:10:17 +0000 (UTC)
In-Reply-To: <CALkWK0=2T5BA8+dro8U7bcp3ODsuQAj78mEPnxs=ERqf9FhSBQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 8 Apr 2013 21:38:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 918FA20E-A077-11E2-8DED-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220477>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> 1. Having a toplevel .gitmodules means that any git-core command like
> add/ rm/ mv will be burdened with looking for the .gitmodules at the
> toplevel of the worktree and editing it appropriately along with
> whatever it was built to do (ie. writing to the index and committing
> it).

Burdened is a subjective word.  What's bad about having a single place
you know you can read and find out information about things?  You
have to learn about them to do anything specific to them anyway.

> This is highly unnatural.

Unnatural is a subjective word, and there is no justification I see
here in your message.

> Putting the information in link
> objects means that we get a more natural UI + warts like
> cd-to-toplevel disappear with no extra code.

I do not see how "link objects" _means_ "natural UI", yet, without
an explanation how one leads to the other.

What does cd-to-toplevel have anything to do with it?  In case you
did not notice, all the core commands internally cd-to-toplevel and
carry the "prefix" information while doing so, and prepend the
prefix to user-supplied paths to find which path the user is talking
about.  So "cd to toplevel before starting to carry the operation out"
is a natural pattern inside Git.  As many people already told you,
"the user has to run 'git submodule' from the top-level of the
submodule working tree" is a simple oversight of the implementation.

> 2. If we want to make git-submodule a part of git-core (which I think
> everyone agrees with), we will need to make the information in
> .gitmodules available more easily to the rest of git-core.

Care to define "more easily" which is another subjective word?  The
.gitmodules file uses the bog-standard configuration format that can
be easily read with the config.c infrastructure.  It is a separate
matter that git_config() API is cumbersome to use, but improving it
would help not just .gitmodules but also the regular non-submodule
users of Git.  There is a topic in the works to read data in that
format from core Heiko is working on.

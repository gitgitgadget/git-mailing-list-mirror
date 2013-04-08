From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 10:12:56 -0700
Message-ID: <7vy5ctx7xj.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
 <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
 <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408083712.GE20159@elie.Belkin>
 <7v61zx13nv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 19:13:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFcv-0001pg-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934437Ab3DHRNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:13:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47448 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762420Ab3DHRM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:12:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E93E8142DA;
	Mon,  8 Apr 2013 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZktrIJg96ysBsWPUfIxqAPVNgyk=; b=LV9RqN
	U2UgqmAkZ4o4VcONOhFmlqQKPornqFwf3120cazrBdahWZoqE3YvViZsjQPIeBZI
	L/zHM5qzsrnfCvt5axRMEaK2o9SJHsbdDJRQcKC2Et1QOzIyvpEDpVRDpZZ4qviQ
	Q0SZ632mTs0+1ZZJRnUdb0XFH1u7XDQxsmf/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kr9jhTIdffRgIBerkNKM9ZFL1QR1a7fU
	YjVY8mFRl8nWOGh8rRgjtKcuhJ1zJsTVvamCNodsholA269KnY8VQenrDh7qWgy3
	a3Kera20P6cI+46BzNdRyCmp9fFXNHDWptvB53wILsfhC3oKNl0Pw7iKGLllEx3p
	FQnkyseoPOY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF51142D9;
	Mon,  8 Apr 2013 17:12:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C004142D7; Mon,  8 Apr
 2013 17:12:57 +0000 (UTC)
In-Reply-To: <7v61zx13nv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Apr 2013 07:46:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F4E5704-A06F-11E2-AC4A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220442>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> [snipped everything I agree with...]
>
>> On the other hand, the single .gitmodules file will be a pain to merge
>> if multiple branches modify it.  So I do look forward to a merge
>> strategy that deals more intelligently with its content, and wouldn't
>> have minded a design that split this information into multiple files
>> if we were starting over.
>
> I find it a sensible suggestion to have a content-aware merge
> driver.  Such a custom merge driver to help merging a structured
> datafile in the config format will have other uses when we need to
> do more than the current system (outside submodules there will be
> other things "frotz" that need "information about frotz" in the
> future, and a .gitfrotz file would be one possible way to do so).
>
> I do not think it needs to be split per-submodule.

Another thing to think about is what to do when/if we want to
express "this is the default that applies to all submodules".  For
example, a superproject that binds multiple submodules may want to
say "When on this branch, make all submodules also on 'next'".

With a unified single place that holds information about all
submodules, it is trivial to add a "default" section, perhaps like
this:

	[default]
		branch = next
	[submodule "framework"]
		url = ...
                path = framework
	[submodule "common"]
		url = ...
                path = common
                branch = master ;# regardless of other modules...

on top of the "submodule.<name>.branch" mechanism for floating
checkout (the "default" is of course not limited to "branch" but
applies in general).

It is not obvious where such a "default" piece should go once you
start splitting these into per-submodule files, be it a separate but
still in-tree file that is different from the submodule it desribes,
or a blob-like object that sits at the path for the submodule in the
tree and in the index as Ram wants to do (as I kept saying, the
storage mechanism is not fundamental).

This is similar to why .gitattributes is easy to work with, I think.
You can describe the information about paths in that file (which
lives at a place different from the paths that are described), and
you can have a catch-all rule in it.

This is a tangent, but you could build a system that attaches
attributes to individual paths and hide the attributes from the
working tree filesystem (think: svn:blah) and have a set of special
commands (think: svn propset, proplist, etc.) to work with them, and
that is an equally valid way to implement attributes (it does not
make .gitattributes less valid way to do so, though).

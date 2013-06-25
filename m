From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 14:45:07 -0700
Message-ID: <7v61x127bw.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
	<7vwqpshkxj.fsf@alter.siamese.dyndns.org>
	<1372190294-sup-1398@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Tue Jun 25 23:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urb3A-0005bE-DW
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 23:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711Ab3FYVpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 17:45:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab3FYVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 17:45:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD3C62B842;
	Tue, 25 Jun 2013 21:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1WG4KytI/8urxXmBH4biPtKBxPs=; b=TMTqxr
	u8yT+qcVzueIUOipWyhwGE5RHswpADcG/7zflZU3JYSdYfODVNAPcMbmn52w4nre
	CusMoyib1NtEjf5VL7RtY2HTXZmPX9r/x/EGi1p2zO01w9Myk06GN0TXRECEBQKu
	GSQOgFVv9LhaiIXEMm/ZD/2ZeTXgwtSFTrkrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DVs6C5hpIHicLB7iTK1pykK0cLi/kcHM
	Q3dgM8bGP/moSYdnWEky9/ioHlDa7QfMDA+3jJDe8EGhxacZmzmHtQwpU4lH5k4y
	vLr8s3AoW7hBXe2zE2mAEYIw0ISqV4LOtuH1d20+wLrrzpJK5Hm9QhHpSz3hp3cy
	1aa/B0+GGCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E54A2B83C;
	Tue, 25 Jun 2013 21:45:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C26C52B831;
	Tue, 25 Jun 2013 21:45:09 +0000 (UTC)
In-Reply-To: <1372190294-sup-1398@pimlott.net> (Andrew Pimlott's message of
	"Tue, 25 Jun 2013 13:41:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82109904-DDE0-11E2-9C25-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229002>

Andrew Pimlott <andrew@pimlott.net> writes:

> I agree that it is better to preserve information as long as feasible.
> If we are going to strip it, it may as well be later.  That is Thomas's
> rearrange_squash patch, which I will send again.

Thanks.

> The next question is, do we go all the way and respect the nested
> fixup!s in rearrange_squash?  I understand the case for it, though it's
> hardly compelling to me in practice. :-)  That would be more complicated
> than Thomas's patch.  But I'm happy to try it if someone gives me a
> nudge.  If not, at least the information is preserved in case someone
> wants to do this later.

I think it is fine not to be too smart, as long as we do not lose
information that would help the user to compensate.

After all, autosquash will give the user an opportunity to eyeball
the result of automatic rearrangement.  If the user did this:

	git commit -m original
        git commit --fixup original ;# obviously fixing the first one
        git commit --fixup '!fixup original' ;# explicitly fixing the second
	git commit --fixup original ;# may want to fix the first one

and then "git rebase --autosquash" gave him this:

	pick d78c915 original
        fixup 0c6388e original
        fixup d15b556 !fixup original
        fixup 1e39bcd original

it may not be what the user originally intended, but I think it is
OK.

As long as "!fixup original" message is kept in the buffer, the user
can notice and rearrange, e.g.

	pick d78c915 original
        fixup 0c6388e original
        fixup 1e39bcd original
        fixup d15b556 !fixup original

if the user really wants to.

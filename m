From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Mon, 27 Feb 2012 11:29:53 -0800
Message-ID: <7vr4xg6pn2.fsf@alter.siamese.dyndns.org>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
 <7vhayddxgp.fsf@alter.siamese.dyndns.org>
 <20120227191846.GB1600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 27 20:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S26Gm-00012f-MX
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 20:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2B0T35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 14:29:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab2B0T34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 14:29:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A92B6E83;
	Mon, 27 Feb 2012 14:29:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=orkaUlpVEbHIVQ/nvp2UmopWcuk=; b=kZsYOb
	gSMsLjNjAE7XDaEpk+6p8BTjmdA5LsIE32vInSwFrrSHRrRXkxM86x34eWIPkpoY
	UPm/wJzPtvMmoAyy8Kzq5wUpljYb3qmU0uwB0LPc/7i5zQgzPJW/nRFR8cAjV1zC
	OteczeLxQkSXBVzddqQxxhPmDG4U76NsrQNXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DupgFZH3j3VAWWaPW+6r8/Z1gCa+uKs2
	3h8WHw0GLvl7JkzFmySbibFzGmDj+ywcx/w0Agp4IIst8rajsUpRR4FRxEs0rgU/
	z9TawY5RokHLNLDKTZk3uJjEvT604VzDeduC17mstWJ5nhf5syBRtkj1botq//7s
	UL83iqWarsk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 707206E82;
	Mon, 27 Feb 2012 14:29:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAE1A6E7D; Mon, 27 Feb 2012
 14:29:54 -0500 (EST)
In-Reply-To: <20120227191846.GB1600@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 27 Feb 2012 14:18:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D2CE48C-6179-11E1-9482-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191656>

Jeff King <peff@peff.net> writes:

>> Given that, isn't it not just sufficient but actually better to instead
>> add a new --no-dangling option and keep the default unchanged?
>
> ... Of course, it is fsck, so I wonder how often clueless people are
> really running it in the first place (i.e., it is not and should not be
> part of most users' typical workflows). If it is simply the case that
> they are being told to run "git fsck" by more expert users without
> understanding what it does, then I could buy the argument that those
> expert users could just as easily say "git fsck --no-dangling".

Yes, that was certainly part of my pros-and-cons analysis.  If you run
"git fsck" without "--no-dangling" without reading the manual, you may
get confused, but that is *not* the primary audience.  People who are
curious can read the manual and figure it out, and the need for "fsck" is
much rarer these days, compared to 2005 ;-)

In that context, only large downsides of potentially breaking and having
to adjust existing scripts remains without much upsides, if we were to
switch the default.

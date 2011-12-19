From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't pass back fake refs
Date: Mon, 19 Dec 2011 13:28:09 -0800
Message-ID: <7v39cgmety.fsf@alter.siamese.dyndns.org>
References: <20111217104539.GA23844@sigill.intra.peff.net>
 <20111219171055.GA21227@sigill.intra.peff.net>
 <7vty4wmkdt.fsf@alter.siamese.dyndns.org>
 <20111219211203.GA18396@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 19 22:28:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rckkw-0007vW-3x
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 22:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab1LSV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 16:28:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38681 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab1LSV2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 16:28:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06980629E;
	Mon, 19 Dec 2011 16:28:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=el3LPlcSwZxSCbJxeeK5cprUR5U=; b=FU8zA8
	QVeupuN8btbBWPD9xYQKWoF4/vtD97dNnMy3MSkDgI8FV5uxQCa3qHbckOlZz4A/
	Ds5vsHJludJ9EznWMRXZ3v3eqPQR3ow7Bv5JYjXWLXXwIXRwcvviDo5t1SHmIMiW
	pyxNgLzKSG/0JNUHZ6anEiPWK2RcusyvvFbV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s6+xFl/JLkUoDg3JQa6tJvmxkUiSjjcQ
	GnaIKXVQfwZtgrWIYXazWbUzs9FR271sE+2X0t4JW6NH1ZcaDEnSpI4V29ponO1z
	TAv1eRClS0NfSMYR7oKWyDGxpRpdiUablsRzagpubbiaIY8n0A3z7+WYQCpi6xc3
	rI5eK+spqSE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F119E629D;
	Mon, 19 Dec 2011 16:28:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83267629B; Mon, 19 Dec 2011
 16:28:10 -0500 (EST)
In-Reply-To: <20111219211203.GA18396@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Dec 2011 16:12:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59A12360-2A88-11E1-9FD1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187474>

Jeff King <peff@peff.net> writes:

> On Mon, Dec 19, 2011 at 11:28:14AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Perhaps we should squash in the test below, which demonstrates the
>> > breakage. I also wonder if this is maint-worthy.
>> 
>> Thanks for a thorough analysis. I agree that this should go to maint even
>> more so, as it fixes a case to push to a non-empty repository.
>
> Do you want to squash in those tests, or should I re-send with a commit
> message more fully explaining the situation?

I was lazy and added these three lines at the end:

    This also fixes pushing with --mirror to a smart-http remote that uses
    alternates. The fake ".have" refs the server gives to avoid unnecessary
    network transfer has a similar bad interactions with the machinery.

but it may warrant a more thorough write-up there.

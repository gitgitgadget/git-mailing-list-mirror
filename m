From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] archive: limit ourselves during remote requests
Date: Tue, 15 Nov 2011 16:03:28 -0800
Message-ID: <7v7h31szlb.fsf@alter.siamese.dyndns.org>
References: <20111115214159.GA20457@sigill.intra.peff.net>
 <20111115214840.GB20624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 16 01:05:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQT0Q-00070g-FT
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 01:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574Ab1KPADb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 19:03:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756994Ab1KPADb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 19:03:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 503C5673E;
	Tue, 15 Nov 2011 19:03:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M5z4mUETW/wM/aEe9RI8v7HStLk=; b=Un6yGw
	GxtkHwCvuRfcVfmiD7N88zd8unZTs3SKGbdhTkW/on03ioidCX+cczatXrZXDIQn
	LF/H4sxvALJRxAXSd8bzutaBfAbifMvua1KuMa3mGTcm1Lj0u5de9QaWmicj+5ZW
	2k+9LLq7ZnbzF0/K3u3q7PWT0u2iIUJyBOKfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i4bVicslabTY5am4/yz6ks7ES4mFB9eo
	XwmiPjMnMJih+K5tN00Y1HdsvGU6r7jJoK1lvoLesYJqAaUwoyuDgWvPGYZWNU1V
	ioAg3xlVQoXoPUluVpzfu2rvyPPCCJ6AOb0lHRW84JtVwhL0P07rGI5KadFxoQRt
	tAYoU3kshWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46DF5673D;
	Tue, 15 Nov 2011 19:03:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D266A673C; Tue, 15 Nov 2011
 19:03:29 -0500 (EST)
In-Reply-To: <20111115214840.GB20624@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Nov 2011 16:48:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A55B7DC-0FE6-11E1-9908-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185501>

Jeff King <peff@peff.net> writes:

> ... just a very stripped-down version of
> git-archive (i.e., it _only_ calls write_archive). Or it could even be
> spelled "git upload-archive --remote-request". But the point is that
> git-archive never needed to worry about security before.  We
> shouldn't be polluting it with security code; we should be bypassing it
> going to write_archive directly.

Quite sensible, and a good approach to reroll the series, I would think.

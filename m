From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] bundle: use libified rev-list --boundary
Date: Wed, 30 Jun 2010 10:57:10 -0700
Message-ID: <7vtyok5rpl.fsf@alter.siamese.dyndns.org>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino> <20100626062005.GC15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org,
	554682@bugs.debian.org, Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 19:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU1Xn-0004tH-V4
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 19:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab0F3R5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 13:57:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763Ab0F3R5u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 13:57:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D096C009E;
	Wed, 30 Jun 2010 13:57:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NxxWooAwTODj7VEq+MIG+FaVtq4=; b=MdjdDK
	Ipk2853mdx/4QKbasyJ4JzqqKgCTsExO3eD9yGZN7WKVdi7hRIXWT8NlEBUgeT6f
	/cKldfhFABxbVA94cDW5uy++/rpUFzco1YD81Uv5kdvZ+5Gv4wItsKO094zcP8BI
	nOEBFQSS+yaUK7wT86sVlWg1sQHNbG5pxVCdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aR3TcvS8pcfpZflWExok5NSSgCi9Xbah
	hqYv+VHVY6OIC9OLwqpcD/Ops1XgwWaxWxDHSzSX1dR3Vj11Gu+FcmHU4DHOXnYo
	lmRpX1QIgZA5xBhpvU95xDLrbAFDOwhUJlPw8gN3UK181dP5KDXDVYgC1o1J30j5
	GK8ug1UCxqA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C32C008D;
	Wed, 30 Jun 2010 13:57:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6D1EC0076; Wed, 30 Jun
 2010 13:57:34 -0400 (EDT)
In-Reply-To: <20100626062005.GC15881@burratino> (Jonathan Nieder's message of
 "Sat\, 26 Jun 2010 01\:20\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAB5D4E0-8470-11DF-B184-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149982>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The revision walker produces structured output, which should be a
> little easier to work with than the text from rev-list.

Hmm, doesn't it negatively affect later traversal you would need to do if
you smudged the flag bits by running revision traversal like this?

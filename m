From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git checkout lies about number of ahead commits when
 switching from detached HEAD
Date: Sat, 19 Mar 2011 17:35:37 -0700
Message-ID: <7vy64avdba.fsf@alter.siamese.dyndns.org>
References: <4D8525C9.2060203@gmail.com>
 <20110319222852.GB7116@sigill.intra.peff.net>
 <20110319224726.GC7116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 01:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q16ca-0000zj-VW
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 01:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343Ab1CTAft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 20:35:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1CTAfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 20:35:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1E0341E8;
	Sat, 19 Mar 2011 20:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FiXtBlTED+GPrhc6uGgUHEYyPK8=; b=lY9nL4
	cy8D0eyu7zetcZONXW94HAWhnKseiFmBeFe7t6YEgLf1Pp6z5UIIkJJMcXrTBgaU
	7TiSi7xEuhG3fF+SSw5Vr9k/MuyX0ydzfdRFkM48SQhX7k+oylD1bOxaqWLagW2f
	lIGw3KZwQKcG2d6j7JjhncM2M/cJv4mt2wp+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UwsTW6QVaplP40SbGLH1AIl6CyzWK6Yv
	V2bMp9jr/PIRXhstCUxPjv41nlXyG9NHCtrtlONcnZHb5atZpI6GRTDR8DTrRnHp
	JBAJaZXljFf2+BZgvwVYMZeygX0watqfgqlVyx0AEja+OFkzxjwmNTOloaa6QTxC
	O/l8TFoX3Rg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70E9C41E6;
	Sat, 19 Mar 2011 20:37:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4CDA441DF; Sat, 19 Mar 2011
 20:37:15 -0400 (EDT)
In-Reply-To: <20110319224726.GC7116@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 19 Mar 2011 18:47:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3675CDEA-528A-11E0-B103-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169480>

Jeff King <peff@peff.net> writes:

> but I'm not quite sure if this is the right place. Is it the
> responsibility of the checkout-orphan-warning code to clean up after
> itself, or is it the responsibility of a revision walker to clean up
> before itself?

Usually it is the former; the latter is generally impossible (unless it is
willing to clear everything), but the former knows where it started
traversal from.

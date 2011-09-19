From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 15:28:33 -0700
Message-ID: <7vk49488vi.fsf@alter.siamese.dyndns.org>
References: <20110918032933.GA17977@sigill.intra.peff.net>
 <1316341224-4359-1-git-send-email-judge.packham@gmail.com>
 <20110918183846.GA31176@sigill.intra.peff.net>
 <7vvcso9zzi.fsf@alter.siamese.dyndns.org>
 <20110919182049.GA26115@sigill.intra.peff.net>
 <7v62ko9scw.fsf@alter.siamese.dyndns.org>
 <20110919204448.GA3562@sigill.intra.peff.net>
 <7v1uvc9qhz.fsf@alter.siamese.dyndns.org> <m2bougtdc2.fsf@igel.home>
 <20110919222325.GA4056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, jepler@unpythonic.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5mKP-0002ly-0v
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 00:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642Ab1ISW2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 18:28:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756619Ab1ISW2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 18:28:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A07A5544;
	Mon, 19 Sep 2011 18:28:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ySVDF3QzDJ3XdeK7V+L1XhiSZZk=; b=wiVWP+
	N3xdSpINBb/dEpALdzw67zfoNXkBU+CwBXjhsvulJILF4LKL6DpofNPYJGqaUYLZ
	uloKg3yTx3qXQ+7XcOZrTBUz4or6IEX86OxufZtADT2VMXAqag+LFSxBIN6srgyQ
	X+ix/3gL5BlItEEuUqjqKqgfCe9RwSg2d0J44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XHMTA0pSj5YsIa0c1BKPSqcpRemKyVVv
	qyPSchm4NVZN7ecmcuV7ZlNwjgzGleo6D6b6UGXRjheaRF/uUgGyH4n9Gon757ne
	Gl1zlP5D7xe0Th6+g/4wJdjjmKHpyIrdd2ry04sI6ejahf6p3zXtiAfiudzwfTNt
	e/MraKIIAS8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711575543;
	Mon, 19 Sep 2011 18:28:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 026ED5542; Mon, 19 Sep 2011
 18:28:34 -0400 (EDT)
In-Reply-To: <20110919222325.GA4056@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 18:23:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B667479E-E30E-11E0-AF14-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181715>

Jeff King <peff@peff.net> writes:

> Yeah. Doing:
>
>   eval '$browser_cmd'
>
> will do the whitespace-breaking we want, but it won't interpret actual
> shell magic characters, which we need in order to be compatible with
> other parts of git (which typically use "sh -c ..."). E.g.:
>
>   foo=worked
>   browser_cmd='echo $foo'

Yikes, I forgot that we do that. You are right.

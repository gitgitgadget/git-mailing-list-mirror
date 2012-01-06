From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: try internal cache before reading object
 db
Date: Fri, 06 Jan 2012 14:45:15 -0800
Message-ID: <7vmxa0ih6s.fsf@alter.siamese.dyndns.org>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191654.GA11022@sigill.intra.peff.net>
 <7v8vlkjzcj.fsf@alter.siamese.dyndns.org>
 <20120106223324.GB13106@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 06 23:45:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjIXN-0003Qe-7j
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 23:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000Ab2AFWpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 17:45:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab2AFWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 17:45:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C87EC6139;
	Fri,  6 Jan 2012 17:45:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cO/pqZxKpnN5fjIm/m90GPi6/YY=; b=FZR7zP
	kd8y5FvgsZtXITU/pYhFuhFG1/p6apDRABeN03/kajNspcQPM9J5/QnJDn6yy2xg
	ZVSTD/pyK8v2l3NslTAYIOJaPE0kXSb/QRrJfuCcdQBn9YY20OKcrUrUxdloManS
	kurD/xH6YUyo1/nUASgudj2PTSaT+5JNo1v50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mwbuqdd5+hujSwAG5HzayqVl+3CMtkAG
	nGnMgkDtHsoY/DX86Et//hxKbaXVRRCDOx0F5tg74Ko9nQ1r9imbK+9nKjUru+OS
	qH4y1nyd0tMhxRrLbh2VBzjSBcqocXgPWZrhRAgvgLblqqRD7bRmg9h7YkH+xUMs
	73tFYp29TBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C02B66137;
	Fri,  6 Jan 2012 17:45:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28EAE6136; Fri,  6 Jan 2012
 17:45:17 -0500 (EST)
In-Reply-To: <20120106223324.GB13106@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Jan 2012 17:33:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AC07F68-38B8-11E1-A992-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188052>

Jeff King <peff@peff.net> writes:

>> Even though it is a bit scary kind of loosening of sanity checks that I
>> hesitate to take at this late in the cycle, I think it makes sense. Let's
>> queue them on 'pu' and aim for the next cycle.
>
> Did you want to leave the parse_object optimization until next cycle,
> too? It's not loosening checks, but it's such a core piece of code that
> it makes me nervous somebody somewhere is abusing "struct object" in a
> way that will break it.

I was just updating the "What's cooking" report and my current thinking is
that we should keep all three in "next" to give it a bit of exposure for
now, and merge them to "master" early in the 1.7.10 cycle.

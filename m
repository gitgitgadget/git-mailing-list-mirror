From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 06 Feb 2012 10:17:55 -0800
Message-ID: <7vpqdr7rn0.fsf@alter.siamese.dyndns.org>
References: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
 <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
 <20120206050637.GA4263@sigill.intra.peff.net> <4F2F94AC.6010800@alum.mit.edu>
 <20120206085707.GA24149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 19:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuT8f-0001kI-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 19:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab2BFSR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 13:17:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754700Ab2BFSR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 13:17:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DC426D2E;
	Mon,  6 Feb 2012 13:17:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G+nUsW9UuVb3KVV1oR2PYQLhh68=; b=MuIiBd
	K07QJfmftyLyvGPx4SPENIwmxjB2jgTj1BmMbdGwPBru1KA2YR5bdGQRTYiiXSd1
	cEZEH3e5RTLoQvK2byUtlC8oKzONs+1otqYyRslH45QexYrAec6SxmvpunqwGcEo
	Dc82FrSow65p6CFewaawjrniJlXMRzPAdNrsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LWTqvbFIZeobepcNq9OcfTuen+8XFczR
	4One5gyLhktqd4PiUhw0aLcJhgJpuCh9bTynvQQBaoTY3zltcogK9J4VXQ8SRkHT
	zIKtBUeZSXx388iDPWFB8GvkNY+Ee7W9NbdBhmkgz3e9CNegwrI/vCTUSxSdgs6D
	Z3Ofp30Jois=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8353B6D2D;
	Mon,  6 Feb 2012 13:17:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 147856D2C; Mon,  6 Feb 2012
 13:17:56 -0500 (EST)
In-Reply-To: <20120206085707.GA24149@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 6 Feb 2012 03:57:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4EC2DE8-50EE-11E1-9AE2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190086>

Jeff King <peff@peff.net> writes:

> PS I probably would have done it as:
>
>      git init vendor
>      cd vendor
>      import import import
>      cd ..
>
>      git init project
>      cd project
>      git fetch ../vendor master:vendor
>
>    but I don't think there's anything wrong with your approach (in fact,
>    it's slightly more efficient).

Probably I am slower than my usual slow self this morning. Does Michael's
approach go like this:

	git init project
        cd project
        import import import
        git branch -m vendor
        git checkout -b master

to fork from third-party codebase?

Or Michael had his own 'master' already and wanted an independent orphaned
history from vendor, perhaps like this?

	git init project
        cd project
        work work work
        git checkout --orphan vendor
        : perhaps "git clean -f" here???
        import import import
        git checkout master
        : rootless merge???
        git merge vendor

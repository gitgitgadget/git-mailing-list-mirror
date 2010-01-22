From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive ignores export-ignore
Date: Thu, 21 Jan 2010 16:57:39 -0800
Message-ID: <7vocknhs70.fsf@alter.siamese.dyndns.org>
References: <20100121221312.GB5307@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: nospam@codegnome.org
X-From: git-owner@vger.kernel.org Fri Jan 22 01:57:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7qR-00058o-NF
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab0AVA5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677Ab0AVA5r
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:57:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab0AVA5q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:57:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 258629375F;
	Thu, 21 Jan 2010 19:57:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7/ErueralyCvPGSOUp18OXMMnLY=; b=CyrLcU
	BX5dX5Bsj2XMSAAlzSeddS8oDzGm3AQ5Gy3fuzhChb+RCHCn7imL4wxIT8BiGJLa
	9T571R1VhOeh/XmMdr9NolZWWPJyu5fmRvbEgIl6aTlDgU/0i+BbhiN/LcUk2jaf
	nL426antsY2pXGDISMEROJTkacpc633CAwGP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=St46Rrc573dDeT8m4raiTLXT61QN21aa
	STBCcNlERjlmDgf3n2/5Sxi3W7nBW5R/01hdzaRITfW3YeQAbUJNj8joPFIlZEWQ
	oltgE02hqc7bpDPa3FbafThtWtSyn7Qn9mCgkr7+rj9InTOJOp+O0SFFSokBaTiB
	qQ4nVC7V0qw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0146E9375E;
	Thu, 21 Jan 2010 19:57:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45CEC9375D; Thu, 21 Jan
 2010 19:57:41 -0500 (EST)
In-Reply-To: <20100121221312.GB5307@penguin.codegnome.org> (Todd A. Jacobs's
 message of "Thu\, 21 Jan 2010 14\:13\:12 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 260E609C-06F1-11DF-ABEF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137711>

"Todd A. Jacobs" <nospam@codegnome.org> writes:

> Using git 1.6.4.2, the manual page prophesies that:
>
>     Files and directories with the attribute export-ignore won't be
>     added to archive files. See gitattributes(5) for details.
>
> However, various tools seem to be unhappy about this attribute. In
> particular, checkout complains about invalid attributes:
>
>     $ cat .gitattributes
>     *.py export-subst
>     *.html export-subst
>     juniperxml.cfg export-ignore
>
>     $ git checkout juniperxml.cfg
>     export-ignore is not a valid attribute name: .gitattributes:3

    $ cat .gitattributes
    * whitespace=!indent,trail,space
    *.[ch] whitespace=indent,trail,space
    *.sh whitespace=indent,trail,space
    COPYING export-ignore
    $ git checkout COPYING
    $ wc -l COPYING
    360 COPYING

There is something that is different in my failed attempt to reproduce it
from your problem description, but I cannot tell what it is.

Do you have some garbage character immediately after "e" in "-ignore"?

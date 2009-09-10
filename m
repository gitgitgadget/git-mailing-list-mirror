From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 11:53:23 -0700
Message-ID: <7vbpliaaxo.fsf@alter.siamese.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <m3fxavvl5k.fsf@localhost.localdomain>
 <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com>
 <200909101850.26109.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlom5-0006aJ-3R
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 20:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZIJSxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 14:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753100AbZIJSxc
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 14:53:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZIJSxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 14:53:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBFA62D7A9;
	Thu, 10 Sep 2009 14:53:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RSHKK5ec9WjiJ6S+fhhDHzEHKH4=; b=A56uLs
	AdN276gtewtGnouLKlSQUeRy+59nueAyvMEUqyTY+m23XyJPQ204g8GjXvi+927U
	mS+8i2Wtb1uBKbvlyEKpVtVgT7lBKdCJENTJ7pUY+CSrDAakPmofrD4g5GAtIp6E
	cEXpPEZllOi+x2XqR3C5y1NGIE9RHKm18u5EA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Orc3LRaJ8CgBS1O2welvTqe/iu4OLARl
	+6dLV/I6fXhvss+Fbe51wbw92IHS3e+qArWRm4E+x8lxIEWRNyIn5GrykquPBUye
	U3WmtkRTpqy28/JsUzpCAmrRWsVxj8m/E9RdytwF6O87YRUnXQU8Fy7BUzRxCoyU
	8mNe/h57KTk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A60472D7A6;
	Thu, 10 Sep 2009 14:53:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF04E2D7A2; Thu, 10 Sep
 2009 14:53:24 -0400 (EDT)
In-Reply-To: <200909101850.26109.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 10 Sep 2009 18\:50\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AEC6EF6-9E3B-11DE-83BB-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128134>

Jakub Narebski <jnareb@gmail.com> writes:

> First, it would be consistent with how ordinary archivers such as tar
> or zip are used, where you have to specify list of files to archive
> (in our case this list is HEAD).  Second, I'd rather not accidentally
> dump binary to terminal: "git archive [HEAD]" dumps archive to standard
> output.

So does "cat".  I do not agree with your second point.

While I somewhat see the similarity argument, your first point, I am not
sure if it is relevant.  It is not like "tar or zip allows us to say what
files to archive, but git-archive doesn't and it always archives HEAD";
you are saying "they require us to specify, so should we".

But I do not see a strong reason not to default to HEAD.  The case that
would make difference would be to differentiate among

	$ git archive HEAD TAIL
        $ git archive HEAD -- TAIL
        $ git archive -- HEAD TAIL

i.e. what if you happen to have a tracked content called HEAD.  I didn't
check the current command line parser in git-archive understands the "--"
convention for that, but it is not a rocket science to add it if it
doesn't.

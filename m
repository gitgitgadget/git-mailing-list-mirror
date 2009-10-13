From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect reset: Allow resetting to any commit, not just a 
  branch
Date: Tue, 13 Oct 2009 00:01:44 -0700
Message-ID: <7v3a5n3hgn.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu>
 <7vr5t8coex.fsf@alter.siamese.dyndns.org> <4AD420BC.5060506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:05:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxbRr-0003oz-MA
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933506AbZJMHDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933495AbZJMHDC
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:03:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088AbZJMHDB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:03:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D37A375C98;
	Tue, 13 Oct 2009 03:01:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RujPazVOF0hXSvwTkXSHBhetdk0=; b=Ll8Kw+
	lqMfY2QocS3PoNa7Ge+B6c4L9L1y2LHnucV7GOGYKzZ2DA3oVq+Ajklwp2xDXdtp
	0npHRowBG4o803T+2MZ2ubx+4vRDk/8kt01S89mK4AeMYUhPcfPBUForvwmZiMJg
	9ldlgYD/k0J6wfX8RDCeuC6NDTzUg3DFtM4LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKlXIxA95mGQe2IbHKwVEqYFlH9U/45c
	Za+HCUJzJOC8au9X94Z0cM6UEG5C98vN9I2gCRIldAyhzChunceZFh8sXgKki+mV
	A370/9P2SnGmf4tHLjn+C2MDomm6B7ZtXeMrcJStwlLAaGin6tYsSp0t6PK2067B
	ewMQmX4EXUA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9E8675C97;
	Tue, 13 Oct 2009 03:01:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 87DF175C96; Tue, 13 Oct 2009
 03:01:46 -0400 (EDT)
In-Reply-To: <4AD420BC.5060506@viscovery.net> (Johannes Sixt's message of
 "Tue\, 13 Oct 2009 08\:39\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47F8422E-B7C6-11DE-BD77-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130133>

Johannes Sixt <j.sixt@viscovery.net> writes:

> In my workflow, after I've found the bad commit, I always want bisect to
> stay at the commit that it found. I don't want it to warp me somewhere
> else; I want to make the decision where to go next myself.

Are you sure about what you are saying?

Half of the time, the commit you test in your "git bisect" section would
be a "good" one, and immediately after you tell it "bisect good", it tells
you that some _other_ commit you marked "bad" is the first bad commit.  In
such a case, you won't be on the commit that the bisect has found.

So I _do_ agree that you would always want to stare at the commit that is
the first bad one, leaving the bisection session at the detached HEAD
state bisection session ends at is _totally_ different from what you want.

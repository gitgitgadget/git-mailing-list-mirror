From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Tue, 02 Oct 2012 13:18:18 -0700
Message-ID: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
References: <5064140E.50007@drmicha.warpmail.net>
 <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
 <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org>
 <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl>
 <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl>
 <7va9w5c31w.fsf@alter.siamese.dyndns.org>
 <506A99DE.7080503@drmicha.warpmail.net>
 <7vhaqcajvt.fsf@alter.siamese.dyndns.org> <506B4598.1020206@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8vJ-0003uK-51
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 22:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab2JBUSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 16:18:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab2JBUSV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 16:18:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D81C096C4;
	Tue,  2 Oct 2012 16:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Evvc3YW2xhJ+/SIeRnQ//WUs/x0=; b=sj48P2
	AephUu8yP7AsK7zxfW57sOJ0jFc9y81aWQsij/zdWrckPft2qXXShPzLCU5fEd4D
	r9t2d0kJTBktb+wDaCHxhfhpQfLq/9cG4SMJnBfoDBXX0zHQqWdGD4R1LHT4RCDE
	7jaB4wIqbd9dH1hp3ripRNnS1+3gVWzTajG20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m0o+XPF0urSa0WVqsR5JqrF8dsQiYjMv
	BtJKnmrIQ3x2iDnPfEYrJRb8+T0gV9VBO4YAb1AzG3Sq0vrDRCFxSvLfN9ESeaWd
	5N4MuIwetIgnGo8bJJ65o9otdcH72Cic9+lc8mvnmDuT9nF8eMgeE+4C0DoDiBCA
	pmYuJUkebzA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C523A96C3;
	Tue,  2 Oct 2012 16:18:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24C4096BD; Tue,  2 Oct 2012
 16:18:20 -0400 (EDT)
In-Reply-To: <506B4598.1020206@xs4all.nl> (Simon Oosthoek's message of "Tue,
 02 Oct 2012 21:50:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EF35112-0CCE-11E2-AE07-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206845>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> ... This is
> prevented (and quite the norm in static PS1 strings) by enclosing the
> terminal code for color inside \[ and \] so bash doesn't count these and
> what is in between them in the length of the prompt string.

Ah, OK, and these \[ things \] behave like other magics like \h and \W
in PS1 in that PS1='\h $(echo_bs_w)' will not work as expected with

	echo_bs_w () {
		printf "%s" "\\W"
	}

hence cannot be used in __git_ps1 function that is called as $(command
substitution).

That was what I was missing.

> The only way to get the colors in without messing up normal functioning
> of the prompt is to use PROMPT_COMMAND to set PS1, with colors based
> dynamically on the state of the tree.

OK.  Thanks for explanation.

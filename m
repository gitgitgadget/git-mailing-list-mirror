From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 03 Jan 2012 10:19:42 -0800
Message-ID: <7vzke4vebl.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Jan 03 19:19:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri8xl-0000hj-UB
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 19:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab2ACSTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 13:19:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497Ab2ACSTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 13:19:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A17A755A;
	Tue,  3 Jan 2012 13:19:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UeVAqPJG/Op1j7dYSTAplOVHRr8=; b=i3FKQR
	cOMfX++UL3LAW9uSAVWoILcl7v6UVswCkhpPErEgLO4r5lk1zSybG4x42T/X25Aa
	8fNftSj2Xy2Qm9qSQJrnzhFYhTVTGi7Ol6Xt04MBys+3OjunaqNdYxRQqAb1lroR
	cSKs9+4kwC1WnNA6KgHzoVnzdG3HnxeROmcIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IQ/lJvhFPn9uag9DzPERld91YMmK8QAT
	9mbNWrsjtIXgS2Z2sPiez/OZXnYzessEUnFn8sbstcaTiu74D/bL327Zoj2+L0aX
	CREYXzDhzN9JtEd9+ZZXAU2X9ZTs0TWMCKvqBuI9wilnZVCDWkSQZvGOQBCgc/LX
	QpnkzQqdeX8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9197A7559;
	Tue,  3 Jan 2012 13:19:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC6337558; Tue,  3 Jan 2012
 13:19:43 -0500 (EST)
In-Reply-To: <4F00B7F3.1060105@tu-clausthal.de> (Sven Strickroth's message of
 "Sun, 01 Jan 2012 20:45:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8296049C-3637-11E1-841A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187869>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> I'm still for the second patch to be applied (maybe w/o the certificate
> filename prompt), too, because this makes git-svn behave the save way as
> git-core does (especially asking for username).

I do not have much issues against the patch if the filename thing is
excluded as a short-term workaround to avoid regression.

For people who have been used to interact with git-svn from the terminal
but has *_ASKPASS for reasons other than their use of git-svn in their
environment, the change to the username codepath is technically a
regression, as they used to be able to see and correct typo while giving
their username but with the patch *_ASKPASS will kick in and they have to
type in bline, but I am not particularly worried about it. It is something
you type very often and committed to your muscle memory anyway.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Wed, 14 Oct 2009 17:56:52 -0700
Message-ID: <7viqeha2zv.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 03:03:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyEkD-0003Ia-Vd
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 03:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762314AbZJOA5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 20:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762295AbZJOA5s
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 20:57:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762293AbZJOA5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 20:57:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E159F5995A;
	Wed, 14 Oct 2009 20:57:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ZdtBvWKokvRuzfXOV83+lB6Drk=; b=JVdJtP
	MyhQjd4ZODllrk0sMtsmnzcHFzNbxDDVyzIZqb0CN9pA3N+yzj+z1T4MtSdg16Sp
	CucGE4AnWXMhwDA4MrF8UM91DbZcPUW26Z9Xeq3+cvD0GPcunypLxiptmVroQzIz
	QUPpqBmnJQHjE0qkUUPiXglN7QGMoX0Ehlnv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+nA/mxiY0BdBnVqyC+b2tv0hsZzAMb6
	bQNg4572+drlKdZoInwi9hi4UFUgDQRSFrdgiuR/GYncSLxDXqyWsa/ClCrtzcJ2
	h49FkVJNQNAfbpewXU9RWf3PrTjIQ4YU0dfEm2NYwts5v/VsHavpP7g3FUWIhZb1
	SKU5WKEo6nE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A5759955;
	Wed, 14 Oct 2009 20:57:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F51E5994B; Wed, 14 Oct
 2009 20:56:53 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910141926170.20122@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 14 Oct 2009 19\:34\:46 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A54E041C-B925-11DE-BAF7-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130353>

Nicolas Pitre <nico@fluxnic.net> writes:

> Can't the user confusion be dealt with through some means other than 
> making the tool less flexible?  I don't mind extra help message to be 
> displayed after a headless commit is made for example.  But trying to 
> make the tool more friendly should perhaps come from better education 
> rather than added restrictions.
>
> My thoughts only.

I actually share that but there apparently are people who have given up on
the education route.

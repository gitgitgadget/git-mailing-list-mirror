From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 06 Sep 2009 14:17:07 -0700
Message-ID: <7vocpnydrg.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
 <7vab191dz1.fsf@alter.siamese.dyndns.org>
 <7vzl98vrmt.fsf@alter.siamese.dyndns.org>
 <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain>
 <7v3a6z3lsg.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain>
 <7vws4bzu7w.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
 <alpine.LFD.2.01.0909061354010.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 23:22:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkPBd-0002mX-QS
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 23:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758950AbZIFVRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758919AbZIFVRP
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 17:17:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758921AbZIFVRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 17:17:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8769C46960;
	Sun,  6 Sep 2009 17:17:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dja8o/4+CecjX/aL+gEbAjbjYYU=; b=tcc/Vb
	Nn4f8r+yktzUBjkDd4U8dT+qFmwRx4m3YQTMQMROBc//u6d6JrhW3HYJzpENDy1t
	VA7opFAGU/j6wCUBE4dr5iIJdprzkO06PaUGNQK6ahBFXjGFIRiHmDDpNjonWfXo
	c3Ja6N1bBskPj7n7CxGH+hwURKiV88hPbs2NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LfOGxS2gVnPN1SJrXe1UA3EOjRpxjpyA
	5u29D9/DvYePICVrnHxHz5t/Gdoq25Zox1H5abeqoG8dGqHbnpIhiNIxaT2ki2XD
	wzXmGThEln9oO1A3pVyc+I+Y497NhpyPeL6q/bLiZ6JCCKCr1wwjgkYS6supx/Vb
	rjcLXq76OYQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B4E24695D;
	Sun,  6 Sep 2009 17:17:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 42A834695C; Sun,  6 Sep 2009
 17:17:08 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0909061354010.8946@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 6 Sep 2009 13\:58\:20 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4D302E4-9B2A-11DE-BD26-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127871>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Grr. I need to go off and do some other things, and this still fails a few 
> tests...
> [ In other words: in this version, we only do a single-entry lookahead, 
>   exactly like we used to do before. So this is not meant to _fix_ 
>   anything, or change any semantics. It's an incremental "change the model 
>   so that we can look ahead more in a future patch" patch.
>
>   But it's broken, and I have to run away for a while. ]

That's okay.  I myself have to go and give a final review to the galley
proof of my book, before the publisher gives a go to the printing press
now.

I do not think we are in a hurry, as this issue, as far as I can tell, has
been with us from early days of git; I would say for the whole lifetime of
the unpack_trees() interface, but I didn't check.

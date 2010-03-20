From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 06:30:23 -0700
Message-ID: <7vaau3ruhc.fsf@alter.siamese.dyndns.org>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
 <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de>
 <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 14:30:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsylB-0000s8-CG
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 14:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab0CTNac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 09:30:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab0CTNab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 09:30:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 411A1A3EAF;
	Sat, 20 Mar 2010 09:30:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=4I8dVOado5yoxLbNfAt/PUHu1AQ=; b=d34DkD
	4dVgH4Sc3dWLZu8ZyKFcr0RfsiYxNo2hYd5+TOpSQFwoE885enhUwNDjvy9y1Guu
	d0FjItt1zIY147Vyi7RKJKuthi72dAHnpi+UTbVi1+zJUV3g8afGMDCB0FX4QK3+
	2Te44QDPwH9halxNbjnOdicxBKYstmwYPiGrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U9u0/WmeY4UBjmlqwDOv4qdmuv3tCYkk
	P91VrVAms+2yIsLB0n640VqdzqcYMdLNVVh+VFWZQRGzr9eIxyr04CyVHblXTBLK
	vnQ8bWJl2kQKbtniQvsKzGoW292mUe8RNLg+hYOZGBxuwW5JaB+bQqbSmzruikG0
	Qh7YIIbnLWY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FFA1A3EAE;
	Sat, 20 Mar 2010 09:30:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9146FA3EAD; Sat, 20 Mar
 2010 09:30:24 -0400 (EDT)
In-Reply-To: <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
 (Bo Yang's message of "Sat\, 20 Mar 2010 21\:10\:55 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BEEC357C-3424-11DF-AFE9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142707>

Bo Yang <struggleyb.nku@gmail.com> writes:

> But notice that, detect code movement in one commit is much efficient
> than detecting code copy. So, I think we should add an option to
> control whether we detect such kind of code copy.

If you are hooking into "git log", it already has "-M / -C / -C -C" as a
notion to express "different levels of digging" to find code movement and
copies, and so does "git blame".  You probably will save a lot of time if
you studied the current blame implementation thouroughly before designing
or coding.

Two things that you need to think about carefully is why "blame" stops at
the commits it shows, and if you could "peel" these lines in its output to
peek what are behind the lines, what you would see.  This is not a rocket
science topic, but it is not entirely trivial.

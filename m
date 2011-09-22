From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Thu, 22 Sep 2011 10:32:32 -0700
Message-ID: <7vsjnoxz2n.fsf@alter.siamese.dyndns.org>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
 <7vr53a2icn.fsf@alter.siamese.dyndns.org>
 <3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
 <7vobyd1vmo.fsf@alter.siamese.dyndns.org>
 <FAB0B05E-6BAD-488C-8478-F4B80493FB96@inf.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Alexander Pepper <pepper@inf.fu-berlin.de>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6n8h-0007Sk-4R
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1IVRck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:32:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab1IVRch (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:32:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8901D6A25;
	Thu, 22 Sep 2011 13:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=blScuKTjMxL+dVOstQ4Ythw6cuU=; b=Ias3zv
	MB8iThJGUkQRInj2plQZ1xqLn+hFzQ87zdKm1Nfy23HtahJDjN//4xIiehc9uR0+
	mUubmTmJzngqufrgPh7QPvemdSrutCyOX4dL5x0WHXnzuYenjXBC0Q9ezve3Jd+2
	QZyO8pNFDLE1Kr6dBOuLE1+TynS455KNmjxDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kTv3df9vhs99KDVMeVGiHMh0W8+2Xcdm
	aJWok60eCjlWW9/rJFagYJcaJXgeOIJQVF0v+qGBnBcxqrgJ0ZFcguczJHaNpkjp
	FCGSYYTIH3nD7JlCOckHB1u70Go91RgCRdW+ShRXmyft8yBJJTqM1kJe+8ulje1M
	TVKHgGyNr5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 806246A24;
	Thu, 22 Sep 2011 13:32:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC0706A22; Thu, 22 Sep 2011
 13:32:34 -0400 (EDT)
In-Reply-To: <FAB0B05E-6BAD-488C-8478-F4B80493FB96@inf.fu-berlin.de>
 (Alexander Pepper's message of "Thu, 22 Sep 2011 15:19:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBD2704C-E540-11E0-B2B2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181904>

Alexander Pepper <pepper@inf.fu-berlin.de> writes:

> When used git version 1.7.7.rc1 I didn't observed any case where git
> show and git log --numstat mismatch. I'm only a little confused, that
> 'git show' yields different results, depending on the git version.

In general it is not surprising nor unexpected--as long as both patches
describe the change correctly, they are both valid.

What was unexpected to me was that 27af01d (xdiff/xprepare: improve O(n*m)
performance in xdl_cleanup_records(), 2011-08-17) which was supposed to be
only about performance and not about logic made that difference.

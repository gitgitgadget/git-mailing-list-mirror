From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 10:25:14 -0700
Message-ID: <7vvc7j7nut.fsf@alter.siamese.dyndns.org>
References: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
	<alpine.DEB.2.00.1304181146090.30868@ds9.cixit.se>
	<CAMP44s014Yv9+N7=0CYiYYybJCZJ7r-vQp_zcfg6Xo=3f21RWA@mail.gmail.com>
	<87k3nzx6dn.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsaM-0005Yq-6L
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967172Ab3DRRZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:25:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967001Ab3DRRZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70158170E6;
	Thu, 18 Apr 2013 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1qyup1527NePDhbWA8XTFXZdUQ=; b=ImB33O
	jgnhzkUvn4OBmbVV9iMCvGp9VR7AYruaWsybJtR6YsdGKaU41wiXcICZ+ZIRaxrE
	eerqrOzeRQ0ixtY8fJx+5HmPECfZsJwav2D/vgdpvCl3pfmSOvKZEastj/GWMUi1
	1ALLVKaTihXKHD+vbpG6Byn/4c8N8oDCuTqnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llV8sPkXEuPbK2UtrAHxpMfYJ0RTqQja
	jL1UdBDWKRISkyBLUIYjpberzMu4Bx4WtKDZHUqe0X1lD3MGZhgDMScItW7Or4wm
	TEp/Sw3ipoU1lLB//RxDsPT+taHivfL2032Qh4ISKz2QXWLfWxHYFYAAWzxg6Tco
	5I1DULvV2PI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64862170E5;
	Thu, 18 Apr 2013 17:25:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE0D1170E4;
	Thu, 18 Apr 2013 17:25:15 +0000 (UTC)
In-Reply-To: <87k3nzx6dn.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Thu, 18 Apr 2013 16:25:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF3C326E-A84C-11E2-92C5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221669>

Thomas Rast <trast@inf.ethz.ch> writes:

> You could come up with a patch series that first starts emitting
> warnings whenever the user asks for behavior that will change, and later
> flips the default and removes the warning (the latter would be merged
> for 2.0 or so).

Please don't.  The fact that "reverse then count" mode may be useful
does not mean "count then show in reverse" mode does not have any
use. "git log --oneline --reverse -20" is a very valid way to ask
"what did I do recently" and get "you did this, that and then..." in
that order.

Adding a new option can be done anytime without any complex
transition plan.  You may want to introduce a --show-in-reverse
synonym to the current --reverse when you add the new mode of
reversing (--reverse-before-count?) so that eventually we won't have
to ask "which kind of reverse an unadorned --reverse option mean?"
by deprecating a plain "--reverse", though.

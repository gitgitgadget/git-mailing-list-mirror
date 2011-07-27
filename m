From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] commit: allow partial commits with relative paths
Date: Wed, 27 Jul 2011 08:37:33 -0700
Message-ID: <7vfwlrpwea.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <7v8vrmrxok.fsf@alter.siamese.dyndns.org> <4E2FCAC4.7020408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Reuben Thomas <rrt@sc3d.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:37:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6B6-0005F9-3G
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab1G0Phj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 11:37:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab1G0Phi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 11:37:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A0063E0F;
	Wed, 27 Jul 2011 11:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2eEFwiBjenLxffFDdVBbZIvZK80=; b=dFYvi4
	BW8x2QF9nd2vnI4QjedWCZdNQYkOru94xPOHBa1LE42JqZ8kz0JYDnjyQR+iaeqn
	eK8tH8m87q1oehhaRfMJyCTtmdk7bcLXjZdc8N/J7zaEGm/s4QR8pZ54Wam/3Qwa
	xKeGONVo0NCAtgeSxCsJUCd3knRw7AtKBFoz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jAZG+s74RmiW8yrTbYrLRe2nirYN5n62
	ue68FXz0s0IyHlD1hXcewr3FsBWSdw2ELRD4GAf2t/CgtceXxW7jj6Jd4xCC5B8d
	g8RwYgyWP6fGoi7CEGP3ojOfF3vGVLG/khJObF9PnYroGRXGOyxVUnDcwd6J2kLI
	jfoMn6ZKu3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 612143E0D;
	Wed, 27 Jul 2011 11:37:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D32333E0C; Wed, 27 Jul 2011
 11:37:34 -0400 (EDT)
In-Reply-To: <4E2FCAC4.7020408@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 27 Jul 2011 10:22:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 597E7D4A-B866-11E0-88ED-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177972>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git rm ../a
> git add ../a
> fatal: pathspec 'a' did not match any files

If you didn't have that ../a from the beginning, wouldn't you get the same
error message? Or instead of "git add ../a", you did "(cd .. && git add a)"
what message do (and more importantly "should") you get?

I think it would be an improvement if we said "../a" in the message, but
otherwise I agree with you that there is no bug here.

A side note. If this didn't work:

    $ git rm --cached ../a
    $ git add ../a

I would suspect that would be a bug (this however seems to work).

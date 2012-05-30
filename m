From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] wt-status.*: better advices for git status added
Date: Wed, 30 May 2012 10:24:33 -0700
Message-ID: <7vvcjdzini.fsf@alter.siamese.dyndns.org>
References: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v4nqy4wrz.fsf@alter.siamese.dyndns.org>
 <20120530130914.Horde.CK7IZHwdC4BPxf-ak9fkbPA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Wed May 30 19:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZmdV-0001Z8-5l
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab2E3RYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 13:24:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177Ab2E3RYg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 13:24:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B2B8FF2;
	Wed, 30 May 2012 13:24:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P9TE6cCq5uYZoZL8c3x0YNBC3o8=; b=Ax4l8q
	E8/c9ahXNO3yFqF7wCMzJtze0pD+WfSZ7OUee+PotYcdI7ZAmALuIHWG88u3H758
	zDm2oaKqakFjbXSbgyrYusGGwfxNPbHdNJeOIwbPZiIw0kj0t2nGhA0SUSx8EwYi
	0aFrt/ZRbWrERpyT+k3ZFNKYOSU3U1i0/C8lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J08uZsE6kZ6MpQrdZRhFfAzy0JV8kBx0
	OLkzvwcCPeP4lVi9GMu9kMDSGh+9hiv4a8Fb/8oAE5KixR5lodpwlNCJaDTto6VC
	6bp86/pW+Dn2l+MbO18RS2+mZFjRNM2IpktV+ERn8TkrtBUm6Ep8ePFwSzkCVhgb
	Lvt0Kj3YHA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D42B8FF1;
	Wed, 30 May 2012 13:24:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4999A8FF0; Wed, 30 May 2012
 13:24:35 -0400 (EDT)
In-Reply-To: <20120530130914.Horde.CK7IZHwdC4BPxf-ak9fkbPA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Wed, 30 May 2012 13:09:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 539ABD68-AA7C-11E1-9585-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198824>

konglu@minatec.inpg.fr writes:

>> It strikes me odd that this is not listed next to statusHints, and
>> it also makes me wonder if we even need to invent a new one, or it
>> is better to just make the output more verbose when statusHints is
>> not being declined.
>
> Yes, we first thought that we could use statusHints to protect the
> new messages warnings. But users that disabled statusHints and still
> wished to know what to do during am/rebase/bisect etc. won't be
> able to. On the other hand, if they want to hide the new advices, they
> can see in the doc the presence of the advice.statusHelp and disable it.

"When we have more more knobs, we can differentiate more cases" is
not a valid argument, unless you can successfully argue that it is
worth differentiating these subcases.  Otherwise it is just another
useless knob the user needs to tweak without real gain.

In this particular case, I think the new text is merely an extension
of existing help text.  Those who have already declined statusHints
should not be bothered by it, and those who are being helped by them
would benefit from the help text being more complete.

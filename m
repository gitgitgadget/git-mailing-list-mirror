From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff
 and Git
Date: Fri, 17 Feb 2012 05:31:26 -0800
Message-ID: <7vmx8hvb69.fsf@alter.siamese.dyndns.org>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
 <7v8vk2zghl.fsf@alter.siamese.dyndns.org> <vpqty2px4l5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 17 14:31:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyNuR-0004KL-16
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 14:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab2BQNbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 08:31:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab2BQNb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 08:31:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAC0842D1;
	Fri, 17 Feb 2012 08:31:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XAUn25+BrBRVLl/Qhw8Ykl1agSw=; b=Ps4XhG
	EZPl/vKlAt6BsvhALxhzpC1NRSw1aBUDCljLSg3RxftTWJf2HVGbE7NS2wlb3bTJ
	yockK4/motiP4ESEEQJPOdLBspXNuKqlIQ+OQ1mPXpGNLk7g4E7m2e+YUwZwA2Yi
	x2R7QgvL6s9J5xWGAHxSKeDInsOL6/fOpJLdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gip5tFxnd9wcbEqDC07DdpA+Je44xPYr
	gJw3CiTeUmBCpvlkzqfCywrdqDWYlSnMSRi5P3t0Q0lzw5CppFD2KKRlPpTjjCr4
	JyjgauFEn5JEkxeG6S3sef/jv3cSI2EqqT4TpRhPZf7G633KS/aw9SNkqaik55lp
	sGox+V1sVpU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E206F42D0;
	Fri, 17 Feb 2012 08:31:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76C3D42CF; Fri, 17 Feb 2012
 08:31:28 -0500 (EST)
In-Reply-To: <vpqty2px4l5.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 17 Feb 2012 09:10:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2439B3A-596B-11E1-8DE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190955>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I agree that the next step may be to allow users of <whatever SCM
> outside Git>, but I don't think the way to do that would be to make the
> script generic. The script is a quick hack, and all the "clever" parts
> of it are calls to Git.

You are not suggesting me to take and carry any future request that wants
to add any quick hack that is heavily specific to Git and not portable to
other SCMs to the contrib/ area only because they depend on Git, are you?

That would bloat the contrib/ area with stuff that do not belong there and
we need to draw a line somewhere.  The criteria I use to draw it is by
answering "is this an application that merely happens to use git, or is it
a way to help people who use Git?" question.

Look at what we have in the contrib/ area.  I think what is common among
them is that their primary benefit is to enrich user's Git experience.
Bash completion for example is dependent on bash and it may be useless for
Csh users, but if you are a bash user, your Git experience will be
infinitely better with it regardless of what kind of payload you are
tracking in your Git repository.  And in my mind, "regardless of what you
are tracking" is the key part that defines "the enhancement is about
user's Git experience".

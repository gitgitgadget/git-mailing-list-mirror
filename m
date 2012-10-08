From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch documentation problem or bug
Date: Mon, 08 Oct 2012 12:16:34 -0700
Message-ID: <7vfw5olqp9.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 21:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLIow-0007dv-DH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731Ab2JHTQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 15:16:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498Ab2JHTQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 15:16:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D93D869F;
	Mon,  8 Oct 2012 15:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AjFnxYxZTJR02Sqt8ZPwJ1x7vbk=; b=OepH3u
	5+9Qn0F8+WtUOfDkFU+FdEw52LSE5txDqrNeTWEk+lCGPSGcDKF4FL/GSlQIxptI
	lR4SisgAgMCm7SaXZeZGFXTlkerKpl9qqrztobFkrlpLFkOzAGjamD2UltVOGRRm
	mTUml3JcZNIVcVhWkSF3aGxl245WU+MxQkkPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSaPv0avo3w7P7uj2fJ101vC4myJcGsZ
	KjN5ZgsYxgQgIAL+RZ7cjKxm4xTKjHoJjY9BKTFEY3F+T3a0HQwk1DUB2SChXNrx
	15Zz+mfJvUAL3Ut+UszTA3KJVUCev8rmQLaZpJlO2h8/S3RLa/3ZtNNNpsKoxwiB
	/fKow0EApUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AE32869E;
	Mon,  8 Oct 2012 15:16:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25C3A8698; Mon,  8 Oct 2012
 15:16:37 -0400 (EDT)
In-Reply-To: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com> (Angelo
 Borsotti's message of "Mon, 8 Oct 2012 20:59:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE40A2CA-117C-11E2-879E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207260>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> git fetch <repository> <refspec> does not create the remote refs in
> the current (local)
> repository...
> However, if a git fetch origin is executed, the refs are properly created:

Working as designed and documented.

 $ git fetch origin master

is giving the refspec "master" from the command line which is a
short-hand for "refs/heads/master".

When you run

 $ git fetch origin

configured refspec is looked up from your config (because you didn't
give any from the command line).  The default refspec in your config
is likely to be "refs/heads/*:refs/remotes/origin/*".

The former, "refs/heads/master" refspec, tells Git not to update the
remote tracking branch.  The latter has colon and right-hand-side of
the colon tells Git what to update with what was fetched.

It would hlep to read up on refspec by running "git fetch --help"
and looking for a string "colon".

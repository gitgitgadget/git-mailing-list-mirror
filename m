From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Mon, 16 Jul 2012 12:03:40 -0700
Message-ID: <7vipdn1qb7.fsf@alter.siamese.dyndns.org>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqqaD-0001uW-EZ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851Ab2GPTDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:03:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133Ab2GPTDm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:03:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6966786C3;
	Mon, 16 Jul 2012 15:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o9eBJNf4yVSMlIsnS/7KLvzWn48=; b=JcR2tY
	bW/+zU267IlzOmhlGLati2MP2HlLFa6v1/1dERjCQpeMv3+AchyBpO+wP4Zzg5MV
	kisNrxh8LP0ZDaQEjw7GYhox7iM38fjaDBb4Bq1Eyg4APSr2ev0umIX2ydTpW5Ve
	zCrD78IfVyf4l9bZ2C7UWkoSLLnQGacyfzfu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qeU1cCGFiOCrSrx0L96ZjljqVsygBOIs
	DkAEiDDKQVKPAPE/obl/UpeT8pAA6jToiCLpJo20WiBTMy3K5ZiPgzn2wVC+20sX
	Scg2tL37eVyjbu5aaofrGZJdNt76Xz5lqIcek28xPEddu84ppB/J33J7QRtruU9j
	P1DYl0Eud1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55A8586C1;
	Mon, 16 Jul 2012 15:03:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B017286BD; Mon, 16 Jul 2012
 15:03:41 -0400 (EDT)
In-Reply-To: <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 (Jukka Lehtniemi's message of "Mon, 16 Jul 2012 21:30:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F55BFD76-CF78-11E1-9083-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201546>

Jukka Lehtniemi <jukka.lehtniemi@gmail.com> writes:

> Display notes in the rev-list when switch '--notes' is used.
> Also expand notes place holder (%N) in user format.
> Previously rev-list ignored both of these.
>
> Signed-off-by: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>
> ---
>
> Thanks for your feedback Peff!

If it is an update for some old patch (I am guessing that is the
case from "v2" and "feedback" above), please hint where the
original can be found not to waste reviewers' time.

As "git rev-list -h" does not say anything about "notes", I do not
think this should be even called "Fix"; rather it is "teach rev-list
to show notes with --notes", a new feature.

And as a new feature, "git rev-list -h" should be taught to include
this new option in its output.  I didn't check the documentation but
you may also want to add --notes there, too (hint: grep for "--pretty"
to find where you may need to add the new option).

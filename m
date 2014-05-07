From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 07 May 2014 10:07:29 -0700
Message-ID: <xmqqy4ydbjqm.fsf@gitster.dls.corp.google.com>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140505184441.GS9218@google.com>
	<110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
	<xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
	<87mweuss7d.fsf@fencepost.gnu.org> <vpqzjiuu4i5.fsf@anie.imag.fr>
	<20140506215516.GA30185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David Kastrup <dak@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	d9ba@mailtor.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 19:07:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi5Ji-0000Ve-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 19:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbaEGRHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 13:07:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53631 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbaEGRHe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 13:07:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D44BB16EC2;
	Wed,  7 May 2014 13:07:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4dRbNdpC2R15sJOFULs79bAWrzE=; b=UxSMpn
	CNLpM21uS73r8qm2JCDGl25duA97PFgArTQFzrZ7hitEwgju/701lSbHZOa2XIAq
	eWbL/I0AsjbttBtbgFOCweqa59prjHMWxF6QrO25n+9Esl6/TLnlg3XM/QsX8kyH
	a9+oIqGa8rPkdfZpDhIIDhf/GFPYeEHVJlkao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T5FFB1wjhCGmf4nSM40mU7GlkS/QVwwQ
	DAEZuEcx26WjJhxniduaaAOYYNQZRddbq6N19FXCDrI2FM3HI+e3pGeM1R7p99Sw
	q19BGGhQdsu4RCz+twohvWhAvEmPF64dbKtLNEq8zJ+YP0VByhnwDUec3V6Nx5fH
	Nyt/GbYsorY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7A4E16EC1;
	Wed,  7 May 2014 13:07:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B06016EBF;
	Wed,  7 May 2014 13:07:31 -0400 (EDT)
In-Reply-To: <20140506215516.GA30185@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 6 May 2014 17:55:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13635C44-D60A-11E3-B78E-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248332>

Jeff King <peff@peff.net> writes:

> On Tue, May 06, 2014 at 08:49:22PM +0200, Matthieu Moy wrote:
> ...
>> The idea of having a separate default value for pager.blame (or set
>> $LESS differently for blame) crossed my mind, but I actually don't like
>> it, as it would make it harder for a user to fine-tune his configuration
>> manually (one would have to cancel all the corner-cases that Git would
>> set by default).
>
> Agreed. We already get some confusion from users with "git has set $LESS
> for me".  Changing it to "git set up $LESS depending on which command is
> running" seems like it would cause more of the same.

While I fully agree with the above conclusion, I just noticed that I
will be irritated enough to eventually set pager.blame myself, after
running a short "git blame -L1311,+7 git-p4.py", which is one of the
standard first steps for me to start reading patches submit on the
list.

Even with line wrapping, the output fits on a single page, so "F"
(aka "--quit-if-one-screen") kicks in, before giving me a chance to
scroll horizontally around.

Not objecting to the conclusion of the discussion with a concrete
counterproposal.  Just hoping somebody clever enough might come up
with a good trick to make things easier to use and explain, which I
however suspect may be an incompatible pair of goals.

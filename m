From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Tue, 06 May 2014 10:34:24 -0700
Message-ID: <xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140505184441.GS9218@google.com>
	<110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Kastrup <dak@gnu.org>, d9ba@mailtor.net, peff@peff.net
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 06 21:41:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhjGE-0004KT-4j
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 19:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbaEFRea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 13:34:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52414 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbaEFRe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 13:34:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7D4114936;
	Tue,  6 May 2014 13:34:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5pazj+6hqKsf6HgZamFIBLb8jMY=; b=yFtDmn
	CPcODjPuPxTsPspPmNx0h3jFTQUuTMJ9020W9vrr47insrbSHIkP6l7KII1WWSnR
	on8jiqh2Xuyv3Fj6AeLd/q9BMqkNgxrewn1BcBKCor/+OG8m9G/RwOke2lr1qWIb
	z+u03ooVOwQATrlJPFFWfm46fm5H3QjCKfRIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qbJwGLesZYLxwse5AQv9ygC7K+5lVJS4
	4H4vChtVM2rOIS079ZVw6l8Q7fVVPoXmiAZvFKYLcLsvjxjpfXuAIHH2Y3880efS
	H5ijkg1DuwEQrgQ6eEgjpAXHJky+Ijnp/Zcqc41ijEvni6AIxm9GoVhy/g2asMGr
	df6HrFUjYU8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEBBF14935;
	Tue,  6 May 2014 13:34:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6898F14934;
	Tue,  6 May 2014 13:34:26 -0400 (EDT)
In-Reply-To: <110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
	(Matthieu Moy's message of "Mon, 5 May 2014 22:10:54 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AB953F76-D544-11E3-8310-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248223>

Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:

>> > By default, Git used to set $LESS to -FRSX if $LESS was not set by the
>> > user. The FRX flags actually make sense for Git (F and X because Git
>> > sometimes pipes short output to less, and R because Git pipes colored
>> > output). The S flag (chop long lines), on the other hand, is not related
>> > to Git and is a matter of user preference. Git should not decide for the
>> > user to change LESS's default.
>> 
>> Thanks!  Sounds like a very good change.
>> 
>> (Nit: instead of "because Git sometimes pipes short output to less",
>> it would be clearer to say something like "when Git pipes short output
>> to less it is nice to exit and let the user type their next command".)
>
> It's actually a bit more than this: X to avoid initializing the terminal
> and F for the exit behavior you describe.
>
> But since the change is actually not about F and X, I prefered keeping
> the text about them as short as possible, so I prefer my version actually.

True.

As some of you might know, the version I use for my regular work is
slightly ahead of 'next' (you can see where it is by running "git
log --oneline --first-parent master..pu" and find the first entry
marked as "Merge ... into jch").  After having this patch for a few
days in there and using it, I have to say that I like this change a
lot while viewing the "git log -p" output.

I still find the output from "git blame" disturbing, though.  The
first thing I do in "git blame" output is to scroll to the right in
order to identify the the area I am interested in, and this first
step is not negatively affected, because the right scrolled output 
automatically wraps long lines.

But my second step is to scroll back to the left edge to find the
commit object name and at that point, the new default output without
"S" gets somewhat annoying, because most of the output lines from
"git blame" are longer than my window width.

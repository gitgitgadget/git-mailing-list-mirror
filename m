From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: make annotate configurable
Date: Wed, 11 Apr 2012 08:46:34 -0700
Message-ID: <7v62d6nued.fsf@alter.siamese.dyndns.org>
References: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
 <7vy5q8xhkb.fsf@alter.siamese.dyndns.org> <vpqaa2n7rvd.fsf@bauges.imag.fr>
 <7vwr5owzgz.fsf@alter.siamese.dyndns.org>
 <7vlim4vfk7.fsf@alter.siamese.dyndns.org> <vpqaa2i61ty.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Adam Roben" <aroben@apple.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 11 17:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzl0-0003yq-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759052Ab2DKPqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:46:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab2DKPqh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:46:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2D917123;
	Wed, 11 Apr 2012 11:46:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kHl5jtA7sIuz/js9CZwRMn1HQac=; b=Y3kIBv
	XH6zS/U0Uyo/6pnDrWBLY0BARi6mM2l8PxvjT4hIlunGcB8917ITGHtatCARlvsJ
	6rot8jojnttEjOxGCOqR1ZqLMstgYD2Wmax79tLQk1nyF4ERsPwJAW4tIA2CfIjF
	WYYVQo6HtyOYxtdEUIs6dRBLesyqfTUQWKMPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eclel3+oFgU6mh4vNdfKamL2DQeAbemJ
	dcAv7sYSxc35jvSNN+wcH40brwGRs87POnCjzhMonEM7oWRxOXgRXwX1ppZ7OARt
	DdA6hR6fc+HbJRtjS41GoKELb6huXw32g00XxF93cTFlfIQAlg6bO8o1i8nTc38J
	Zufwsz6ZNq8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A807F7122;
	Wed, 11 Apr 2012 11:46:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D028B7120; Wed, 11 Apr 2012
 11:46:35 -0400 (EDT)
In-Reply-To: <vpqaa2i61ty.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed, 11 Apr 2012 11:43:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84F3E3E0-83ED-11E1-92A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195192>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I do not doubt the usefulness of it, but if there is no --no-annotate, it
>>> would make the new variable unusable for those who would never run it
>>> without --annotate option
>>
>> Sorry; I meant to say "for those who mostly but not always run it with
>> the --annotate option".
>
> Actually, I guess you also meant "and who sometimes use older versions
> of Git", since the --no-annotate is there for people who always use the
> new version.

Not really.  I didn't even have that in mind, and I agree with below.

> I don't think we can do anything for it. Any patch that introduces a new
> command-line option has the same issue. The only solution is on the user
> side: use only features that work for all versions of Git you use. In
> this case, it means "wait for all your machines to upgrade Git before
> setting sendemail.annotate".

And for that to work well, it is most sensible for the version that
introduces the configuration variable to make sure that the --no-annotate
command line override also is there, as the override becomes even more
necessary because of the configuration variable.

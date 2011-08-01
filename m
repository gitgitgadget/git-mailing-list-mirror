From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] grep: add option to show whole function as
 context
Date: Mon, 01 Aug 2011 16:17:22 -0700
Message-ID: <7vei14hgcd.fsf@alter.siamese.dyndns.org>
References: <4E357BE2.8030409@lsrfire.ath.cx>
 <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com>
 <4E36C840.9000808@lsrfire.ath.cx>
 <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com>
 <4E36E075.20603@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 02 01:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo1jm-0006Nj-5a
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 01:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1HAXR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 19:17:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab1HAXRZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 19:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3EE2581;
	Mon,  1 Aug 2011 19:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0Iu7n+WhB09K
	MCITg0McGR0Yoao=; b=sgIkr57/EjygqRFii5XKC9VzWV4CdsJQefD6vsKqaSG9
	a/P4ykepbJHowpBJ8s2Iwt6fXRN+zPXeXcLNMNk2k5YOC7Z2+VQhCaxq9F6j3M7H
	dIMAPGGQjP9wkkXRIxDUtnRvxICeS9KPVVsIBHhm4Z2wA8SiCAOmXyTqjA8/qwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wf4zUH
	BKig/JLxHkgdC0TIu61pnsPvkule2nzPbbT4ug1xwmOQI6JNSgu/+PxdP+3TCUIo
	+tH9yQI3cV0euc2BTQR2u5F6ExZwdnmJwvBPdfaJNkXdadZbzCAoTJW37I5vPFdE
	8zsh+S5dtlDYzys40TbI49FhV5Ola/VJLXUA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81E892580;
	Mon,  1 Aug 2011 19:17:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7A6F257F; Mon,  1 Aug 2011
 19:17:23 -0400 (EDT)
In-Reply-To: <4E36E075.20603@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 01 Aug 2011 19:20:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69EF754E-BC94-11E0-B873-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178426>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Add a new option, -W, to show the whole surrounding function of a mat=
ch.

Thanks, will queue both patches.

It feels somewhat dirty to take the range between the previous "funcnam=
e"
and the next "funcname" and consider it the whole function, as if there=
 is
nothing outside the function, though. I certainly understand that this =
is
a natural and unfortunate consequence that "funcname" is a mechanism
designed to mark only the _beginning_, and we didn't have any need for =
a
mechanism to mark the _end_.

I am not complaining; just making an observation.  I do not offhand hav=
e a
suggestion for improving this, and I think the obvious "then let's come=
 up
with another configuration to mark the end" is not an improvement but
making things worse, so...

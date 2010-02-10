From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-archive documentation: .gitattributes must be
 committed
Date: Wed, 10 Feb 2010 11:27:50 -0800
Message-ID: <7v1vgsao21.fsf@alter.siamese.dyndns.org>
References: <1265770284-14830-1-git-send-email-fmarier@gmail.com>
 <4B7303FC.6070701@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francois Marier <fmarier@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIEP-0007f5-Re
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995Ab0BJT2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 14:28:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0BJT17 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 14:27:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C5F7B98BBC;
	Wed, 10 Feb 2010 14:27:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/PVDK1YpBveR
	C7gnMyltL6AjURo=; b=mxiZTAos3jOQYZBdNc5x/it3Qvu8UJohxrb5CFWWbj7s
	CALiNbhh/nOvmHHWNpQ35Z+C5tno3+LWebrulmyhy8qI/g9RphpY99LzX23bKmd1
	rGS43uY/jUPcoJNt+uUrtFPMUgsY64YB9Y8S6tTcyq7SQSYt+e+FkCpkyLEl2Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c4PJJf
	gXcYW+OzEEzDzfyOCg8Yzn32TrUEjnIuTjrHS3ZsEr9w2VEKBliiawQs8wpq/A5/
	R59F6PRK7i9ot/MEEUHfFNapDzSdb7agt7tKIELFd3kb1gMAnlNmMMDPqRR0UL2w
	XgE4j2GldzKsETN45CpOhckegXHMtz5j5hHjk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DEF798BB5;
	Wed, 10 Feb 2010 14:27:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA35598BAA; Wed, 10 Feb
 2010 14:27:51 -0500 (EST)
In-Reply-To: <4B7303FC.6070701@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed\, 10 Feb 2010 20\:07\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 637ECD0C-167A-11DF-917E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139535>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> +The .gitattributes file must be present in the named tree for it to=
 take
>> +effect. Uncommitted attributes will not be considered in exports.
>> +
>>  EXAMPLES
>>  --------
>>  git archive --format=3Dtar --prefix=3Djunk/ HEAD | (cd /var/tmp/ &&=
 tar xf -)::
>
> Yeah, the description of --worktree-attributes is a bit terse.  The
> lines you add make it appear almost as if this switch doesn't exist,
> though; perhaps add a "unless --worktree-attributes is given" or simi=
lar
> to one of the new sentences?

My impression has always been that people use attributes with archive m=
ore
often to _tweak_ how the archive is produced after the fact, and they d=
o
so by modifying checked out .gitattributes (or $GIT_DIR/info/attributes=
)
than allowing a possibly stale .gitattributes file etched in stone^Wtre=
e
being archived.  So in that sense, probably --worktree-attributes shoul=
d
have been the default.

By the way, if you commit the attributes file, then commit the removal =
of
that attributes file, would that removed attributes file take effect wh=
en
you archive HEAD^ (which still had the attribues file)?  That's how I r=
ead
what the added description claims, but I somehow suspect that is not wh=
at
actually happens.

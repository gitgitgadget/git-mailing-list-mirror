From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Include unistd.h.
Date: Wed, 25 May 2011 14:00:25 -0700
Message-ID: <7vvcwy1onq.fsf@alter.siamese.dyndns.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-3-git-send-email-mduft@gentoo.org>
 <7vd3j64oq6.fsf@alter.siamese.dyndns.org>
 <BANLkTim4gPAyA9vLnpBz7qRY+b4RQ7LwNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mduft@gentoo.org, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed May 25 23:00:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPLC5-0001zN-Ll
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 23:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab1EYVAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 17:00:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1EYVAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 17:00:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18A125655;
	Wed, 25 May 2011 17:02:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GN33l/DRm+0a
	/h5sJPKYCvTau4s=; b=n3Gq/aR07t2CT8u5ZY2o02nn81iXBXTmH+g3/GcTndUg
	EhSpKfLD5H9HqqyvIUOUi/EC0lsb2X7Z35/TLo5xvhiX5ZpZL2PDDgcmUxtM8dLN
	DGtE+XXdGX59L602Wa29C1KtwyaGkJJussZvX/7w0eOaNoVvNumH0uf/p8/18WE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ut5S1D
	0hukKuAabDV+99lIlkhnCz9mNlO4NFfEaHIvOgZDzmrVCS3TcwVVwzgXjtzisxtK
	HOTwRPvqiM2s5/TiDyAqgPieQzPj9PGbPSnoXYBvgKO+XiqMofPbJZHupFWFkCZ/
	dNu/MjMFRwu/iTA25dmDvxBSmPVySOROzrRxU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8F865653;
	Wed, 25 May 2011 17:02:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A1A6F5652; Wed, 25 May 2011
 17:02:34 -0400 (EDT)
In-Reply-To: <BANLkTim4gPAyA9vLnpBz7qRY+b4RQ7LwNw@mail.gmail.com> (Tor
 Arntsen's message of "Wed, 25 May 2011 22:37:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52B75C00-8712-11E0-A2AB-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174463>

Tor Arntsen <tor@spacetec.no> writes:

> On Wed, May 25, 2011 at 20:30, Junio C Hamano <gitster@pobox.com> wro=
te:
> ...
>> The header stddef.h is where NULL is supposed to be defined, and com=
monly
>> used headers are supposed to define NULL the same way as stddef.h do=
es.
>> There is a conditional inclusion of stdlib.h in fnmatch.c and stdlib=
=2Eh is
>> one of those files; probably that is how the upstream pulls in NULL =
when
>> compiling this.
>
> According to POSIX (well, IEEE Std 1003.1, 2004 Edition at least)
> unistd.h must define NULL:

Yes, unistd.h is also one of the common header files just like stdlib.h=
 and
stdio.h that are required to define NULL the same way as stddef.h does.

Cf.
    http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/unistd.h.h=
tml

>> Other platforms (e.g. SunOS, IRIX, HPUX, Windows) use NO_FNMATCH_CAS=
EFOLD
>> and compile this file. =C2=A0How are they getting their NULLs?
>
> IRIX defines NULL in ...
> ... presumably it's in some compiler-provided place.

Yes, but that still does not explain where compat/fnmatch/fnmatch.c get=
s
its NULL from.

> #ifndef NULL
> #define NULL 0 /* or sometimes 0L */
> #endif

You probably would want to say "(void *) 0" if you quote POSIX in the s=
ame
message ;-).

Cf.
    http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/stddef.h.h=
tml

To recap my original question that is not unanswered, the current codeb=
ase
does not include unistd.h nor stddef.h when compiling the compatibility
fnmatch.c source we borrowed from glibc, but nobody seems to have
complained that it does not compile due to the lack of NULL, so they mu=
st
be getting their NULL from somewhere already, but I couldn't find where=
=2E
That is what I was wondering.

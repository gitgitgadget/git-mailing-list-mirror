From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Wed, 07 Mar 2012 13:59:46 -0800
Message-ID: <7vzkbskr71.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <4F57D18B.5090506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:59:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Otp-0005UN-BL
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 22:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230Ab2CGV7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 16:59:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab2CGV7s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 16:59:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB6F7095;
	Wed,  7 Mar 2012 16:59:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=81axE7ByTy8C
	6Mmi6Oy5prDdnC4=; b=bHyWLg27eouMTqT1OieB3DvmNHdGzSIsagr/+pk+lURD
	LKD1kjRBTwu7maONLSaE4cGYqoTMNnzvvF1eMgP1MjBOdrFHoM8KIcKtyVKeDDpa
	4JrPFC7kCifVKnPk4P1bXqlReylEzK/t4d0mUwdOSKkDG5+JVjOu6mjQ13OCrSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lkpzuO
	mEmPVnXdv6zvOetNnzDiR62j9ameC5l7Cj0teo6Jb7pZXIXZ08Kyz0DOpBvhHdKo
	mgVqyBpTI9RjrFRih3xn72cvcPWcuoRHLf+o3ryk2D3oeTSs0tNUo7Xh2G8IyjdR
	W4ZhKD8q+/x4aeFvhchuxaQ1P6aoMz6ShPZp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07AFC7094;
	Wed,  7 Mar 2012 16:59:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90FAC7093; Wed,  7 Mar 2012
 16:59:47 -0500 (EST)
In-Reply-To: <4F57D18B.5090506@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 07 Mar 2012 22:22:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAFF45BC-68A0-11E1-B0A1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192488>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 05.03.2012 22:34, schrieb Junio C Hamano:
>
>> +#define util_as_int(elem) ((intptr_t)((elem)->util))
>
> Something that actually returns an int would fit the name better. ;)

The particular type would not matter to the callers of the helper
macro, would it?

>> +static int committer_is_me(const char *name)
>> +{
>> +	int namelen =3D strlen(name);
>> +	const char *me =3D git_committer_info(IDENT_NO_DATE);
>> +	return (me && !memcmp(me, name, namelen) &&
>> +		!memcmp(me + namelen, " <", 2));
>> +}
>
> This looks scary due to the missing length check of me before the
> memcmp() call, but is actually safe because git_committer_info()
> returns a pointer to a static buffer that is just as long as name can
> possibly be.  Still, perhaps this is nicer instead:
>
> 	const char *me =3D git_committer_info(IDENT_NO_DATE);
> 	const char *rest =3D skip_prefix(me, name);
> 	return rest && skip_prefix(rest, " <");

Probably.  Let me fix it up.

Thanks.

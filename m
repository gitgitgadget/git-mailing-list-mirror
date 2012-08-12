From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive --format zip utf-8 issues
Date: Sat, 11 Aug 2012 21:08:03 -0700
Message-ID: <7vlihkhhwc.fsf@alter.siamese.dyndns.org>
References: <502583F4.8030308@tu-clausthal.de>
 <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <50259EEC.2020701@tu-clausthal.de>
 <5026C651.8050705@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Aug 12 06:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0PTM-0007HA-GO
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 06:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778Ab2HLEIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Aug 2012 00:08:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab2HLEII convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2012 00:08:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B08EE8C7E;
	Sun, 12 Aug 2012 00:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C9rvm/tB21ci
	s0nybr9G5YWWaUg=; b=teAmVkRI1qSFCUNzwq9mJ3lcg/swATzS+vsFAhWLuA9k
	5dk+IrOmXpFLl5Z0CIOdFotM5FqUQkQYMP/unSZlVP3K6ayDlOOkozHZu9I2cIbS
	F4Yz2UVw8ev3fzcZEw4grEuczEFbTPSZimELKrXxhfDaoZ1KJJkXBd7qdcQhoyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qb7xBc
	vs1DB+G7e0tB2hKjesVVr3T6hAaUL4MgNQQ5gCriQ/c5s+eyzTwMb7Rj4Sq/20jd
	3xz07x9B6cx2FbLqbyaBVyNkOAqYSDDNXVyCRm4F8JHdAJ//pK/LbUS1+8475caW
	zUHYzJq+mm4qdlFWUbQsep+0lC6MMk4dimPeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC1D8C7D;
	Sun, 12 Aug 2012 00:08:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AA688C7C; Sun, 12 Aug 2012
 00:08:04 -0400 (EDT)
In-Reply-To: <5026C651.8050705@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 11 Aug 2012 22:53:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50F4F2AE-E433-11E1-BBDA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203300>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> PKZIP APPNOTE seems to be the zip standard and it specifies a utf-8
>> flag: http://www.pkware.com/documents/casestudies/APPNOTE.TXT
>>> A.  Local file header:
>>> general purpose bit flag: (2 bytes)
>>> Bit 11: Language encoding flag (EFS).  If this bit is
>>> set, the filename and comment fields for this file
>>> must be encoded using UTF-8. (see APPENDIX D)
>
> Yes, that's one of the two methods for supporting UTF-8 filenames
> described there.
>
> The other method involves writing extra ZIP header fields and was
> invented by Info-ZIP. They don't use it consistently anymore, though
> (from zip -h2):
>
>  "Zip now stores UTF-8 in entry path and comment fields on systems
>   where UTF-8 char set is default, such as most modern Unix, and
>   and on other systems in new extra fields with escaped versions in
>   entry path and comment fields for backward compatibility."

Thanks; so if we adopt one of these methods, the readers that matter
will be happy?  And if so, which one?  Or both?

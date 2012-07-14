From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sat, 14 Jul 2012 13:17:29 -0700
Message-ID: <7vzk725c86.fsf@alter.siamese.dyndns.org>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
 <loom.20120714T114718-783@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Zeeshan Ali \(Khattak\)" <zeeshanak@gnome.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq8mh-0006rH-Tt
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab2GNURd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jul 2012 16:17:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56668 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583Ab2GNURc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2012 16:17:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A1BC6DA1;
	Sat, 14 Jul 2012 16:17:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8rTokf3lXJyw
	kVUM6/SQf/aR87k=; b=HGlSWCXWRQzuPhd2c0hdp7BwKMMCCLThHPTMQysegMAS
	/hyvmQExZZ8HJ1m1mjDmLLBI0yGaptABKW+1EqLt16l3wHzVl4eCaeZAfYIplps6
	6OtxlYbufzI7mjGOhilJP6KM5BR8Z7y2gG03v0vFPYws2R8cn82PZb25bak8gOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HOthOk
	Wcmo6Lz8/UGy9czrCrJm4aK5G0KkvBFq7mHkLSyc0xqccSypaGZiUy7S3Y/nT/2e
	mREbntWSoYxtuU2bHAulewmk6lwkj0u72lL6ZMF7PAC0GYd690IEct/Mh6i7q8/Q
	Z6AxCNJ+0qURzpgVEXYtRIzCKD3OHahzHF8GQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 873B26D9F;
	Sat, 14 Jul 2012 16:17:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07A7A6D9C; Sat, 14 Jul 2012
 16:17:30 -0400 (EDT)
In-Reply-To: <loom.20120714T114718-783@post.gmane.org> ("Stefan
 =?utf-8?Q?N=C3=A4we=22's?= message of "Sat, 14 Jul 2012 09:48:31 +0000
 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F09B860A-CDF0-11E1-8170-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201452>

Stefan N=C3=A4we <stefan.naewe@gmail.com> writes:

> Zeeshan Ali (Khattak <zeeshanak <at> gnome.org> writes:
>>=20
>> Many times I want to refer to 'HEAD^', 'HEAD^^' and sometimes even
>> further up the tree. It would be really nice if I didn't have to typ=
e
>> 'HEAD^' but could only type '^'. Bash completion make things easier
>> but it automatically inserts a space immediately after HEAD so you
>> have to hit backspace. I think this change would be good in general
>> anyway.
>
> Or even '~1', '~3'.

"^" has a problem when used with other things (does "log ^^2
origin" mean "log HEAD^2..origin"?  Or "log HEAD^^2 origin"), so I
do not think it would never fly as an abbreviated syntax.

While I see your "~<N>" much distasteful compared to "^", you still
need to be a bit more careful when analysing the benefit of such an
abbreviation.  To shells used by many people, these mean tilde
expansion ~<N> to refer to elements on the dirstack and you need to
quote, perhaps like \~3.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 18:04:58 -0700
Message-ID: <7vy5zej611.fsf@alter.siamese.dyndns.org>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
 <CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
 <4E350F15.9050009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	mike@nahas.com, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:05:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QngwN-0000LC-J4
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 03:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab1HABFC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 21:05:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059Ab1HABFA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 21:05:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3038D46F6;
	Sun, 31 Jul 2011 21:05:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RfNHIb0NFDSC
	3vg935miCSzmssY=; b=xN3PcGTjMwwPlV0N6xv8z4x38zPtgd18UhdopsiUXK3h
	TqiYNzv4Z2nbi6oCyvPQZERB+Vg3Q+QdYPsAyBWhamJY9szY6exF9D4ILEGvICfP
	Iqh5EXZEnqrV2fgSBrA9TH3RIpe4wuKFZloAeEL8k0ldaUf6XQsDbWvdAyzGGgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JM/WvN
	yrFBIsqE7yEujW7eSOCFBa/ndYYeD4IjtwZS/c9uLh6j06t1n+DESLFneWV4waOq
	6N49/6MFxXOTSy/raUZM5tU9aGUVtAxHKCHpWRzxh6iAAsIoH/LNUIGjcgXJmtDs
	jW0m08pOzVbxZmtxQchb7/OuNhkZ49JPQdJ00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2758946F5;
	Sun, 31 Jul 2011 21:05:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA1A746F4; Sun, 31 Jul 2011
 21:04:59 -0400 (EDT)
In-Reply-To: <4E350F15.9050009@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun, 31 Jul 2011 10:15:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4772A870-BBDA-11E0-9E3B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178290>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 30.07.2011 21:06, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Sat, Jul 30, 2011 at 16:29, Michael Nahas <mike.nahas@gmail.com> =
wrote:
>>>     "git xargs <commit> ..."  (Is this possible?)
>>=20
>> I don't have comments on the rest of your proposal, but I've often
>> wanted a git-find(1) similar to git-grep(1). Which would give you th=
is
>> functionality.
>>=20
>> Then you could simply:
>>=20
>>     git find <commit> <path> -type f | xargs <whatever>
>>=20
>> Or something like that.
>
> How about this, which should match your example:
>
> 	git ls-tree -r --name-only <commit> <path> | xargs <whatever>

I don't get what this thread wants to achieve quite yet.

The devil is in <whatever> part. What would it do, given only the seque=
nce
of pathnames and object names but not data?  Invoke low-level git comma=
nds
on them?

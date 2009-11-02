From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit -c/-C/--amend: acquire authorship and restamp
 time  with --claim
Date: Sun, 01 Nov 2009 16:47:07 -0800
Message-ID: <7vbpjlycqc.fsf@alter.siamese.dyndns.org>
References: <1257099580-7365-1-git-send-email-erick.mattos@gmail.com>
 <1257101127-8196-1-git-send-email-erick.mattos@gmail.com>
 <7vr5sixbd1.fsf@alter.siamese.dyndns.org>
 <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 01:47:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4l4r-0001LO-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 01:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbZKBArL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2009 19:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbZKBArK
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 19:47:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43422 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbZKBArJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Nov 2009 19:47:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CCE67070B;
	Sun,  1 Nov 2009 19:47:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NKEaP9OMO0v0
	upSEnUnbYNZoVoM=; b=kI7d+yI2aOKdgSJPPg8eyhDv+zlXjOuyJErX+/yrqfiQ
	iwMIwEJxM5pkRi9Av2R/WukuNSkS5lyZMrbwKeM7VXQpzgZGiDKiVZtF0vBDpBah
	0ny37jchfz6hhdOhYnowQiX5rjI5dwlFH2/3npgndl5qLI892a/NldL+trkU+ro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SW58OU
	5q9wa1BnPafAOXGzNRa6F1RpQqO9+K8FCiYPgeZH2W0XuV1/iZIWuYBCm9QlUZe2
	qX3+gCkIUw+MaIc8/KQfAVt6g/OPCMjBe82jQ4RV67Dt2QuYjx6llCmpazwTNipv
	fZVAoiESIAPFNGfyZeDooO6Hs1eJUehtYAZ7s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E21DC7070A;
	Sun,  1 Nov 2009 19:47:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3489F70709; Sun,  1 Nov
 2009 19:47:09 -0500 (EST)
In-Reply-To: <55bacdd30911011257m22ee85f2wc5d51865f7f2aadd@mail.gmail.com>
 (Erick Mattos's message of "Sun\, 1 Nov 2009 18\:57\:37 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41D1DB5C-C749-11DE-A022-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131887>

Erick Mattos <erick.mattos@gmail.com> writes:

>> =C2=A0 =C2=A0% git commit --claim --author=3D'Erick Mattos <eric@mat=
tos>' -C HEAD
>>
>> Should you detect an error? =C2=A0Does your code do so? =C2=A0Do you=
 have a test
>> that catches this error?
>
> It works as intended.  Both together.

That does not make any sense.  If you are saying this is yours and it i=
s
his at the same time, there can be no sane way to work "as intended", n=
o?.

>>> + =C2=A0 =C2=A0 git commit -c HEAD <<EOF
>>> + =C2=A0 =C2=A0 "Changed"
>>> + =C2=A0 =C2=A0 EOF &&
>>
>> What editor is reading this "Changed"?
>
> Nobody cares...  Just a text to change the file.

I actually care.  Who uses that Changed string, and where does it end u=
p
with?  At the end of the log message?  At the beginning?  What "file"?

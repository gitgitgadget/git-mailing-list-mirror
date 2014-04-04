From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/10] log: --function-name pickaxe
Date: Fri, 04 Apr 2014 11:46:31 -0700
Message-ID: <xmqqlhvlorug.fsf@gitster.dls.corp.google.com>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
	<62ab0f9c34eabe020ae99c7c1f69d580d9bb36d8.1395942768.git.davidad@alum.mit.edu>
	<533DD1B1.3000107@web.de>
	<xmqqwqf6ozp3.fsf@gitster.dls.corp.google.com>
	<533E9465.8070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"David A. Dalrymple \(and Bhushan G. Lodha\)" <dad-bgl@mit.edu>,
	git@vger.kernel.org, peff@peff.net,
	"David Dalrymple \(on zayin\)" <davidad@alum.mit.edu>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 20:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW98W-0001tE-FG
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 20:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbaDDSqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Apr 2014 14:46:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbaDDSqf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Apr 2014 14:46:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC23C79436;
	Fri,  4 Apr 2014 14:46:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wD+7UaAUy8mk
	zVkeH+eejD5gVUI=; b=Kb0hpf1Xe8vBMl2LftyJbqHDBTWXHABpTGuh6nqGMs5d
	IT+IF4VefuoBTGTwl6Ai2q9FrO3SceUymqsBfzMIPheWK4KfYbnSjJz0OosuOJU9
	yexJV+XOlgGJRUFJOX4WSKCZ/6g9iRrMf7EZEnGNn982Vr6vutWoC/V0/QVR/5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=k6U0pm
	Z/tcq7H83LiTZRstJv2IZDbnuIVm2BBVE9+msNFH+6eJEtEHGECQnKtOCTZ+XGqq
	0e8EgP0AJDzuKnLND+e3mcxnOXpf277+JlSVSWCmRX1Q5gYKZ8hg5sBbyz7F8SCK
	XMszKAIJTzTRKxVIhgaPQXa5z8Sy5YCcMm6Q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99FB179435;
	Fri,  4 Apr 2014 14:46:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 835247942E;
	Fri,  4 Apr 2014 14:46:33 -0400 (EDT)
In-Reply-To: <533E9465.8070609@gmail.com> ("Jakub =?utf-8?Q?Nar=C4=99bski?=
 =?utf-8?Q?=22's?= message of "Fri,
	04 Apr 2014 13:15:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 718FE940-BC29-11E3-80B6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245769>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 2014-04-03 23:44, Junio C Hamano pisze:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> With that approach you depend on the hunk header and apparently nee=
d
>>> to add XDL_EMIT_MOREFUNCNAMES and XDL_EMIT_MOREHUNKHEADS to improve
>>> the results.  This approach feels fragile.
>>>
>>> Would it perhaps be more robust to not base the implementation on d=
iff
>>> and instead to scan the raw file contents?
>>
>> That is an interesting idea.
>>
>> Perhaps this can be implemented as a new stage in the transformation
>> pipeline, I wonder?  There is currently no transformation that
>> modifies the blob contents being compared, but I do not think there
>> is anything fundamental that prevents one from being written.  The
>> new "limit to this function body" transformation would perhaps sit
>> before the diffcore-rename and would transform all the blobs to
>> empty, except for the part that is the body of the function the user
>> is interested in.
>
> Well, there is 'texconv', e.g.
>
>   .gitattributes
>   *.jpg diff=3Djpg
>
>   .git/config
>   [diff "jpg"]
>          textconv =3D exif

;-)  So you could define this textconv

    sed -n -e '/^int main(/,/^}/p'

to limit the output only to the definition of the function main().

> Doesn't it fit in said place in the transformation pipeline?

Not at all, unfortunately.  The textconv conversion happens in the
final output stage and comes way too late to influence the earlier
stages like renames and pickaxe, which will still see the whole
contents outside the definition of the function main().

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/11] connect: use "-l user" instead of "user@" on ssh command line
Date: Tue, 03 May 2016 10:50:50 -0700
Message-ID: <xmqqk2jbni85.fsf@gitster.mtv.corp.google.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462265452-32360-1-git-send-email-mh@glandium.org>
	<1462265452-32360-10-git-send-email-mh@glandium.org>
	<8f470378-07a9-525b-ff8b-f0de011019cb@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 19:51:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axeTa-0004V2-An
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 19:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934363AbcECRu7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 13:50:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933825AbcECRu5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 13:50:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A97219844;
	Tue,  3 May 2016 13:50:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=04cmoW5HRQdy
	jcJmYkGna/Nfzkk=; b=xPJUtJE14zVfY/BlvhweNRi7sfVQWHD7v4HzzMGymU57
	9m/4z+l/AQ8ExITOLQ5MUJ+S3A3ZoKD5TEh+a4Erfm3CsV3+kWZsb8JnFduWh210
	rfh3L2o8bd95SehL3+PVHTgI+pEi7AZqk+VwJdSUyHgbP2qSbJSxHLWgmcloiyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qog42/
	oiiVtfJAkRmYr0weWY8GiO6IzGS/9TjZ8uD+teQz6mmI4gESLg9paOe9HEGJ27km
	LDirxlYfrQmeVwUnkcq+vePOWTkwEV1kq9+v61T+nrqdFVuJ25/2O43aEXdGABT5
	qpeltFSUyNtIkgC6J0vnnqLwBXhfTgbE7tdP4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0194519843;
	Tue,  3 May 2016 13:50:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6978719841;
	Tue,  3 May 2016 13:50:53 -0400 (EDT)
In-Reply-To: <8f470378-07a9-525b-ff8b-f0de011019cb@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 3 May 2016 18:25:05
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 949BCB18-1157-11E6-8103-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293422>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2016-05-03 10.50, Mike Hommey wrote:
>> While it is not strictly necessary, it makes the connect code simple=
r
>> when there is user.
>>=20
>
> That commit message does't tell too much, I think.

"Doesn't tell too much" is not necessarily bad, but "tells too
little" is, and I think this tells me enough to say it is not a good
change ;-)

> Besides that, I'm sure it will break (at least) my ssh wrapper script=
s,
> which rely on user@host to be passed into the script.

Thanks for bringing it up.  "By reducing the language we accept it
makes my coding simpler" is not a good excuse to break existing
users, and "While it is not strictly necessary, " is a good hint
that the author _knows_ that the change can either (1) be done
without, or (2) be done in a way that does not break existing users
and yet make the end result easier to read.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] i18n.pathencoding
Date: Tue, 04 Sep 2012 13:12:50 -0700
Message-ID: <7vy5kp8s3h.fsf@alter.siamese.dyndns.org>
References: <201209010811.33994.tboegi@web.de>
 <CACsJy8A1GnhTeMzwXwA1C96pp0ERskxZC=SO+QE2__pfwmChow@mail.gmail.com>
 <7vvcftbt8o.fsf@alter.siamese.dyndns.org> <50465BBC.30203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8zUd-000068-BX
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 22:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab2IDUM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 16:12:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356Ab2IDUMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 16:12:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFBEA90BF;
	Tue,  4 Sep 2012 16:12:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mb3lUKRK0xTE
	YYBZDfwUwTt/CXk=; b=tJUBd0Oy2mYAjsvxOAO/Gs9umWwnTiXg/LOuJ+vGoG5w
	2RpAEJr3DDjiFOHfHoJxijuC0mUBv3nl9TPtmJggsEI6jMts5ONZJ38qVLaOTMVV
	nCIEd+wSCA6OxJpM645AxeNZf2BRogAP+TYMEYSKy7zjGDr1CdJXRMEUmsC0xtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SysUdV
	/2FOp3rDYuO4ZqqEH8thjgWi5VP/e2CFuwyJqdzLTyZbkcSnudk3YTz3d4Hh/7zh
	rLJiSOKylsuB4WiYGpfBzHzZMdqMLUscY3AOqDc+csHDDD9f1DmMnJ5HXgDGzAcW
	h9Hm+rMNSgVhEWLQsohNdXha4hdjwENvW48LM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD5490BE;
	Tue,  4 Sep 2012 16:12:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89D0190BA; Tue,  4 Sep 2012
 16:12:51 -0400 (EDT)
In-Reply-To: <50465BBC.30203@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Tue, 04 Sep 2012 21:51:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7833D42-F6CC-11E1-A7B8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204781>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> This leads to 2 questions:
> a) Do we want the reencode feature in git, so that I continue to work=
 on it?
>    From a performance point of view that would probably OK:
>    The "git status" on a linux tree was slightly slower on my PC when=
 measured with time.
>    From the user experience there was not a difference.

I am not fundamentally opposed to such a change, as long as the
change does not affect performance at all when the feature is not
used, and the resulting code does not become too ugly.

Use of the "reencode" feature may have to make things slow, but you
have to spend some cycle to do what the feature has to do anyway,
so...

> b) If yes,
>    I have to admit that I don't use paths from --stdin or file so muc=
h,
>    except "git am" or "git format-patch"
>    Which commands are affected?

$ git grep -l -e '--stdin' Documentation/git*

may be a good starting point.

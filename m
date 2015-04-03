From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Fri, 03 Apr 2015 14:01:55 -0700
Message-ID: <xmqqy4m9exj0.fsf@gitster.dls.corp.google.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com>
	<20150402180914.GA19081@peff.net>
	<201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
	<20150402191452.GA20420@peff.net>
	<xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
	<62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com>
	<20150402193524.GA21555@peff.net> <551DD887.2010403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"Reid Woodbury Jr." <reidw@rawsound.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye8jE-0007k9-Sq
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbDCVCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 17:02:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751327AbbDCVCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 17:02:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F42D44897;
	Fri,  3 Apr 2015 17:02:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=go7rCkILHK8t
	9A3XVbWNUSsJefQ=; b=vIk9sI/stfiFDkkQYbyPCKEKAS/qfIkyEsTIHZYvxFRL
	zWRs5MUxe+ULhUmfVSehPP+N0iTJYyMa3wj/y/54zxniT3iUGKaxEUWIa2L6LL7s
	XUWyqk417eE5MfImZJ5fjfA2qxusWjmgCASlIOHTpHswH6QnugshU24Hp6VjTE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XPAWpi
	Jr0NJdWCpZ2kyjxX8CWbggkgHM8/JdS+H4PC532+2wWJ1D/b0Loekl1XysIDMoPr
	V1bcjPY0ElItxDe/eyRdoBzJ/Cl/XQm7QcWQv61R7ofCmk6OGhiud8imVNrjoqUI
	BrzQu95fsxQVVkg8+JT/CunYSu0Z06s8V/OTw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1455A44896;
	Fri,  3 Apr 2015 17:02:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34A8C44891;
	Fri,  3 Apr 2015 17:01:57 -0400 (EDT)
In-Reply-To: <551DD887.2010403@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 03 Apr 2015 02:02:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9F9AF20-DA44-11E4-AC11-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266725>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> This makes my think that it is
> a) non-standard to have the extra colon
> b) The error message could be better

=46or that, perhaps

-ssh: Could not resolve hostname xxxx:: nodename nor servname provided,=
 or not known
+ssh: Could not resolve hostname "xxxx:": nodename nor servname provide=
d, or not known

would be something we would want to do, no matter what other fixes
we would apply.

> Spontaneously I would say that a trailing ':' at the end of a
> hostname in the ssh:// scheme can be safely ignored, what do you
> think?

If it is not too much hassle to make the current code do so, I'd say
that is a good way forward.  Giving a warning that lets the user
know that the input has an extra and unwanted colon in it may be a
plus, too.

Thanks.

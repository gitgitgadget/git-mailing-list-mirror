From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Tue, 08 Apr 2014 15:37:15 -0700
Message-ID: <xmqq61mj30tg.fsf@gitster.dls.corp.google.com>
References: <201404072139.42519.tboegi@web.de>
	<20140407195458.GA3912@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXedz-0006Ui-GD
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 00:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbaDHWhU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 18:37:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40994 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756410AbaDHWhT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 18:37:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FC9A7BC63;
	Tue,  8 Apr 2014 18:37:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PVaOEDhyipZO
	R2J6g5m+5NPBM/Q=; b=F5SpUgKt9IYvdlPYWfdUFmoxOvVWW2accuFSIeI5gjHP
	m0mKosqIWKqP+qFhvYZ05/W3WoStI3yRinRDg2HAeD+fMGqhCPyrESc4VPWbOWc0
	0DuYTtgWlKBoletnK49Dp8mgRHhIzRIkLBEVecuwERZUvsUao/jfTwSibP1K4cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uaiMKk
	Hq5NbijD/b4GLE3JN6cKcWL9DGH5eTkslPjggj9+ddbTWcn5FsdYbrec4ewFdEcn
	cBlARVW1B5/6UM3nZfKSL64bU6V/uhkECigQ1fa6K8kGpW2fHydLx8wRn+5xV7P1
	9EXzRlQlxp/MUraf2pHExVZLKYehre+T1hbKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC087BC61;
	Tue,  8 Apr 2014 18:37:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1486C7BC5E;
	Tue,  8 Apr 2014 18:37:17 -0400 (EDT)
In-Reply-To: <20140407195458.GA3912@google.com> (Jonathan Nieder's message of
	"Mon, 7 Apr 2014 12:54:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 569157A8-BF6E-11E3-99EB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245964>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Torsten B=C3=B6gershausen wrote:
>
>> Unicode 6.3 defines the following code as combining or accents,
>> git_wcwidth() should return 0.
>>
>> Earlier unicode standards had defined these code point as "reserved"=
:
>
> Thanks for the update.  Could the commit message also explain how thi=
s
> was noticed and what the user-visible effect is?
>
> For example:
>
>  "Unicode just announced that <...>.  That means we should mark the
>   relevant code points as combining characters so git knows they are
>   zero-width and doesn't screw up the alignment when presenting branc=
h
>   names in columns with 'git branch --column'"
>
> or something like that.

Perhaps (the original read clearly enough for me, though).

> [...]
>> 358 COMBINING DOT ABOVE RIGHT
>> 359 COMBINING ASTERISK BELOW
>
> I'm not sure this list is needed --- the code + the reference to the
> Unicode 6.3 standard seems like enough (but if you think otherwise,
> I don't really mind).

I can go either way.

>> This commit touches only the range 300-6FF, there may be more to be =
updated.
>
> The "there may be more" here sounds ominous.

Indeed it does ;-)

> Does that mean Unicode
> 6.3 also added some zero-width characters in other ranges that should
> be dealt with in the future?  How many such ranges?  How do we know
> when we're done?
>
> Just biting off the most important characters first and putting off
> the rest for later sounds fine to me --- my complaint is that the
> above comment doesn't make clear what the to-do list is for finishing
> the update later.

I'll queue this at the tip of 'pu', not to forget about it while
waiting for a clarification.

Thanks.

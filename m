From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of XDG_RUNTIME_DIR
Date: Thu, 17 Mar 2016 01:12:02 -0700
Message-ID: <xmqqmvpx1q25.fsf@gitster.mtv.corp.google.com>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
	<1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
	<1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
	<xmqqr3fa5rdi.fsf@gitster.mtv.corp.google.com>
	<CAKqreuwRpS3uP6=afm-0pBkPW0-bqoJconnKO5q3qTgZwdU_xQ@mail.gmail.com>
	<xmqqbn6e5o9v.fsf@gitster.mtv.corp.google.com>
	<729c6af810e3000e789f4afd537b77a8@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?6LCt5L+K5rWp?= <pickfire@riseup.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:12:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agT2b-0004fG-CH
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 09:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691AbcCQIMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 04:12:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752721AbcCQIMF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 04:12:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 453B3447A3;
	Thu, 17 Mar 2016 04:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P7LT8KAJ8sH5
	6r8FXc2KhmeNYJw=; b=ske7dGsldJo4MoUFJDN9x5iYSRNoYzrCn7E8FNHPkOlk
	Epy0XjJ7RWER68VWu4WAzGMPBWLi82MSG4O4XOzxkopRJTkNP5ZLiUPnW2QOO+MQ
	WUxmhL+Jo8tkKJoywMAfb9ycTjWPPIkdWzWjhsS/MfWeIa+tPIYMMP+6kxFCifY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Dx+7jG
	EcTDwrMQun6V36z5SihPTClPp9hCIYeDJT5HeFzyUI0oTj4TabE2dGDfXMRQmsCv
	OYS3vFtPKpAgia5pLNQSA6ZZ183TYPPsYtKfpAgfY3ppp90MZVa7iNZYpARHLsmm
	VdG5IIj3MrTGs4/IiGOSE/DatRmOQxyTx1TwM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D4C3447A2;
	Thu, 17 Mar 2016 04:12:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B98854479E;
	Thu, 17 Mar 2016 04:12:03 -0400 (EDT)
In-Reply-To: <729c6af810e3000e789f4afd537b77a8@riseup.net> (=?utf-8?B?Ig==?=
 =?utf-8?B?6LCt5L+K5rWpIidz?= message
	of "Thu, 17 Mar 2016 11:59:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EEB2659A-EC17-11E5-9631-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289086>

=E8=B0=AD=E4=BF=8A=E6=B5=A9 <pickfire@riseup.net> writes:

> On 17/03/2016 01:24, Junio C Hamano wrote:
>
>> Using ~/.git-credential-cache/credential-cache.sock would not help
>> at all for existing users, but ~/.git-credential-cache/socket would
>> interoperate well with users with existing versions of Git, no?
>>
>>>> Just being curious, and wanting to see the reasoning behind the
>>>> design decision the patch series makes in the log message of one o=
f
>>>> these patches.
>
> I guess it is better to use /tmp or such instead of $HOME/.* so that
> the users home directory won't be flooded by sockets.

The "fallback" being discussed is to see if $XDG can be used (and
use it if so), otherwise see if ~/.git-credential-cache/socket can
be used (and use it if so), otherwise die with a message (see
credential-cache.c).  The order of the falling back may want to be
the other way around, but in either case, the definition of "can be
used" includes "is there already a directory in which we can create
a socket?".

The existing versions have used ~/.git-credential-cache/socket as
the default socket path, so it is reasonable to expect that users
that are already using the feature already have the directory there.

So I do not think there is any "flooded" involved; if the directory
is already there, we can use it to create and use a single socket.
It's not like we'd be creating many random new directories in ~/.

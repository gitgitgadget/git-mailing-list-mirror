From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Mon, 03 Feb 2014 16:14:14 -0800
Message-ID: <xmqqwqhbag4p.fsf@gitster.dls.corp.google.com>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>
	<52EEA5D3.9000502@web.de>
	<CAD_8n+RZACW0380co75gWSwVmCJdcH4COsySTF3BFCyKEumXNA@mail.gmail.com>
	<52EFFA36.8090305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Reuben Hawkins <reubenhwk@gmail.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 04 01:14:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WATeh-0007WB-6t
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 01:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbaBDAOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 19:14:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbaBDAOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 19:14:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1873069C61;
	Mon,  3 Feb 2014 19:14:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A4wwwhBmjbEJ
	54GJ0SC9yfyBw+s=; b=Q/56pgeZxCyEFUBnOPZixbW0g1PhBWBnFeOZSxBYwxqw
	ZM2UbwuZ1NlZqiBGshDQDmxFXwlk3ob2uXTQwPByuLsvOW1snnNBPzZC1FMymMxL
	FBYbn2XfmdzyHgxsN20dQXGpV36nl+5Jj8am+IieJMFuikhqPffN6NLjNfZ3Rjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aj4fK8
	VhtVDtPPTQQC+yK26HJhuE43NCqnNQ1c3nSalh9YVCOd8JYGxe7Qr4m8HEmpVrZs
	LU0CMNfuHU9eCToIUeiRrVdeMc/qFdVOxANr28rvgQ3GA1/8XHxzBWjKWY5z1Ues
	CGPLTb0LEUQ8SIOmtXLUKdqOLmC+cx73BMR7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0745469C60;
	Mon,  3 Feb 2014 19:14:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C0D069C5F;
	Mon,  3 Feb 2014 19:14:17 -0500 (EST)
In-Reply-To: <52EFFA36.8090305@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 03 Feb 2014 21:21:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 494C1F7A-8D31-11E3-9EB4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241503>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> []
>> So to summarize, when fast-import uses strncmp_icase (what fast-impo=
rt does now) import on a repository where ignorecase=3Dtrue is wrong.  =
My patch, "fast-import.c: always honor the filename case" fixes this.  =
Can you verify?
>>
>> Thanks in advance,
>> Reuben
>>
> Yes, I can verify. My feeling is that
> a) the fast-export should generate the rename the other way around.
>    Would that be feasable ?
>    Or generate a real rename ?
>   (I'm not using fast-export or import myself)

I do not think this matters.  Or at least, it should not matter.  As
Peff said in the nearby message, core.ignorecase is completely about
the _filesystem_, and that git should generally be case-sensitive
internally.

And fast-import is about reading internal representation of paths
and data to populate the repository, without having to guess what
pathnames were meant to be used---the guess is only needed if we
need to consult the filesystem that loses case information.

The change made by 50906e04 (Support case folding in git fast-import
when core.ignorecase=3Dtrue, 2010-10-03) should probably be half
reverted by making the case-squashing an optional feature, that
could be used even on a system with case sensitive filesystems.

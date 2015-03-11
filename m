From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Wed, 11 Mar 2015 10:59:58 -0700
Message-ID: <xmqqwq2n5s9t.fsf@gitster.dls.corp.google.com>
References: <54F88684.3020905@alum.mit.edu>
	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>
	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>
	<xmqq385c1v13.fsf@gitster.dls.corp.google.com>
	<54FF6D23.4060301@alum.mit.edu>
	<xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
	<54FFD89A.9050306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 19:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVkvi-0006jb-3V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 19:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbCKSAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 14:00:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbbCKSAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 14:00:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEEA63DBDA;
	Wed, 11 Mar 2015 14:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UJPSXDckXudM
	UdvmskdXoAl06XU=; b=HTuJvG5bZppSAdVP+DgCu1D54SrqOer16NLFZpVYcvZU
	cPiLqgB/Y4g4CIFpUJH03OV0WLknw0Qut9WCJkWxmi+niCyEP9hfrtKPUaOamzjQ
	HUC5oY9desAtZOUB33Uy4sjRK7R7fRYf7J/4de0iLM9DAT+1oAZhrCncJBGEasM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QJ5O2l
	9Wcm7dVJjaosrbYbmER9XxnFOEt94RNAom9XDtY3N23yr3fHqWNShqiH0FsZpbmW
	TwXj5gitEgPHm+rvRVbODDnROCnqEWv/mu8hB5mFv94gIRrPjmcl3NeIaZsMMZjj
	crGcp/xPcdEjH5+iVIochr6BbbMb4gp5b0Zwo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E75D73DBD9;
	Wed, 11 Mar 2015 14:00:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F8F93DB99;
	Wed, 11 Mar 2015 13:59:59 -0400 (EDT)
In-Reply-To: <54FFD89A.9050306@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 11 Mar 2015 06:54:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6EFBA998-C818-11E4-B9C8-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265330>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 03/10/2015 11:54 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> Well, that's true, but the "eol" attribute can regain its effect if
>>> "binary" is followed by "text" or "text=3Dauto". So I guess the sim=
plest
>>> question is as follows. Suppose I have the following .gitattributes=
:
>>>
>>>      a.foo eol=3Dcrlf
>>>      a.foo binary
>>>      a.foo text
>>>
>> As binary is not just -text and turns other things off, those other
>> things will be off after these three.
> Not sure if I follow:
> Whenever you specify -text, the eol doesn't matter, or what do I miss=
 ?

Something unrelated to the main theme of this topic ;-).

I was just saying that saying "a.foo text" is not a way to take your
earlier mistake of saying "a.foo binary" back, if that "binary" was
placed on the path by mistake or an over-eager globbing.  The 'text'
attribute will be reset, but -diff you placed on the path by saying
"binary" is still there after these three attribute lines and running
"git diff a.foo" would sill show the effect from it.

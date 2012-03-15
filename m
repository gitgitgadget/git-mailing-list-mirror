From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] help: Add '--follow-alias' option
Date: Wed, 14 Mar 2012 23:23:27 -0700
Message-ID: <7vvcm6l6w0.fsf@alter.siamese.dyndns.org>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
 <1331779969-8641-2-git-send-email-namhyung.kim@lge.com>
 <7vehsummit.fsf@alter.siamese.dyndns.org> <4F6188FB.7020406@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:23:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8462-0007kS-U2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab2COGXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 02:23:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2COGX3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 02:23:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A15E41B1;
	Thu, 15 Mar 2012 02:23:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FlO8KTtSp16W
	36HAc5FUTlghI3E=; b=SX03lSLcirHvtnWSX30931tXwl5tJJwElE9RGidcuVNo
	dRcVDzB1zZN0lf2V6scsPTN7qfi7/4bBsPwE5078Iw373nNYg7H64ZEr2QmANTMm
	3kTujU/nBHpOsF8N8gZ1vGx46tf4en/3vWYw7PlAYC3GMU3aZ6iRN0ex08z7Vt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SgAxHa
	nDEBhPLuBqCTw24FcbYzRfVJ5W6OVunsP6BwE8j013YP72r4g2oY47Fq58OQArdU
	1W8fgmyeidqGLkWnuFmfptUbLx2smM8kLHBuskztKWwCjVwj1broRRfu+dsGmw3i
	VzerbLx/hdmB7efc2vdHHGj0ImnHgpM5ZjcxI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40B9941B0;
	Thu, 15 Mar 2012 02:23:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C88EA41AF; Thu, 15 Mar 2012
 02:23:28 -0400 (EDT)
In-Reply-To: <4F6188FB.7020406@lge.com> (=?utf-8?B?Iuq5gOuCqO2YlSIncw==?=
 message of "Thu, 15 Mar 2012 15:15:23 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6124E734-6E67-11E1-B3E5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193185>

=EA=B9=80=EB=82=A8=ED=98=95 <namhyung.kim@lge.com> writes:

> 2012-03-15 3:00 PM, Junio C Hamano wrote:
>> Namhyung Kim<namhyung.kim@lge.com>  writes:
>>
>>> The --follow-alias option will look up the alias definitions and
>>> use the first word as a command. For example, if I set my aliases
>>> as follows:
>>>
>>>   $ git help br
>>>   `git br' is aliased to `git branch'
>>>   $ git help ru
>>>   `git ru' is aliased to `git remote update'
>>>
>>> adding --follow-alias (or -f) option will show man pages of
>>> git-branch and git-remote, respectively.
>>
>> What would happen when somebody has this?
>>
>> 	[alias]
>>          	br =3D branch --list
>>
>> 	$ git help --follow-alias br
>> 	... man page for git-branch is shown ...
>>
>> NAK.
>
> I'm sorry I don't understand what you meant by this. What should be
> happened for this?

You _somehow_ restict the output, or at least draw the user's attention=
,
to the description of --list mode in the resulting "git-branch" manual.

I do not think that is feasible.

But showing the whole manual page, without telling the user that "br" i=
s
not aliased to a plain vanilla "branch" without any option, is not a
solution, especially if you are going to let the user set a configurati=
on
variable to allow him to forget about this setting. Progressive revelat=
ion
would not have such a downside and I think it is more appropriate appro=
ach
for something like "help".

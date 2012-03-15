From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] help: Fix help message for aliases
Date: Wed, 14 Mar 2012 23:18:22 -0700
Message-ID: <7v399amlox.fsf@alter.siamese.dyndns.org>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
 <7vipi6mo93.fsf@alter.siamese.dyndns.org> <4F6182C1.9080600@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 07:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8418-00044h-6V
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 07:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305Ab2COGSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 02:18:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763Ab2COGSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 02:18:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 777D240D4;
	Thu, 15 Mar 2012 02:18:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EPG76lh2Eiim
	SG7y1LvsgVrXdxU=; b=E75z80Ya8ExmAtDlj7IaB2Tv1eAHxEZIfLwot3diAn2M
	FwBG6BLEGb7GjkZDVrkuiLRg+VLIEBUIDpuXyMarmODMdSgiV4H1Y2nKrkFJFn7x
	f9pIgOEqtV+hLSvoykw1cKIQx1inzSEBfHIsPMLAKbe2ytGKCEFMumG0Fss0cwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JMRzW1
	NOgVmYbohc1Bq1/PeGK2Xh3KtrMZcvtbc9Hcw+qoiofnIb+NckkdSF7QAYxPG4pf
	4pIpAzsAcDWL2X3ZE0/hh2Qp6tijjbFRl1juw/iwK0o6jTdpj+IuAKtYwPgxGzcD
	fAvPmY7ZZSZBzzcfUgNkeTc2w/78C4srUvZSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F80240D3;
	Thu, 15 Mar 2012 02:18:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C445540D2; Thu, 15 Mar 2012
 02:18:23 -0400 (EDT)
In-Reply-To: <4F6182C1.9080600@lge.com> (=?utf-8?B?Iuq5gOuCqO2YlSIncw==?=
 message of "Thu, 15 Mar 2012 14:48:49 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB570BD0-6E66-11E1-8A20-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193184>

=EA=B9=80=EB=82=A8=ED=98=95 <namhyung.kim@lge.com> writes:

> 2012-03-15 2:23 PM, Junio C Hamano wrote:
>> Namhyung Kim <namhyung.kim@lge.com> writes:
>>
>>> -		printf("`git %s' is aliased to `%s'\n", argv[0], alias);
>>> +		printf("`git %s' is aliased to `git %s'\n", argv[0], alias);
>>
>> NAK.
>>
>> What would the above change will do to one of my favorite alias?
>>
>> $ git help who
>> `git who' is aliased to `!sh -c 'git log -1 --format=3D"%an<%ae>" --=
author=3D"$1"' -'
>>
>> Wouldn't removing "git " from the first phrase be a better solution?
>
> Right. But as I replied to Jeff King, it can be improved to check
> whether the aliased output is such a complicated commands or not. Now
> I see that we can examine if the first letter is '!'.

Trimming the four bytes from the beginning would be an improvement by
itself---it makes the output shorter without losing information.

And for your "[alias] br =3D branch", you will see:

	`br` is aliased to `branch`

which after all is exactly what the user wrote in the configuration.

There is even a worse problem with your "I can look at '!' at the
beginning".  By tweaking the part that is the answer to what the user
asked, depending on the value the user configured, you would not be abl=
e
to tell from this output:

	`git br` is aliased to `git branch`

which one the user really has between these two, no?

	[alias] br =3D branch
        [alias] br =3D !git branch

In short, I do not think there is any merit trying to be clever and cut=
e
when answering "git help <alias>".  The cleverness will actively hurt b=
y
obscuring the details of the answer you are giving in response to user'=
s
question.

Exactly the same "don't obscure by trying to be clever and cute" commen=
t
applies to the --follow-alias patch. There is nothing wrong in the seri=
es
of revelation:

 1. The user types 'git help br',
 2. The user then realizes it is aliased to 'branch' (this could even
    be 'branch --list'), then
 3. The user asks 'git help branch' (and perhaps goes to read on --list=
)

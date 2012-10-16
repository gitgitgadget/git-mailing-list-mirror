From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] Add git-check-ignore sub-command
Date: Tue, 16 Oct 2012 09:12:58 -0700
Message-ID: <7vmwzmtmyd.fsf@alter.siamese.dyndns.org>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-12-git-send-email-pclouds@gmail.com>
 <7vlif7v03r.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9g6rNiv7nnTu2i34dbn_z7r5SmhDuxief7iEQLVxtO5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:13:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO9lb-00034U-3G
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab2JPQND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2012 12:13:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754357Ab2JPQNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 12:13:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 795C68947;
	Tue, 16 Oct 2012 12:13:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Wp4Y1zogz/jo
	AYYa7iFvgvgdYeE=; b=rFfNOX9YwHbUBuXDUbMQP5J0lIsSgU1MvHlV4fq8gxd8
	YmAKGzz0axuXA0YVZyxwMlYDIbN3/v3dh/lDzk/58cQL7Pp4yprxfZdEnfTMrAq4
	wtBPdwYYBQUrOozTCowMe4qPunVcF9Uxih/y80GlmGomwWvk13IL6Aamvi61VI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=N4Bc56
	rtUV23mUgVsi9ea8EHIQtJ5oSUz9F0UHVl7rbUWaBWajJKfIWdemSF2UK80G1sD9
	vLTRxGReJaW+hr3alPwQJ5aHiKMGTg2J1Dro9QRg/3OG6iaiaxGikFSmfomspS9H
	SKrWW1EBIINT5xDslxqbAq2EalYRcmNYdVbd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FEDF8946;
	Tue, 16 Oct 2012 12:13:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B885C8941; Tue, 16 Oct 2012
 12:12:59 -0400 (EDT)
In-Reply-To: <CAOkDyE9g6rNiv7nnTu2i34dbn_z7r5SmhDuxief7iEQLVxtO5g@mail.gmail.com> (Adam
 Spiers's message of "Tue, 16 Oct 2012 07:13:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5AAD45A6-17AC-11E2-B73A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207841>

Adam Spiers <git@adamspiers.org> writes:

> On Mon, Oct 15, 2012 at 3:31 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> +For each pathname given via the command-line or from a file via
>>> +`--stdin`, this command will list the first exclude pattern found =
(if
>>> +any) which explicitly excludes or includes that pathname.  Note th=
at
>>> +within any given exclude file, later patterns take precedence over
>>> +earlier ones, so any matching pattern which this command outputs m=
ay
>>> +not be the one you would immediately expect.
>>
>> "The first exclude pattern" is very misleading, isn't it?
>
> I don't think so, because of the second sentence.
>
>> For example, with these in $GIT_DIR/info/exclude, I would get:
>>
>>         $ cat -n .git/info/exclude
>>           1 *~
>>           2 Makefile~
>>         $ git check-ignore -v Makefile~
>>         .git/info/exclude:2:Makefile~   Makefile~
>>
>> which is the correct result (the last one in a single source decides
>> the fate of the path), but it hardly is "first one found" and the
>> matching pattern in the output would not be something unexpected for
>> the users, either.
>>
>> The reason it is "the first one found" is because the implementation
>> arranges the loop in such a way that it can stop early when it finds
>> a match---it simply checks matches from the end of the source.
>>
>> But that is not visible to end-users,
>
> Correct; that's precisely why I wrote the second sentence which
> explicitly explains this.
>
>> and they will find the above description just wrong, no?
>
> It's not wrong AFAICS, but suggestions for rewording this more clearl=
y
> are of course welcome.  Maybe s/immediately/intuitively/ ?

I think this is sufficient:

	For each pathname given via the command-line or from a file
	via `--stdin`, show the pattern from .gitignore (or other
	input files to the exclude mechanism) that decides if the
	pathname is excluded.

and without "Note that" at all.

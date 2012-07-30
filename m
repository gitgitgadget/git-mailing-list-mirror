From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve tests for detached worktree in git-submodule
Date: Mon, 30 Jul 2012 10:44:32 -0700
Message-ID: <7vsjc9qh33.fsf@alter.siamese.dyndns.org>
References: <1343664610-479-1-git-send-email-dangra@gmail.com>
 <7v6295rxmb.fsf@alter.siamese.dyndns.org>
 <CAHCkQtPmJdFBk7G-EP70FwtkRk11Utp+rppjNrEZFtZgOVrObA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:45:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svu1W-0002KN-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab2G3Rol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 13:44:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2G3Roj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2012 13:44:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 785FC9D33;
	Mon, 30 Jul 2012 13:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0IVgwSATvkZq
	Rzx/9ThSgDE1qRg=; b=j4+3Y39/ZChpz3jeHdrjkX91IGNNFA5d4wEELcqMsB0U
	6sZcMPFrHb57cN9XOT0TjRcyl6UZI/T+U8S/P8TiitsnrsiNr4n4wOk6Vutjxz8s
	yymwxMJRfF6nOeZqfamsm6QduqjEVwGthniDLUgnxY6/Lgh+YwzRBCh/XAdaYcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=o2pfNU
	2iLn0C4WCnKWIfX8zaZduW+kTv8GTHoS90Lp9v6hq0qU6zBrWvCO5AKRicymVZ2T
	XW5ZjTfKv97kpV2AJXv5vpxl6EW/kB+bx/+1Zyz3pn3PxAO16lSIH1gaSWS0jyoE
	qjFDz02AKvQTQGkyxmXOX7lobjMhSi9y7Epvs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6655A9D32;
	Mon, 30 Jul 2012 13:44:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 920319D31; Mon, 30 Jul 2012
 13:44:37 -0400 (EDT)
In-Reply-To: <CAHCkQtPmJdFBk7G-EP70FwtkRk11Utp+rppjNrEZFtZgOVrObA@mail.gmail.com> ("Daniel
 =?utf-8?Q?Gra=C3=B1a=22's?= message of "Mon, 30 Jul 2012 14:18:22 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B6C9E38-DA6E-11E1-9324-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202593>

Daniel Gra=C3=B1a <dangra@gmail.com> writes:

> On Mon, Jul 30, 2012 at 2:02 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Daniel Gra=C3=B1a <dangra@gmail.com> writes:
>>
>>> Signed-off-by: Daniel Gra=C3=B1a <dangra@gmail.com>
>>> ---
>>>  t/t7409-submodule-detached-worktree.sh |   31 ++++++++++++++++++++=
++++-------
>>>  1 files changed, 24 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/t/t7409-submodule-detached-worktree.sh b/t/t7409-submo=
dule-detached-worktree.sh
>>> index db75642..d88f400 100755
>>> --- a/t/t7409-submodule-detached-worktree.sh
>>> +++ b/t/t7409-submodule-detached-worktree.sh
>>> @@ -15,7 +15,11 @@ TEST_NO_CREATE_REPO=3D1
>>>  test_expect_success 'submodule on detached working tree' '
>>>       git init --bare remote &&
>>>       test_create_repo bundle1 &&
>>> -     (cd bundle1 && test_commit "shoot") &&
>>> +     (
>>> +             cd bundle1 &&
>>> +             test_commit "shoot" &&
>>> +             git rev-list --max-count=3D1 HEAD > "$TRASH_DIRECTORY=
/expect"
>>
>> Better written as
>>
>>         git rev-parse --verify HEAD >../expect
>>
>> methinks.
>
> You rule here,
>
> is it still better than "git rev-parse --max-count=3D1 HEAD" seen in
> t7406-submodule.update.sh?

"git rev-parse --max-count=3D1 HEAD" will show "--max-count=3D1\n"
followed by the value of HEAD, so if the expected result and the
actual result were both prepared by that command, the comparison
would succeed (as the irrelevant --max-count=3D1 line will appear in
both output), but honestly, I do not think it makes any sense.

Who wrote that crap?

>
>>
>>> +     ) &&
>>>       mkdir home &&
>>>       (
>>>               cd home &&
>>> @@ -23,14 +27,27 @@ test_expect_success 'submodule on detached work=
ing tree' '
>>>               git clone --bare ../remote .dotfiles &&
>>>               git submodule add ../bundle1 .vim/bundle/sogood &&
>>>               test_commit "sogood" &&
>>> +             (
>>> +                     unset GIT_WORK_TREE GIT_DIR &&
>>> +                     cd .vim/bundle/sogood &&
>>> +                     git rev-list --max-count=3D1 HEAD > actual &&
>>> +                     test_cmp actual "$TRASH_DIRECTORY/expect"
>>
>> Likewise.
>>
>>         git rev-parse --verify HEAD >actual &&
>>         test_cmp ../expect actual
>
> I tried to avoid the too many ".." usage, in that case it'd be:
>
>     test_cmp ../../../../expect actual

"$TRASH_DIRECTORY/expect" is fine as well.  Just drop the extra SP
between the redirection '>' and the filename, and make sure the
filename is inside double quotes for some versions of bash that
issue an unnecessary warning.

>>> +             git checkout master &&
>>
>> So you populate the newly created home2 working tree out of the .otf=
iles
>> repository in it.
>
> right, before it wasn't creating ~/.gitmodules and "git subodule
> update --init" wasn't taking effect.

Good.

>> Is the "existence" the only thing you care about?  That's not all
>> that different from the old test that only checked the existence of
>> the directory dupe, no?
>
> Except the submodule wasn't updating but the directory still existed
> so test passed, now it check for a file that exists only if the
> submodule update works.

OK.

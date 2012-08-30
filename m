From: carlos@cmartin.tk (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: [PATCHv2 0/3] Improve branch UI for setting upstream information
Date: Thu, 30 Aug 2012 20:57:56 +0200
Message-ID: <87fw745hsb.fsf@centaur.cmartin.tk>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
	<7v1uios2ma.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 20:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T79wF-0000Fb-VG
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 20:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982Ab2H3S5x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Aug 2012 14:57:53 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:57972 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab2H3S5x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 14:57:53 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id 0DF8280030;
	Thu, 30 Aug 2012 20:57:52 +0200 (CEST)
Received: (nullmailer pid 9064 invoked by uid 1000);
	Thu, 30 Aug 2012 18:57:56 -0000
In-Reply-To: <7v1uios2ma.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 30 Aug 2012 10:37:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204562>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> As a result of making --unset-upstream fail if the given branch
>> doesn't exist, I discovered a copy-paste error in on the the tests i=
n
>> the patch after it, so I'm resending the whole thing.
>>
>> The changes from the last reroll are the tightening of the situation=
s
>> where git will show an error message (not it's just if the branch is
>> new and exists as remote-tracking) which I already sent as a reply i=
n
>> the other thread; and making --unset-upstream error out on bad input=
,
>> which I already mentioned above.
>
> Thanks.
>
> In addition to "--unset-upstream must fail on i-dont-exist branch"
> in [2/3], I am wondering if we would want to also make sure the
> command fails when the upstream information is not set for the
> branch, i.e. something like the following on top.
>
> What do you think?
>
>  t/t3200-branch.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git i/t/t3200-branch.sh w/t/t3200-branch.sh
> index 1018e8b..a0aaedd 100755
> --- i/t/t3200-branch.sh
> +++ w/t/t3200-branch.sh
> @@ -393,7 +393,9 @@ test_expect_success 'test --unset-upstream on HEA=
D' \
>       git branch --set-upstream-to my14 &&
>       git branch --unset-upstream &&
>       test_must_fail git config branch.master.remote &&
> -     test_must_fail git config branch.master.merge'
> +     test_must_fail git config branch.master.merge &&
> +     test_must_fail git branch --unset-upstream
> +'

Yeah, this looks good, makes sure that it will still behave correctly
even if the code path for these two situations diverges.

   cmn

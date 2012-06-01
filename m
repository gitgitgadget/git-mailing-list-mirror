From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 11:16:51 +0200
Message-ID: <20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vmx4o58zc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNym-000564-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872Ab2FAJQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 05:16:56 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:55688 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759146Ab2FAJQy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 05:16:54 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 210621A02F1;
	Fri,  1 Jun 2012 11:16:52 +0200 (CEST)
Received: from wifi-030054.grenet.fr (wifi-030054.grenet.fr [130.190.30.54])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 01 Jun
 2012 11:16:51 +0200
In-Reply-To: <7vmx4o58zc.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198966>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> How is your development process work, by the way?  Does everybody on
> this list have code in this patch?  Or are you just listing people
> who are in the same class taught by Matthieu who reviewed and
> commented on this patch?

Basically, we 5 people are in the same group and work together on
the same project. Some are more involved into improving the advices
in git status, and some are more involved into the XDG configuration
but we are all in the same room thus there're a lot of communication so
everyone knows what's happening in each topics. Matthieu is helping us
when we have technical questions but he doesn't review our code beforeh=
and
(he is very busy :p).

Btw, we're also working on other small improvements such as the impleme=
ntation
of "git rebase -i --exec <cmd>".

> And rename "output" to "actual" to match the existing practice
> (unless there is a compelling reason not to).

We based our coding-style on the t7508-status.sh script which
seem to use out-of-date style (some instructions are not in
test_expect_success for example). We will use the modern coding
style from now on.

>> +	} else {
>> +		status_printf_ln(s, color, _("You are currently editing a commit =
=20
>> during a rebase."));
>> +		if (advice_status_hints) {
>> +			status_printf_ln(s, color, _("  You can amend the commit with"))=
;
>> +			status_printf_ln(s, color, _("	git commit --amend"));
>> +			status_printf_ln(s, color, _("  Once you are satisfied with =20
>> your changes, run"));
>> +			status_printf_ln(s, color, _("	git rebase --continue"));
>
> For an advice in "git status" output, the above may be appropriate,
> but would the user see this in "git commit" template, and if so,
> isn't it because the user typed "git commit --amend"?  Does it make
> sense to suggest to run "git commit --amend" in that context?

True, the user will see the messages in the "git commit" template. We
didn't take this case into account because we thought that not many peo=
ple
read the status in the "git commit" template. Anyway, just adding a con=
dition

if (advice_status_hints && !s->amend)

does the job.

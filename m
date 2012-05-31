From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv4 1/3] wt-status.*: better advices for git status added
Date: Thu, 31 May 2012 08:42:00 +0200
Message-ID: <vpq1um0svgn.fsf@bauges.imag.fr>
References: <1338226598-16056-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vmx4pzfse.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 08:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZz5L-0001TX-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2EaGmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:42:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51414 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2EaGmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:42:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4V6Xgh1021661
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 08:33:42 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZz57-0002Kc-S8; Thu, 31 May 2012 08:42:01 +0200
In-Reply-To: <7vmx4pzfse.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 30 May 2012 11:26:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 08:33:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V6Xgh1021661
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339050824.93864@8VDrh8T0NzcNxol6KJ3riQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198864>

Junio C Hamano <gitster@pobox.com> writes:

>> +	status_printf_ln(s, color,
>> +		_("You are currently in am progress:"));
>
> Is it just me, or is the above -ECANTPARSE?  "You are currently in
> commit/merge/meal/commute progress?"

It's not just you ;-).

> Perhaps	"You are in the middle of an am session" or something?

I'd just say "rebase in progress".

>> +	status_printf_ln(s, color,
>> +		_("You are currently in am progress:"));
[...]
>> +	if (advice_status_help) {
>> +		status_printf_ln(s, color,
>> +			_("  When you have resolved this problem run \"git am --resolved\"."));
>> +		status_printf_ln(s, color,
>> +			_("  If you would prefer to skip this patch, instead run \"git am --skip\"."));
>> +		status_printf_ln(s, color,
>> +			_("  To restore the original branch and stop patching run \"git am --abort\"."));
>> +	}
>
> I doubt it makes much sense to hide only these messages behind "if
> (advice_status_help)".  Look at how you give your "what to do"
> advices in wt-status-merge-in-progress function.

I disagree.

"rebase in progress" adds information for advanced Git users as well as
for newbies. I think it makes sense to display it unconditionnally, like
we currently display "Not currently on any branch." or "Your branch is
ahead of ...".

The state in which the user is is important for anyone, but the set of
commands to get out of this state is not relevant for advanced users,
and simply eats a few terminal lines for them.

I think the situation is no different from other messages like "Changes
not staged for commit:", where the list matters for everyone, but the
suggested commands don't, and that's why I still think
advice.statusHints should be used here too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

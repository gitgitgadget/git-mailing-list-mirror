From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 17:53:46 +0200
Message-ID: <vpqiobcy9yt.fsf@anie.imag.fr>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com>
	<1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 17:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy086-0002mh-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 17:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbbE1Pxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 11:53:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47445 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932354AbbE1Pxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 11:53:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4SFri4k029196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 17:53:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SFrk3h014295;
	Thu, 28 May 2015 17:53:46 +0200
In-Reply-To: <1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Guillaume Pages's message of "Thu, 28 May 2015 17:43:09 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 28 May 2015 17:53:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SFri4k029196
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433433228.29565@gqPw00ixnMGhN5CICZCJLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270156>

Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> Hi, 
>
> "Paul Tan" <pyokagan@gmail.com> : 
>> I haven't kept up with the discussion, but I'm wondering: since you 
>> need the functionality in wt-status.c, why not implement it in git 
>> status? In fact, git-status already shows if there is a rebase in 
>> progress, so why not extend it to say which patch/todo line the rebase 
>> stopped on? It feels much more natural to me to use git-status to 
>> check the status of the rebase, instead of git rebase --status. 
>> Thanks, Paul 
>
> It's a question I have asked myself but since git rebase --status will 
> certainly display more information 

Historically, I had the idea of "git rebase --status" and Ensimag
students started working on it 2 years ago. The same question came back
then during the discussion: why not just in status? This lead to the
header in the output of "git status" ("You are currently ...", for
rebase/am/bisect/...).

But I think there are more relevant information to show (e.g. list of
already applied commits, remaining list of commits, possibly truncated
if the list is overly long, and information that rebase gave you when
stopping like the path to the file being applied). Having them all in
"git status" would make the output really long, for little benefit in
day-to-day use.

So, to me, it makes sense to have a separate command "tell me everything
you know about the current state of the rebase".

> If we choose to use git status, it could be an option to display the
> full information since it currently gives very few information. I'm
> not sure what -verbose does but it could be its role.

"git status --verbose" is already taken for "show me the diff together
with status".

(I'm also dreaming of a "git status --tutor" that would show detailed
explanations with pointers to the documentation & all for each section
of "status". Useless for non-beginners, but could be a nice way to teach
Git to beginners)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

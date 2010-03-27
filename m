From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] pull: mention "pull", not "fetch" in the error message.
Date: Sat, 27 Mar 2010 09:52:23 +0100
Message-ID: <vpqy6hep2ns.fsf@bauges.imag.fr>
References: <4BACC241.4010608@drmicha.warpmail.net>
	<1269615836-13995-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100326231209.GB6797@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 09:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvRlm-0007AD-58
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 09:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab0C0IxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 04:53:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57762 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728Ab0C0IxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 04:53:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o2R8mOEO010574
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 27 Mar 2010 09:48:24 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NvRkl-0007gL-Hp; Sat, 27 Mar 2010 09:52:23 +0100
In-Reply-To: <20100326231209.GB6797@blimp.localdomain> (Alex Riesen's message of "Sat\, 27 Mar 2010 00\:12\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 27 Mar 2010 09:48:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2R8mOEO010574
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1270284509.47457@94b0PSxEY0SN8MDLB6YNqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143321>

Alex Riesen <raa.lkml@gmail.com> writes:

> Matthieu Moy, Fri, Mar 26, 2010 16:03:56 +0100:
>> For newbies who've just been taught "git pull", the error message
>> "Where do you want to fetch from today?" is indeed confusing. Change it
>> to "Where do you want to pull from today?" in case fetch was called from
>> pull.
> ...
>> @@ -842,8 +842,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>>  	int ref_nr = 0;
>>  	int exit_code;
>>
>> +	char *cmd = getenv("GIT_USER_COMMAND");
>
> Isn't the variable name a little too generic? USER_COMMAND doesn't make it
> clear that its only purpose is to pass a string "pull"

It is generic, so that the same variable can be reused elsewhere if
needed. When a command "git foo" calls internally "git bar", the
instance of "git bar" thinks it's executing the command "bar", but the
user thinks he just ran the command "foo". This variable lets git know
that and adapt its error message accordingly.

> to an error message which is never even seen under normal
> circumstances.

For some definition of "never ever" and/or "normal circumstances"
only, then:

/tmp/test$ git init
Initialized empty Git repository in /tmp/test/.git/
/tmp/test$ git pull
fatal: Where do you want to pull from today?

(the confused newbie scenario isn't imaginary, it just happened to a
colleague of mine)

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/

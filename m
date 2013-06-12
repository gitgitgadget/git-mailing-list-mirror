From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 12:17:23 +0200
Message-ID: <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
 <20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
 <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
 <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 12 12:17:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Umi7P-0007QO-RH
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 12:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab3FLKR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 06:17:28 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33529 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab3FLKR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 06:17:27 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CAHNVd026397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 12:17:23 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CAHOcS011473;
	Wed, 12 Jun 2013 12:17:24 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5CAHOVH030728;
	Wed, 12 Jun 2013 12:17:24 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5CAHNEW030727;
	Wed, 12 Jun 2013 12:17:23 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 12:17:23 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227596>

After a few hours, here's a quick summary of your opinions:

-'git status' should be the command to display the information instead=20
of a --status flag
-the SHA1 of the patch being applied currently is a very important=20
information
-displaying how we got to this state would be nice

I had in mind a slight change in the current status message, just to=20
include the SHA1 and where we're at in the rebasing. It would look like=
=20
this:

$ git status
# HEAD detached from ecb9f3e
# You are currently editing a832578... my_commit_message [3/5] while=20
rebasing.
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your=20
changes)
# ......
# ......

Now, I'm not sure if we should always display the list of commits=20
already applied and those left to apply. What I mean is that maybe it=20
would be better to make status require a flag to display the two lists.
Something like (not sure about the flag's name):

$ git status --rebase-state
# HEAD detached from ecb9f3e
# Already applied 2 patches:
# 	b170635... my_commit_message
# 	b170635... my_commit_message
# You are currently editing a832578... my_commit_message [3/5] while=20
rebasing.
# 2 patches left to apply:
#	b170635... my_commit_message
#	b170635... my_commit_message
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your=20
changes)
# ......
# ......

What do you guys think ?

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02

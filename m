From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: OK, how should I have done this...
Date: Mon, 22 Nov 2010 14:34:48 +0100
Message-ID: <vpq4ob9qy6f.fsf@bauges.imag.fr>
References: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 14:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKWb0-0006z1-2J
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 14:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab0KVNiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 08:38:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:61853 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172Ab0KVNiC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 08:38:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oAMDYmHA013189
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Nov 2010 14:34:48 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PKWXg-0003W7-AO; Mon, 22 Nov 2010 14:34:48 +0100
In-Reply-To: <AANLkTim0_J0i_a0o+z1oCC4mramfUxCGtCg_Y+ab+h+-@mail.gmail.com> (Patrick Doyle's message of "Mon\, 22 Nov 2010 08\:22\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 22 Nov 2010 14:34:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161892>

Patrick Doyle <wpdster@gmail.com> writes:

> I just checked in modifications to 1/2 dozen or so files in a single
> commit and pushed them to my server.

> So now I want to figure out which modification(s) in which file(s)
> introduced the problem.

'didn't read all the details of your message, but the way I'd have
done this would be with stash --keep-index:

(untested)

git checkout the-one-that-works # staging area and tree checked out.
git reset the-one-that-doesnt   # just change the staging area
git add -p
# pick some commits
git stash --keep-index
# run some tests
# if test fail then
   # happy, "git diff --staged" tells you what.
# else
   git commit -m "first modification"
   git stash pop
   # goto the git add -p step.
# fi

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

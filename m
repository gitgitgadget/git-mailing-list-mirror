From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSOC remote-svn
Date: Mon, 23 Jul 2012 09:59:40 +0200
Message-ID: <vpqr4s2nc0j.fsf@bauges.imag.fr>
References: <4514544.Xip1OCQ7Uj@flomedio>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, davidbarr@google.com, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 10:00:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StDYh-0001sc-JO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 10:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990Ab2GWH76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:59:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52909 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458Ab2GWH75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:59:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6N7vkMh014169
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2012 09:57:46 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1StDYL-0003F4-72; Mon, 23 Jul 2012 09:59:41 +0200
In-Reply-To: <4514544.Xip1OCQ7Uj@flomedio> (Florian Achleitner's message of
	"Sun, 22 Jul 2012 23:03:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Jul 2012 09:57:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6N7vkMh014169
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343635070.97438@9yVXxOLrM9WtgM8I6lj5Rw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201924>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> But my remote-helper didn't advertise the refspec capability, so transport-
> helper assumed it imports to refs/heads/master, which is the default import 
> refspec.

The man page for git-remote-helpers says:

refspec <refspec>
    [...] It is recommended that all importers providing the import
    capability use this.

I'm not sure I fully understand the rationale, but one difference
between refs/<remote name>/* and refs/remotes/<remote name> is that
refs/remotes/ is automatically updated by Git on push, while the private
namespace isn't (it only receives updates when importing).

I played a bit with that it git-remote-mediawiki. There's a
configuration variable mediawiki.dumbPush that controls what "push"
does. It can either export the local history without touching local
metadata (and then, it is expected that the user does a "git pull
--rebase" right after to re-import the history), or update the local
metadata (private ref, and notes that keep the <local commit> <->
<remote revision number> map), so that the next "git pull" says
"Already up to date.".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

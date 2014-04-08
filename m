From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Handling empty directories in Git
Date: Tue, 08 Apr 2014 19:03:37 +0200
Message-ID: <vpqob0blpna.fsf@anie.imag.fr>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Olivier LE ROY <olivier_le_roy@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 19:03:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXZR6-0008WM-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 19:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283AbaDHRDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 13:03:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47390 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757376AbaDHRDm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 13:03:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s38H3Z76032112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Apr 2014 19:03:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s38H3bFv012274;
	Tue, 8 Apr 2014 19:03:37 +0200
In-Reply-To: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>
	(Olivier LE's message of "Tue, 8 Apr 2014 07:47:22 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 08 Apr 2014 19:03:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s38H3Z76032112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397581417.45961@eUnx4smIuXeEV4cDgKAhIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245933>

Olivier LE ROY <olivier_le_roy@yahoo.com> writes:

> The solution: put a .gitignore file in each empty directory to have them recognized by the Git database cannot work, because some scripts in my projects test the actual emptiness of the directories.

Another option is to have a post-checkout hook that does the mkdir for
you. Or do that in the build system if your use case is to store
untracked generated files in the directory.

> Is there any expert able to tell me: this cannot be done in Git, or
> this can be done by the following trick,

https://git.wiki.kernel.org/index.php/Git_FAQ#Can_I_add_empty_directories.3F

Short answer: it cannot be done.

> or why there is no valuable reason to maintain empty directories under
> version control?

The reason would be closer to "there is a valuable reason, but not
valuable enough to change Git to do it". It's actually not so easy to
track directories properly. Storing them in the Git repository is
actually possible (actually, an empty tree is a special case of this,
and is obviously supported), but defining and implementing a decent
behavior for each Git command wrt this is not trivial.

David Kastrup gave it a try a few years ago. I don't remember exactly
what made him give up, but it was never completed and merged.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

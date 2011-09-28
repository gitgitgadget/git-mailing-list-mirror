From: Nick <oinksocket@letterboxes.org>
Subject: Re: emacs as mergetool
Date: Wed, 28 Sep 2011 18:03:47 +0100
Message-ID: <4E835373.1070006@letterboxes.org>
References: <201109261821.28382.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: thomas@koch.ro
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 19:51:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yI8-0000Mt-6L
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab1I1Rv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:51:27 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:47669 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab1I1Rv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:51:27 -0400
X-Greylist: delayed 2638 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Sep 2011 13:51:27 EDT
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.103])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1R8xbT-0008NZ-7o; Wed, 28 Sep 2011 18:07:27 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <201109261821.28382.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182353>

On 26/09/11 17:21, Thomas Koch wrote:
> would you be so kind and give an emacs newbie (and vim refugee) a hint about 
> using emacs as mergetool?
> 
> - Which one? ediff vs. emerge (I don't bother learning, just give me the best)

I tend to use git.el - which provides the M-x git-status command - and therefore
ediff.  It's not necessarily the best git interface, but I've been too lazy
learn anything else so far.  git-status allows you to do basic git
adding/committing etc. and will show modification diffs.

Given a git-status buffer, a conflicted merge will show up with certain files in
red.  You can then view the conflicted versions side-by-side positioning the
cursor over the conflicted file, and using the key-sequence 'd E' to start
interactive merges in ediff mode.  Afterwards you have to save the buffers and
mark the file as 'resolved' in git-status ('r').

There are other things you can do in a git-status buffer. M-x describe-mode (C-h
m) and M-x describe-bindings (C-h b) will provide some idea.

> - I'd like to have a setup, where I can run mergetool with different options 
> to
>   - connect to a running emacs server
>   - run emacs in X
>   - or in the terminal (default)

git-status works with all the above.  I don't use git-mergetool at all.

To keep things in one emacs session I sometimes use git directly in emacs shell
buffers. i.e.

 - Run emacs
 - Open the repo in dired: M-x find-file <path to your git repo>
 - Invoke git-status:      M-x git-status
 - (do stuff)
 - Open a shell            M-x shell, M-x eshell, or M-x ansi-term
 - (do more stuff)

> - Is it possible to resolve all conflicting files in one session instead of
> having emacs called again for every file?

As I said, I don't use git-mergetool, but git-status should allow most basic
things in fairly straightforward way. For anything more complicated (e.g. git
commit --amend, or git add --interactive) I open an shell in emacs.

If you tell git to use emacsclient as the editor, and then git commit and co.
will open an emacs buffer so you can invoke git from the command line without
leaving your emacs session.  To do this:

 - invoke: git config --global core.editor emacsclient
 - in emacs: M-x server-start
   (or add "(server-start)" to your ~/.emacs file)

At some point I might check out magit. I'd be interested to hear about
comparisons between git.el and the alternatives.

Cheers,

N

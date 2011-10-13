From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [CLOSED] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 22:56:11 +0400
Message-ID: <20111013225611.37093103@zappedws>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	<20111013145924.2113c142@ashu.dyn.rarus.ru>
	<loom.20111013T130924-792@post.gmane.org>
	<4E96D819.20905@op5.se>
	<loom.20111013T144822-277@post.gmane.org>
	<1318514356.4646.16.camel@centaur.lab.cmartin.tk>
	<loom.20111013T181801-923@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:56:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQSA-0000ba-HE
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab1JMS4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:56:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49317 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1JMS4V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:56:21 -0400
Received: by bkbzt4 with SMTP id zt4so1831030bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=o3K/xtKxpqL6VkYAmtdcVbLWHRdaAuXZSRS83/tplwM=;
        b=q3CH+kwGJQ52lKe1fdvh+oLSDU+mwHAhiZWqJmZrULDlGa2G29ll4M7E5c2x9jrAw0
         JLaqpV/TM8oKnAgMvoNTHO+pv50cnhRsgXU/PcGEA8bRy8YwpirUW+vF2+2ehtgxXiXi
         qN6J9jroA5ES3Ib8XLpScLueSLqnopmjAHojc=
Received: by 10.204.132.199 with SMTP id c7mr3945488bkt.45.1318532180119;
        Thu, 13 Oct 2011 11:56:20 -0700 (PDT)
Received: from zappedws (ppp91-78-136-140.pppoe.mtu-net.ru. [91.78.136.140])
        by mx.google.com with ESMTPS id u10sm4682947bkv.3.2011.10.13.11.56.18
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 11:56:18 -0700 (PDT)
In-Reply-To: <loom.20111013T181801-923@post.gmane.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183514>

> (Though if someone can come up with a script / hook / whatever that
> improves the "visibility" of stash, that would be awesome. 
> 
"git-completion" for Bash/ZSH gives such an opportunity
I use it

take a look into 
<git-sources>/contrib/completion/git-completion.bash
-- >8 --
#    3) Consider changing your PS1 to also show the current branch:
#         Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#         ZSH:  PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
#
#       The argument to __git_ps1 will be displayed only if you
#       are currently in a git repository.  The %s token will be
#       the name of the current branch.
#
#       In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty
#       value, unstaged (*) and staged (+) changes will be shown next
#       to the branch name.  You can configure this per-repository
#       with the bash.showDirtyState variable, which defaults to true
#       once GIT_PS1_SHOWDIRTYSTATE is enabled.
#
#       You can also see if currently something is stashed, by setting
#       GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is
stashed, #       then a '$' will be shown next to the branch name.
#
#       If you would like to see if there're untracked files, then you
can #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If
there're #       untracked files, then a '%' will be shown next to the
branch name. #
#       If you would like to see the difference between HEAD and its
#       upstream, set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates
#       you are behind, ">" indicates you are ahead, and "<>"
#       indicates you have diverged.
-- >8 --
my .bashrc contains (shortly)
PS1='\[\e]0;\w [$(__git_ps1 "%s")]\a\]\n\[\e[32m\]\u@\h'
PS1=$PS1' \[\e[33m\]\w\[\e[0m\]\n[$(__git_ps1 "%s")]\n\$'

export PS1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"

and console prompt with all possible cases looks like

<username>@<hostname> ~/Git-src.git/contrib/completion
[post-receive-email *+$>]
$ 

* - I have unstaged changes
+ - I have staged changes
$ - I have stashed changes (ta-daaa!)
> - I have commits ahead upsteam (named branch I branched from)

P.S. 
And JFYI, it is a good form in mailing lists to CC (Reply to all)
participants

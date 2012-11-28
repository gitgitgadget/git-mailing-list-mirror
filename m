From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: git-prompt.sh vs leading white space in
 __git_ps1()::printf_format
Date: Wed, 28 Nov 2012 14:20:34 +0100
Message-ID: <20121128132033.GA10082@xs4all.nl>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdhnZ-0004NM-EW
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 14:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645Ab2K1NfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 08:35:16 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:2491 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab2K1NfP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 08:35:15 -0500
X-Greylist: delayed 847 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2012 08:35:15 EST
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id qASDKZwI024341
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Nov 2012 14:20:35 +0100 (CET)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id qASDKYkI011925;
	Wed, 28 Nov 2012 14:20:34 +0100
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id qASDKYLk011922;
	Wed, 28 Nov 2012 14:20:34 +0100
Content-Disposition: inline
In-Reply-To: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210731>

* Piotr Krukowiecki <piotr.krukowiecki@gmail.com> [2012-11-28 11:03:29 +0100]:

> Hi,
> 
> when I set PROMPT_COMMAND to __git_ps1 I get a space at the beginning:
> 

Is your setting?:
PROMPT_COMMAND=__git_ps1

I believe you need to give 2 parameters in order to use it in PROMPT_COMMAND mode.

In my .bashrc I have:
if [ -f ~/.gitprompt.sh ]
then
        . ~/.gitprompt.sh
        GIT_PS1_SHOWDIRTYSTATE=true
        GIT_PS1_SHOWCOLORHINTS=true
        GIT_PS1_SHOWUNTRACKEDFILES=true
        PROMPT_COMMAND="__git_ps1 '\u@\[\e[1;34m\]\h\[\e[0m\]:\w' '\\\$ '"
fi


>  (master)pkruk@foobar ~/dir$
> ^ space
> 
> Is there a reason for this? It looks like a waste of space. If I'm not in
> git repository I don't have the space:
> 
> pkruk@foobar ~/other$
> 
> I noticed the space is explicitly specified in printf_format in
> git-prompt.sh. Is it needed? If I remove it, everything seems to work fine
> (no leading space)...
> 
> --- /usr/local/src/git/git/contrib/completion/git-prompt.sh 2012-11-28
> 10:27:05.728939201 +0100
> +++ /home/pkruk/.git-prompt.sh 2012-11-28 10:52:56.852629745 +0100
> @@ -218,7 +218,7 @@ __git_ps1 ()
>   local detached=no
>   local ps1pc_start='\u@\h:\w '
>   local ps1pc_end='\$ '
> - local printf_format=' (%s)'
> + local printf_format='(%s)'
> 
>   case "$#" in
>   2) pcmode=yes


These last 2 lines say: if 2 arguments are given, use pcmode. Otherwise you get command-subtitution mode, which gives weird effects when being called from PROMPT_COMMAND.

Cheers

Simon

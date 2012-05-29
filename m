From: nguyenhu@minatec.inpg.fr
Subject: [RFC] Possibility to have a per-user config directory
Date: Wed, 30 May 2012 01:50:35 +0200
Message-ID: <20120530015035.Horde.XJPMC3wdC4BPxWDLkXMByVA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; DelSp=Yes
Cc: Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 01:50:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZWBV-0004fe-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 01:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980Ab2E2Xuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 19:50:37 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:53379 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755890Ab2E2Xuh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 19:50:37 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 980641A0275;
	Wed, 30 May 2012 01:50:35 +0200 (CEST)
Received: from etu-188-42.vpn-inp.grenoble-inp.fr
 (etu-188-42.vpn-inp.grenoble-inp.fr [147.171.188.42]) by
 webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Wed, 30 May
 2012 01:50:35 +0200
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198776>


Huynh Khoi Nguyen NGUYEN <nguyenhu@minatec.inpg.fr> writes:
> Hello,
>
> As you know, git stores its configuration in ~/.gitconfig file and  
> in other >hidden files at the root of the user's directory.
>
> We would like to have a configuration directory instead of all these  
> >configuration files by following the XDG specification because:
> - not a lot of hidden files at the root, so better view
> - one directory per software in ~/.config

I update my suggestion.

As I said, I would like to propose to users the possibility to have an  
XDG configuration file, that's to say $XDG_CONFIG_HOME/git/config. If  
$XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/config  
will be used.

So now I will put forward 2 patches: one for reading, and one for writing.

Patch for reading:
Git would read both in $XDG_CONFIG_HOME/git/config and in ~/.gitconfig  
in this order:
.git/config > ~/.gitconfig > $XDG_CONFIG_HOME/git/config > /etc/gitconfig

Patch for writing:
Git would write its configuration in $XDG_CONFIG_HOME/git/config file if:
- this file exists,
- and ~/.gitconfig file doesn't.
Otherwise git would write its configuration in ~/.gitconfig as usual.

If you don't create $XDG_CONFIG_HOME/git/config, there is no change.
I don't want to force users to have $XDG_CONFIG_HOME/git/config.
I will write in documentation advice for users who often come back to  
an old version of Git, on different computers with the same $HOME, not  
to use $XDG_CONFIG_HOME/git/config for the time being. If they don't  
read documentation, they can't know possibility of  
$XDG_CONFIG_HOME/git/config.

I will send you the patch for reading before 24h.
Then I will try to send you the patch for writing before 24h.

We will also send other patches to propose to users the possiblity to  
have easily $XDG_CONFIG_HOME/git/gitignore and  
$XDG_CONFIG_HOME/git/gitattributes.

Valentin DUPERRAY,
Franck JONAS
Lucien KONG,
Thomas NGUY,
Huynh Khoi Nguyen NGUYEN,

Grenoble INP ENSIMAG

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Read configuration also from ~/.gitrc
Date: Mon, 29 May 2006 16:00:36 +0200
Organization: At home
Message-ID: <e5euq2$10t$1@sea.gmane.org>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060528222641.GF10488@pasky.or.cz> <Pine.LNX.4.63.0605290913330.8863@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 29 16:01:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkiJE-0004mE-MU
	for gcvg-git@gmane.org; Mon, 29 May 2006 16:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWE2OBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 10:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWE2OBM
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 10:01:12 -0400
Received: from main.gmane.org ([80.91.229.2]:63620 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750880AbWE2OBK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 10:01:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkiIu-0004gf-7A
	for git@vger.kernel.org; Mon, 29 May 2006 16:01:08 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 16:01:08 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 May 2006 16:01:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20948>

Johannes Schindelin wrote:

> But would this not break for the normal case? If you override one key in 
> the repository's config, with this patch, repo-config will barf. The 
> normal case is that you do not expect multiple values for the same key. 
> Your patch reads both ~/.gitrc and $GIT_DIR/config, and if a key has a 
> value in both (even if they are identical), repo-config will error out.

So the patch was to simplistic. Values from user's configuration file
~/.gitrc should be marked, to be overridden by $GIT_DIR/config per
repository configuration file.
 
> Further, storing a key will no longer work. This is an obscure side 
> effect of this patch not caring about storing anything in ~/.gitrc: If you 
> find the key section (or the key) in ~/.gitrc, the offset will be stored, 
> _and used on $GIT_DIR/config_!

I think that storing a key should (unless new option --user-config or
--global is used) should store it in $GIT_DIR/config file; of course index
has to be found there, and if not found it key should be created. Per
configuration file offsets?

> I agree it is nice to have a global git configuration, but I have it: I 
> use templates.

There are system-wide templates. git-init-db(1) doesn't show default
directory for _user_ templates...


And I guess that these are the issues why Junio C Hamano wrote:

> * The 'pu' branch, in addition, has these.
> 
>  - $HOME/.gitrc (Petr Baudis)
>       Read configuration also from ~/.gitrc
> 
>    * I like this but it breaks the tests big time.  Not "next"
>      material yet, unfortunately.
 

-- 
Jakub Narebski
Warsaw, Poland

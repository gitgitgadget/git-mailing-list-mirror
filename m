From: Michel Jouvin <jouvin@lal.in2p3.fr>
Subject: Re: git-svn dcommit ignores --username if there are =?utf-8?b?Y2FjaGVkCWNyZWRlbnRpYWxz?=
Date: Wed, 13 Jan 2010 07:05:23 +0000 (UTC)
Message-ID: <loom.20100113T080137-723@post.gmane.org>
References: <loom.20100112T233835-324@post.gmane.org> <20100113054138.GB23182@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 08:05:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUxIe-0003VZ-3A
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 08:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab0AMHFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 02:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185Ab0AMHFs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 02:05:48 -0500
Received: from lo.gmane.org ([80.91.229.12]:51445 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab0AMHFr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 02:05:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUxIX-0003Tt-7g
	for git@vger.kernel.org; Wed, 13 Jan 2010 08:05:45 +0100
Received: from APuteaux-153-1-43-64.w82-124.abo.wanadoo.fr ([82.124.7.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 08:05:45 +0100
Received: from jouvin by APuteaux-153-1-43-64.w82-124.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 08:05:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.124.7.64 (Opera/9.80 (Windows NT 6.0; U; fr) Presto/2.2.15 Version/10.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136786>

Eric Wong <normalperson <at> yhbt.net> writes:

> Hi Michel,
> 
> I wonder if this is because we explicitly reread the config directory
> when creating Git::SVN::Editor.
> 
> Does using --no-auth-cache work for you?
> 
> Otherwise, try pointing --config-dir= to an empty directory.
> 
> Or you can try this patch to force us to not reread the config_dir:
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 650c9e5..280fd15 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -550,9 +550,6 @@ sub cmd_dcommit {
>  			my %ed_opts = ( r => $last_rev,
>  			                log => get_commit_entry($d)->{log},
>  			                ra => Git::SVN::Ra->new($url),
> -			                config => SVN::Core::config_get_config(
> -			                        $Git::SVN::Ra::config_dir
> -			                ),
>  			                tree_a => "$d~1",
>  			                tree_b => $d,
>  			                editor_cb => sub {
> 
> We have a good reason to read config dirs there for getting auto-props,
> though, so the above patch isn't going into git.git
> 

Hi Eric,

Thanks for your quick answer. Unfortunatly, none of the suggested workaround 
worked for me... I even tried to clone again the SVN repository passing the 
suggested options when cloning but no effect. BTW, does specifying --username 
at cloning time should add something to some config file (like .git/config) ?

Cheers,

Michel

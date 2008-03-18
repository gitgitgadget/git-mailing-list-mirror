From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Allow git-cvsserver database table name prefix to be specified.
Date: Tue, 18 Mar 2008 09:09:13 +0100
Message-ID: <20080318080913.GF18624@mail-vs.djpig.de>
References: <12058051092735-git-send-email-josh@elsasser.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Elsasser <josh@elsasser.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 09:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbWtl-00043B-AH
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 09:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYCRIJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 04:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYCRIJg
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 04:09:36 -0400
Received: from pauli.djpig.de ([78.46.38.139]:45499 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbYCRIJe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 04:09:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 0CEFE90071;
	Tue, 18 Mar 2008 09:09:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D8+gDRdMe1KL; Tue, 18 Mar 2008 09:09:15 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 1200B90075;
	Tue, 18 Mar 2008 09:09:14 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1JbWsj-0003Cs-L0; Tue, 18 Mar 2008 09:09:13 +0100
Content-Disposition: inline
In-Reply-To: <12058051092735-git-send-email-josh@elsasser.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77492>

On Mon, Mar 17, 2008 at 06:51:49PM -0700, Josh Elsasser wrote:
> Adds a gitcvs.dbprefix config variable, the contents of which are
> prepended to any database tables used by git-cvsserver. The same
> substutions as gitcvs.dbname and gitcvs.dbuser are supported, and any
> non-alphabetic characters are replaced with underscores.
> ---
> The purpose of this patch is to easily allow a single database (think
> PostgreSQL or MySQL) to be shared by multiple repositories.

For the record, I think that this is a good idea, but have no time
to really test it.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0865f4e..ca232cf 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -661,6 +661,13 @@ gitcvs.dbuser, gitcvs.dbpass::
>  	'gitcvs.dbuser' supports variable substitution (see
>  	linkgit:git-cvsserver[1] for details).
>  
> +gitcvs.dbprefix::
> +	Database table name prefix. This will be prepended to any
> +	tables used, allowing a single database to be used for deveral

Typo s/deveral/several/

> +gitcvs.dbprefix::
> +	Database table name prefix. Supports variable substitution
> +	(see below). Any non-alphabetic characters will be replaces

Typo s/replaces/replaced/

> +	with underscores.
> +
>  All variables can also be set per access method, see <<configaccessmethod,above>>.
>  
>  Variable substitution
[...]
> @@ -2427,10 +2431,10 @@ sub update
>      # first lets get the commit list
>      $ENV{GIT_DIR} = $self->{git_path};
>  
> -    my $commitsha1 = `git rev-parse $self->{module}`;
> +    my $commitsha1 = `git-rev-parse $self->{module}`;
>      chomp $commitsha1;
>  
> -    my $commitinfo = `git cat-file commit $self->{module} 2>&1`;
> +    my $commitinfo = `git-cat-file commit $self->{module} 2>&1`;
>      unless ( $commitinfo =~ /tree\s+[a-zA-Z0-9]{40}/ )

Unrelated whitespace changes?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/

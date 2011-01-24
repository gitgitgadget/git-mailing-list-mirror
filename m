From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Mon, 24 Jan 2011 02:45:53 -0600
Message-ID: <20110124084552.GA17348@burratino>
References: <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
 <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino>
 <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
 <7v39omotxg.fsf@alter.siamese.dyndns.org>
 <AANLkTim_o9GGWbDFkeGb-va+4dP+StQE6GJyLpSMmV1H@mail.gmail.com>
 <7vipxfmb9u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 09:46:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhI4I-0001yP-QH
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 09:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab1AXIq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 03:46:27 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:32940 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab1AXIq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 03:46:26 -0500
Received: by gwj20 with SMTP id 20so1184786gwj.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fvm59cT1J91+ENTyPI2FdwaJor+58SZrg4npZaQo9kA=;
        b=vFoNvWztO3qeF6vHVmLHXdlutXP2uP7XbUJ6AI4MrSL/d0W2PRcbaJao0J49ynvOj7
         pfHS9wRvRuftmQ/jH7VVnh/Z92Quf+jsMj8d/W3e2H1/2qbkicJVG7ThGsNLHdvAh6i2
         FTb9APfCy5euVqANDL12wwJ4yXp9cKiP330tE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K/H1gl+6M4QqAM1ogCtJ3Tx2/qHMxGL5/VGcGcw4ujsbRJFHU5rAXcuKeiM1gWTR56
         iHd+f0KHV14ho+hCDaHupejU2t0BsW+847qshp+8gtT6bUhmlGJLY+5+UJItn3n7qmjC
         qD90Uk/idnXuxFNs7EAhnqEGGDDJdVyXVjea8=
Received: by 10.150.93.21 with SMTP id q21mr4190322ybb.356.1295858785457;
        Mon, 24 Jan 2011 00:46:25 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id r41sm8457410yba.4.2011.01.24.00.46.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Jan 2011 00:46:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vipxfmb9u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165439>

Junio C Hamano wrote:

> Something like this (on top of jn/setup-fixes branch queued in
> next)?

For what it's worth,
 Acked-by: Jonathan Nieder <jrnieder@gmail.com>

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -317,17 +317,26 @@ false), while all other repositories are assumed to be bare (bare
>  = true).
>  
>  core.worktree::
> -	Set the path to the working tree.  The value will not be
> -	used in combination with repositories found automatically in
> -	a .git directory (i.e. $GIT_DIR is not set).
> +	Set the path to the root of the work tree.

Most manpages seem to stick to the phrase "working tree".  Not sure
if that's worth worrying about --- maybe it would be good to allow or
encourage usage to drift to the term "work tree" that gets used in
many parts of the interface.

>  	This can be overridden by the GIT_WORK_TREE environment
>  	variable and the '--work-tree' command line option. It can be
> +	an absolute path or a relative path to the .git directory,
> +	either specified by --git-dir or GIT_DIR, or automatically
> +	discovered.

Maybe:

	The value can be an absolute path or relative to the path to
	the .git directory, which is either specified by --git-dir or
	GIT_DIR or automatically discovered.

> -	an absolute path or relative path to the directory specified by
> -	--git-dir or GIT_DIR.
> -	Note: If --git-dir or GIT_DIR are specified but none of
> +	If --git-dir or GIT_DIR are specified but none of
>  	--work-tree, GIT_WORK_TREE and core.worktree is specified,
> -	the current working directory is regarded as the top directory
> +	the current working directory is regarded as the top level
>  	of your working tree.

Subject-verb agreement: "--git-dir or GIT_DIR is specified" (s/are/is/)

> ++
> +Note that this variable is honored even when set in a configuration
> +file in a ".git" subdirectory of a directory, and its value differs
> +from the latter directory (e.g. "/path/to/.git/config" has
> +core.worktree set to "/different/path"), which is most likely a
> +misconfiguration.

I think it's clearer without the comma between "directory" and "and"
(otherwise, it's too easy to parse as

	Note that this variable is honored even when set ....
	Its value differs from the latter directory, which is most
	likely a misconfiguration.

).

> +                   Running git commands in "/path/to" directory will
> +still use "/different/path" as the root of the work tree and can cause
> +confusion, unless you know what you are doing (e.g. you are creating a
> +read-only snapshot of the same index to a location different from the
> +repository's usual working tree).

Missing article: s,in "path/to" directory,in the "/path/to" directory,

Comma usage: s/confusion, unless/confusion unless/ to avoid misparsing
this as meaning "will use this work tree unless you know what you are
doing".

> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -291,17 +291,12 @@ help ...`.
>  	path or relative path to current working directory.
>  
>  --work-tree=<path>::
> -	Set the path to the working tree.  The value will not be
> -	used in combination with repositories found automatically in
> -	a .git directory (i.e. $GIT_DIR is not set).
> +	Set the path to the working tree. It can be an absolute path
> +	or relative path to the current working directory.

s/relative path to/path relative to/

>  	This can also be controlled by setting the GIT_WORK_TREE
>  	environment variable and the core.worktree configuration
> +	variable (see core.worktree in linkgit:git-config[1] for a
> +	more detailed discussion).
> -	variable. It can be an absolute path or relative path to
[...]

Nice.

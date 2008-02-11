From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: checks for gitweb.description
Date: Mon, 11 Feb 2008 13:20:21 -0800 (PST)
Message-ID: <m3ejbjdwc6.fsf@localhost.localdomain>
References: <1202760138-24227-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOg5E-0001fs-9N
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbYBKVU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbYBKVU0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:20:26 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:37103 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbYBKVUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:20:25 -0500
Received: by fk-out-0910.google.com with SMTP id z23so4665019fkz.5
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 13:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=HyNURDCJnJ9UTDPYtdHhlGleGU+G28wIwFStROd4Zbo=;
        b=AE2PovkXTdlsaVSAH4RWyQUAPrgTeg8eRD96UXJFYSmgDu/SXyGl7uZqZOpzrcZbJ/2X+SHwcGWbiYq9c8JznyQiUqyZ0KQkmSKdu+3XJgYMYdbcVghIlSNMrsB601YmQhCiKKpMsrpmTEvOJowLpdzU8/k7f9rpvD/ICWcJieI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=W6yO5MFF6zbayZsSF7clzZ4FBaOsKsjZuMOmz3UuHIMpn+ATiH1eZTYA6MOGWOMLkJf+RDttFolsqgLRmX0d+fCM8E7s4jk/L0haCGoiAKP+Bxqp7toqnS55M4LyFh3b/DwrobwWP/Mfu82d7lsBvJ4MXejyQzc2VVi9L+mrg44=
Received: by 10.82.150.20 with SMTP id x20mr892617bud.5.1202764823438;
        Mon, 11 Feb 2008 13:20:23 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.23])
        by mx.google.com with ESMTPS id y34sm19889271iky.6.2008.02.11.13.20.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 13:20:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1BLKDBj017602;
	Mon, 11 Feb 2008 22:20:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1BLK9b2017599;
	Mon, 11 Feb 2008 22:20:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1202760138-24227-1-git-send-email-ribas@c3sl.ufpr.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73586>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

Here it would be nice to have longer description, like:

  Check repository configuration gitweb.description for project
  description, if $GIT_DIR/description does not exist

Note that 'description' file is created by default when creating
repository by git-init by default repo template.

> Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
> ---
>  contrib/hooks/post-receive-email |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 77c88eb..bdd21fa 100644
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -614,7 +614,11 @@ if [ -z "$GIT_DIR" ]; then
>  	exit 1
>  fi
>  
> -projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> +if [ -f "$GIT_DIR/description" ]; then
> +	projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> +else
> +	projectdesc=$(git-config gitweb.description)

The rest of this hook use "git cmd". Preferred way to call git
commands is "git cmd". So I would use

  "git config gitweb.description"

> +fi
>  # Check if the description is unchanged from it's default, and shorten it to
>  # a more manageable length if it is
>  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> -- 
> 1.5.4.24.gce08d
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git

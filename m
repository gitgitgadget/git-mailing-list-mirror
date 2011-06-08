From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Wed, 8 Jun 2011 14:42:05 -0500
Message-ID: <20110608194205.GI27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:42:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOds-0000A7-VW
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492Ab1FHTmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 15:42:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63660 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab1FHTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 15:42:10 -0400
Received: by iwn34 with SMTP id 34so700788iwn.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tJF92VvVKrLM4pP/cpPbNWAcYZr0BqOFfXvnRyo3J2s=;
        b=FfGxx4GzfB+S14pzhuRfX+TxRuykOj6wvWUA5Jto9SuN8ssgqEgHj12bpqBJK7jyfA
         xzgw+p4zT/s56IuoGqaA3P2nvaAF6jZHP0LcKt2hHUxu+qBKPWhCpVYp1nEXxRhrf1+3
         OlEyQgeSk0aU+gFaX2RKLuFYSgclYQEr27V+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KhRFPVvI/Ha8dBSY4XoK16cSiDz01Z/E434VMsb9SJs3FPE5iCmZYTkA5vU2LhsbIU
         A2Ookb8tg2uxs8bcjzqCG/JzdSofwgpeubmGVYEDSE/9Pge3MpGDJMu54qxbFcO1t8Os
         wVPVBYj4g2KJ3o86siCM0vpH3XJpQVSlP+58I=
Received: by 10.42.163.8 with SMTP id a8mr1279831icy.525.1307562129938;
        Wed, 08 Jun 2011 12:42:09 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.ameritech.net [69.209.61.87])
        by mx.google.com with ESMTPS id d8sm687721icy.9.2011.06.08.12.42.08
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 12:42:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175450>

Sverre Rabbelier wrote:

> --- a/git_remote_helpers/git/non_local.py
> +++ b/git_remote_helpers/git/non_local.py
> @@ -63,7 +63,7 @@ class NonLocalGit(object):
>          if not os.path.exists(path):
>              die("could not find repo at %s", path)
>  
> -        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath]
> +        args = ["git", "--git-dir=" + path, "push", "--quiet", self.repo.gitpath, "--all"]
>          child = subprocess.Popen(args)

Does this deal with forced (non-fast-forward) pushes?  (Not a
complaint, just curious.)

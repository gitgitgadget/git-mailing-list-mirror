From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Fri, 18 Jan 2008 00:49:18 +0100
Message-ID: <200801180049.19174.jnareb@gmail.com>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <m3y7aplbie.fsf@roke.D-201> <b0943d9e0801170907x9c4721cy4e5ac886eb61e0a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Karl =?iso-8859-1?q?Hasselstr=F6m?=" <kha@treskal.com>,
	"Dan McGee" <dpmcgee@gmail.com>, git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"Peter Oberndorfer" <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 00:45:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFePo-00051k-JZ
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 00:44:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617AbYAQXo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 18:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756101AbYAQXo1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 18:44:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26918 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbYAQXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 18:44:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so410078ugc.16
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 15:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=fzas5Dq7o5toFL4XGamhGlMcyA4nQFgGvnVsGXBYsDc=;
        b=feyNHatRVE8sO2O2Sh6Oohm1E1qQV972sC4iWgx1RQ7SeFFn4zENwA0lAg7T7TUqKcemM7xN3zkivRCMe3pv92H3RCGqSsnOLcNnElGAu1XsLDzeNe7dNQE+UW05CMFcTTUk2Y+l54UrAjjjegWcV7MK5OugsR3TXcy3c96zuNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FG6ScpAFQ+sjMn2EB37HyKsiWKV73rPwRUGyl14a9KhOtlAAUMN11h/4un5/g7bL4Kyd3CN6kqWWHLb7OpPPgLpVcBHIUJ4Rl2+czfaZVXIEXMG7Q7h6DNqorrmfHqhiwgNFRPeMLBijP45wb24/ccpXB9AV2qanoE62V23vZLo=
Received: by 10.67.195.14 with SMTP id x14mr316146ugp.40.1200613465320;
        Thu, 17 Jan 2008 15:44:25 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.209.38])
        by mx.google.com with ESMTPS id b36sm1310489ika.2.2008.01.17.15.44.23
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Jan 2008 15:44:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0801170907x9c4721cy4e5ac886eb61e0a5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70939>

On Thu, 17 January 2008, Catalin Marinas wrote:
>
> Now I'm back from holiday and I'll start merging patches.
> Thanks for the fixes. 
> 
> On 16/01/2008, Jakub Narebski <jnareb@gmail.com> wrote:
> > Strange that StGIT didn't abstracted out reading git config, like
> > Git.pm and gitweb.perl did.
> 
> The initial implementation was to use Python to parse the config file
> but it was dropped in favour of the git-config tool. It might be a bit
> slower but, at least, we don't need to follow any future syntax
> changes.

Errr... this is not what I meant. What I meant here is why StGit doesn't
have a thin wrapper around "git config", so instead of all those calls
to "Run('git', 'config', '--get', name)" use "git_config(name)" etc.,
similarly to Git.pm and gitweb.perl (which also use git-config to parse
the config file; only git-cvsimport parses config file in Perl IIRC).

This way if you want to load the whole config file at once (like gitweb
now does, using "git config -z -l") you would have to make changes only
in one place.

-- 
Jakub Narebski
Poland

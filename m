From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Document that gitweb deals with bare repositories
Date: Sat, 16 May 2009 10:14:27 +0200
Message-ID: <200905161014.28521.jnareb@gmail.com>
References: <ed82fe3e0905151349k15f040aej30dbec82037e9d76@mail.gmail.com> <200905152336.49319.jnareb@gmail.com> <ed82fe3e0905151521m64df542eifca87073c4360fbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Sat May 16 10:14:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5F2d-0004iB-Ry
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 10:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977AbZEPIOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 04:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbZEPIOj
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 04:14:39 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57524 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbZEPIOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 04:14:36 -0400
Received: by fxm2 with SMTP id 2so2312549fxm.37
        for <git@vger.kernel.org>; Sat, 16 May 2009 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7J+MfslGFSeY6zgZbSbfSMhaw0d0R6jp3QOyojlb1ZE=;
        b=BYit4qxMjCYM/YORNXNjeDdoDWA8yrTPoVUxGIGrHPz12utik/umqDSyutEhNcXYtH
         3yvD2IbsGode71ndpBAf/9BKNBMuHPfxHkly0a1P1knhx9tz6C0tVvqkgDw1n4D5L3X2
         Vk3wdwXlXDmuLgTAff7ZgjJ0wCy0i8bJd53QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K4LFEPmQGRLcEPyCTcjYhSC0Zpp0OUvR4gvz3ZWuDd/d8sShHCiLUKFFAJGHeJqTbn
         GQ4jWcYZcAGpuQvO64zCVeMMyWtSl8nADR1h/hG5DZaq20ONXQVjzx0UL2rC/P1Lced3
         d4WlvQnOIxmHbc79hJl7V1OkZlMyaLCJreOW8=
Received: by 10.103.174.18 with SMTP id b18mr711399mup.128.1242461676525;
        Sat, 16 May 2009 01:14:36 -0700 (PDT)
Received: from ?192.168.1.13? (abvj81.neoplus.adsl.tpnet.pl [83.8.207.81])
        by mx.google.com with ESMTPS id u26sm579728mug.52.2009.05.16.01.14.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 01:14:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <ed82fe3e0905151521m64df542eifca87073c4360fbf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119344>

On Sat, 16 May 2009, Timur Tabi wrote:
> On Fri, May 15, 2009 at 4:36 PM, Jakub Narebski <jnareb@gmail.com> wrote:

> > Gitweb can deal with non-bare repositories. It is only that because
> > gitweb is not interested in working area, it shows $GIT_DIR (path to
> > repository itself) as name/path to repository. Therefore repo/.git
> > for non-bare repositories, because it is repository itself that matters.
> 
> I understand that, but why does gitweb have to punish me because I
> give it more than it cares about?

Gitweb doesn't punish you for using non-bare repositories. Gitweb is
just consistent: all that matters to gitweb is repository itself
($GIT_DIR), therefore it uses 'project/.git' as a project name for
non-bare, because this is $GIT_DIR for it.

Besides, why do you care that your non-bare repositories have
'project/.git' as their name? As Junio wrote it is a good idea to be
able to distinguish between bare and non-bare repositories. Perhaps
I should remove description of workaround from the patch...


Anyway I'd rather not complicate further 6336 lines long 
gitweb/gitweb.perl, one of largest scripts in git repository. One would
have to add stripping s!/\.git$!! from repository path (project name)
on display, and do additional check for $path/.git when checking if
what we were given looks like git repository.

> 
> > If you provide access for others, i.e. if those repositories shown in
> > gitweb are public repositories, it is much better to use bare
> > repositories for that.
> 
> Why?  What difference does it make if they clone directly from my
> working tree, instead of some shadow repository?

Well, best practice is to not change (rewrite) published history. This
means that you very strongly shouldn't even use "git commit --amend",
neverthemind "git rebase" and reordering patches and squashing bugfixes
using "git rebase --interactive" (or other tools like StGit or Guilt)
on the branches you meant to share. Because otherwise you would seriously
inconvenience developers which base their work your work on
shared/published branch.

Also you should take into account that if you publish your working,
non-bare repositories, all your branches are visible to the world.
So unless you tell other developers which branches are meant to share,
and which are not, you would have trouble with working on topic branches.
And for more complicated features best practices demand that you do them
as a series of commits rather than one big complicated patch on feature
branch, and it is hard to create a perfect, or just good (so it doesn't
look like "A, B, oops fix A, C, oops revert B, oops fix C"), series of
commits on first try. And there is also bit of complication for other
developers if you, as best practices tell you should, delete no longer
used (merged in) short term feature branches; this would require pruning
remote-tracking branches by other developers.


So unless you work by yourself (and then see git-instaweb), it is really
better to have separate public publishing repository, which is bare.

-- 
Jakub Narebski
Poland

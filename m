From: bill lam <cbill.lam@gmail.com>
Subject: Re: combine git repo historically
Date: Sat, 10 Oct 2009 22:03:58 +0800
Message-ID: <20091010140358.GA3924@debian.b2j>
References: <20091009012254.GA3980@debian.b2j>
 <4ACED204.3000907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Oct 10 16:08:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwcch-0006p9-0p
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 16:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761278AbZJJOEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 10:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbZJJOEo
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 10:04:44 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:64920 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbZJJOEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 10:04:43 -0400
Received: by pzk7 with SMTP id 7so2840244pzk.33
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qGJ/9JdCJfAEJp/8ms3Io52vKmpqsg3oIqJZ7qupo2U=;
        b=Yq+5LWaVlMuM3sww1H7uMRRa5bxv+fnzwyqi+i6PDANw7nK+9ZFpl5cN2bwzNkZO88
         f6sjbSTj1lQEkW3F3ZSPLZvgdx9DC2hT4epgqBVdav+P1aeB9ITB0zO3K9MXajmeYQ9W
         t/2KKA/3zjlT4+4LKCmNz7+EF2qTrj9DUsoXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T6rX/nnCiRFt+R/ZcwVOZa77K3LtfqXeDfV+mEi3curWRhHXd2b7unrEulXuv0eU4m
         GPur4GfNCA17QMzMKuk3w+aubsGT7laTZG1noSmUJHkkJFMO80gULXOYuRTvkvy8FwY6
         xI95YCUunx8O6/3S9sMKRyxJral2+ytitkCZk=
Received: by 10.114.2.12 with SMTP id 12mr5567086wab.52.1255183447468;
        Sat, 10 Oct 2009 07:04:07 -0700 (PDT)
Received: from localhost (n219077027017.netvigator.com [219.77.27.17])
        by mx.google.com with ESMTPS id 21sm228320pzk.7.2009.10.10.07.04.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 07:04:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ACED204.3000907@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129883>

On Fri, 09 Oct 2009, Johannes Sixt wrote:
> bill lam schrieb:
> > I have two git repos, no branches.
> > 
> > repo 1.
> >   emptyrootcommit -- A ... M 
> > 
> > repo 2.
> >   emptyrootcommit -- N ... Z
> > 
> > N was evolved from M but the time gap is large, how can I combine them
> > into one repo
> > 
> > emptyrootcommit -- A ... M -- N ... Z
> > 
> > so that snapshots N .. Z will not be changed.
> 
> $ echo $(git rev-parse N) $(git rev-parse M) >> .git/info/grafts
> $ git filter-branch --tag-name-filter cat -- --all --not M
> 
> i.e. you graft the older history right before the younger history, then
> you use git filter-branch to rewrite the parentship of the younger commits.
 

Thanks,  graft is new to me. I tested it works but it needs first issue
   git fetch /path/to/repo1
within repo2 to fetch tip M from repo1 into repo2, is it correct?

If I also want to fetch also all objects from repo1, what will the
command to do it.

Christian Couder also mentioned the git-replace command, how to stitch
with it?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3

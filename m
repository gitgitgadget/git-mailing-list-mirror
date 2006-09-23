From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Even more support for PATH_INFO based URLs
Date: Sat, 23 Sep 2006 16:55:49 +0200
Message-ID: <200609231655.49915.jnareb@gmail.com>
References: <200609200049.52036.jnareb@gmail.com> <20060923142941.GL8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 23 16:56:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR8vJ-0000zZ-7m
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 16:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWIWO4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 10:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWIWO4D
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 10:56:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:2546 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751224AbWIWO4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 10:56:01 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1214134nfa
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 07:55:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XELv32EaDay4MYJZuRZ3B5+h1JsdTf1aRNND9T7SUVGB/ENPAf5g0+AlqEmKWGqLccujhg+1zgKJQXZaJ+J4v72Gp7CP9y9/Pfybmmp8f8ASIWBSmCiT5tqBeZ/clzfaelVFhZGQfvGdf5jNU1vQ65IatIz6istNXCuoe1LDxHA=
Received: by 10.78.97.7 with SMTP id u7mr783541hub;
        Sat, 23 Sep 2006 07:55:59 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id 39sm345432hug.2006.09.23.07.55.58;
        Sat, 23 Sep 2006 07:55:58 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060923142941.GL8259@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27593>

Petr Baudis wrote:
> Dear diary, on Wed, Sep 20, 2006 at 12:49:51AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
> > Now the following types of path based URLs are supported:
> > 
> > * project              overview (summary) page of project
> > * project/branch       shortlog of branch
> > * project/branch:file  file in branch, blob_plain view
> > * project/branch:dir/  directory listing of dir in branch, tree view
> > 
> > The following shortcuts works (see explanation below):
> > 
> > * project/branch:      directory listing of branch, main tree view
> > * project/:file        file in HEAD (raw)
> > * project/:dir/        directory listing of dir in HEAD
> > * project/:            directory listing of project's HEAD
> 
>   I haven't followed this stuff carefully but just to confirm, there is
> currently no way to persuade gitweb to actually produce such links,
> right?
> 
>   I like pathinfo and would like to use it for repo.or.cz's gitweb.

Well, all inner links go through href() subroutine, so this is where
you would want to make changes. Having project in pathinfo would be easy,
having branch/ref harder because it might be in hash, or in hash_base
parameter.

Perhaps we should use
	my $path_info = $ENV{MOD_PERL} ? $r->path_info() : $ENV{PATH_INFO};
-- 
Jakub Narebski
Poland

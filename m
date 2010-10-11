From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb: Show git clone url on projects list
Date: Tue, 12 Oct 2010 01:11:08 +0200
Message-ID: <201010120111.09436.jnareb@gmail.com>
References: <AANLkTi=5P1OiKprOifyu2xuFjVToL5kE9dXrEr3gSr+_@mail.gmail.com> <m3iq1efhlp.fsf@localhost.localdomain> <4CB3812B.8060209@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Manuel Doninger <manuel@doninger.net>, git <git@vger.kernel.org>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Tue Oct 12 01:11:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5RWY-0000de-FD
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 01:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab0JKXLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 19:11:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41884 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0JKXLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 19:11:12 -0400
Received: by bwz15 with SMTP id 15so2037518bwz.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UixpyAhAWFONXtNGFKfgpYrvZXoIuNx8nVdGApkWcYU=;
        b=UCyFqbZn1jz0IvE/7tO8xjFiw293lr48LogRwvG660CAlVuUUIXk6MKdu5YMulNpag
         g+HlNqJWW+1dXLcUMc+FWA4Nq6W3M10rpslUJSsIs72mAyjxpwipAg/D+9EslbVKziao
         uwLbDe7ObzsEfmjfgYqcpfNFI0RaqfTEh4HLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Z5ilQtkSVP51Hco0iua8rcewk7zN4Ed4WRsPY+rgST0Z8tYCyNSqn9MM7t0YtXsCGW
         IoC4tFNlEVhdDD6Zra8uWKm1DBWyNzIepFS9WnCTO9Kt99/403s3w0iKGYKRdtcmwi6A
         DLRZnu6seFCdtIVhF70XbOSrNihmGvZQPvSoo=
Received: by 10.204.119.80 with SMTP id y16mr5201517bkq.113.1286838669974;
        Mon, 11 Oct 2010 16:11:09 -0700 (PDT)
Received: from [192.168.1.13] (abwu155.neoplus.adsl.tpnet.pl [83.8.244.155])
        by mx.google.com with ESMTPS id 4sm3167875bki.1.2010.10.11.16.11.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 16:11:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4CB3812B.8060209@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158812>

On Mon, 11 Oct 2010, J.H. wrote:
> Sorry for the late response, was traveling on the 7th.  Comments inline.
> 
> > There were multiple attempts to add such link to core gitweb (i.e. the
> > one present in git 1.7.3), but were not merged in due to runing
> > aground the following problems:
> > 
> > 1. There might be more than one link for one git repository.  One can
> >    provide git://, http:// and ssh:// URLs.  Which one to chose?
> > 
> >    This issue might be solved by either using first one on the list,
> >    or filtering and showing link(s) to anonymous unauthenticated ones,
> >    i.e. _git_ link (if git:// URL exists) and perhaps _http_ link (if
> >    http:// URL exists).
> 
> If you are running a uniform enough site, http://git.kernel.org,
> http://git.fedorahosted.org/git/, etc it's easy enough to deal with.
> This only becomes an issue if/when you allow more generic trees to
> exist, and aren't expecting a uniform git link.

The issue is that solution in core gitweb (as opposed to local version)
should be generic enough.  Is supporting single link per repository
generic enough?

> > 2. More important issue is that besides @git_base_url_list the URL or
> >    URLs for a repository can come from various other places: from
> >    'cloneurl' text file and from `gitweb.url' configuration variable.
> >    It it was taken into account (even to check that such configuration
> >    does not exist) it would badly affect performance of generating
> >    projects list page.
> > 
> >    The git.kernel.org gitweb doesn't have this problem because it uses
> >    @git_base_url_list (I think unconditionally); also it supports
> >    output caching, so eventual performance hit is migitated.
> 
> We actually don't, at least currently, use @git_base_url_list.  Right
> now there's a configuration variable to set a uniform server / base url,
> and then use project path to append to that.  git:// in this case is
> hard coded, though with http being smart now there is no reason why that
> should be that way (no one has asked for the change &/or submitted a
> patch to me to alter that behavior).

Well, @git_base_url_list by default is empty or is single-element list
filled using GITWEB_BASE_URL build time configuration variable.  The
URL or URLs for a repository are composed of elements of @git_base_url_list
concatenated with project name; in most common non-empty case it would be

  "$git_base_url_list[0]/$project"

while, from what I understand, the solution used by http://git.kernel.org
is

  "git://$gitlinkurl/$project"

Not much difference.
 
> The caching helps, though since I'm not actually using @git_base_url the
> caching isn't of significant impact, since I only need to know the path
> vs. poking in the repo directly.  (that said caching still buys me a lot
> of performance overall).
> 
> Assuming you are using my caching version of gitweb setting $gitlinkurl
> in your config file to be the base (before the path) of your link, it
> should work.  Should get that even if caching is disabled, though YMMV I
> don't do a lot of testing with the cache turned off, and I haven't
> written a test case for that yet.

Caching is not necessary when using only @git_base_url_list, but is
necessary when project URLs can come from $projectroot/$project/cloneurl
file, or from `gitweb.url` repository config.  And even if they are not
set, if they can be used, we have to check them.

The solution might be to specify somehow that only @git_base_url_list
(or even only $git_base_url_list[0]) is to be taken into account when
generating _git_ links on project list page.

-- 
Jakub Narebski
Poland

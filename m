From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 22:34:14 +0200
Message-ID: <200807172234.19146.jnareb@gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <m3k5fks2et.fsf@localhost.localdomain> <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJaCK-0005DY-FG
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbYGQUeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbYGQUea
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:34:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:39003 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867AbYGQUe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:34:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so36534fgg.17
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 13:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AMMNLV9pniI66TAFLo8gGOF8SjBXE4V1dyu1oZGm/fQ=;
        b=h2MdLHxr/SXoAdjRvullHpM0UlFa+z0j6Sicg3N4OxRM4JQabpWlKr6nFYycVyNoDP
         +lJilkWjCriEnmOzR/tORFiPS/uQOu5YWA5iYoqeJTyBpAPjCRwonwFQJkVs1it7NJoM
         rZgggMDEezZEIUQuRklE/2Vjbi6bDZyHdjQqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FGZ6flL9cTqVi9/0vi28LbSZXInRl01jXx6HsPfyP9zXdbPnjDpdz7B96AQrIgTg3K
         UD4INhGOXqTJnoTauWYOr2dQbTeG0nFYRsGnM7rJn+3cYLRMDv28kS4BtwZxjPUEoYGE
         8A5HEQyloOs5Ll1+Rq6RUtoHTekSyqYWp4WfQ=
Received: by 10.86.72.15 with SMTP id u15mr4691845fga.22.1216326868018;
        Thu, 17 Jul 2008 13:34:28 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.74])
        by mx.google.com with ESMTPS id 3sm686816fge.3.2008.07.17.13.34.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 13:34:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <38486DD8-B4D8-4AAC-9B5F-0A8035D894DD@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88911>

On Thu, 17 July 2008, Kevin Ballard wrote:
> On Jul 17, 2008, at 1:04 PM, Jakub Narebski wrote:
> 
>> Git submodules are roughly equivalent to svn:externals with peg
>> revisions; I mean here that they refer not to some branch in some
>> external repository, but to specific revision.  This is the only sane
>> design, as it assures that when checking out some historical revision,
>> the state that is checked out will be the same for everybody.
>>
>> Please take into account however that submodules are quite new
>> feature, and while underlying engine is solid, interface (UI) needs
>> some polishing (and use cases).
> 
> There is one facet of submodules that annoys me, because it prevents  
> me from using them as a replacement for svn:externals. Namely, the  
> submodule refers to a specific repository, but not a path within that  
> repository. I work with svn repos that use svn:externals to peg  
> revisions (as is appropriate) but they all refer to various paths  
> within the other repositories, and the only way I can deal with that  
> is to throw symlinks everywhere.

I don't quite understand.  At the lowest, "gitlink" level submodule
entry is just having _commit_ object in place of directory.  And of
course this commit object refers to top tree (top directory) in
a subproject.

If you have subproject B with the following file structure

  B/foo
  B/bar/baz

and you have (super)project A, which contains B as subproject at path
sub-b, and has some files itself, the directory sytucture would look
like this:

  A/quux
  A/sub-b/foo
  A/sub-b/bar/baz


What you want, I guess, is some a bit weird for me mixture of submodule
and partial (subtree) checkout... and the latter is not implemented yet
(I say "yet" because there was some preliminary implementation of
subtree checkout on git mailing list).
-- 
Jakub Narebski
Poland

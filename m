From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: Migrating from subversion via git svn contains log entry, but not 
	the file change in the branch.
Date: Mon, 3 May 2010 13:52:41 +0100
Message-ID: <p2g86ecb3c71005030552odafaa805ob43f7f0c8a9be0b8@mail.gmail.com>
References: <1272889536578-4997493.post@n2.nabble.com> <4BDEC3AE.90409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: magnuspalmer <magnus.palmer@jayway.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 03 14:53:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8v94-00005P-2B
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 14:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758795Ab0ECMxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 08:53:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42011 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765Ab0ECMxE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 08:53:04 -0400
Received: by pxi5 with SMTP id 5so190133pxi.19
        for <git@vger.kernel.org>; Mon, 03 May 2010 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=qz+E6Nv0hjqpcItKlKO1ea/43z7CnC32C3+X2FoLvno=;
        b=bfYuz3IgyLwz4XX0ZgyfbFQXJA9H0S3s5LFdlpNM2Flg8GhuYpCm/fDXrj023uIeaX
         WQqPxUwlFwWFXKfzILKI1pHszEnEfejHuTI0ohldJyU0ftyA8tL06dWWT/0T2VP/b783
         U9gFYHTyzYG6qpLcfz9GA2/SK8n4EX9tGiS7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=hnc6kNwVA4T4OfgmmHOo5M+Cmk8RwPQFlnDuaC4aUcy20PK4UKx/eJ7fVUZiUcpLVd
         jetp0BwwBsI1Pdki7N35z5GQiiian6paTb+OJNxwGyaL6wmqFlc5qKOeXQQevuKqG8jN
         bwFSdgnX1i0srlsSnFZVM0irWvQniCiObf6fc=
Received: by 10.142.6.33 with SMTP id 33mr2785222wff.135.1272891181118; Mon, 
	03 May 2010 05:53:01 -0700 (PDT)
Received: by 10.142.191.1 with HTTP; Mon, 3 May 2010 05:52:41 -0700 (PDT)
In-Reply-To: <4BDEC3AE.90409@drmicha.warpmail.net>
X-Google-Sender-Auth: 3aac881d9d50123a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146233>

On 3 May 2010 13:38, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> magnuspalmer venit, vidit, dixit 03.05.2010 14:25:
>>
>> I've been working almost fulltime for two weeks migrating a subversion
>> repository to git.
>> Most repos go fine, but some doesn't and I'm running out of options.
>>
>> Been trying to find posts regarding this and tried what I've found.
>>
>> The subversion repo contains subrepos.
>> Layout is this:
>> tags
>> branches
>> <trunk is in root dir, contains only a maven pom.xml>
>> subrepo-a(with standard layout: trunk, tags, branches)
>> subrepo-n
>>
>> Team is doing ongoing development in currently four branches (develop,
>> release-product-a-1.1, release-product-b-1.0, trunk). I'll deal with that
>> later.
>>
>> What happends is that I get the svn log message, but the file is not the
>> correct one, or the file is completely missing suddenly.
>> git checkout develop
>> HEAD is now at 5269d17... increased version to 1.2.0-SNAPSHOT.
>>
>> The change in the file is not there, the old version number in the pom.xml.
>> I compare this with the one checkout out via svn.
>>
>> git svn init --trunk='' --tags=tags/*/* --branches=branches --prefix=svn/
>

I've actually just edited .git/config and then did git svn init URL.
Found this easier for complex layouts, cause then you can control
everything that is happening.

[svn-remote "svn"]
        url = http://mingw-w64.svn.sourceforge.net/svnroot/mingw-w64
        fetch = trunk:refs/remotes/trunk
        branches = {experimental,web}:refs/remotes/*
        tags = branches/releases/*:refs/remotes/releases/*
        fetch = :refs/remotes/git-svn

From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH GSoC 2/3] git-instaweb: Configure it to work with a global 
	server root and projects list
Date: Wed, 19 May 2010 00:26:25 +0530
Message-ID: <AANLkTilhdkw7v-jV9JNBx8qvGBCenieExRh_zVm3hAKq@mail.gmail.com>
References: <1273953520-25990-1-git-send-email-pavan.sss1991@gmail.com>
	 <1273953520-25990-2-git-send-email-pavan.sss1991@gmail.com>
	 <m3ljbhcp46.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 20:56:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OERxy-0001Zj-Pp
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 20:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541Ab0ERS42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 May 2010 14:56:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50667 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510Ab0ERS40 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 14:56:26 -0400
Received: by gwaa20 with SMTP id a20so1329045gwa.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=98807vMWDTktLn0MK8j+vHiIj69oMQO020zA4xJt6Xw=;
        b=C45/t9w+rjtk0gmc6K2GOCRcTisgC1v1Mdhhmr+klsw6GvK7ZcJdJ1oASJQPNkR4GD
         jD9t/GciKetkUp7lfJTXe/QJ/1xI3wegY/dl6QQajpMJtTim+lfGV56hf55Ba7Lawqv5
         jc1oOC6er4DMz7l7tQltNzKWstyNWKXDg61IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Onoal14n6K7eQ/NQ8a37A28+FuauA1AUrUECSROw3HX5HCG9714rd2vGxvixeJsTn5
         SUmKq+b8tQYgzOdyIX/HuVY0BsU0uNqDM4UwgkGXdtvfsrnGJpu60gQTGF3bxsBE2yI3
         /1Ns73oZmVFYDvAEYeSTDu1pP/kmxZUUvN988=
Received: by 10.90.18.20 with SMTP id 20mr2856895agr.125.1274208986005; Tue, 
	18 May 2010 11:56:26 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Tue, 18 May 2010 11:56:25 -0700 (PDT)
In-Reply-To: <m3ljbhcp46.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147296>

> While I can agree with `instaweb.root' config variable to *override*
> the default, it should have sane default, and setting it should be no=
t
> required to be able to run git-instaweb. =A0Therefore the 'install'
> target of main Makefile should either:
> a.) install gitweb into gitdir=3D$(sharedir)/gitweb, and make
> =A0 =A0instaweb.root be $(sharedir)/gitweb by default
> b.) install gitweb into $(gitwebdir), which only have $(sharedir)/git=
web
> =A0 =A0as default, and embed $(gitwebdir) in git-instaweb script when
> =A0 =A0building, so that it would be default value of instaweb.root
>
> This would probably mean replacing either @@sharedir@@ or @@gitwebdir=
@@
> placeholders in git-instaweb.sh when building git-instaweb.

Yeah I will do that.

>> and the httpd.conf along with server logs and pid go into
>> '$(HOME)/.gitweb' directory.
>>
>> As there is no need to call git-instaweb in every git repository,
>> configure gitweb to get $projects_list from file '$(HOME)/.gitweb/li=
st'
>> and $projectroot is ''
>>
>> Example of ~/.gitweb/list:
>> home%2Fpavan%2Fgit%2F.git Linus+Torvalds
>> home%2Fpavan%2Fgsoc%2F.git Pavan+Kumar+Sunkara
>
> This is quite a large change on how git-instaweb works.
>
> First, I think such change should be better left for a separate
> commit, splitting this one in two: one making git-instaweb use
> installed gitweb files, and installing gitweb files somewhere when
> installing git, and second changing how git-instaweb behave.
> "Do one thing, and do it well." =A0It would make easier to check
> if there are errors in the commit.

Ok.

> Second, in my opinion it is not a good change at all. =A0Currently yo=
u
> can run "git instaweb" when inside git repository, and get a web
> browser (or a new tab in existing session of a running web browser)
> with current repository in it, to browse its history. =A0It is simila=
r
> to running gitk (or other graphical history browser, like qgit, tig,
> etc.), or running "git log", but with web interface.

Yes. But this change is vital for the success of my GSoC project. I
will explain why.
If you remember, my GSoC project contains some functionalities like
creating/cloning repositories which need a server which need to start
outside git directory.

Until now, I thought to use git-instaweb to do this. But I realised
now that it would be better if we have another script.
So we need to have a different "git-client" script which starts this cl=
ient.

What do you say ?

> Now, current git-instaweb behavior has its quirks, but having
> git-instaweb show _current_ repository is a very important feature,
> and I'd rather we didn't lose it in transition.
>
> So in my opinion it would be better to just update git-instaweb and
> generating git-instaweb to make use of installed gitweb and installed
> gitweb files, but do not change organization of generated files; just
> instead of gitweb.cgi there should be gitweb_config.perl with
> appropriate configuration to show current repository. =A0And of cours=
e
> there would be no gitweb files in $GIT_DIR/gitweb (in .git/gitweb)
> directory.

Ok. Sure I will do it.

Thanks
- Pavan

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Add support for --infodir
Date: Sat, 28 Feb 2009 02:57:55 +0100
Message-ID: <200902280257.56932.jnareb@gmail.com>
References: <tim.visher@gmail.com> <20090228002550.22597.53878.stgit@localhost.localdomain> <9a0027270902271712y57839e22w492f7ad46baf49b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Tim Visher <tim.visher@gmail.com>
To: David Syzdek <syzdek@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 02:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdEUK-0000hZ-AR
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 02:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbZB1B6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 20:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbZB1B6F
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 20:58:05 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:42082 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbZB1B6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 20:58:04 -0500
Received: by fxm24 with SMTP id 24so1307733fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 17:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1ax05iVRFVjqGUo/2V+wNoFt2v1mbVM1fUVqQfufPkw=;
        b=D1gOQAWqji+ZKdDnEhIbMOd1pKY33HqwapuP7ZyKrrJ6u3BIEieF1HBHy4KkeEVeuq
         9Mob5Wk3wWJRkHIcr52GDq/ECP05+Gweh05SjNYc07QNRBbWRmQLFS0Hk+nal8ofZXJV
         O/w93EjkZCz5fD5WdQkYL+CQRfs0KCsMqmfWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BoRbOW/26oVrkTrVsdc/gHSkD7LJXIP7KSw1XdRNgKTvjI/Dn1hE08mrrqlr2+Mrky
         fgniDVRgEPaeGo1/3m2/Q3Z9YtdPVys7gpSXSWSNBZWqKpduf0kIxL25faofHnaVDvRx
         mHs9+G4dxigdICNEIWzu2NzKBu557J71O8Oow=
Received: by 10.103.173.5 with SMTP id a5mr1639374mup.57.1235786281160;
        Fri, 27 Feb 2009 17:58:01 -0800 (PST)
Received: from ?192.168.1.15? (abwe96.neoplus.adsl.tpnet.pl [83.8.228.96])
        by mx.google.com with ESMTPS id n7sm518136mue.6.2009.02.27.17.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 17:58:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <9a0027270902271712y57839e22w492f7ad46baf49b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111737>

On Sat, 28 Feb 2009, David Syzdek wrote:
> On Fri, Feb 27, 2009 at 3:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 26 Feb 2009, Jeff King wrote:
>>> On Thu, Feb 26, 2009 at 09:48:29AM -0500, Tim Visher wrote:
>>>
>>>> I'm working on getting git 1.6.2-rc2 built.  I have a bin, man, info,
>>>> and html directory in my home folder that I'd like to use as the
>>>> defaults for git.  I attempted to do this through
>>>>
>>>>     make configure
>>>>     ./configure --XXdir=/full/path/to/dir
>>>>     make all man info html
>>>>     make install install-man install-info install-html
[...]

>>> The configure support is notoriously incomplete (AFAIK, very few of the
>>> active developers use it regularly). Probably you need something like
>>> this (but I didn't test it):
>>>
>>> diff --git a/config.mak.in b/config.mak.in
>>> index 7cce0c1..505d5c7 100644
>>> --- a/config.mak.in
>>> +++ b/config.mak.in
>>> @@ -18,6 +18,8 @@ datarootdir = @datarootdir@
>>>  template_dir = @datadir@/git-core/templates
>>>
>>>  mandir=@mandir@
>>> +htmldir=@htmldir@
>>> +infodir=@infodir@
>>>
>>>  srcdir = @srcdir@
>>>  VPATH = @srcdir@
>>
>> Well, the infodir part works trivially, because autoconf (and
>> therefore ./configure script) has support for --infodir=DIR.
>> Below there is patch that adds that, with the commit message.
>>
>> But it is more difficult with respect to --htmldir. I am not autoconf
>> hacker, so I don't know how to add support for having --htmldir=DIR in
>> ./configure (in configure.ac).  What can be done is to derive htmldir
>> in config.mak.in from other sources, for example:
> 
> Autoconf add support for --htmldir in version 2.60.  Here is a snippet from
> the help message from a configure script generated with 2.60:
> 
> --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
> 
> --docdir=DIR            documentation root [DATAROOTDIR/doc/PROJECT_TARNAME]
> 
> --htmldir=DIR           html documentation [DOCDIR]
> 
> 
> The current configure.ac requires autoconf version>= 2.59, bumping the
> requirement to autoconf>= 2.60 would allow the autoconf variable $(htmldir)
> to be used.  Bumping the required version of autoconf will affect users with
> older linux installations who use git to upgrade git; and may affect the
> maintainer's ability to create a "release" tarball if he has an older
> version of autoconf.

Well, I have autoconf 2.59, so I cannot test the following patch
(and I am not sure if it is welcome). And of course it needs commit
message, at least with explanation why bumping required version of
autoconf was needed.

-- >8 --
diff --git a/config.mak.in b/config.mak.in
index acff9ed..56a0147 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -19,6 +19,7 @@ template_dir = @datadir@/git-core/templates
 
 mandir=@mandir@
 infodir=@infodir@
+htmldir=@htmldir@
 
 srcdir = @srcdir@
 VPATH = @srcdir@
diff --git a/configure.ac b/configure.ac
index 082a03d..b1ab0e1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,7 +1,7 @@
 #                                               -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)
+AC_PREREQ(2.60)
 AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])

-- 
Jakub Narebski
Poland

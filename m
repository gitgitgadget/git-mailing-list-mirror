From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Use character class for sed expression instead of \s
Date: Thu, 25 Oct 2012 19:08:53 +0100
Message-ID: <CAP30j15n1hVn6zptDpAfM+Aqc3LnRR4PN6jHTHpTkcjYLgPnjw@mail.gmail.com>
References: <508935CB.9020408@web.de>
	<1351180699-24695-1-git-send-email-bdwalton@gmail.com>
	<C2AB6973-7BC2-45A4-836E-BB1FAAE7501C@gernhardtsoftware.com>
	<5089689A.9070301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>, peff@peff.net,
	bosch@adacore.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:09:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRRrf-00021h-JB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 20:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760078Ab2JYSIy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 14:08:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63020 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759795Ab2JYSIx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 14:08:53 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1845577obb.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0/2RHlgEwI/E9mBzQshDFVwIfTP3FPEF2ooldgNQSXM=;
        b=vB29Fgz/Jbj0vig2jkdqhHssx4TQSz7y+k7Ki7llfRTzecN/SsU2mFsnen0nJqai3Z
         XQLosGMLkLrNYaUFl2KvcS8swWOE/d2F6BIB1VHwSTJl1tkIchmyk6mhb4+jC2/MoGkP
         gQk7rLg637cvG8Yl/QsnSDXyqa85yPMN5oZ8GZ22ZW2xGY3zrq0cxrsuN2n1K2Ax3HDS
         zcmSYy9rbRYTE6a6LUF8bwLd7P6HpyNnmO2sAtHj4SvSZoaEcPImHfqgW0SFezYhGK6s
         kX1FmalmneSSFulilZAanBKSuJ4wSSPWlvIO9diLd2VOej4xdH6QRiJUw8tMpGeAz+sS
         nc7w==
Received: by 10.60.31.175 with SMTP id b15mr1370907oei.76.1351188533185; Thu,
 25 Oct 2012 11:08:53 -0700 (PDT)
Received: by 10.76.173.1 with HTTP; Thu, 25 Oct 2012 11:08:53 -0700 (PDT)
In-Reply-To: <5089689A.9070301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208414>

Hi Torsten,

On Thu, Oct 25, 2012 at 5:28 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:

> BTW: While we are talking CVS: (I installed a fresh version)
> cvs --version
> Concurrent Versions System (CVS) 1.11.23 (client/server)

I have 1.12.13-MirDebian-8 here.

> And t9200 fails:
> git checkout t9200-git-cvsexportcommit.sh
> tb@birne:~/projects/git/git.pu/t> ./t9200-git-cvsexportcommit.sh
> cvs [init aborted]: Cannot initialize repository under existing CVSRO=
OT: `/Users/tb/projects/git/git.pu/t/trash directory.t9200-git-cvsexpor=
tcommit'
> FATAL: Unexpected exit with code 1

I'm not able to reproduce this manually...are you able to make it fail
this way outside of the test harness?

$ CVSROOT=3D$PWD/bw
$ export CVSROOT
$ mkdir $CVSROOT && cvs init && echo ok
ok
$ rm -rf $CVSROOT
$ cvs init && echo ok
ok

>> (cvs init || mkdir "$CVSROOT" && cvs init ) &&

If your version of cvs fails the checks above in manual testing, we
could see if there is a flag that works in all (old and new) versions
to override the failure if CVSROOT exists.  Otherwise, this isn't a
bad fix, I don't think.

If your version does fail the manual checks, I think it's likely a
regression that was introduced and later reverted.  I don't see those
strings inside my cvs binary at all...?

HTH.

Thanks
-Ben
--=20
-----------------------------------------------------------------------=
----------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
-----------------------------------------------------------------------=
----------------------------------------------------

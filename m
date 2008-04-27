From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Sun, 27 Apr 2008 15:38:39 +0800
Message-ID: <46dff0320804270038t651d94d4t3c63fe0cb5240e0d@mail.gmail.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
	 <1207230582.17329.39.camel@gandalf.cobite.com>
	 <47F5FA79.8010604@alum.mit.edu>
	 <1207590845.17329.98.camel@gandalf.cobite.com>
	 <47FC2190.3070303@alum.mit.edu>
	 <46dff0320804262206p76941ee8la6a784ed0b6f8294@mail.gmail.com>
	 <48141379.9030306@alum.mit.edu>
	 <46dff0320804262251g3a0f12b2rb9197fc07ea57c51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Mansfield" <david@cobite.com>,
	"Steffen Prohaska" <prohaska@zib.de>, git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 27 09:39:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq1U4-0002Xa-Q2
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 09:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYD0Hil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 03:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYD0Hil
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 03:38:41 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:55216 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYD0Hik (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 03:38:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so1101747and.103
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=17SokyTgQAup6mgffhA26Hz+dchnFkRsMoldT192V58=;
        b=O+YMmde/uIV5hSEYgo8ZsrHowh2lUpAB4/IGbhG1ojYJyDFYkB/YAl0HKQ/xSUb6JwYCg3x7I81PjA/BbTgamhIfuw4uf73p9PGndgkXUAXAxQagr+x1fILcdo2b7I+WP3X976ktSDHM0pA//+HyibjCF/0L1agn2Fkz16sgNGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=arBXhyW4GJ5ILSvnev9W7PnakdXK3eJOTrDD7Nr9z69axlWBhv2VXO3RueiYHeWqPAZr4hpJEGeOgLCGSmYtRRJxGpcNZ3zdsZKaeIZc03U+84xj2q3zYbtT530jj1VKweyDHqnTq6R/paJxXk3Y4eRzR8gTwJP/bLlRv1JXLxY=
Received: by 10.100.133.1 with SMTP id g1mr10104009and.88.1209281919480;
        Sun, 27 Apr 2008 00:38:39 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sun, 27 Apr 2008 00:38:39 -0700 (PDT)
In-Reply-To: <46dff0320804262251g3a0f12b2rb9197fc07ea57c51@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80430>

On Sun, Apr 27, 2008 at 1:51 PM, Ping Yin <pkufranky@gmail.com> wrote:
> On Sun, Apr 27, 2008 at 1:47 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>  > Ping Yin wrote:
>  >  > These days i tried to convert the cvs repository into git. I really
>  >  > want the conversion to be as accurate as possible. However, the cvs
>  >  > repository has been tagged in a very bad style which makes
>  >  > git-cvsimport or cvsps not work well.
>  >  >
>  >  > cvs2git sounds to be the right tool i should try. Unfortualely, i
>  >  > can't touch the cvs repository directly. So is it possible to use
>  >  > cvs2git in the remote host instead of the host of the cvs repository
>  >  > just as git-cvsimport does? Yes, i know it can't now. I just wonder
>  >  > whether it is possible to implement.
>  >
>  >  cvs2svn/cvs2git itself can't work with remote repositories.  It would be
>  >  enough if you could just get a copy of the repository; obviously you
>  >  don't need to use the original.
>  >
>  >  If you can't get a copy of the CVS repository directly, you might be
>  >  able to recreate it indirectly via information read over the CVS
>  >  protocol using a tool like CVSsuck [1,2].  I have no experience with
>  >  CVSsuck, so if you try it out, please let us know whether you were
>  >  successful.
>  >
>
>  THX. If i try out cvssuck, i will let you know.
>

Great, i succeed. And the result is exactly what i want!

However, it is so so slow.

Here is a example to convert a module util from cvs to git
--------------------------------------------------------------------------------------------
$ cvssuck $CVSROOT util                   <1>
$ mkdir util/CVSROOT                        <2>
$ edit cvs2svn-git.options and cvs2svn-example.options
   ( change run_options.add_project and ctx.cvs_log_decorder)
$ cvs2svn --options=cvs2svn-git.options
$ mkdir util.git && cd util.git && git init
$ cat ../cvs2svn-tmp/git-{blob,dump}.dat  | git-fast-import
-------------------------------------------------------------------------------------------
<1> very slow, about 30 minutes for a very small module.
       Other steps are fast enough.
<2> I have to create a dir util/CVSROOT to avoid the error
"util is not a CVS repository, nor a path within a CVS repository.  A
CVS repository contains a CVSROOT directory within its root
directory."


-- 
Ping Yin

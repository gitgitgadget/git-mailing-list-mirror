From: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 05:20:41 +0200
Message-ID: <f3d7535d0605222020j2d581bd9j602752659a4b3ac2@mail.gmail.com>
References: <Pine.LNX.4.64.0605170919290.10823@g5.osdl.org>
	 <6471.1147883724@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 23 05:20:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiNRw-0005Az-KH
	for gcvg-git@gmane.org; Tue, 23 May 2006 05:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWEWDUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 23:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWEWDUn
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 23:20:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:19191 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWEWDUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 23:20:43 -0400
Received: by wr-out-0506.google.com with SMTP id 68so1973470wra
        for <git@vger.kernel.org>; Mon, 22 May 2006 20:20:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ohcmXEyks1lfYMlWWqDMPVXdPlG7XQPVh0944bJ79A5COZIW/FJHhorKvA+V2tYtngOOyneyBEn1wE0DNieo9CDQpUXYWPhVx1pKwrI5jeF5iWRNpAoe7K8g6rLTXOLr+Jgz1ln7RulHWmQj1WPfgokWoyREGTXz7Ivh61+d4AQ=
Received: by 10.65.248.12 with SMTP id a12mr1463291qbs;
        Mon, 22 May 2006 20:20:42 -0700 (PDT)
Received: by 10.64.253.10 with HTTP; Mon, 22 May 2006 20:20:41 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <6471.1147883724@lotus.CS.Berkeley.EDU>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20563>

Hi Jason,

2006/5/17, Jason Riedy <ejr@eecs.berkeley.edu>:
> And pkgsrc itself works just fine without the silly g prefix,
> or at least does for me as a mere user (and as well as it does
> work).  But if you intend on adding the package upstream, it'll
> need something to cope with the g.  And pkgsrc handles local
> patches...

Well I had some problems on NetBSD without the g prefix for the
gnu coreutils - since then I always used that prefix.

But now I have a completely different problem with the tests on
solaris. It seems on solaris access() always returns 0 if a file is
existant and the effective uid is 0.

so:
--- snip ---
#include <stdio.h>
#include <unistd.h>

int
main (int argc, char **argv)
{
  printf ("access: %d\n", access("/etc/motd", X_OK));
  return 0;
}
--- snap ---

will return 0 on solaris - when run as root, even though /etc/motd
is not executeable. This seems to break hooks on Solaris - but
I'm not sure if this is only a Solaris Express bug. (I have no Solaris
10 system to verify it)

bye

Stefan

-- 
       http://www.dreamind.de/
Oroborus and Debian GNU/Linux Developer.

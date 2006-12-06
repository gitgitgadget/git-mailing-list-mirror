X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 06 Dec 2006 17:40:59 +0100
Message-ID: <4576F29B.6010105@xs4all.nl>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061656.55888.jnareb@gmail.com> <4576E9DF.5090709@xs4all.nl> <200612061727.54058.jnareb@gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 16:41:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 43
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <200612061727.54058.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33487>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grzpw-0006yQ-CU for gcvg-git@gmane.org; Wed, 06 Dec
 2006 17:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936427AbWLFQlR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 11:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936399AbWLFQlR
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 11:41:17 -0500
Received: from main.gmane.org ([80.91.229.2]:50172 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936427AbWLFQlQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 11:41:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrzpO-0001Yh-Lo for git@vger.kernel.org; Wed, 06 Dec 2006 17:41:02 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Wed, 06 Dec 2006 17:41:02 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006 17:41:02
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
>> there should be Makefiles in said directories. Otherwise, every rule
>> in the toplevel Makefile saying
>>
>>
>>   $(MAKE) -C subdir/
>>
>> will fail because $builddir/ does not have a Makefile in
>> $builddir/subdir.
> 
> Wouldn't it be better just to modify toplevel Makefile to say:
> 
>    $(MAKE) -C $(srcdir)/subdir/
> 
> without messing with ./configure script, and creating "redirect"
> Makefiles?
> 

that doesn't work.

  make -C foo bla

just does 

  (cd foo && make bla)

If you did this, part of the object files would end up in the source dir; 
The idea of separate srcdir builds,is to keep the srcdir completely clean 
of generated files.  That can't really be done without aid of a script,
to setup the builddir. In this case that is the configure script.

I did forget to add a check 

  if "$srcdir" != "." ; then
    ..
  fi

around the messy stuff.



-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

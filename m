From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Thu, 05 May 2011 16:45:40 +0200
Message-ID: <4DC2B814.5070507@viscovery.net>
References: <20110428022922.GC4833@camk.edu.pl> <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl> <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org> <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl> <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org> <7vwri5c27e.fsf@alter.siamese.dyndns.org> <20110505142910.GA31229@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Thu May 05 16:45:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHzoQ-0001Y1-2O
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 16:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1EEOps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 10:45:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45697 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753132Ab1EEOpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 10:45:47 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHzoC-0000fp-Kg; Thu, 05 May 2011 16:45:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5D95B1660F;
	Thu,  5 May 2011 16:45:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110505142910.GA31229@camk.edu.pl>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172835>

A:

> 1. ./configure --prefix=dir1  and dir1 != /usr
> 
>     git_etcdir = etc
> 
> 2. ./configure --prefix=/usr
> 
>     git_etcdir = /etc
> 
> 3. ./configure --prefix=dir1 --syscondir=dir2 (here dir2 has to be an
> absolute path)
> 
>     git_etcdir =  dir2

Why do you have the restriction that --sysconfdir must be absolute? Is it
imposed by autotools?

  4. ./configure --sysconfdir=dir2

     git_etcdir =  dir2

B:

> 1. make prefix=dir1 and dir1 != /usr
> 
>     git_etcdir = etc
> 
> 2. make prefix=/usr
> 
>     git_etcdir = /etc
> 
> 3. make prefix=dir1 sysconfdir=dir2 (here dir2 can be an absolute or
> a relative path)
> 
>     git_etcdir = dir2

  4. make sysconfdir=dir2

      git_etcdir = dir2

C:
in config.mak write none, one, or both of

  prefix=dir1
  sysconfdir=dir2

with the same 4 case distinctions and corresponding desired results as in B.

Looks fine and simple to implement, except that I don't see that you have
to introduce git_etcdir; can't you just stick with the name "sysconfdir"?

-- Hannes

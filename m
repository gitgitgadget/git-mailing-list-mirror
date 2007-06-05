From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-svn and googlecode.com?
Date: Tue, 5 Jun 2007 10:05:44 +0100
Message-ID: <200706051005.46603.andyparkins@gmail.com>
References: <46651AAD.4010705@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 11:06:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvUzK-0005IX-2W
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762630AbXFEJFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762368AbXFEJFz
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:05:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:43887 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762077AbXFEJFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:05:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so52760nfb
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 02:05:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D2TVjf+Ltq/eTgzgOEUvnQHunSkM+h9Hk5/oJrirLIJacYMZW/ccDOHACxlLywiQYYWbvFs2SeuZsBjiec2pGy5kwT0Q28bIpETA7uxdYvGuD5mIMhY6bNC/xV+SJr/V5EFKDAdpCWuJBQNDvpofiANhW5phyelP9pv6iPaMIaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OfGa/agJc32DWMSo0gjvy6WzyPMSgK3roTJXcwh3eHYWgGPLT/jb9RDTsKXaDmS4FN8suUEQu5deZ/J7Mo13eGO2pjQY0zpMiOZ49AH1TR8abcDcQ3Ku/Ysn2zKHLw7XZ2QqTCD6d9nHUSViYUe4MNgGQ/4XYRXvF1tBsUPDiTk=
Received: by 10.82.112.16 with SMTP id k16mr8281451buc.1181034352347;
        Tue, 05 Jun 2007 02:05:52 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z37sm2751775ikz.2007.06.05.02.05.49;
        Tue, 05 Jun 2007 02:05:51 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <46651AAD.4010705@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49172>

On Tuesday 2007 June 05, Rogan Dawes wrote:

> (Original) svn checkout http://webgoat.googlecode.com/svn/trunk/ webgoat
>
> (Funny, the initial path component had a space in it?!)

I suspect that that is not the case.  The form of svn checkout is:

 svn checkout <url> <directory>

So your command is saying check out http://webgoat.googlecode.com/svn/trunk/ 
to the local directory "webgoat".  That is to say - it doesn't have a space 
in it and in fact is nothing to do with the URL at all.

> 0 $ git-svn clone -T "trunk/ webgoat"
> https://webgoat.googlecode.com/svn/trunk/
> Initialized empty Git repository in .git/
> Using higher level of URL: https://webgoat.googlecode.com/svn/trunk =>
> https://webgoat.googlecode.com/svn
> W: Ignoring error from SVN, path probably does not exist: (175002): RA
> layer request failed: REPORT request failed on '/svn/!svn/bc/100':
> REPORT of '/svn/!svn/bc/100': 200 OK (https://webgoat.googlecode.com)
> Path 'trunk/trunk/ webgoat' was probably deleted:

... which explains this error because there is no path "trunk/ webgoat".


> However, the following command line does seem to work:
>
> git-svn clone -T "trunk/ webgoat" https://webgoat.googlecode.com/svn/

Oh dear; I'm surprised it worked as well as it did.  I just ran this command, 
which seemed to work well:

 $ git-svn clone -T trunk http://webgoat.googlecode.com/svn/ webgoat-local

This clones webgoat.googlecode.com/svn to the local directory webgoat-local; 
you can change "webgoat-local" to anything you want, it's just naming the 
directory on your own computer.

If you're the maintainer then perhaps you will want to change "http" 
to "https" as well.

> Note that I manually removed the "trunk" component from the URL. This
> suggests that there is something missing in the automatic "Using higher
> level" detection code.

I think there is no bug; it's simply a misunderstanding.  git-svn working 
wonderfully for me.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

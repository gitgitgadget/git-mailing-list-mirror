From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 10:23:31 +0700
Organization: AcademSoft Ltd.
Message-ID: <200808011023.32139.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <200807311257.49108.litvinov2004@gmail.com> <20080731104529.GE7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 05:24:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOlG1-0007i8-G3
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 05:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbYHADXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 23:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbYHADXn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 23:23:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:27054 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbYHADXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 23:23:43 -0400
Received: by ug-out-1314.google.com with SMTP id h2so449897ugf.16
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HGeITIMsAn1PEmzVif2PQYCbzl+x2ULU7ql2k9MT/o8=;
        b=TLaDCkP9wdhzjWdWM/nEuR/vYDlj1Pp0cJ2xKDyLhIcduOzdZTMaLPG3yNivBwcv5s
         nE4SSjZ/LxlRqDiLC8WqOk470UjG0szFvcdSLLjuwKgT11c8dzjt1lDQxeL971qPD2Al
         BV9a98WajsVHUXVYijfya/TKHsi1ZA8+W7Mrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CDLmMH+Jy6O/S9MZBDQ2SY2Ieuydgu3HN3thaqcHgnTnObj5qxKLSPe9/8LA1j2lEM
         865Pv2c5t4GZgSYXr6y3sg4qNkkkTahlWQ/AupvciZfCVT67vuzJPPMhXooU7ZnDsR+G
         MBl4iXKl34K2+2efxwl0v+Fn0tK2eMuGD9dJ8=
Received: by 10.67.115.2 with SMTP id s2mr3267347ugm.49.1217561020393;
        Thu, 31 Jul 2008 20:23:40 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id e34sm13098777ugd.71.2008.07.31.20.23.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 20:23:39 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <20080731104529.GE7008@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91024>

> It does not look to be true. I did the following test:
...
> which means that the autocrlf conversion is done for temporary
> files created by perl. (I tested it on Linux and Windows/Cygwin).
>
> In any case, I believe the right solution should be adding a
> new option to git-hash-object to disable any conversion.

My bad, I did not append full thoughts. git-hash-object DOES autocrlf 
convertion but  it cant do it correctly. All it can do - is to autodetect 
text files. My setup has .git/info/attributes file where all files but .cpp 
and .h are binary. While .cpp and .h are text files. In this case 
git-hash-object do not know the real file name as far as git-svn use 
temporary files.

I dont think that disabling convertion is a good way. I really want to convert 
my files. Possible solution is to pass two file names to git-hash-object: the 
real file with content and the proposed file name in the working directory. 
In this case git-hash-object will be able to make correct convertion.

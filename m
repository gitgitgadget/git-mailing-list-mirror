From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Allow gitk to start on Cygwin with native Win32 Tcl/Tk
Date: Sat, 20 Oct 2007 14:47:33 -0400
Message-ID: <471A4D45.1040107@gmail.com>
References: <20070922050446.GA28467@spearce.org> <18201.59649.800748.780690@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <shawn.o.pearce@bankofamerica.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 20:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjJMV-0001WE-Bx
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 20:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757331AbXJTSrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756506AbXJTSrj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 14:47:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:40910 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757071AbXJTSri (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 14:47:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so866924wxd
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=dxxNhS6QzaO5+jtTnvDwatvNFAUq/Z6vSpSFwOqj+sY=;
        b=az+wrl2FhJr8xWtNUjMgzRQxLdB05a7D3IPrLrLjTP28up/sZyEdCtZi/M/CPLvzFoEwUjHX3bEsJFkxv7ALCTEXhYxtxXP+EXwVkiGbDzpcW5nNYs+ifxfoHaWX9jGZeuaVTQrUyfF6jd6jYukQ8mbSjTWXDXliKud55hEpm8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b/FR17gZmQ6G+424npWjJIe68S5gytcdrnDijzZaeCiAPK7u6aR6KKgv/M84s9jFMn2cz/e3ycjESlFVKlGskxMzvA6icc0LLpwbGS+YRcaeTwJIAwFpdThZajvmU9eNJ8CYN5812MeQUjHFesXL5N1mvFRJkoLwl2HWNPr1O28=
Received: by 10.90.70.10 with SMTP id s10mr4954093aga.1192906057493;
        Sat, 20 Oct 2007 11:47:37 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.225.127])
        by mx.google.com with ESMTPS id c30sm4739549ana.2007.10.20.11.47.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Oct 2007 11:47:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <18201.59649.800748.780690@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61849>

Paul Mackerras wrote:
> Shawn O. Pearce writes:
>
>   
>>  Yes, I admit this is an odd patch.  I can certainly carry it in
>>  my own tree (I already carry some other patches) but I wonder if
>>  we shouldn't include it as some users may actually try to do this,
>>  just like I did.  Latest git-gui `master` already has changes to its
>>  Makefile and shell startup boilerplate to handle this weird case.
>>     
>
> Why do you need to change gitk itself?  If you're going to modify it
> with sed, why can't you change the $0 on the 3rd line to the installed
> path of the gitk script?
>
>   
While gitk is most likely installed as /usr/bin/gitk in Cygwin's 
filespace, that could resolve to anything in the Windows file system. It 
might be c:\cygwin\usr\bin\gitk, but could also be "d:\Documents and 
Settings\Bill\Programs\cygwin\usr\bin\gitk" depending upon who installed 
it and with what options. Both are seen as /usr/bin/gitk by Cygwin. 
Thus, Shawn is correct in using cygpath to resolve the name.

Also, as Cygwin's tcl/tk package is bound to the port of the insight 
debugger to Cygwin, and that project is stuck for years on 8.4.1, this 
patch (or something like it) may be the only way to allow gitk to access 
a more recent version on Cygwin in the foreseeable future. So, I think 
this is a good idea.

Mark

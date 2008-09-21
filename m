From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
Date: Sun, 21 Sep 2008 09:48:27 +0200
Message-ID: <C76DB1B2-D9AB-4BA1-A983-E39D156F56A6@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de> <1218977083-14526-2-git-send-email-prohaska@zib.de> <200808172235.48321.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 09:53:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhJlD-0001Io-6P
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 09:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYIUHsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 03:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYIUHsd
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 03:48:33 -0400
Received: from mailer.zib.de ([130.73.108.11]:33472 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbYIUHsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 03:48:32 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8L7m7Kv014077;
	Sun, 21 Sep 2008 09:48:12 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83fe5.pool.einsundeins.de [77.184.63.229])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8L7m5cB024085
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 21 Sep 2008 09:48:06 +0200 (MEST)
In-Reply-To: <200808172235.48321.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96384>


On Aug 17, 2008, at 10:35 PM, Johannes Sixt wrote:

> On Sonntag, 17. August 2008, Steffen Prohaska wrote:
>> MSYS' automatic path conversion causes problems when passing paths  
>> as '-D'
>> arguments to the compiler.  MSYS tries to be smart and converts  
>> absolute
>> paths to native Windows paths.  But we want the paths as we compute  
>> them in
>> the Makefile.
>
> Huh? Doesn't the Makefile compute paths like "/c/path/to/git"? We  
> certainly
> don't want to compile such paths into git that in Windows speak  
> actually
> mean "c:/path/to/git" - git is not an MSYS program and wouldn't  
> understand
> the former. Which form of conversion are you refering to?


MSYS' automatic path conversion causes problems when passing paths as
defines ('-D' arguments to the compiler).  MSYS tries to be smart and
converts absolute paths to native Windows paths, e.g. if MSYS sees
"/bin" it converts it to "c:/msysgit/bin".  But we want completely
unmodified paths; e.g. if we set bindir in the Makefile to "/bin", the
define BINDIR shall expand to "/bin".  Conversion to absolute Windows
path will takes place later, during runtime.

I'll update the commit message.

	Steffen

From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW port usable
Date: Thu, 01 Feb 2007 11:34:50 +0100
Organization: eudaptics software gmbh
Message-ID: <45C1C24A.471F40AD@eudaptics.com>
References: <200701292320.43888.johannes.sixt@telecom.at> <45C18A3B.2070004@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 11:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCZGG-00076A-61
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 11:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbXBAKdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 05:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbXBAKdo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 05:33:44 -0500
Received: from main.gmane.org ([80.91.229.2]:48810 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422768AbXBAKdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 05:33:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCZG0-0002yL-8n
	for git@vger.kernel.org; Thu, 01 Feb 2007 11:33:32 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 11:33:32 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 11:33:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38341>

"H. Peter Anvin" wrote:
> 
> Johannes Sixt wrote:
> > (*) The reason is that on Windows read() and write() cannot operate on
> > descriptors created by socket(). A work-around is to implement a (threaded)
> > proxy, but that's almost the same as if netcat were used as
> > GIT_PROXY_COMMAND.
> >
> 
> Actually, I believe it can for the NT series kernels (at least 2000 or
> later, not sure about the earlier ones), but not for the DOS-based ones.
> 
> The trick is to use _open_osfhandle() to convert the file handle (a
> WinAPI construct) to a file descriptor (which in Windows is a construct
> of the C library.)

I tried this, but it doesn't seem to work. I get an EINVAL at the first
write() to the socket. I conclude that the things returned by socket()
are not WinAPI file handles that are valid for WriteFile(). :(

-- Hannes

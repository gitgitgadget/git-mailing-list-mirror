From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now
	noticibly faster on windows.
Date: Sat, 08 Nov 2008 17:52:10 +1100
Message-ID: <1226127130.8252.6.camel@therock.nsw.bigpond.net.au>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
	 <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
	 <ee77f5c20811072119y65738f54o7e6792fb405c142c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 08:59:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyijS-0001Jq-Ab
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 08:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbYKHH6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 02:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbYKHH6O
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 02:58:14 -0500
Received: from nschwqsrv01p.mx.bigpond.com ([61.9.189.231]:39310 "EHLO
	nschwqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753106AbYKHH6N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 02:58:13 -0500
Received: from nschwotgx02p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas03p.mx.bigpond.com with ESMTP
          id <20081108064144.WHFD11562.nschwmtas03p.mx.bigpond.com@nschwotgx02p.mx.bigpond.com>;
          Sat, 8 Nov 2008 06:41:44 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx02p.mx.bigpond.com with ESMTP
          id <20081108064140.WDXL21966.nschwotgx02p.mx.bigpond.com@therock.local>;
          Sat, 8 Nov 2008 06:41:40 +0000
In-Reply-To: <ee77f5c20811072119y65738f54o7e6792fb405c142c@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150205.491534A4.0039,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100389>

On Fri, 2008-11-07 at 21:19 -0800, David Symonds wrote:
<snip>
> _gitConfig = None
> def gitConfig(key):
>   if _gitConfig is None:
>     lines = read_pipe("git config -l", ignore_error=True).readlines():
>     _gitConfig = dict([l.strip().split('=', 1) for l in lines])
>   return _gitConfig.get(key, None)

That certainly is better, if one can assume that git's configuration is
small. (And relative to the memory usage of the script, it will
definetly be small).

I shall give that a go, although the change won't make it even faster -
I suspect that much of the performance penalty in windows is the
pathetic fork() performance, particularly as the memory usage of the
script increases. (If subprocess does fork() and exec() in order to open
another process, in cygwin).

Thankyou.

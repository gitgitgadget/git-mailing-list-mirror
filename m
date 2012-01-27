From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: make install rewrites source files
Date: Fri, 27 Jan 2012 10:46:55 +0100
Message-ID: <79b0e5e55a438cc757cfeb6408be4d23@ulrik.uio.no>
References: <hbf.20120123bz2f@bombur.uio.no> <4F1DC2F7.2070502@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 11:05:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqigO-0004zw-R5
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 11:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab2A0KFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 05:05:20 -0500
Received: from mail-out2.uio.no ([129.240.10.58]:34184 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721Ab2A0KFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 05:05:19 -0500
X-Greylist: delayed 1102 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2012 05:05:19 EST
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1RqiOV-0002uW-R1; Fri, 27 Jan 2012 10:46:55 +0100
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx1.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1RqiOV-0001mY-EK; Fri, 27 Jan 2012 10:46:55 +0100
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Fri, 27 Jan 2012 10:46:55 +0100
In-Reply-To: <4F1DC2F7.2070502@ubuntu.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2109 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 39C4C51489B50A1F9283B73898BC6FBDF746A31A
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 246 total 2045007 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189212>

 On Mon, 23 Jan 2012 15:28:39 -0500, Phillip Susi <psusi@ubuntu.com> 
 wrote:
> On 1/23/2012 9:18 AM, Hallvard Breien Furuseth wrote:
>> However, make install should not write to the source directory in
>> any case.  That fails as root if root lacks write access there, due
>> to NFS mounts that map root to nobody etc.  At least git-instaweb
>> and GIT-BUILD-OPTIONS are rewritten.  You can simulate this with su
>> nobody -s /bin/bash -c 'make -k install' after configuring with
>> prefix=<directory owned by nobody>.
>
> If you want to build locally from a read only nfs mount, then you
> should run the configure script in a local directory:
>
> mkdir /tmp/build
> (...)

 Not a read-only nfs mount.  Just an ordinary remote mount where root
 on the local host is mapped to nobody on the remote host.  (Having
 local root access does not mean you should get root on the remote.)

 In any case, it's normal practice to do as little as possible as root,
 and also to at least try not write to the source dir during install.
 BTW, building in /tmp can be nasty to other users when you don't know
 how much space the build (and maybe test) will use, so you may need
 access to some other local dir.

-- 
 Hallvard

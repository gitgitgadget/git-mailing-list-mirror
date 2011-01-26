From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 14:29:53 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com> <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com> <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
 <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mika Fischer <mika.a.fischer@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 14:30:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi5Rj-0003Zs-30
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 14:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184Ab1AZN34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 08:29:56 -0500
Received: from giant.haxx.se ([80.67.6.50]:60262 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab1AZN3z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 08:29:55 -0500
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9.1) with ESMTP id p0QDTrmC026034;
	Wed, 26 Jan 2011 14:29:53 +0100
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165519>

On Wed, 26 Jan 2011, Mika Fischer wrote:

> But I noticed that the same problem occurs on OpenSuSE 11.2. So I compiled 
> the latest version of curl on OpenSuSE 11.2 and the problem is still 
> present...

Sorry, but I can't repeat this problem. I tried this:

1. I got OpenSSL 1.0.0c, built it and installed it.

2. I started OpenSSL's little HTTPS server with this version:

$ openssl s_server -HTTP -cert [PEM]

(I verified, and this binary uses the lib statically so there's no funny lib 
path issues here.)

3. I tried getting a file through this using curl 7.21.2 and my current dev 
version of 7.21.4-DEV (see below for full details). Both managed to get it 
fine.

>From this, I conclude that there's some additional factors necessary to make 
this problem trigger. Can you figure out what?

The full curl -V outputs from my two test versions:

curl 7.21.2 (i486-pc-linux-gnu) libcurl/7.21.2 OpenSSL/0.9.8o zlib/1.2.3.4 
libidn/1.18 libssh2/1.2.6
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 
pop3s rtsp scp sftp smtp smtps telnet tftp
Features: GSS-Negotiate IDN IPv6 Largefile NTLM SSL libz

curl 7.21.4-DEV (i686-pc-linux-gnu) libcurl/7.21.4-DEV OpenSSL/1.0.0c 
zlib/1.2.3.4 c-ares/1.7.5-DEV libidn/1.18 libssh2/1.2.8_DEV librtmp/2.2e
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 
pop3s rtmp rtsp scp sftp smtp smtps telnet tftp
Features: AsynchDNS Debug TrackMemory GSS-Negotiate IDN IPv6 Largefile NTLM 
SSL libz

-- 

  / daniel.haxx.se

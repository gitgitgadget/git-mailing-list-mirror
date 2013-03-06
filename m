From: Yves Blusseau <yves.blusseau@gmail.com>
Subject: Re: Using socks proxy with git for http(s) transport
Date: Wed, 6 Mar 2013 10:21:42 +0100
Message-ID: <CABmRxH2CGTxFaGufSMgUqhrSTZPvFBHoEnP8-p5HhkU4kszJPw@mail.gmail.com>
References: <CABmRxH1g2BR+-MvGZ4J-2vC8NDq3x8pG148hXfuYTpUkX0L=0A@mail.gmail.com>
	<20130306082110.GA31638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 10:22:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDAY7-0007NB-4L
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 10:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab3CFJVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 04:21:46 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:37023 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab3CFJVm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 04:21:42 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so5731489pbb.27
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 01:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=kB3vRM9LTRz2HOnz/2jB28a3/m/SUUkZk3omXHA4Iwc=;
        b=Z44xwl5wfdLELDTKCHl23QyiohXBeJdtSHBFmzQ1n6yS+MR4lMI0q3HdRy7ITlRj0X
         gSormSIUBNSookRClB61fzASEDlz5jYl7DRJV8oGzEOUImD7x93xC7OavezVWdxzwknz
         MpymX0Yit7TTxStfDCOC3KVa8ojQeRpRaP2G3ywMjCAO4dIass4J8fIT1WVGY03Crv4k
         /hEQLDuEQ7WgMbISai3q7j+bw3rgsKgplL8QvzoNUc1aHPC0PnfkqI+KSSu5GMNidMWX
         EpdoepgvQuoEIidfcKzb3lOOkxMvZk7xcAin0mQGQoUgiwWbuAhjYtm4lDZlvJQDEu4b
         k0ug==
X-Received: by 10.68.49.73 with SMTP id s9mr12422054pbn.106.1362561702085;
 Wed, 06 Mar 2013 01:21:42 -0800 (PST)
Received: by 10.68.136.225 with HTTP; Wed, 6 Mar 2013 01:21:42 -0800 (PST)
In-Reply-To: <20130306082110.GA31638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217509>

> Try:
>
>   git config --global http.proxy 'socks://yourhost:port'
>
> That will enable it for all git repositories on your machine. Git should
> also respect any environment variables that curl handles (because we use
> libcurl under the hood), if you prefer to set it up that way. See "man
> curl" for details.

Thanks Jeff but it's not working.
I use git 1.8.15
My socks proxy listen on my localhost at port 1080 so I do:
git config --global http.proxy  'socks://127.0.0.1:1080'

But when i try to talk with a git server with http protocol i have:

GIT_TRACE=1 GIT_CURL_VERBOSE=1 git ls-remote
http://git.kernel.org/pub/scm/git/git.git

trace: built-in: git 'ls-remote' 'http://git.kernel.org/pub/scm/git/git.git'
trace: run_command: 'git-remote-http'
'http://git.kernel.org/pub/scm/git/git.git'
'http://git.kernel.org/pub/scm/git/git.git'
* Couldn't find host git.kernel.org in the .netrc file, using defaults
* About to connect() to proxy 127.0.0.1 port 1080
*   Trying 127.0.0.1... * connected
* Connected to 127.0.0.1 (127.0.0.1) port 1080
> GET http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.8.1.5
Host: git.kernel.org
Accept: */*
Accept-Encoding: gzip
Proxy-Connection: Keep-Alive
Pragma: no-cache

* Empty reply from server
* Connection #0 to host 127.0.0.1 left intact
error: Empty reply from server while accessing
http://git.kernel.org/pub/scm/git/git.git/info/refs?service=git-upload-pack
fatal: HTTP request failed

As you can see git connect to my socks proxy (Connected to 127.0.0.1
(127.0.0.1) port 1080) but seems to send the http request directly
instead of a socks command. So it does'nt work :(

Regards,
Yves

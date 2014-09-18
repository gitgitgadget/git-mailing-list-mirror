From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Broken handling of URL with literal IPv6 address
Date: Thu, 18 Sep 2014 15:03:32 +0200
Message-ID: <541AD824.2040401@web.de>
References: <2004412952.561305.1411039751559.open-xchange@app02.ox.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Christian Taube <lists@hcf.yourweb.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 15:03:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUbN5-00018A-Be
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 15:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbaIRNDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 09:03:35 -0400
Received: from mout.web.de ([212.227.17.12]:51722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbaIRNDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 09:03:35 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LtnvF-1YVPHs0JyH-011F6J; Thu, 18 Sep 2014 15:03:33
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <2004412952.561305.1411039751559.open-xchange@app02.ox.hosteurope.de>
X-Provags-ID: V03:K0:i7BpQW4WHdawU1nZvFmbQ/Q9PImc+hhhovRvesX2AFgujYs/Lr0
 8GZe9GROgkpFIkPeymunSfnTcY8Q35bJFdLujksq742l3B9WAx4ysL3QBkwHD7O1LyaiQib
 NBBzIixEXDDR9YdQea+73BNqJynNJaeQDjPPcC3UYOx4sx7cG8SeF9QB7ykKYmVVudXzjdn
 XKciKSQAKNDkWwUe0a7Jg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257259>

On 2014-09-18 13.29, Christian Taube wrote:
> 
> Hello,
> 
> I was sent here from the IRC channel.
> 
> 
> Using git 2.1.0, the command
> 
>   git clone ssh://[2001:db8::1]/repo.git
> 
> succeeds, but adding a username to the URL like this
> 
>   git clone ssh://user@[2001:db8::1]/repo.git
> 
> fails with an invalid hostname message:
> 
> Cloning into 'repo.git'...
> ssh: Could not resolve hostname [2001: Name or service not known
> fatal: Could not read from remote repository.
> 
> 
> I found this workaround:
> 
>   git clone ssh://[user@2001:db8::1]/repo.git
> 
> but this seems to be contrary to the definition of URLs in RFC 3986.
> 
> http://tools.ietf.org/html/rfc3986
> 
> 
> Please have a look at this. Thank you!
> 
> 
> --
> Christian Taube

This is indeed a bug.
We handle literal IPv6 adresses OK, we handle ssh://user@host OK.
But it seems as if you are the first one using the combination of both,
thanks for the bug report.

If somebody want to have a look in the Git source tree:
connect.c, t/t5500-fetch-pack.sh and t/t5601-clone.sh may deserve an update.
 

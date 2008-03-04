From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Tue, 4 Mar 2008 16:12:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041608420.22527@racer.site>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZm0-0000Tq-UX
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763833AbYCDQNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763638AbYCDQNK
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:13:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54296 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763401AbYCDQNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:13:09 -0500
Received: (qmail invoked by alias); 04 Mar 2008 16:13:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 04 Mar 2008 17:13:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IU449TuKI92ZkJXsDEpbw/HiAdMBnk2xZA9pXK+
	Ae/q5lRKYwUr6O
X-X-Sender: gene099@racer.site
In-Reply-To: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76113>

Hi,

On Wed, 5 Mar 2008, Ping Yin wrote:

> [submodule "service"]
>    submodule = crawler
>    submodule = search
> [submodule "crawler"]
>    submodule = util
>    submodule = imcrawter
> [submodule "search"]
>    submodule = util
>    submodule = imsearch
> [submodule "util"]
>    url = git://xyzzy/util.git
> [submodule "imsearch"]
>    path = search/imsearch
>    url = git://xyzzy/imsearch.git
> [submodule "imcrawler"]
>    path = crawler/imcrawter
>    url = git://xyzzy/imcrawter.git

In "git remote", we also have a notion of groups.  It looks much nicer, 
IMO.  So why not do this?

[submodules]
	service = crawler search
	crawler = util imcrawler
	search = util imsearch
[submodule "util"]
    url = git://xyzzy/util.git
[submodule "imsearch"]
   path = search/imsearch
   url = git://xyzzy/imsearch.git
[submodule "imcrawler"]
   path = crawler/imcrawter
   url = git://xyzzy/imcrawter.git

However, I think that being able to specify submodule groups recursively 
is only adding to confusion, so I would even prefer this:

[submodules]
	service = util imcrawler imsearch
	crawler = util imcrawler
	search = util imsearch
[...]

Ciao,
Dscho

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 21:27:05 +0100
Message-ID: <200612102127.05894.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612102011.52589.jnareb@gmail.com> <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 20:25:08 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aZyPAE6N5sTdrQqHvLlkhOhCZNR4U5RMQvMVG+mQQ+h5+oJdnNVPS6z//hU2i5Z6mLfo4tM5/CBGn/nq1zgckUBnjiTTYmzoF/QlOFodm1BNQurpsMSU7xJ1NhN/42zI0IujvUHXeyq3R/FuWFB6JrinM+lJl44TS5oeZ1aGyAE=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33923>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtVEL-0007CX-65 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762514AbWLJUYx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762541AbWLJUYx
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:24:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:59865 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762514AbWLJUYw (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 15:24:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1155797uga for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 12:24:51 -0800 (PST)
Received: by 10.67.20.3 with SMTP id x3mr8730959ugi.1165782291416; Sun, 10
 Dec 2006 12:24:51 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id k1sm6154545ugf.2006.12.10.12.24.49; Sun, 10 Dec
 2006 12:24:50 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 10 Dec 2006, Jakub Narebski wrote:
>>>> If-Modified-Since:, If-Match:, If-None-Match: do you?
>> 
>> And in CGI standard there is a way to access additional HTTP headers
>> info from CGI script: the envirionmental variables are HTTP_HEADER,
>> for example if browser sent If-Modified-Since: header it's value
>> can be found in HTTP_IF_MODIFIED_SINCE environmental variable.
> 
> Guys, you're missing something fairly fundamnetal. 
> 
> It helps almost _nothing_ to support client-side caching with all these 
> fancy "If-Modified-Since:" etc crap.
> 
> That's not the _problem_.
> 
> It's usually not one client asking for the gitweb pages: the load comes 
> from just lots of people independently asking for it. So client-side 
> caching may help a tiny tiny bit, but it's not actually fixing the 
> fundamental problem at all.

Well, the idea (perhaps stupid idea: I don't know how caching engines
/ reverse proxy works) was that there would be caching engine / reverse
proxy in the front (Squid for example) would cache results and serve it
to rampaging hordes. But this caching engine has to ask gitweb if the
cache is valid using "If-Modified-Since:" and "If-None-Match:" headers.
If gitweb returns 304 Not Modified then it serves contents from cache.

> So forget about "If-Modified-Since:" etc. It may help in benchmarks when 
> you try it yourself, and use "refresh" on the client side. But the basic 
> problem is all about lots of clients that do NOT have things cached, 
> because all teh client caches are all filled up with pr0n, not with gitweb 
> data from yesterday.

What about the other idea, the one with raising expires to infinity for
immutable pages like "commit" view for commit given by SHA-1? Even if
the clients won't cache it, the proxies and caches between gitweb and
client might cache it...

Talking about most accessed gitweb pages, the project list page changes
on every push, the project summary page and project main RSS feed
(now in both RSS and Atom formats) changes on every push to given project.
With a help of hooks they can be static pages, generated by push...
...with the exception that projects list and summary pages have _relative_
dates.

-- 
Jakub Narebski

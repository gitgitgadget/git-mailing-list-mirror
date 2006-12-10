X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 17:07:22 +1300
Message-ID: <46a038f90612092007w4637637aya1a01ec18ff16f6f@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <200612091251.16460.jnareb@gmail.com> <457AAF31.2050002@garzik.org>
	 <200612091437.01183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 04:07:37 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kApUaLjyRJZoo4tM08YVQgAboklgBB7qyjH7EHM+81FUF8WehwlonHlGkHsK6XfxinL9Bg4PuZBa3viK36FUnN4AObUU+YC1H03mUoKCVOaF0tNl3iDTwNUz73W4AgmNNY+WM7u7YGdQu5lNJFfO2saUQG5cHj8f016ZIa12gyo=
In-Reply-To: <200612091437.01183.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33867>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtFyQ-0002t1-Je for gcvg-git@gmane.org; Sun, 10 Dec
 2006 05:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759967AbWLJEHY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 23:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759968AbWLJEHY
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 23:07:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:1163 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759967AbWLJEHX (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 23:07:23 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1591361nfa for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 20:07:22 -0800 (PST)
Received: by 10.48.4.17 with SMTP id 17mr2555068nfd.1165723642265; Sat, 09
 Dec 2006 20:07:22 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Sat, 9 Dec 2006 20:07:22 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/10/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Jeff Garzik wrote:
> > Jakub Narebski wrote:
>
> >> In addition to setting either Expires: header or Cache-Control: max-age
> >> gitweb should also set Last-Modified: and ETag headers, and also
> >> probably respond to If-Modified-Since: and If-None-Match: requests.
> >>
> >> Would be worth implementing this?
> >
> > IMO yes, since most major browsers, caches, and spiders support these
> > headers.
>
> Sending Last-Modified: should be easy; sending ETag needs some consensus
> on the contents: mainly about validation. Responding to If-Modified-Since:
> and If-None-Match: should cut at least _some_ of the page generating time.
> If ETag can be calculated on URL alone, then we can cut If-None-Match:
> just at beginning of script.

Indeed. Let me add myself to the pileup agreeing that a combination of
setting Last-Modified and checking for If-Modified-Since for
ref-centric pages (log, shortlog, RSS, and summary) is the smartest
scheme. I got locked into thinking ETags.

> > That would be a good start, and suffice for many cases.  If the CGI can
> > simply stat(2) files rather than executing git-* programs, that would
> > increase efficiency quite a bit.
>
> As I said, I'm not talking (at least now) about saving generated HTML
> output. This I think is better solved in caching engine like Squid can
> be. Although even here some git specific can be of help: we can invalidate
> cache on push, and we know that some results doesn't ever change (well,
> with exception of changing output of gitweb).

Indeed - gitweb should not be saving HTML around bit giving the best
possible hints to squid and friends. And improving our ability to
short-cut and send a 304 - Not Modified.

> What can be _easily_ done:

Great plan. :-)


cheers,



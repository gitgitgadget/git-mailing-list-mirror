From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sun, 17 Apr 2011 00:19:07 +0200
Message-ID: <201104170019.07997.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104162317.56045.jnareb@gmail.com> <20110416215328.GA5739@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 00:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBDpp-0000bd-Sz
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 00:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202Ab1DPWTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 18:19:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60507 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909Ab1DPWTP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 18:19:15 -0400
Received: by wwa36 with SMTP id 36so4364480wwa.1
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+zLuFRh18Rbf75tPZ+xdkD3yKCgAXY3uMnR/mSLRsTU=;
        b=jnZUiUNE9TAdEFFL6Bhxw/6r1HHgjwMn//+4Sfu33ZgYtH7ZKU8l7Vx7rVeKjF28Nu
         7aA6oulqev/yARDvYZGaVRI1tmm9WJhwEoWEXizqeNEmY2XFlskZp1eQffENFAGpYWX7
         HQImRzumbgtp+1pimXYAT6Ax/f0aVAkU5Ybi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DzBfoiRC97op46hRXtzJtawsyQlhHbWqgUynVp4tK1Tw9C3xss32+HdqhUbxvb5hL5
         gZ8vfkyAe8HSh/l/hZpy0o9wm3uLNlp/odxGjVBK+iOp8RHs3eDITcik/LMhvQbMezFG
         wTWhqKBb3NfSdOmxjJMFwC9uLLgN7oaR0jtR4=
Received: by 10.227.108.105 with SMTP id e41mr3507893wbp.48.1302992354351;
        Sat, 16 Apr 2011 15:19:14 -0700 (PDT)
Received: from [192.168.1.13] (abvu151.neoplus.adsl.tpnet.pl [83.8.218.151])
        by mx.google.com with ESMTPS id b20sm2382172wbb.67.2011.04.16.15.19.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 15:19:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110416215328.GA5739@external.screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171698>

On Sat, 16 Apr 2011, Peter Vereshagin wrote:
> You're face to face with man who sold the world, Jakub!
> 2011/04/16 23:17:55 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :

> JN> > JN> No, fetching and pushing using HTTP transport, be it "smart" or "dumb"
> JN> > JN> Gitweb is web interface for _viewing and browsing_ repositories using
> JN>
> JN> You can configure web server in such way that you can use the same
> JN> URL for fetching with git as for browsing repository with web browser
> 
> There are more disadvantages of such  an approach:
> - for CGI, the process is being executed on every request. On some systems, e.
>   g., Windows, launching a process is very expensive, sometimes more than
>   compiling of perl source itself.

You can run gitweb as a persistent web app, using it either as FastCGI
script, or via mod_perl + ModPerl::Registry.

git-http-backend is written in C, not Perl.

> - for development, some different parts of the code for the same purpose do
>   exist, e. g., client and storage i/o. The more it is being developed, the
>   more features it satisfies, the more such a code.

Gitweb is written in Perl.  This language is good for prototyping, for
fast development, and for easy writing of a web app.  Gitweb works on
porcelain level - it is an user interface (a web one).

C is good for performance.  git-http-backend is only an example
implementation.  The "smart" HTTP protocol works on porcelain level.

>   For example, I suppose git-http-backend will have 'get a particular
>   commitdiff quickly without fetching all the repo' feature one day
>   to be used in web clients' scripts, e.g. will serve the same way
>   for git cli as a file system. This will make it have the same
>   feature like 'commitdiff' feature of a gitweb but implemented 
>   differently.

Unix philosophy which Git tries to follow is "do one thing and do it
well".

I don't believe git-http-backend would ever talk to web browsers, and
it is quite unlikely for git to acquire non-distributed client-server
mode.

And if it does acquire such feature, then gitweb will be simply modified
to use it...

> - the routing of the request, the deciding what to do with the particular
>   HTTP request, becomes more obfuscated. First, web server decides what CGI
>   should approve it. Plus two more decision makers are those 2 CGI, all different.
> 
> It's just why I never supposed git to have 2 different native web interfaces,
> especially in sight of plumbing vs porcelain contrast in cli, sorry for
> confusion.

Those are not two _web interfaces_.  Gitweb is one of web interfaces
to git repositories; more at
  https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Web_Interfaces

Fetching and pushing via HTTP is not web interface, is HTTP _transport_.
For one you use web browser, for other you use git itself.


But this discussion got very off-topic...
-- 
Jakub Narebski
Poland

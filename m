From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #02; Mon, 07)
Date: Tue, 08 Sep 2009 06:10:28 -0700 (PDT)
Message-ID: <m3k509vaym.fsf@localhost.localdomain>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 15:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml0T0-0001Y3-2Y
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 15:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbZIHNK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 09:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752251AbZIHNK2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 09:10:28 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48772 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZIHNK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 09:10:27 -0400
Received: by bwz19 with SMTP id 19so2178882bwz.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=36m0IT1y4RoQ24WVhAhHD3HeT1UhV+Ay3J0Q+rJ5LsQ=;
        b=GVap5iSTrohxd8ZjdPY3wNHKz62iOzhImJPxp5YFA3tmj0IYrqL1jS6aD/zb93pVsc
         auWA0U0WWN8bqX1xIvKunykM1BcYt9eYCNfDMn3mfDXr6BAVP4C5u5TiTME4lChGbxV/
         MZ2+PhD8/L3zutvwm/aEO4PqDVGWX5D2Qt5u8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=epPZxmaUAxFU0OI08j1bOHPgNWv3KckySauuXwNwBtxp+DG1xQMdsC1oKdgGJKDqZN
         t05hHr12vNXiDybAHT1QPaoItqoRUSL5Cmwx1nJbfhJZO2vBPITYIt49bO/LvHbKqd0B
         a3WVE0VNrVXFFpYKNWFvgxksbnLS0rrvtMPIM=
Received: by 10.204.23.199 with SMTP id s7mr13254397bkb.91.1252415428412;
        Tue, 08 Sep 2009 06:10:28 -0700 (PDT)
Received: from localhost.localdomain (abwp75.neoplus.adsl.tpnet.pl [83.8.239.75])
        by mx.google.com with ESMTPS id c28sm8551342fka.19.2009.09.08.06.10.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Sep 2009 06:10:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n88DAQMt015559;
	Tue, 8 Sep 2009 15:10:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n88DAPBY015556;
	Tue, 8 Sep 2009 15:10:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128004>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-show-size (2009-09-07) 1 commit
>  - gitweb: Add 'show-sizes' feature to show blob sizes in tree view

This is an RFC, because of a) feature naming, and b) tests.
It does work correctly, though.
 
> * jn/gitweb-blame (2009-09-01) 5 commits
>  - gitweb: Minify gitweb.js if JSMIN is defined
>  - gitweb: Create links leading to 'blame_incremental' using JavaScript
>   (merged to 'next' on 2009-09-07 at 3622199)

I plan on reverting the order of those two patches, as JSMIN patch is
more ready than 'blame_incremental' linking.

With JSMIN there is perhaps question of documenting it, and whether
git-instaweb.sh should use minified JavaScript or not (curently it
does not).  With 'blame_incremental' linking there are quite a few
issues:

 1. When to do JavaScript detection
    a. on load (current solution)
    b. on click (via event handler)
 2. How to invoke actions requiring JavaScript
    a. add 'js=1' parameter (perhaps limiting URLs, as not to
       add it e.g. to http://git-scm.com/ $home_link)
    b. rewrite action parameter, e.g. from 'blame' to
       'blame_incremental' (troubles with path_info URLs)
    c. use cookies

Current solution works, but I think is suboptimal.

>  + gitweb: Colorize 'blame_incremental' view during processing
>  + gitweb: Incremental blame (using JavaScript)
>  + gitweb: Add optional "time to generate page" info in footer
> 
> Ajax-y blame.

I'd very much like for others to check if it works with other browsers
(Internet Explorer 6, 7, 8; Opera 9, 10; Safari; Firefox 2, 3, 3.5)

-- 
Jakub Narebski
Poland
ShadeHawk on #git

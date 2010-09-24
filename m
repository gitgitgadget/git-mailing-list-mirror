From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Listing files in order they are changed
Date: Fri, 24 Sep 2010 08:59:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009240855080.31704@ds9.cixit.se>
References: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com> <20100923203814.GA10951@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Parag Kalra <paragkalra@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz3Bu-0000Hv-MT
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119Ab0IXH73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:59:29 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:55525 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750898Ab0IXH73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:59:29 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8O7xK0n000580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Sep 2010 09:59:20 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8O7xJGg000577;
	Fri, 24 Sep 2010 09:59:20 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20100923203814.GA10951@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 24 Sep 2010 09:59:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156962>

Jeff King:

> git log --pretty=format: --name-only |
>  grep . |
>  perl -ne 'print unless $seen{$_}++'

Nice one!

That made me come up with this, which shows a timestamp next to each file:

   git log --pretty=format:/%ai --name-only |
     grep . |
 	perl -ne 'if (m(^/(.*))) { $date = $1; } else { print "$date $_" unless $seen{$_}++; }'

(change %ai into whatever timestamp you want to show)

Mutating that into something that calls "touch" might be useful for those of 
us who would like an initial check-out to have last-modified times like the 
ones CVS would give you.

-- 
\\// Peter - http://www.softwolves.pp.se/

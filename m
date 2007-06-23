From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git log -z' last commit is not '\0' terminated
Date: Sat, 23 Jun 2007 07:51:07 +0200
Message-ID: <e5bfff550706222251kdc6ccb4s6caf0195682ab727@mail.gmail.com>
References: <e5bfff550706221227x4b785698taabfa7572bf8204b@mail.gmail.com>
	 <alpine.LFD.0.98.0706221451570.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 07:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1yWm-0000ik-B0
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 07:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbXFWFvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 01:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXFWFvJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 01:51:09 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:61036 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbXFWFvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 01:51:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1008508wah
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 22:51:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=owrPNv9SX+hlIZrdmFyzA9wqDtRF4KOsQ4+WEaOIdW/K2KpLzFZBT3hTmgH0Yrv0GELtPlGfBGUzYJFez3NY1NE68XDx7wBAD41KkVJiyp+nJDNeZO/3X/9M9daJgz0qmsJ2IQcaw+LeGutTfh4NH3We/n8XBMhWWhXwpIzbL6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HPCAYqs28aAeoi/lWS/ru/UISeP46uoqPryPHLGnpSq1lopsJbd3RztECIRTnXXBt6czTrIDpFeCFtL6AAqDxLpHDduizO8xbmByWJH/eMVcshgzaY5g8X4YUanO+AbicCA4AP3KWcFTgkXT+7yX87Hdu9QhyQFcqIwm/7Pjqww=
Received: by 10.114.199.1 with SMTP id w1mr3608128waf.1182577867074;
        Fri, 22 Jun 2007 22:51:07 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Fri, 22 Jun 2007 22:51:07 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706221451570.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50719>

On 6/22/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> So you should think of the "\0" as being a delimeter that goes between
> commits, not something that "ends" the commit. It's not a "end of record"
> thing, it's a "between records" thing.
>

Thanks for explanation.

Interesting enough git-dif-tree with -z, documented as

"-z  \0 line termination on output"

has a different behaviour, with and without -p option:

git diff-tree -z HEAD ---> a '\0' is printed at the end

git diff-tree -z -p HEAD --> No '\0' is printed.

I suppose 'git log' passes '-z' to 'git diff-tree' because no
documentation exsists in 'git log' man page.

Thanks
Marco

BTW git-rev-list --header uses '\0' differently (appends to each
record), but that's another story.

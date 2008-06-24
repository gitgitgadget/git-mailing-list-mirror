From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:13:23 +0200
Message-ID: <200806241413.24111.jnareb@gmail.com>
References: <m3mylbl0xb.fsf@localhost.localdomain> <willow-jeske-01l5kwGPFEDjCc7b> <200806241322.14224.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:10:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7MH-0008Qr-ST
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYFXMJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbYFXMJy
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:09:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:28318 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYFXMJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:09:53 -0400
Received: by ug-out-1314.google.com with SMTP id h2so705439ugf.16
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eHILWNvXXkcYu9g6Nz0P2Lh19GC+7U96SS2UUh+0nfw=;
        b=qam/3qv5zHRcrSJrfQ5TsToei+wQbPPd4FijPfdRTFO0v9toBVwraWoiopcqbMHMwR
         3LKv6qTe8GuC+sG/yMZtnA8Kjzj2wKfXiCJ1DyClo5AG69OisaIIw7ncPO6A2JDSmRk/
         gBmaQg9XP8xLBy0SFB4dubojsBXpEuWjNLK8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kMrssGY3iBrfC17lbCDVyLhcAXiL+K9FzOf2V8yZTTsWD+HZ+qRRQhgglzMrOmBCO7
         zR7294w0tw97ad62/eeR9hkYnapv3WcOwNTHQr8wn8Y8QBmrzsWR+68ffsXPm2x3Cgfe
         J83Ml2dmKEQuamm48S3kBP9Ja79uqanUjcEbg=
Received: by 10.66.232.9 with SMTP id e9mr3255395ugh.17.1214309391141;
        Tue, 24 Jun 2008 05:09:51 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.195.249])
        by mx.google.com with ESMTPS id a1sm33089356ugf.74.2008.06.24.05.09.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 05:09:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200806241322.14224.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86040>

Jakub Narebski wrote:
> David Jeske wrote:

> > Now, five years down the road, [...] someone does:
> > 
> >  $ git-branch -f customer_A_branch ZZZ
> 
> If they are using '-f', i.e. force, they should know and be sure what
> they are doing; it is not much different from 'rm -f *'.
> 
> If reflog for 'customer_A_branch' expired it would be hard to go back
> to old 'customer_A_branch', and impossible after garbage collector
> pruned history.

Actually it is not true.  In the case of "git branch -f <branch>", which
is the case which wouldn't be covered by protecting reflogs when
deleting branches (saving them to some kind of "attic") git _saves_
old branch pointer to reflog, so "git log -g <branch>" would work
as expected.

The reflog entry looks like the following:

   0c52414d... 80b4c7e5.. A U Thor <author@example.com> 1214306246 +0200 \
	branch: Reset from ZZZ

(where of course there are full SHA-1 of commits, instead of shortened
ones, and everything is in single line, without line continuation.)
 
> What you _should do_, if you want to preserve old 'customer_A_branch'
> pointer is to *tag* it, e.g. something like 'Attic/customer_A_branch';
> if you use annotated tags you can even state why do you want to keep
> old work, and why old work wasn't merged into long-lived branch, and
> why the work was abandoned.

This of course is still valid.

-- 
Jakub Narebski
Poland

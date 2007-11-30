From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Some git performance measurements..
Date: Fri, 30 Nov 2007 03:39:56 +0100
Message-ID: <200711300339.56867.jnareb@gmail.com>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org> <finmvm$da8$1@ger.gmane.org> <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 03:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixvnn-0007Yl-SW
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 03:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758224AbXK3CkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 21:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758114AbXK3CkI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 21:40:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:55776 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbXK3CkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 21:40:06 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2097573nfb
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 18:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=BbsNM/AzN6fYdKs14qONQaGiSO2W+QqT1s7vGXQSAhY=;
        b=pSsR+XGTlP531c0CLq4kUEYbvTqBOt4Fdnas8fXeeUeArw3Y4xDBzauYCRLn1CwR0HHWZBzBdJdIxvPQlUGaY5Ds+koUyXrEpOhVBlMeTDI6kFLqQmxGb1ZDZoXU/Ka0gjBkYHbHHh+5oxE1aqupAuME9pfSiM9FGYLJVF1QP1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ktWJd5BKwkSmwPeJ+l9mQ6YvJbKrWu5dPIatGUbGRT3+06ggKs7a3ZYqLF3eHuZoXuKUkFH3SJi7rsbWkq11083wTom4n4uNXi4OLmQyijGHvQaxqAYiRIcCJ3mXXhi1h6Uv+5mIdancJXd9tKKSmj6elHP7Qlk+Oz2v8mdJ/s8=
Received: by 10.86.82.16 with SMTP id f16mr6740539fgb.1196390405435;
        Thu, 29 Nov 2007 18:40:05 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.205.222])
        by mx.google.com with ESMTPS id g28sm8599167fkg.2007.11.29.18.40.03
        (version=SSLv3 cipher=OTHER);
        Thu, 29 Nov 2007 18:40:04 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66608>

On Fri, 30 Nov 2007, Linus Torvalds wrote:
> 
> On Fri, 30 Nov 2007, Jakub Narebski wrote:
>> 
>> Isn't there a better way to do this sorting? What is needed here is
>> (stable) _bucket_ sort / _pigeonhole_ sort (or counting sort), which
>> is O(n); quicksort is perhaps simpler to use, but I'm not sure if
>> faster in this situation.
> 
> Actually, I doubt you need to do any sorting at all: what would be easiest 
> would be to simply change "traverse_commit_list()" to use different lists 
> for different object types, and just output them in type order (semi-sane 
> order choice: commits first, then tags, then trees, and finally blobs).
> 
> Ta-daa! All done! Magic! No sorting required, because all the objects got 
> output in the right order without any extra sort phase!

Actually this algorithm has the fancy name of "pigeonhole sort" algorithm,
and is a subcase (special case) of bucket sort. Well, sort of, as there
is no final sorted list, only output in "sorted" order.

-- 
Jakub Narebski
Poland

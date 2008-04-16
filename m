From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/3] git-svn: Add --add-author-from option.
Date: Wed, 16 Apr 2008 23:23:12 +0400
Message-ID: <20080416192312.GF3133@dpotapov.dyndns.org>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com> <1208307858-31039-2-git-send-email-apenwarr@gmail.com> <7vej96v2pk.fsf@gitster.siamese.dyndns.org> <32541b130804160946s343d53d2l271b9391d89a7953@mail.gmail.com> <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Avery Pennarun <apenwarr@versabanq.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 21:34:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDEt-0005tO-Cw
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 21:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765972AbYDPTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765955AbYDPTXV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 15:23:21 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:50696 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765920AbYDPTXT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 15:23:19 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2932141fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=fVhAtf8ufqpGxnFv/a/Peks016uuK1rAku7oatxV4mQ=;
        b=TeH5qIqMoc20ntkruQhtG+3HmkOzC3GVRoL5w+9RJjDffM8gCxemWizBihcX3t3MEe/pJFBB6dBNMeJ+Vi0h6TUOOtXMUBR5KGEd+4XuXgIK42xaLnJC597FGVpR8tMl+onUtSEU49DGFdtIxWX69Eturdj+WAbV/Om1OcKPMhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VLSBJ+8w6hLdQwppk8ubOqpU7j42K9r+gyV4CQ+KnlG+cqGsXsDY23MC34W4wL7Ot0ATtvyfowE7UGO2VWqHgiowwajn4Ciye+L/phwQY4M9fElr31yfK0ibejhwnE98/k4PF12EhsZH+Ge09CrE27Qrb9KfTAXcDS4qSVfdTeI=
Received: by 10.82.159.2 with SMTP id h2mr557138bue.61.1208373798260;
        Wed, 16 Apr 2008 12:23:18 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id f4sm13025901nfh.26.2008.04.16.12.23.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 12:23:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v3aplsl3p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79729>

On Wed, Apr 16, 2008 at 11:36:26AM -0700, Junio C Hamano wrote:
> 
> It makes me wonder if there is a better way.
> 
> For example, CVS honors LOGNAME to allow you to "lie" who the author of a
> change was, which is the behaviour inherited from RCS.  I have to wonder
> if SVN has a similar mechanism to tell it "Excuse me, but I am just a
> secretary recording changes for my boss."

Yes, there is such a mechanism:
====
Revision Property (revprop)

Just as files can have properties, so can each revision in the
repository. Some special revprops are added automatically when the
revision is created, namely: svn:date svn:author svn:log which represent
the commit date/time, the committer and the log message respectively.
These properties can be edited, but they are not versioned, so any
change is permanent and cannot be undone. 
====

So, it is possible not only set the real author but also date/time.
Unfortunately, there is one problem with this approach -- by default,
these properties are disabled from modification for security reasons.
To enable modification of these properties, the administrator is
required to change some hooks. Personally, I have never observed any
SVN repository where anyone was granted the right to change them. So,
while it is possible, it is impractical.


Dmitry

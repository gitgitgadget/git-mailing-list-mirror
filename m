From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 08:47:33 -0700 (PDT)
Message-ID: <m3hcdi6n7r.fsf@localhost.localdomain>
References: <4819CF50.2020509@tikalk.com>
	<20080501144524.GA10876@sigill.intra.peff.net>
	<4819DCF1.7090504@tikalk.com>
	<20080501152035.GB11145@sigill.intra.peff.net>
	<4819E226.6000404@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:48:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrb1J-0004le-15
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761961AbYEAPri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761919AbYEAPri
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:47:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:16659 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761909AbYEAPrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:47:37 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1746538ugc.16
        for <git@vger.kernel.org>; Thu, 01 May 2008 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=T+xXd24MHiHry2iz2VtJuHGDnF1YlXGkQpzDThDPhqk=;
        b=MySdaT6XvYy+rVX1D3mIDw03CzGxIIJMyc5IQF9nmpVPYqIiL+303pbAvcw6QZCv3TD2IfK+U084dtzZRMHb0gSlq4UrMiFmoBD04nVMaxHfbZboVB++CKB78aHedd5RoEiS+MWDPK49MCJswszF4LncVgCGiVlNymf9S81az/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=sOP6bfqFNvwLHZjYiGnsLLlBD016bjBxUaOM+Ea5O8u/aiPriTfQ90/UFoa4BmflvNVOXFMFVuG1uPCGVhB4V7j7Z31pDFR+VJOCuihbx5NuXXMUTwl2gUIA11uD/EkI3t9mRWy9zPm8ZPiarIU5yKnoZe3u+BrLDtlNxB2rPlA=
Received: by 10.66.237.14 with SMTP id k14mr9624556ugh.72.1209656855083;
        Thu, 01 May 2008 08:47:35 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.219.4])
        by mx.google.com with ESMTPS id r38sm4257563ugc.55.2008.05.01.08.47.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 May 2008 08:47:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m41FlRNd011943;
	Thu, 1 May 2008 17:47:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m41Fl53i011937;
	Thu, 1 May 2008 17:47:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4819E226.6000404@tikalk.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80926>

Ittay Dror <ittayd@tikalk.com> writes:

> Jeff King wrote:
> >
> > Of course it doesn't work here. You have two files, one containing
> > "hello\n" and one containing "hello\nworld\n". Their similarity is 50%,
> > which is not enough to consider it a rename. And I would argue that's
> > reasonable, since the files have only one line in common. The problem is
> > that you are using a toy example (which is why my example used
> > /usr/share/dict/words, which has enough content to definitively call it
> > a rename).
> >
> >
> Well, I would have expected git to notice that the file was renamed in
> one commit and keep tracking changes afterwards.
> 
> Also, as I wrote in another post, this happened to me with real files
> of a real source tree, and with very small changes (and sometimes not
> at all) to these files.

The idea of rename detection is to help with merges.  If the files are
different enough that content based (similarity based) rename
detection doesn't detect rename, they are usually too different to
merge automatically anyway.

-- 
Jakub Narebski
Poland
ShadeHawk on #git

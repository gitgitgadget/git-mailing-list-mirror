From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC] autocrlf: Make it work also for un-normalized
 repositories
Date: Tue, 11 May 2010 01:17:39 +0400
Message-ID: <20100510211739.GI14069@dpotapov.dyndns.org>
References: <20100510171119.GA17875@pvv.org>
 <m37hnbec16.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	msysgit@googlegroups.com,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 23:17:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBaMN-00017F-Tb
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 23:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254Ab0EJVRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 17:17:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:61077 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab0EJVRo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 17:17:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so972681fgg.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cp3ZnnhtB9Xzfxt+Or9LuAZ36L3QyjHCVsA2YkVbHTQ=;
        b=Qr7tKY8ndYhfvng7qy3DPYEbrT6+j7bQpELF0Q4JgkI85FEO2bHBR7PGTaGVlQCKl3
         ZuIZspFsVrKxOnq1xiBsHUu2QZ5Tp6F8hin6sl+7fPj8afRED4vgVqMT4FL+cnKPNs75
         1utm2vdNHgLGIROT0vgs2f5SJ/9gpat02nb20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gmndFC1fZB1YkcP5xvyTCbS53c73NQ5CX3XuSPr4K207nvWaTVFT39MbhQr5h+dLjr
         cGvjEZxXIXvcKqlJkJH4njLmiM8zw/CNqgeQyPYbBYEfNeiSw7BvWSzLE4QUDKvF2bM1
         G748jxKHlt1vi+vrc9x6AWntwv/e2zqU9iXsY=
Received: by 10.86.22.32 with SMTP id 32mr10438312fgv.61.1273526262956;
        Mon, 10 May 2010 14:17:42 -0700 (PDT)
Received: from localhost (ppp85-140-167-246.pppoe.mtu-net.ru [85.140.167.246])
        by mx.google.com with ESMTPS id d6sm8736108fga.8.2010.05.10.14.17.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 14:17:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m37hnbec16.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146853>

On Mon, May 10, 2010 at 01:30:22PM -0700, Jakub Narebski wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
> > 
> > The following sequence should now always be a NOP even with autocrlf
> > set (assuming a clean working directory):
> > 
> > git checkout <something>
> > touch *
> > git add -A .    (will add nothing)
> > git comit       (nothing to commit)
> > 
> > Previously this would break for any text file containing a CR
> 
> How this feature relates to `core.safecrfl'?

safecrlf is about making sure that you will get back exactly same file
on the next checkout as you have now in your working directory unless
you change your autocrlf value. So, the statement about breaking any
file with CR is certainly not correct.

This feature is about preserving CRLF in files inside of the repository
that were committed with CRLF despite that your current settings that
suggests that those files should be committed with LF. This makes sense
for the "guess" case, but it is clearly wrong when the user explicitly
mandated CRLF conversion for that file through attributes.


Dmitry

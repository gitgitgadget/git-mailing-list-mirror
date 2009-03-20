From: bdowning@lavos.net (Brian Downing)
Subject: Re: Git no longer reads attributes from the index properly
Date: Fri, 20 Mar 2009 03:40:31 -0500
Message-ID: <20090320084031.GD1037@lavos.net>
References: <20090320073527.GC1037@lavos.net> <7vab7gk39o.fsf@gitster.siamese.dyndns.org>
Reply-To: bdowning@lavos.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Mar 20 09:42:29 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkaIp-0007aH-Bc
	for gcvm-msysgit@m.gmane.org; Fri, 20 Mar 2009 09:42:07 +0100
Received: by yx-out-2122.google.com with SMTP id 22so334296yxm.63
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Mar 2009 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:received:date:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:from:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=3TxZwLghEKfRoKs19dGHGjyPcbue+T7f68dGhz0CEJQ=;
        b=hI7Rw+jYES2VFcHYCRdTJVZJfFQDhtFe80U9Qv2RJBBLTqm+C82GG1POdnh8M0U87L
         4aFaMdpm35hRBEIs/hAZ6dAdznjdWlT1ggJD2lg0+Dh4kb9CvDC3EsPUGVNxs+dWm0wV
         eZiy1WMy/fU2YctdwZ2jsUmZI/vz8Tm7UvmuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=cO+vg4RyIqvVPw/4O1DrDO98+ewRXPtKA4WQ0U4hZ4uKzGfgDaKSHdSPR6nfFHiqUq
         9IurbjQsiD8DXMI17IhQRbJ0Q4GE1SHc1ou8JgoOoe1SAFYowKz+E5jQqB8InDsHEBx7
         y/itzf8VAJiHoK69upt/Ff8h0/p0Pvb16QLxw=
Received: by 10.100.216.12 with SMTP id o12mr557106ang.27.1237538433474;
        Fri, 20 Mar 2009 01:40:33 -0700 (PDT)
Received: by 10.177.37.21 with SMTP id p21gr4307yqj.0;
	Fri, 20 Mar 2009 01:40:33 -0700 (PDT)
X-Sender: bdowning@lavos.net
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.75.13 with SMTP id x13mr2412928aga.21.1237538432804; Fri, 20 Mar 2009 01:40:32 -0700 (PDT)
Received: from QMTA04.westchester.pa.mail.comcast.net (qmta04.westchester.pa.mail.comcast.net [76.96.62.40]) by gmr-mx.google.com with ESMTP id 13si527873gxk.2.2009.03.20.01.40.32; Fri, 20 Mar 2009 01:40:32 -0700 (PDT)
Received-SPF: neutral (google.com: 76.96.62.40 is neither permitted nor denied by best guess record for domain of bdowning@lavos.net) client-ip=76.96.62.40;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 76.96.62.40 is neither permitted nor denied by best guess record for domain of bdowning@lavos.net) smtp.mail=bdowning@lavos.net
Received: from OMTA07.westchester.pa.mail.comcast.net ([76.96.62.59]) by QMTA04.westchester.pa.mail.comcast.net with comcast id VLeG1b0011GhbT854LgZkw; Fri, 20 Mar 2009 08:40:33 +0000
Received: from mnementh.lavos.net ([98.212.138.194]) by OMTA07.westchester.pa.mail.comcast.net with comcast id VLgY1b0084BqYqi3TLgZ31; Fri, 20 Mar 2009 08:40:33 +0000
Received: by mnementh.lavos.net (Postfix, from userid 1000) id 87E39309F24; Fri, 20 Mar 2009 03:40:31 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vab7gk39o.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113917>


On Fri, Mar 20, 2009 at 01:27:31AM -0700, Junio C Hamano wrote:
> bdowning@lavos.net (Brian Downing) writes:
> > As of 34110cd4e394e3f92c01a4709689b384c34645d8, (2008-03-06, just over a
> > year ago), Git no longer reads attributes from the index properly in all
> > cases....
> 
> Perhaps you would want to try it on 06f33c1 (Read attributes from the
> index that is being checked out, 2009-03-13) that is part of 'pu'?

I only tried it on next, groan.  Yes, it works there, thanks.

However, that commit looks like it's solving a different problem
entirely (supporting changing between two branches where .gitattributes
exists in both cases) and happens to fix the no .gitattributes -> read
from index regression at the same time.  I don't know enough about the
guts to tell, but does this also fix the core problem of the regression
(I assume something about trying to read from the wrong index, given the
commit that broke it), or does it just happen to work around it?

Specifically, it would be nice to have a fix for the regression that
could land on maint relatively soon, as the initial checkout case is
breaking a real repository I use, whereas the switching branches case is
something I don't care about as much at the moment.

Of course, I don't know how to fix it at the moment, and beggars can't
be choosers.  :)

-bcd

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Thu, 3 Jul 2008 13:29:27 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031313140.9925@racer>
References: <486C425D.8090904@thewritingpot.com>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, msysGit <msysgit@googlegroups.com>,  junio@pobox.com
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 03 14:32:54 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENzX-0006RG-JO
	for gcvm-msysgit@m.gmane.org; Thu, 03 Jul 2008 14:32:52 +0200
Received: by wa-out-0708.google.com with SMTP id n36so1341916wag.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 03 Jul 2008 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=Qg183WsPdSgAaDKNnbhc0TF33m6ep59G5tCyRUSU8Q8=;
        b=SsLx9myWHAmaX9h5+OM26BZCGOJzkvyeuSc5ChlRqP2rWoDrRDv2HOV3uvBt3aBmi8
         6tI2YA2biBzuntkZQmPxbSmxIa/GY/Et48dPGm/T71IJ7YXZlYWvKw7RavwRyriH+Uuq
         cy/MCgk0bNkWslUgXEXl4zYHOQfPQuLC88vJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=T0Rrx0qYT3MDmcmSZVmq+tpnUpn2+yOBT3huOlgi/VVr+7pP51mLiVWJ1TJXWDw+Zj
         7eBX3aGXdBmomMUuwi+QpRmLkDHTEianpkpqNxEp4qDG97NquK5DmQlDHPtH6s+xQ58F
         BwwAj56WeLxJrDBfHf5UJQzWWqGlqYeLga7yk=
Received: by 10.114.27.19 with SMTP id a19mr4035waa.8.1215088312289;
        Thu, 03 Jul 2008 05:31:52 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2593prm.0;
	Thu, 03 Jul 2008 05:31:52 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.144.18 with SMTP id r18mr28564and.24.1215088311852; Thu, 03 Jul 2008 05:31:51 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by mx.google.com with SMTP id 22si64742yxr.2.2008.07.03.05.31.21; Thu, 03 Jul 2008 05:31:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 03 Jul 2008 12:31:20 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28] by mail.gmx.net (mp039) with SMTP; 03 Jul 2008 14:31:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8gTBGVzH8tYXrRn0MMH3hYwoV9iau45uDsTsISJ V0rV62cdQqQtRK
X-X-Sender: gene099@racer
In-Reply-To: <486C425D.8090904@thewritingpot.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87275>


Hi,

On Wed, 2 Jul 2008, Edward Z. Yang wrote:

> Johannes Sixt wrote:
> > What about installing a wrapper script, plinkssh, that does this:
> > [snip]
> 
> Well, the patch is shorter :-)

But you have to do it for every SSH backend that you might want to 
support.

And you have to recompile.

> 1. It's been tested, it works. I haven't tried the script yet, so I 
>    don't know if it works.

Sorry, that argument does not fly.  "My patch is better, because I did not 
test your patch."

> 2. Git historically doesn't use bash, so the script would have to be 
>    rewritten in Perl or plain sh or tcl or something.

That is so totally untrue.  We have Perl scripts and Shell scripts (for 
which we need the bash), and then we have the two GUIs which use Tcl/Tk.

Actually, we only have so few Perl scripts left that it might be possible 
to ship a version of Git on Windows without Perl.  The only script that 
needs to be converted to a builtin is add -i.

The rest of the scripts are shell.

So this argument is totally bogus.

> 3. It's less brittle than the wrapper script if we decide to have Git 
>    pass more params to OpenSSH.

Granted, should we decide one day to use more elaborate features of 
OpenSSH, then we would have to change the script, too.

But most likely, Plink support would be broken by that update _anyway_, 
since it does not grok the OpenSSH options directly.

And guess what is easier to fix, a script that rewrites the arguments from 
OpenSSH syntax to Plink syntax, or a C program with over 78,000 code 
lines that has to be recompiled?

> 4. It's "more native".

Would it not be even more native if we just linked in libssl?  Would you 
write the patch?

Further, would you like to convert and maintain all people's wrapper 
scripts to C code inside Git?

BTW what is the reason why Hannes' mail does not appear to be the mail 
you replied to in GMane, but the patch Steffen sent?

Ciao,
Dscho

From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Fri, 04 Jul 2008 16:05:48 -0400
Message-ID: <486E829C.608@thewritingpot.com>
References: <486C425D.8090904@thewritingpot.com> <alpine.DEB.1.00.0807031313140.9925@racer>
Reply-To: edwardzyang@thewritingpot.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org, gitster@pobox.com, junio@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 04 22:07:04 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.241])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KErYY-0001Dt-Gn
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jul 2008 22:07:01 +0200
Received: by wa-out-0708.google.com with SMTP id n36so2885143wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2008 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received:date
         :from:subject:in-reply-to:to:cc:message-id:mime-version:content-type
         :content-transfer-encoding:references:user-agent:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=kO9IKCgVtngt8VqkcDsBN69b4f3NcGNJKo0iUXZ/7mU=;
        b=qPW5yB87uTBrAvZ5+4N/U06XVp8s2tIXKkeqfD6IFix45jvZBcTSMwPk30EMr2mbsg
         wAOqZwmnvwQu5UdgRthMO/K4oM0b8zQqb0ocuxu1PWNjvwdyGeSkDn6qLy1GMLBLz41P
         xgA5oMB4jArTFMFTrEV8PC2eqJgxejAVu6v70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:subject:in-reply-to:to:cc:message-id:mime-version:content-type
         :content-transfer-encoding:references:user-agent:reply-to:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=YNLNPXcT5ZQ4UXAuNknLnGZcR9rlTrHqnmBEr8BpqIdhZ7GLlkRtrPH663kq5eRYpb
         M7aBMZEObVwUvsIRbhRBVMCSxLPbbfQU65+Xp6rVYbInLaLZAOhVMsHczUUMETzy/sRn
         Mpy2F2RSFTf9YZSlu2M25Td9adHx87OBn7/8c=
Received: by 10.114.27.19 with SMTP id a19mr146778waa.8.1215201957663;
        Fri, 04 Jul 2008 13:05:57 -0700 (PDT)
Received: by 10.107.3.34 with SMTP id f34gr2611pri.0;
	Fri, 04 Jul 2008 13:05:57 -0700 (PDT)
X-Sender: edwardzyang@thewritingpot.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.78.10 with SMTP id a10mr2120398agb.12.1215201957073; Fri, 04 Jul 2008 13:05:57 -0700 (PDT)
Received: from mta2.srv.hcvlny.cv.net (mta2.srv.hcvlny.cv.net [167.206.4.197]) by mx.google.com with ESMTP id a28si213156pye.0.2008.07.04.13.05.56; Fri, 04 Jul 2008 13:05:57 -0700 (PDT)
Received-SPF: neutral (google.com: 167.206.4.197 is neither permitted nor denied by best guess record for domain of edwardzyang@thewritingpot.com) client-ip=167.206.4.197;
Authentication-Results: mx.google.com; spf=neutral (google.com: 167.206.4.197 is neither permitted nor denied by best guess record for domain of edwardzyang@thewritingpot.com) smtp.mail=edwardzyang@thewritingpot.com
Received: from [192.168.0.10] (ool-18e45099.dyn.optonline.net [24.228.80.153]) by mta2.srv.hcvlny.cv.net (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007)) with ESMTP id <0K3H00IJ8ZTWRFD0@mta2.srv.hcvlny.cv.net> for msysgit@googlegroups.com; Fri, 04 Jul 2008 16:05:56 -0400 (EDT)
In-reply-to: <alpine.DEB.1.00.0807031313140.9925@racer>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87416>


> Sorry, that argument does not fly.  "My patch is better, because I did not 
> test your patch."

Just tested, the patch works.

> That is so totally untrue.  We have Perl scripts and Shell scripts (for 
> which we need the bash), and then we have the two GUIs which use Tcl/Tk.

I came up with that conclusion by grepping the Git source code for the 
word bash; no results. Granted, it's still a null point because the 
proposed script doesn't use any bash-specific features.

> Further, would you like to convert and maintain all people's wrapper 
> scripts to C code inside Git?

I was under the impression that wrapper scripts were for fleshing out 
new APIs and implementing non-performance critical functionality, 
without all the overhead of writing in C. There is little to no overhead 
from this patch.

Anyway, Johannes still makes some pretty compelling points for the 
wrapper script, so you can count me +1 for the wrapper.

> BTW what is the reason why Hannes' mail does not appear to be the mail 
> you replied to in GMane, but the patch Steffen sent?

I actually did a "Reply" and so he was the only one who got the email at 
first. Then I resent it to the list, as well as the other CC'ed people.

(Thus my comment at the bottom)

From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Wed, 02 Jul 2008 23:07:09 -0400
Message-ID: <486C425D.8090904@thewritingpot.com>
Reply-To: edwardzyang@thewritingpot.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, msysGit <msysgit@googlegroups.com>, junio@pobox.com
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Jul 03 05:08:23 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from py-out-1314.google.com ([64.233.166.174])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEFBD-0003JW-UM
	for gcvm-msysgit@m.gmane.org; Thu, 03 Jul 2008 05:08:20 +0200
Received: by py-out-1314.google.com with SMTP id u10so1103799pyb.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 20:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received:date
         :from:subject:to:cc:message-id:mime-version:content-type
         :content-transfer-encoding:user-agent:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=UsJp50v846ZOso+dM1gZAoCIud3CpsK1PN+nuUOnmpo=;
        b=gC0eD3l7tPwSmheS4QhCB4YNvHYMLajnppl5ddAYtXS8dAmHE66VHCRvOugh1ghtEf
         I5hHv+okiEnQ8pyddeHtTKHoI++1V5GdDGhUcfc+ZP5miMiCx4SoKpoU57fKa63bHPkm
         AKqkBo5UGIAdR8n/LohnRZu1ozFlDKZrU4D3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:date
         :from:subject:to:cc:message-id:mime-version:content-type
         :content-transfer-encoding:user-agent:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=jLIC35fLY78wUzWKmtULXgChocIKd9/NkVIgl9gr1xTTzihtpbtbFA2lTUGd37uHAc
         rrStZ07AUAdSfzrVAbymEN0/LCL24XfVx9VAREQOlIKgTemDJDpVsIlwoO+nVFJZBXAB
         Y0hnQi0g87i/d5MZDIUuaV6cXdjKL91Sz3AIM=
Received: by 10.140.192.9 with SMTP id p9mr549270rvf.8.1215054437429;
        Wed, 02 Jul 2008 20:07:17 -0700 (PDT)
Received: by 10.107.113.4 with SMTP id q4gr2585prm.0;
	Wed, 02 Jul 2008 20:07:17 -0700 (PDT)
X-Sender: edwardzyang@thewritingpot.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.78.10 with SMTP id a10mr10080537agb.12.1215054436903; Wed, 02 Jul 2008 20:07:16 -0700 (PDT)
Received: from mta5.srv.hcvlny.cv.net (mta5.srv.hcvlny.cv.net [167.206.4.200]) by mx.google.com with ESMTP id b1si549154pyh.3.2008.07.02.20.07.16; Wed, 02 Jul 2008 20:07:16 -0700 (PDT)
Received-SPF: neutral (google.com: 167.206.4.200 is neither permitted nor denied by best guess record for domain of edwardzyang@thewritingpot.com) client-ip=167.206.4.200;
Authentication-Results: mx.google.com; spf=neutral (google.com: 167.206.4.200 is neither permitted nor denied by best guess record for domain of edwardzyang@thewritingpot.com) smtp.mail=edwardzyang@thewritingpot.com
Received: from [192.168.0.10] (ool-18e45099.dyn.optonline.net [24.228.80.153]) by mta5.srv.hcvlny.cv.net (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007)) with ESMTP id <0K3E008LUU04WV30@mta5.srv.hcvlny.cv.net> for msysgit@googlegroups.com; Wed, 02 Jul 2008 23:07:16 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87219>


Johannes Sixt wrote:
 > What about installing a wrapper script, plinkssh, that does this:
 > [snip]

Well, the patch is shorter :-)

Joking aside, it's a good question. I guess I prefer the patch because:

1. It's been tested, it works. I haven't tried the script yet, so I 
don't know if it works.

2. Git historically doesn't use bash, so the script would have to be 
rewritten in Perl or plain sh or tcl or something.

3. It's less brittle than the wrapper script if we decide to have Git 
pass more params to OpenSSH.

4. It's "more native".

I don't know if these are compelling enough reasons, though.

(cc'ed everyone else, whoops)

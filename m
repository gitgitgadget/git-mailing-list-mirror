From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Fri, 4 Jul 2008 11:29:27 +0200
Message-ID: <7188A895-D5B9-480E-8486-8A69B8861646@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <200807022104.20146.johannes.sixt@telecom.at> <7vod5euhw3.fsf@gitster.siamese.dyndns.org>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: johannes.sixt@telecom.at, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org, "Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 04 11:30:20 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhcL-0003ud-JL
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jul 2008 11:30:14 +0200
Received: by wa-out-0708.google.com with SMTP id n36so2346146wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2008 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=ulmSTIpXc0hMMjeuKjYTQUffrCd+SqhUuyLiEQJYJmQ=;
        b=WKGsGsxWioDG54ZX54AKvbR0OmTClU8ykma6vi+PkVWvTnQFTqigHDGU5SZoABuZhJ
         3Umi2zp3wUIApYtzuvWVc4A+/joJUfPg8k/dEGVD63QMbRWW37BjCNV6fPw8uM0/SvN6
         EASM+5C8NayfxuhiaV4Fjqv6eq9lurKVfAtds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=hluei6dQJ6sMMQVxjav9d3MOzD8IbytPwYS47W8EYNVczpK4PiTZs9ftpiaEy7ez6R
         JIQmDIP2j7cDOC68zqfl8jGC1uwgW7aqx6fR2S5eG+xZXkz8tsJpXdKwDAG68MkNgwKh
         5yXFzKxEjz+C3vOldwEp5UhzmlKRk0w7VfXGw=
Received: by 10.114.180.1 with SMTP id c1mr100802waf.17.1215163751229;
        Fri, 04 Jul 2008 02:29:11 -0700 (PDT)
Received: by 10.107.117.4 with SMTP id u4gr2606prm.0;
	Fri, 04 Jul 2008 02:29:11 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.33.5 with SMTP id g5mr1415102agg.14.1215163750869; Fri, 04 Jul 2008 02:29:10 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 22si39357yxr.2.2008.07.04.02.29.09; Fri, 04 Jul 2008 02:29:10 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m649T4S8010350; Fri, 4 Jul 2008 11:29:09 +0200 (CEST)
Received: from [192.168.178.22] (p5499FDC0.dip.t-dialin.net [84.153.253.192]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m649T2bp013160 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 4 Jul 2008 11:29:03 +0200 (MEST)
In-Reply-To: <7vod5euhw3.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87381>



On Jul 4, 2008, at 11:18 AM, Junio C Hamano wrote:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
>
>> What about installing a wrapper script, plinkssh, that does this:
>>
>> #!/bin/bash
>>
>> if test "$1" = -p; then
>> 	port="-P $2"
>> 	shift; shift
>> fi
>>
>> exec plink $port "$@"
>>
>> and require plink users to set GIT_SSH=plinkssh?
>
> That's quite a nice solution with absolute minimum impact.

It has minimum impact on the source code of git.  The same is not
true, however, for the git user and the installer on Windows:

  - The proposed plinkssh requires that plink is in the PATH.  This is
    not necessarily the case on Windows.  If plink is not in the PATH,
    then the user needs to modify plinkssh.

  - The msysgit installer supports setting GIT_SSH to the full path
    of plink.  It automatically detects this path based on Putty's
    entries in the Windows registry.  If we choose the plinkssh
    solution the installer has to be modified.

Setting '-P' in connect.c would have some impact on the git source,
but would avoid changes elsewhere.

	Steffen

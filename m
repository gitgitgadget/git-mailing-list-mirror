From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Fri, 4 Jul 2008 10:50:49 +0200
Message-ID: <579FEE2E-CAED-412D-B4F2-AAEA303A3DAC@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <200807022104.20146.johannes.sixt@telecom.at> <alpine.DEB.1.00.0807031209440.9925@racer>
Reply-To: prohaska@zib.de
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, "Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Jul 04 10:52:13 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.245])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEh1O-0007pK-6C
	for gcvm-msysgit@m.gmane.org; Fri, 04 Jul 2008 10:52:02 +0200
Received: by wa-out-0708.google.com with SMTP id n36so2315086wag.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2008 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:in-reply-to:subject:references:message-id
         :content-type:content-transfer-encoding:mime-version:date:cc
         :x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=IYn7vEfiSGoZFo2wWd1AFIQslLBbENKHheSOwNYa2eA=;
        b=6gENytl5tOHvafSDULnX4loqd3HWyEe/DNUaDG8dhjzGIsPQXfwSroehrHp7Dwf92q
         muQAlmYt46kTyW0BCzSXaozmW+xyWVxHDkNCWO17BaizJK03S8KrE46owEy5vCc/Qob0
         GE0TkA5CRFVM0ruYdbkjLKbDqJT9huLGMHarg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere;
        b=vn1kyhMsw/r29Wzu5exbM4UOIDsFJTSxvJDA2g/eDkkTUyRTZL2Vq9RwDGWxPNCQXt
         dFOHSVg4RGMicghIx67qqPpsXz/TY/+1XzL9Yt/N2NcUKyC2ep5HOsjZO94PzIT/GOhd
         tXwpKRdlbKhxdYxkInvOb5//qdHOV5ErESI30=
Received: by 10.140.187.10 with SMTP id k10mr73823rvf.19.1215161462763;
        Fri, 04 Jul 2008 01:51:02 -0700 (PDT)
Received: by 10.106.234.8 with SMTP id g8gr2604prh.0;
	Fri, 04 Jul 2008 01:51:02 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.92.10 with SMTP id p10mr1387400agb.5.1215161461964; Fri, 04 Jul 2008 01:51:01 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 39si8442yxd.0.2008.07.04.01.51.01; Fri, 04 Jul 2008 01:51:01 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m648oftW006688; Fri, 4 Jul 2008 10:50:51 +0200 (CEST)
Received: from [192.168.178.22] (p5499FDC0.dip.t-dialin.net [84.153.253.192]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m648oO10003618 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 4 Jul 2008 10:50:25 +0200 (MEST)
In-Reply-To: <alpine.DEB.1.00.0807031209440.9925@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87373>



On Jul 3, 2008, at 1:10 PM, Johannes Schindelin wrote:

> On Wed, 2 Jul 2008, Johannes Sixt wrote:
>
>> On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
>>> From: Edward Z. Yang <edwardzyang@thewritingpot.com>
>>>
>>> PuTTY requires -P while OpenSSH requires -p; if plink is detected
>>> as GIT_SSH, use the alternate flag.
>>>
>>> Signed-off-by: Edward Z. Yang <edwardzyang@thewritingpot.com>
>>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>>> ---
>>> connect.c |    4 +++-
>>> 1 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/connect.c b/connect.c
>>> index 574f42f..0d007f3 100644
>>> --- a/connect.c
>>> +++ b/connect.c
>>> @@ -599,11 +599,13 @@ struct child_process *git_connect(int fd[2],  
>>> const
>>> char *url_orig, conn->argv = arg = xcalloc(6, sizeof(*arg));
>>> 	if (protocol == PROTO_SSH) {
>>> 		const char *ssh = getenv("GIT_SSH");
>>> +		int putty = ssh && strstr(ssh, "plink");
>>> 		if (!ssh) ssh = "ssh";
>>>
>>> 		*arg++ = ssh;
>>> 		if (port) {
>>> -			*arg++ = "-p";
>>> +			/* P is for PuTTY, p is for OpenSSH */
>>> +			*arg++ = putty ? "-P" : "-p";
>>> 			*arg++ = port;
>>> 		}
>>> 		*arg++ = host;
>>
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
> I like that better than this special-casing of plink.


I'd prefer to change connect.c.  plinkssh would introduce another
dependency on the shell, while our overall goal is to avoid shell as
much as possible on Windows, no?  Edward's solution also looks more
obvious to me than the plinkssh wrapper script.

	Steffen

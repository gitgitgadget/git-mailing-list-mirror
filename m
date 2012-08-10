From: Andreas Ericsson <ae@op5.se>
Subject: Re: git am and the wrong chunk of ---
Date: Fri, 10 Aug 2012 13:00:07 +0200
Message-ID: <5024E9B7.1070004@op5.se>
References: <5024523F.3050208@zytor.com> <20120810103612.GA21562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 13:00:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szmx1-0000Pl-Uf
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 13:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431Ab2HJLAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 07:00:14 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46159 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957Ab2HJLAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 07:00:13 -0400
Received: by lbbgj3 with SMTP id gj3so105365lbb.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 04:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=y2h5pESGshZ9A4Ncy2QE1pOson/SGm6rpFrtF5KGJr4=;
        b=VcV4nOPNa2v/cAFQzSdHLnj+Gx5IgkH5/nc7dHNltQgutAHZU0eOKFJcpcZKhOBXj7
         eTiFvOxWgHwCNWFCovEhfiL4z8V1V74QGEquZJqXINvm8Bkf+s66hEbk5ghNwQ6tcm/v
         QpOa2xcynlNjtjgrrYRLJ0sexaExXo2ga4n1N+OsXWSpUYbrtejKhujF743jBj3ZvsO/
         d0Z48yRZJc4zriRdThPgWJcVo0MVqZEUubDx2E4HxoGzIBK5vdcT+RX8jhPwr1TLQSbe
         SGoEk6kyjCcGyo7V6Y9RnrP2dZsk67shR2LmbgGYFRHrP94EYk/o5BrLDk9HYta0vzru
         nguQ==
Received: by 10.152.104.77 with SMTP id gc13mr2552810lab.31.1344596410795;
        Fri, 10 Aug 2012 04:00:10 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id sn2sm3709338lab.16.2012.08.10.04.00.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 04:00:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <20120810103612.GA21562@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnFFK4T+LL8NYLbTv2+EYRnCQE3Bum+BgC6QGX6B11c7DS7+GCpv2Oka936H9b0hNInfklp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203215>

On 08/10/2012 12:36 PM, Jeff King wrote:
> On Thu, Aug 09, 2012 at 05:13:51PM -0700, H. Peter Anvin wrote:
> 
>> I have some contributors who consistently put their commentary
>> *before* the "---" line rather than *after* it, presumably with the
>> notion that it is some kind of "cover text".  This messes with "git
>> am", and so I end up having to edit those posts manually.
>>
>> I have tried git am --scissors and it doesn't seem to solve the problem.
>>
>> Is there any other option which can be used to automatically process
>> such a patch?
> 
> If I understand your issue, somebody is writing:
> 
> 
>      From: them
>      To: you
>      Date: ...
>      Subject: [PATCH] subject line
> 
>      commit message body
>      ....
> 
>      some cover letter material that should go below the "---"
>      ---
>        [diffstat + diff]
> 
> 
> How do you know when the commit message body ends, and the cover letter
> begins? We already have two machine-readable formats for separating the
> two ("---" after the commit message, and "-- >8 --" scissors before). Is
> there some machine-readable hint? Is it always the paragraph before the
> "---"? Chopping that off unconditionally seems like a dangerous
> heuristic.
> 

End of SOB lines might be a good cutoff, if they're present. I've never
seen anyone put commit message text below them anyway.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Mon, 26 May 2008 18:49:42 -0400
Message-ID: <483B3E86.5020100@gmail.com>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer> <483AF570.9000609@gmail.com> <alpine.DEB.1.00.0805262226400.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 27 00:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0lWb-0002I0-2G
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 00:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbYEZWtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 18:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbYEZWts
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 18:49:48 -0400
Received: from hs-out-0708.google.com ([64.233.178.242]:46165 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445AbYEZWts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 18:49:48 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1661163hsl.5
        for <git@vger.kernel.org>; Mon, 26 May 2008 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=LXXyej992cJ6uZdaZxpHLU+c1Mq6d5hzwa6Pgwy47LM=;
        b=AmCjP4pThG7n4pF3OO2TFlmW8eyAfgntWDZRLSWaRVBDY+uCcSGjjuivJzGbG5krYVXVDBpe5LPTFPd19GUKteueOrzBFgdzunBtz2c2zJTrRabcUnmJjdi33gCkR/2dZrqB33veV4g4cV4W8YKif6HGi3IGHs+JnviWJGXi/CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XSGwIuAId+6WIiNaQlKyJGFQ0f11fKcarDVwiyn/PgRRDK8MlKvFO7sEx9h2J/TNu+WFO8BhMLVl454EVZ0SVc9J4/8IhiYKNrSoUCTa2K9ZPUOm65mUfzUrBu6xTzRkGkCwGIFt7OyL8Tgf5izJObSh8r53JM/eRoa5n60v3JA=
Received: by 10.90.87.7 with SMTP id k7mr753440agb.25.1211842186871;
        Mon, 26 May 2008 15:49:46 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.126.133.203])
        by mx.google.com with ESMTPS id 3sm980432wrh.6.2008.05.26.15.49.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 May 2008 15:49:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.DEB.1.00.0805262226400.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82968>

Johannes Schindelin wrote:
> Hi,
>
>
>   
> I fail to see how Cygwin is so special as to merit a falsification of 
> history.
>
>   
>> I don't have access to a linux box today, so I can't manipulate master 
>> to find if that branch with your patch would work right now.
>>     
>
> Sure you can.  You should be able to "git mv t/t5100/nul t/t5100/nul-file" 
> and then editing t/t5100-*.sh to refer to nul-file instead of nul.
>
> Hth,
> Dscho
>   
The above two points are related: the current master causes git to abort 
before writing the index:

 >git checkout -f origin/master
error: git-checkout-index: unable to create file t/t5100/nul (File exists)
 >git mv t/t5100/nul t/t5100/nul-file
fatal: not under version control, source=t/t5100/nul, 
destination=t/t5100/nul-file

So, there is now a range of git's history that is unusable (and 
non-bisectable) on Windows, at least from the porcelain. And apparently, 
somewhere in that unusable history, a change was introduced that causes 
test failure on Cygwin. Great...

Mark

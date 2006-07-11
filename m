From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Tue, 11 Jul 2006 13:15:14 +0200
Message-ID: <44B38842.10609@op5.se>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com> <11526131792377-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 13:15:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0GDD-0007wi-T5
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 13:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWGKLPS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 07:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWGKLPS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 07:15:18 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:12435 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751035AbWGKLPQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 07:15:16 -0400
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4814F6BCC0; Tue, 11 Jul 2006 13:15:15 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
To: Alp Toker <alp@atoker.com>
In-Reply-To: <11526131792377-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23708>

Alp Toker wrote:
> Doing this now will save headache in the long run, avoiding mismatched
> versions of installed utilities and dangling copies of removed or
> renamed git commands that still appear to work. It also makes screwups
> when packaging git or making system backups less likely.
> 
> BusyBox has been doing it this way for years.
> 

Git has been doing it for a couple of months, although it uses hardlinks 
instead of symlinks. Hardlinks are slightly faster and actually consume 
a little less hard-disk space, although the differences are so small you 
won't notice it unless you do several thousand invocations.

>  
>  $(BUILT_INS): git$X
> -	rm -f $@ && ln git$X $@
> +	ln -sf git$X $@
>  

The -f option to ln is not very portable, hence the "rm && ln" construct.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

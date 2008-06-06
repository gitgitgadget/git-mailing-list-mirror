From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Fri, 06 Jun 2008 09:02:29 +0200
Message-ID: <4848E105.7050405@gnu.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer> <7v4p87zcv6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806060030160.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 09:03:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Vyw-0006Wq-0N
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 09:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYFFHCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 03:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYFFHCd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 03:02:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:32296 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYFFHCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 03:02:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so589701fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=xj7ZsmDAZC6mI9H/AP6J0++ujKXLJJ++w22caoIugtc=;
        b=jx2q0TuljVCbRHAqbjlryZbtODCvdMD4IbPKHL4pD8a+5ZgGKR9hgXP4q8vIusVNKt
         dyQAZvSzS3iMReEm0VdfmPf+uc+DncLMtNKRmgtrXwsHEx3NeiIfLkqg8xm0WEOaCoGs
         P3Sp+2WKMkxE+8RuDSPX9RqcFUwI18vDtvnZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=BvEaWBtejg0cmqDQ54yUSlj2kQ0ipbI4ktIAAyQcboM+XfUDgXLqJD3P/mMpIWMU6T
         gV8Sy357DvIHEGJSWFRJ8yiKrXAV7N/RQbgzrgFCrGi6KqUpfC+XcHtq34LHZZGRY1Q8
         xQPqPN/stBb7s89+3+RaIt27Aj4JISTmu2zsg=
Received: by 10.86.59.18 with SMTP id h18mr3511640fga.30.1212735750013;
        Fri, 06 Jun 2008 00:02:30 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id d6sm5083036fga.2.2008.06.06.00.02.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Jun 2008 00:02:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0806060030160.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84033>


> @@ -0,0 +0,0 @@
>  	default:
> -		return -1;
> +		return len != 4 && memcmp(line - len, "-- \n", len);
>  	}

You're never returning -1 here, right?

> However, this will not work if anybody has a signature starting with 
> "@@ ", "+", " ", "-" or "diff "...

I think that the main worry is the patches made with git-format-patch, 
and those are not problematic.

Paolo

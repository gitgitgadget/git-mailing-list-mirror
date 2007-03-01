From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 01 Mar 2007 09:45:11 +0100
Message-ID: <45E69297.8070001@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org>	 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0702281045u2e511ebfie14a7b718531f8c4@mail.gmail.com>	 <45E5DE8A.2080101@lu.unisi.ch>	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>	 <45E68897.8000607@lu.unisi.ch>	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>	 <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 09:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMguj-0007m3-9I
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122AbXCAIpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933125AbXCAIpY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:45:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:23919 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933122AbXCAIpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:45:23 -0500
Received: by nf-out-0910.google.com with SMTP id o25so826153nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:45:22 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=sjdFZxUhL/Wo6qjNxwxkmKTXTjWjeBq3Dge3LXLwNZ5PoCUbgmBO523kCUy/AV7EKjlpt2EYGVs58Ko9/dUhBBCIe4yTK2tonukc5f798c6+YSY2xNIAQQUuMOd66/9j/UDFTZfREGXKJhMxpCG2hidZtfMrsY5vIbNqZcQMEMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=ULFcbrxNbjV1G0Ae4ptMwcrolOaNtYUoFmmKnq1sfTnbCIa3Z0GvbBxnVKP2W47n7jZucA450SVIY+rYHGz3IIgeIKuqvAjHeyTpA/sD68HVduuniSdbXdzJVCxRiliuuhg8oo6OA4PkpS3pufh0quodCq2C9PeywcPIo+Wqe6s=
Received: by 10.48.217.11 with SMTP id p11mr5241755nfg.1172738722132;
        Thu, 01 Mar 2007 00:45:22 -0800 (PST)
Received: from ?192.168.76.141? ( [195.176.176.226])
        by mx.google.com with ESMTP id g1sm6248296muf.2007.03.01.00.45.20;
        Thu, 01 Mar 2007 00:45:21 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41054>


>> While I am probably going to modify the patch to satisfy Junio, have you
>> noticed that "git branch -d" will delete the section, hence .git/config
>> will not be growing uncontrollably?
> 
> Maybe you also have noticed that it will remove also the reference?

Sure I have.

> How do I remove the garbage you added for TRACKING?!

I see two possibilities:

1) I can add a "git-config --remove-section" option.  So you can do 
"git-pull" to merge onto your branches, and then remove the tracking 
section.

2) I can add a "git-branch --stop-tracking" option, which just removes 
the section.

3) Same as 2), plus I add a "git-branch --no-track" option, which does 
not add the section in the first place.  But I do believe that there is 
no reason why this cannot be the default.

Paolo

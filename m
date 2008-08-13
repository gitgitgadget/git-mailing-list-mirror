From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 1/3] Git.pm: Add faculties to allow temp files to be cached
Date: Thu, 14 Aug 2008 00:28:18 +0200
Message-ID: <48A36002.1030705@gmail.com>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <48A33E70.8060804@gmail.com> <7vskt8mz0g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 00:29:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTOqE-00081D-67
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 00:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbYHMW2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 18:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYHMW2P
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 18:28:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:8655 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYHMW2O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 18:28:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so164338fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=6Jj2GgbodEzBvV/ui9culSfvcXqE+D2rVztIhzR5e2U=;
        b=jN3HfbCqvKmSLMMT/kc75TBBw0oh8sdjDA8Oq/6Hr/aZAa+y5BiYhPvOleb2rOKG+S
         Z99kbBx73Mq8iZU2chhfMYzO8hAHIVydlPFxd8zQhE4crxYehrQcRMjQ41lPTUEbksVA
         oBn/n6UIQejY6TC1dhJa+R6c/21tQbiLtnGiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=RiWFO2bgjsThomzaCHFsEjkAtj9Y4KYn6f78hnskCcjgMNevZAc0MivTKKGGcURVkD
         qU9ySZnX05UJGbnSRXh6/ase+3SquDTMztvbX2txHdKia5/FktI1GZN2fAddJuBqu5QC
         yz7rxia1L/YzdAblylWoesnZM1HFblyDiABUA=
Received: by 10.86.30.9 with SMTP id d9mr629178fgd.37.1218666493044;
        Wed, 13 Aug 2008 15:28:13 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.235.99])
        by mx.google.com with ESMTPS id d6sm2145196fga.2.2008.08.13.15.28.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 15:28:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <7vskt8mz0g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92286>

Junio C Hamano wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
> 
>> Marcus Griep wrote:
>>> +require File::Spec;
>> This makes Git.pm dependent on Perl 5.6.1.

Ouch, I misquoted.  It's File::Temp that was introduced in Perl 5.6.1,
not File::Spec.  (I think it's probably save to assume that File::Spec
[added in 5.4.5] is available everywhere.)

> Hmm, wouldn't something like this (untested) be more contained?

Uh, sorry for making you write unnecessary code.  Replicating File::Temp
functionality is probably a bit too tricky because of temp-file safety,
though I haven't checked the code.  It's probably not worth the effort
anyway; I was really just concerned about not having the test suite fail
in the 0.1% of cases where someone doesn't have Perl >5.6.1.

Also, adding "use 5.006001" may help with erroring out with a proper
error message for older perl versions.  I'll send a follow-up to this
message.

-- Lea

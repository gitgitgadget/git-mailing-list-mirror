From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv2] git-pull: Avoid merge-base on detached head
Date: Thu, 25 Oct 2012 14:50:37 -0400
Message-ID: <508989FD.7090101@cisco.com>
References: <1351024796-28174-1-git-send-email-hordp@cisco.com> <1351024796-28174-2-git-send-email-hordp@cisco.com> <20121025093441.GH8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 20:50:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRSW8-0005t7-6X
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 20:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238Ab2JYSun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 14:50:43 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:10994 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934870Ab2JYSum (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 14:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=773; q=dns/txt; s=iport;
  t=1351191042; x=1352400642;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=AbaB9ViySHP0OwAoLIfPMoosqjPbw4EOFDox50QPhCQ=;
  b=KPZ55U7aLak1utTsIe40D0SDs8Kz6oE1MPNq86cV75EUcFs6vzzaviSp
   1MPUHHegmjaCvmhqoNXMOj6ooI6BhqmcwxkJkd+PzqyCUY7Pz3lG3Ihtv
   8XVA9Y/G1Sk0ZEjIGPr+QpSUVGtBquV+a8hXeViXjw2SiBNLJuEyr878F
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAFADyJiVCtJXHB/2dsb2JhbABEhha8GoEIgh4BAQEEEgEQVQEQCw4KAgIFFgsCAgkDAgECAUUGDQEHAQEeh2KeKI0oknWBIIpBhVqBEwOVdoVmiGyBa4ML
X-IronPort-AV: E=Sophos;i="4.80,648,1344211200"; 
   d="scan'208";a="135373558"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
  by rcdn-iport-2.cisco.com with ESMTP; 25 Oct 2012 18:50:41 +0000
Received: from [64.100.104.96] (dhcp-64-100-104-96.cisco.com [64.100.104.96])
	by rcdn-core2-6.cisco.com (8.14.5/8.14.5) with ESMTP id q9PIoe1V026771;
	Thu, 25 Oct 2012 18:50:40 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <20121025093441.GH8390@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121025145037182
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208415>

Jeff King wrote:
> On Tue, Oct 23, 2012 at 04:39:56PM -0400, Phil Hord wrote:
>
>> git pull --rebase does some clever tricks to find the base
>> for $upstream , but it forgets that we may not have any
>> branch at all.  When this happens, git merge-base reports its
>> "usage" help in the middle of an otherwise successful
>> rebase operation, because git-merge is called with one too
>> few parameters.
>>
>> Since we do not need the merge-base trick in the case of a
>> detached HEAD, detect this condition and bypass the clever
>> trick and the usage noise.
> Makes sense. I notice there is no test with your patch. It sounds from
> the description like the operation still may succeed, but we just get
> cruft on stderr?
>

Yes, that's correct.

P

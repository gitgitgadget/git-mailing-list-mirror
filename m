From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] pack-bitmap: do not use gcc packed attribute
Date: Wed, 06 Aug 2014 20:58:36 +0200
Message-ID: <53E27ADC.4070501@gmail.com>
References: <20140728171743.GA1927@peff.net> <53D806AC.3070806@gmail.com> <20140801223739.GA15649@peff.net> <20140801231044.GA17960@peff.net> <53DFDCD2.2090803@gmail.com> <20140805184724.GA10369@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:58:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF6Q5-0003d6-FK
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbaHFS6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:58:37 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:43350 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756284AbaHFS6g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:58:36 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so3113103wgh.9
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 11:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=stnib/jKzIVzdRYLbTr2IIH/0NqYWVEf7n9SXzROUOI=;
        b=cOZ0NV5zMJGFyD/2R7L9fQHEmJ7yeARPUQqGbJouqR3zxmX95cPt3KTm9Fcn9zW6zg
         nV0ETxEiwBHC7wpYVR0ufocrv4YTNxyN5eY3CUkpuIVzQ8WnMoVPaLRhYIxieyTX5wIA
         WFhpTP75kD+vWQPl3lJi7jSiiLHfrMAwF85NZSd1XogG5mHcjqGcmhk8Yrg4A2fvZuWJ
         UGTrVWMlgg1q3/YH5bKM7HHx+kfLJnSN7cGH8HDGVCycURQo7poer8gxFOrCLrhTsj9s
         Rf2TCGXCKZE2rzb6ZQZVLApF5w3HY0oA9l5HCyCbrI4bW632cPrWLlv3kt3Lv/LNNaKP
         YSyg==
X-Received: by 10.194.200.229 with SMTP id jv5mr18211605wjc.90.1407351515361;
        Wed, 06 Aug 2014 11:58:35 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id cx5sm4357054wjb.8.2014.08.06.11.58.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 11:58:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140805184724.GA10369@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254892>

Am 05.08.2014 20:47, schrieb Jeff King:
> On Mon, Aug 04, 2014 at 09:19:46PM +0200, Karsten Blees wrote:
> 
>> Hmm, I wonder if it wouldn't be simpler to read / write the desired on-disk
>> structure directly, without copying to a uchar[6] first.
> 
> Probably. My initial attempt was to keep together the read/write logic
> about which sizes each item is, but I think the result ended up
> unnecessarily verbose and harder to follow.
> 

Yeah, having read / write logic in different files is confusing, esp. when
not using structs to define the file format.

>> Here's what I came up with (just a sketch, commit message is lacky and the
>> helper functions deserve a better place / name):
> 
> I like it. Want to clean it up and submit in place of mine?
> 

Will do, but it will have to wait till next week.

> -Peff
> 

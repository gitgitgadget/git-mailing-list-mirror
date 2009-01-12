From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Tue, 13 Jan 2009 00:59:19 +0100
Message-ID: <200901130059.19511.jnareb@gmail.com>
References: <87wsd48wam.fsf@iki.fi> <200901101436.48149.jnareb@gmail.com> <alpine.DEB.1.00.0901101507590.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWi8-00031i-DD
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbZALX7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 18:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZALX7X
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:59:23 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:31354 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZALX7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:59:21 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1388435eye.37
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9Xnp1qiJ09InIHAYZZkCOXnA34Ehc5U3Rq0pDLF7PaE=;
        b=hLGMD/NeMZK1K1YlWsJUPCh7ucT7LDspTfIqqD2LwMOd9qx88iUWFEMFzFOv5R5Ib7
         TWONnSaNnnEl/1zPA0duJ/yo+DVZY62a33jGPLD9xAt9GADyuF4TrcC/bkrskPP3K7Qu
         KKfwvqpIeHbP8UL3WYe04m+imyX5qdKphu3PI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VJGF9OGewWVh1xl7/FYm903EV+Q+YHiafmzZEBw3YjOgRPxu66sDtAxmN6pu1XoRGR
         QPHUgOcRHgrdbuEYoqL9jYFIhc5uPIbyC6KpLTZeA0PYL+UFhbuDs8CZr5gVgu/dyxGS
         Z9NrrGOWWDsnv4tR+b1xfy1XbQRASRGIK91r0=
Received: by 10.210.90.10 with SMTP id n10mr18886748ebb.135.1231804760102;
        Mon, 12 Jan 2009 15:59:20 -0800 (PST)
Received: from ?192.168.1.11? (abvj184.neoplus.adsl.tpnet.pl [83.8.207.184])
        by mx.google.com with ESMTPS id 31sm59820864nfu.62.2009.01.12.15.59.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 15:59:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0901101507590.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105419>

Hello!

On Sat, 10 Jan 2009, Johannes Schindelin wrote:
> On Sat, 10 Jan 2009, Jakub Narebski wrote:
>> On Sat, 10 Jan 2009, Johannes Schindelin wrote:
>>> On Sat, 10 Jan 2009, Jakub Narebski wrote:
>>>> Thomas Rast wrote:
>>>> 
>>>>> --color-words works (and always worked) by splitting words onto one
>>>>> line each, and using the normal line-diff machinery to get a word
>>>>> diff. 
>>>> 
>>>> Cannot we generalize diff machinery / use underlying LCS diff engine
>>>> instead of going through line diff?
>>> 
>>> What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
>>> That's why we're substituting non-word characters with newlines.
>> 
>> Isn't Meyers algorithm used by libxdiff based on LCS, largest common
>> subsequence, and doesn't it generate from the mathematical point of
>> view "diff" between two sequences (two arrays) which just happen to
>> be lines? It is a bit strange that libxdiff doesn't export its low
>> level algorithm...
> 
> Umm.
> 
> It _is_ Myers' algorithm.  It just so happens that libxdiff hardcodes 
> newline to be the separator.

So amd I to understand that _exported_ functions hardcode separator
to be newline (most probably for performance), and there is no function
in libxdiff which calculates LCS, or returns diff for arrays
(sequences)?

-- 
Jakub Narebski
Poland

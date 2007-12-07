From: Luke Lu <git@vicaya.com>
Subject: Re: Git and GCC
Date: Fri, 7 Dec 2007 15:04:25 -0800
Message-ID: <B2B3D9E9-4A5C-4DE0-9FF9-B0F9304BDCD2@vicaya.com>
References: <20071206.193121.40404287.davem@davemloft.net> <20071207063848.GA13101@coredump.intra.peff.net> <9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com> <20071207.045329.204650714.davem@davemloft.net> <alpine.LFD.0.9999.0712070919590.7274@woody.linux-foundation.org> <4759AC8E.3070102@develer.com> <m3hciutaoq.fsf@roke.D-201>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Giovanni Bajo <rasky@develer.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, jonsmirl@gmail.com,
	peff@peff.net, nico@cam.org, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 00:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0mFe-000158-Ae
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 00:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbXLGXEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 18:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbXLGXEg
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 18:04:36 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:48224 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbXLGXEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 18:04:35 -0500
Received: by rv-out-0910.google.com with SMTP id k20so855438rvb
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 15:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=PttN1c2LuE8eeg/7cV5oN9mW7c9Ug9e9o7Djt1y/LZ8=;
        b=SEmMhmz3foEUflOqRv0VJhJxXeWn3gdiHuOWze0iWDiS0kcMbPeOrnv8O0EB0BUZvaWUfGu3RChYvHDLP/9D5EOTj/4rDWstp1Gs7UmJytdHeqjc5O8kInx6r0KMnWz6ZG9XXM2hSRLwBcuSbspOBfh35JMZNn+YhdBl3K2F1cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=bYuLTElrg/JhTAGGivb0Eao7bCY3zWntdrZm3kpvBf531aSbfAmlfFkSou0lt3+Ssh/1NheCTGEV0NjCDRq2LPXVk60w+wVlcLmp1ASIlcIFnPF8i0lepjQiaWt9e3Pj8gCQob3gVtessVH2S1IdYq9tc3tylAwOQ1hLNl7HKbM=
Received: by 10.141.83.15 with SMTP id k15mr3008082rvl.1197068674863;
        Fri, 07 Dec 2007 15:04:34 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id b21sm424227rvf.2007.12.07.15.04.31
        (version=SSLv3 cipher=OTHER);
        Fri, 07 Dec 2007 15:04:32 -0800 (PST)
In-Reply-To: <m3hciutaoq.fsf@roke.D-201>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67484>

On Dec 7, 2007, at 2:14 PM, Jakub Narebski wrote:
> Giovanni Bajo <rasky@develer.com> writes:
>> On 12/7/2007 6:23 PM, Linus Torvalds wrote:
>>>> Is SHA a significant portion of the compute during these repacks?
>>>> I should run oprofile...
>>> SHA1 is almost totally insignificant on x86. It hardly shows up. But
>>> we have a good optimized version there.
>>> zlib tends to be a lot more noticeable (especially the
>>> *uncompression*: it may be faster than compression, but it's done  
>>> _so_
>>> much more that it totally dominates).
>>
>> Have you considered alternatives, like:
>> http://www.oberhumer.com/opensource/ucl/
>
> <quote>
>   As compared to LZO, the UCL algorithms achieve a better compression
>   ratio but *decompression* is a little bit slower. See below for some
>   rough timings.
> </quote>
>
> It is uncompression speed that is more important, because it is used
> much more often.

So why didn't we consider lzo then? It's much faster than zlib.

__Luke

  

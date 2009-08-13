From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign vcs
Date: Fri, 14 Aug 2009 00:00:42 +0200
Message-ID: <200908140000.43185.jnareb@gmail.com>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org> <m363ctpedr.fsf@localhost.localdomain> <7vocqkydum.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 00:00:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbiLr-0006Dw-VE
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 00:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbZHMWAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 18:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753424AbZHMWAn
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 18:00:43 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:43720 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZHMWAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 18:00:43 -0400
Received: by fxm28 with SMTP id 28so853402fxm.17
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yf7Tt72Qu8NtbzCymP5GhODfPNzIjLRdcAZmKa1AUV0=;
        b=rlR2+HeqltumpiOO2KH74s1yG4CXqIFCUgY3kobOQFdYWpDd2XD7DhzLvrIbHlbPGm
         ZYeLZLFeT9egzK6Bi4Htf2htkRBsnFGePpVIC4HVELaN9oeyfMlsh9D4buZOIMXy4Df/
         Me1+wyqUQsJby53lgwMhy71MWedk2KCGgdT3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=G04Msu5R/YWxllnF8wEfJc9RmYLuzZ1zXDh4qpFVTvN5FGDRPGIHSUOmpiRmolY6D3
         UN89ZTfD1lRB4KV9x+sb0nN9Zm9bQaDOLajxguGSPy+llvgSVuuTMpI97eIg8ocxlOS8
         CNd0XjzPn+TGN7tfKpb/Wp8RduM425FYoFyVc=
Received: by 10.103.249.19 with SMTP id b19mr473499mus.33.1250200842860;
        Thu, 13 Aug 2009 15:00:42 -0700 (PDT)
Received: from ?192.168.1.13? (abuz206.neoplus.adsl.tpnet.pl [83.8.197.206])
        by mx.google.com with ESMTPS id n10sm3518574mue.19.2009.08.13.15.00.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 15:00:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vocqkydum.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125884>

On Wed, 12 August 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>>   1. Is there some other syntax that _doesn't_ have this breakage
>>>      but that similarly helps the "vast majority of Git users".
>>
>> Well, proposed possible syntax was:
>> 1. <vcs>:<repository location>
>> ...
>> 2. <vcs>::<repository location>
>> ...
>> 3. <vcs>+<repository location>
>>
>>    e.g.
>>
>>      svn+http://svn.example.com/project
>>
>>    but
>>
>>      http+svn://svn.example.com/project
>>      svn+path/to/repo
> 
> I do not think these are valid examples to demonstrate that 3 is bad.
> 
> We do not have (and we will not create) "http+svn://" native transport, so
> the former can only mean "Feed 'svn://svn.example.com/project' to the vcs
> helper whose name is 'http'".  Similarly I do not see any way to read the
> latter other than "Feed 'path/to/repo' to 'svn' vcs helper".

And not "Use 'svn+path/to/repo' as local filesystem path to repository?
On the other hand you can always use here './svn+path/to/repo'

> Double-colon (your 2) is also workable.  It probably is slightly better
> than plus because it does not have to grandfather "git+ssh" and "ssh+git"
> and that would be beneficial for requiring less complexity in both code
> (i.e. special case logic) and more importantly in mental burden to the end
> users (i.e. '::' would stand out more than '+' and clearly different from
> traditional git URLs in all cases).
> 
> As Jeff said (your 1.), a single colon ':' has a rather bad ambiguity
> between <vcs> and hostname part in the existing scp-style repository
> naming.

Also double colon is better for scp-like repository location, as e.g.

  svn+example.com:path/to/repo

might be 'path/to/repo' on 'svn+example.com' host; there is no "escape"
mechanism like for './svn+path/to/repo' relative path.  On the other 
hand unescaped ':' cannot be present in hostname, therefore the following
is unambiguous:

  svn::example.com:path/to/repo

But on another hand svn+http://svn.example.com/project/trunk/ looks IMVHO
better that svn::http://svn.example.com/project/trunk/

-- 
Jakub Narebski
Poland

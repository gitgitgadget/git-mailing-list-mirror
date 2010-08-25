From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH jn/merge-renormalize] merge-recursive: expose merge
 options for builtin merge
Date: Tue, 24 Aug 2010 23:29:06 -0500
Message-ID: <20100825042906.GI11619@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino>
 <20100824033922.GA19628@burratino>
 <7vk4nfvo56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 06:31:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo7de-0002ae-SV
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 06:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab0HYEa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 00:30:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40910 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0HYEa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 00:30:56 -0400
Received: by gyd8 with SMTP id 8so56016gyd.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 21:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FQvjgz9VAE/tY2P1vhHOFPOrsAFBiEigF3UHAiVYzIc=;
        b=rcc/ZIiwnqF2pSqApT1UHAMXkkYQMlk7NcWrkno0s3zHAeNm0Wd2cNOX8JO7424naL
         gnRzYd6efK6l16jKd5mzkr1dDcpAgsn7NwqQDS6NRu6s7r1I8iQ3WHzdP/hFqtlADxBz
         fze47PN7ireYqhaUh0HqHALByOdBoaEwIc+As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RasUJixtVEK8FUoROMKwgED4tx8M8+K5bDyh2TJP4aLkkTlWKwK4nDXOPa4z4J8+Vj
         Me7O69TfZeJZDdZWJd7Gkp4OLkbtiSo0+MKgaqIcVZlY8n5LLNSkqzs4588axP5UTT4X
         jPJhfgrT3B+DPwkVuT955CBk9riN6QJn24Aek=
Received: by 10.151.69.21 with SMTP id w21mr7845673ybk.428.1282710655282;
        Tue, 24 Aug 2010 21:30:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t20sm5754521ybm.17.2010.08.24.21.30.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 21:30:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4nfvo56.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154413>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> There are two very similar blocks of code that recognize options for
>> the "recursive" merge strategy.  Unify them.
>>
>> No functional change intended.
>
> It makes sense, but I wonder why you chose to do "if (fun() <= 0) error"
> instead of usual "if (fun() < 0) error"...

No good reason (an attempt to vaguely imitate the interface of
handle_revision_opt() from revision.c).  Since both callers die for
an unrecognized option, returning 0 for success and -1 for failure
would indeed be simpler.

I'll try to find time to reroll the series (including --patience)
on top of jn/merge-renormalize tomorrow.  Probably
--ignore-space-change et al are safe, too, though some test cases
would be nice.

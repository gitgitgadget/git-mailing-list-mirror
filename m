From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more gradually
Date: Thu, 01 Jul 2010 10:05:17 -0700 (PDT)
Message-ID: <m3iq4znnfr.fsf@localhost.localdomain>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
	<3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com>
	<4C2C6BC5.1030905@viscovery.net>
	<7v630z41ao.fsf@alter.siamese.dyndns.org>
	<D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.orgList" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 19:05:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUNCa-0003aB-V4
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 19:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab0GARFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 13:05:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38809 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0GARFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 13:05:22 -0400
Received: by fxm14 with SMTP id 14so1502226fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5J5XqFcgnetheWSCQJx29LpsSUBbOv8c7xdS42+4LlE=;
        b=vxaWLUKfMpiFEqsKyE/x50JrOyE69MAniTgXPBxITm2YKzOuruIvipWADgI0CIiLqf
         kT39HuIzL1igq8m5z6T1AB7+AI64HB5WvfW5drukkx57qTEY+2aMgLx/zOxxHg1InKQx
         Fxk6du0CZmB3VPWQPGogQRlIl38gpWjxcqYiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=jiMVGB+MfJvtqHh18JxmmPXKM0RtOhZDAwxReu0bTmVFspDyGR8E5t1B+gOrjRLKOA
         uegFdYdyK5gtIQItFG9ycG/pp0MD0uxJ6N0qcblvP+Iu/De4Vw7+iKdqobnOgXH5fU19
         o4eV5WQNuO9t4AR+wH4q8u7NrRtHCS/GTt5v4=
Received: by 10.223.161.211 with SMTP id s19mr9694267fax.47.1278003919881;
        Thu, 01 Jul 2010 10:05:19 -0700 (PDT)
Received: from localhost.localdomain (abwm116.neoplus.adsl.tpnet.pl [83.8.236.116])
        by mx.google.com with ESMTPS id 11sm228673fas.0.2010.07.01.10.05.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 10:05:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o61H4lPp031145;
	Thu, 1 Jul 2010 19:04:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o61H4PWc031141;
	Thu, 1 Jul 2010 19:04:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150058>

Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> On 1. juli 2010, at 18:25, Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Sixt <j.sixt@viscovery.net> writes:
> >> Am 7/1/2010 11:09, schrieb Eyvind Bernhardsen:
>>>
>>>> +core.mergePrefilter::
>>> 
>>> BTW, any particular reason that this is in the core namespace rather than
>>> merge namespace? It could be merge.prefilter.
>> 
>> Good point.
>> 
>> Somehow to me "prefilter" does not sound to convey what really is going on
>> here, though.
> 
> "Doubleconvert" doesn't really mean anything either though, and
> "convert" and "normalise" are too generic. I think the problem is
> that there's no existing name for what convert.c does.
> 
> I chose "filter" because of the filter property; the crlf and ident
> things can be regarded as built-in filters.  -- Eyvind

What about `merge.renormalize' ;-) ?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

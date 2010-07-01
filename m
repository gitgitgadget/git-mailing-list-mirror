From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more gradually
Date: Thu, 01 Jul 2010 13:15:28 -0700 (PDT)
Message-ID: <m3aaqbnemz.fsf@localhost.localdomain>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
	<3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com>
	<4C2C6BC5.1030905@viscovery.net>
	<7v630z41ao.fsf@alter.siamese.dyndns.org>
	<D2F8C67C-F7AE-4523-870F-879B741C2591@gmail.com>
	<m3iq4znnfr.fsf@localhost.localdomain>
	<20100701185712.GA22421@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.orgList" <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 22:15:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQAg-0001DW-NP
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920Ab0GAUPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 16:15:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52606 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab0GAUPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:15:31 -0400
Received: by fxm14 with SMTP id 14so1680925fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lwHB4DFC81v2cut0AQFm3l1zQ0zILnpBzyy4mrweU/0=;
        b=oKR5zybUqWkmc/q/ptR1DzrfbDGgzfMucNG5Lyuu1Na7rgP0l8H+fqecxQeBQTSGmc
         zDUMqg/ri7sRqbXKy7N76Wm89c54FNsgEbu5yi9GJvZ7KVTQoEYBBgimgyK3y4nxim1x
         z2hRLTh9tCLH9VSVB+bYiSkDMpyAWcU3vrHBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NPGs//Z50078naapMBDcv/g/8RoJY3tho6Z1XlOnyFf5DQ80DIBD4Qc31R7LXd5bHO
         cPUOHPHf7AKkM9w/9vNS7uTKaNuZd01msJPgvg+L7l/wGNyGLYLPFxwHidKgK6eEtuTt
         q7Q/kdySZ1nX7G0k+EeN79wowIMazKKmWRKz4=
Received: by 10.223.26.206 with SMTP id f14mr10079702fac.96.1278015329278;
        Thu, 01 Jul 2010 13:15:29 -0700 (PDT)
Received: from localhost.localdomain (abwm116.neoplus.adsl.tpnet.pl [83.8.236.116])
        by mx.google.com with ESMTPS id 2sm3307328fav.1.2010.07.01.13.15.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:15:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o61KEtpV000872;
	Thu, 1 Jul 2010 22:15:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o61KESbD000861;
	Thu, 1 Jul 2010 22:14:28 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100701185712.GA22421@pvv.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150070>

Finn Arne Gangstad <finnag@pvv.org> writes:
> On Thu, Jul 01, 2010 at 10:05:17AM -0700, Jakub Narebski wrote:
>> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
>>> On 1. juli 2010, at 18:25, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>>> Am 7/1/2010 11:09, schrieb Eyvind Bernhardsen:
>>>>>
>>>>>> +core.mergePrefilter::
>> [...]
>>>> 
>>>> Somehow to me "prefilter" does not sound to convey what really is going on
>>>> here, though.
>>> 
>>> "Doubleconvert" doesn't really mean anything either though, and
>>> "convert" and "normalise" are too generic. I think the problem is
>>> that there's no existing name for what convert.c does.
>>> 
>>> I chose "filter" because of the filter property; the crlf and ident
>>> things can be regarded as built-in filters.  -- Eyvind
>> 
>> What about `merge.renormalize' ;-) ?
> 
> Best so far! Or what about "merge.canonicalize"? Sorry for bikeshedding :)

Perhaps `merge.regularize'?  Or `merge.normalizeToWorkTree'?
It is about converting to worktree version according to current
settings, IIUC...

-- 
Jakub Narebski
Poland
ShadeHawk on #git

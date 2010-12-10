From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 14/14] wt-status.c: Initialise variable to suppress msvc warning
Date: Fri, 10 Dec 2010 14:35:30 +0100
Message-ID: <AANLkTinty08S2vT9ZSVQW03yL5uzrmqW7k_Ozad-q-E2@mail.gmail.com>
References: <4CFA92A2.4030801@ramsay1.demon.co.uk>
	<20101204205206.GB3170@burratino>
	<4D011D30.4070405@ramsay1.demon.co.uk>
	<7vmxoeg3wp.fsf@alter.siamese.dyndns.org>
	<AANLkTi=SzDhoQnLeKUvWe7A6r-7MT-DTLuDGLprqid9X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 10 14:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR38z-0000Wg-RS
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 14:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab0LJNfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 08:35:32 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53089 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0LJNfb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 08:35:31 -0500
Received: by vws16 with SMTP id 16so2196752vws.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=NMjwrMF2t1tV3GnjrvSWnQu2asowK9YQ/eYSJmXq6ks=;
        b=PnXXC8C1sroDq3FF9avWBwOffgdkBAPg0eq0fPt56LemXBsJK9JK2wGOcY0DWMKdme
         nIPuXIYhWyWZquZoCoI+OiHpFow16rrrTkTp0xi1df/7qBaYmz9aNcfk63aTGIJ73d7o
         jksJd4/3CSgUhqWE3N0+vEk4OnYtqgqMdv7V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=S5XXd3p1Cvzt0q+oCP3ldJ+nDidZmCe+BQWr5enkirUy8RQ0mcT0IbZLEu1KM6uqzk
         uCEaPXT520xcVKfRiCbBBq+Co+k3/USQydZODOYxVYkB6HMlYR9baGdCNWTSKPkcHTbg
         Y5tWELHjQFG2oQymfl9vdVdeoHo+yNMQjxNCg=
Received: by 10.229.91.10 with SMTP id k10mr674708qcm.82.1291988130735; Fri,
 10 Dec 2010 05:35:30 -0800 (PST)
Received: by 10.229.25.81 with HTTP; Fri, 10 Dec 2010 05:35:30 -0800 (PST)
In-Reply-To: <AANLkTi=SzDhoQnLeKUvWe7A6r-7MT-DTLuDGLprqid9X@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163412>

On Thu, Dec 9, 2010 at 20:46, Erik Faye-Lund <kusmabite@gmail.com> wrote:

> On Thu, Dec 9, 2010 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> Junio, could you please drop patches 5-14 from the series; the first four patches
>>> are the important ones and I'd rather they didn't get held up. Thanks!
>>
>> Have these four patches been Acked by interested parties?
>>
>> I think I saw 1/N and 2/N acked by Erik and 4/N acked by SSchuberth and
>> J6t, but any words on 3/N?
>>
>> Not that I deeply care nor have environment to test changes to [3/N], but
>> I am wondering if these need conditional definition to futureproof (e.g.
>> what happens when the header you are using the definition _I64_MIN from,
>> or some other headers, started defining these constats?).
>
> I'm not sure if I follow this entirely. _I64_MIN is defined by
> limits.h on Windows, and limits.h has a header-guard (or "#pragma
> once" as Microsoft-code tends to prefer).
>
> Oh, right. You mean if someone else starts defining INTMAX_MAX etc? If
> someone includes an stdint/inttypes-implementation while including
> git-compat-util.h, we're going to have a boat-load of similar issues
> anyway. I think guarding them is something that's better left to when
> we encounter the problem (if ever).

FYI: In contrast to previous versions, Visual Studio 2010 ships with a
stdint.h header which defines INTMAX_MAX etc. However, that stdint.h
is not included by limits.h (in fact, not by *any* other shipping
header file, as it seems), so we should not run into any trouble even
with VS2010.

So I agree with Erik about patch 3/N:

Acked-by: Sebastian Schuberth <sschuberth@gmail.com>

-- 
Sebastian Schuberth

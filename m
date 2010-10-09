From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Sat, 09 Oct 2010 01:47:12 -0700 (PDT)
Message-ID: <m3aamng3dt.fsf@localhost.localdomain>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
	<20101008135034.GC5163@sigill.intra.peff.net>
	<AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
	<20101008195120.GA10810@sigill.intra.peff.net>
	<AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
	<20101008200657.GA10954@sigill.intra.peff.net>
	<AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 10:49:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4V6x-0004mQ-4L
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 10:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab0JIIrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 04:47:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48849 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab0JIIrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 04:47:17 -0400
Received: by fxm14 with SMTP id 14so896321fxm.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 01:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=TjLxvi9PiQHETM9oNZTp9SmS+pwGwC8sxX2zqqFi58w=;
        b=mWbRliUFO6TwL+mxCLU7Aza/2x8dvVT8v9lBJbJxmRNxg+ZIWggip+A+K8e8Ua94O8
         oK2Q5A/bKYXhdKGU/7Ji/itD1ldoLqibecC2QpVkm6OhBKk0jbql+Y7PKFIaIhiicp46
         POkWzxYSLCBgfhNnKiuXp3oWC/PfN8rsM+EFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Nckh7wzbiyQMAnj9zis2tOPP9RVlLAlcfap8CKGzwZOBh6WcbEaYkK/+aY/l9LIPrY
         l6GLcwbuAvb7lRcWwnREe5VOY07y8ovyNx8i+Vna5KJ3l5Tcr7Z5q8jOz4VvCEiilORi
         tbv8fwY/+Rt0FAiEO1pZs6TNsAx/gWuIx6T9M=
Received: by 10.223.96.132 with SMTP id h4mr193601fan.114.1286614035550;
        Sat, 09 Oct 2010 01:47:15 -0700 (PDT)
Received: from localhost.localdomain (abwr119.neoplus.adsl.tpnet.pl [83.8.241.119])
        by mx.google.com with ESMTPS id 10sm2047972fax.18.2010.10.09.01.47.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 01:47:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o998kc0l017496;
	Sat, 9 Oct 2010 10:46:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o998kMrX017456;
	Sat, 9 Oct 2010 10:46:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158575>

Dun Peal <dunpealer@gmail.com> writes:
> On Fri, Oct 8, 2010 at 3:06 PM, Jeff King <peff@peff.net> wrote:

> > Re-reading your original message, I have a few more thoughts.
> >
> > One is that you don't need to do this per-commit. You probably want to
> > do it per-updated-ref, each of which may be pushing many commits. And
> > then you either reject the new ref value or not.
> 
> I think I do, actually, because let's say the developer pushes two
> commits, 1<-2. Suppose commit 1 violates the rule, but commit 2
> reverts the violation. One might think that we don't care, since the
> head will now be on 2, which is a correct state. But in fact we do,
> because this is Git, and anyone may branch of from 1 in the future,
> and voila we have a head in an incorrect state.

Sidenote: why not detect violation earlier, by having pre-commit hook
in each developer repository check for such violation?  It is not as
time sensitive on the local side (when creating a commit, you have to
take some time to write commit message anyway).

See how example pre-commit hook check for "non-ascii" file names.
-- 
Jakub Narebski
Poland
ShadeHawk on #git

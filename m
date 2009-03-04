From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Wed, 4 Mar 2009 17:18:41 +0300
Message-ID: <37fcd2780903040618q24457d96m7a9b181a3e202c7d@mail.gmail.com>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
	 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
	 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
	 <200903021530.01165.trast@student.ethz.ch>
	 <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
	 <37fcd2780903030147q7062ee47w7ce524c28a6aa347@mail.gmail.com>
	 <alpine.DEB.2.00.0903031246420.3702@perkele.intern.softwolves.pp.se>
	 <37fcd2780903030913q4ee0e5d0t45dc3b124285f748@mail.gmail.com>
	 <alpine.DEB.2.00.0903041149250.8926@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Mar 04 15:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LerxM-0000xg-Da
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 15:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbZCDOSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 09:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZCDOSq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 09:18:46 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:33534 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZCDOSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 09:18:44 -0500
Received: by fxm24 with SMTP id 24so2917802fxm.37
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 06:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KsGakhBC07uzd4u5QTA/DBRELN3pdjnuVIWZ20x1634=;
        b=hAHhurGQNTsiD4fxPYxA+/mmKv0LxpSRxlKGvFxd+KAYlWao7dfxZ8DNjnpSQXvpPT
         E2NN+6/0bI5Hsm3pAXAUEjSAiWmTsqaBurqpGHfWMVClBXOM/dIyeXGjDQ3U17WV7NTk
         RYPPJUikXs2QvHIftI6UxqGguvdWkej+tRYtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jOAovVS/Vop8MdywMD8hmXUchNzj733HSgu7Z4uhvwJjB2tRZ9Gb8n7nhkU0NSrj/I
         XcmBHTqb+r/hGg0ucM3ENGkw2gTqThQvZnlYUt3KPqMNK1V1S3SI0P20q5xJ9xCVr7IL
         52Z9Ixww0Xhf2ptwsOu6FUM/hOG81eLM/6slk=
Received: by 10.86.53.11 with SMTP id b11mr95386fga.76.1236176321171; Wed, 04 
	Mar 2009 06:18:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0903041149250.8926@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112215>

On Wed, Mar 04, 2009 at 11:51:15AM +0100, Peter Krefting wrote:

> The problem with changing wchar_t is that_
> it was defined to use 16-bit values at a time where Unicode was defined_
> to use 16-bit code points (but they soon figured out that was not_
> enough).

I do realize that is a problem, and unfortunately there is no easy and
quick fix to it. But you brought Windows as an example of good Unicode
support... Well, to my mind, it is not, at least, not for C programs.
You have two serious problems here:
1. wchar_t is too small to hold all Unicode characters as it is required
   by C standard.
2. UTF-8 support is broken in C runtime library.

In fact, if UTF-8 were supported by C runtime, we would not have this thread
in the first place... Now, it is possible to wrap all C functions used by Git to
make them work with UTF-8, but it is a lot of work...

Dmitry

From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 6 Sep 2007 20:09:23 -0700
Message-ID: <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <1189004090.20311.12.camel@hinata.boston.redhat.com>
	 <vpq642pkoln.fsf@bauges.imag.fr>
	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 05:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITUDp-0002cB-Uu
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 05:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbXIGDJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 23:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbXIGDJZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 23:09:25 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:39023 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbXIGDJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 23:09:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so313034rvb
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uhxD4hlUy3Bl8gNvzlG8IhqKEfutHn/tgf73JGHo+y8=;
        b=aNnyS1ZR2g/MJDorenc0pMT3SqJb6xw9k1Vmwigmb4hZkr1I+SgU8SBo9vCPOucQDaf+q0qsFy4KeOj6HZQ5PsGZ7hWxMEmm3HsImi1cj7Qa5J6JlyXu8A49CXfpMEFUfGVH9C3tKWEo15eiz8pz4QA7dloRp9iDFtsQQd+q2/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=anOjOq8parjxkPUNer2f6NCbrhxFoHmarjv6SBKG5je0jH6Ls/fGGuRuRaVkJ+ynLK8BMJuMtPUSXpyPml+lUjA0YXg/Yowz26bro6tMB08Xu6cdo5FCzslEJNtofw2es1lpqu1CZPRWI2ip1g7mZ7c5OdVE4waJVZBvBQrl+OY=
Received: by 10.141.161.6 with SMTP id n6mr538403rvo.1189134563124;
        Thu, 06 Sep 2007 20:09:23 -0700 (PDT)
Received: by 10.141.204.17 with HTTP; Thu, 6 Sep 2007 20:09:23 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57968>

On 9/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
> >
> > As it is right now, it's too hard to see the high-level logic thru
> > this endless-busy-work of micro-managing strings and memory.
>
> Total BS. The string/memory management is not at all relevant. Look at the
> code (I bet you didn't). This isn't the important, or complex part.

Not only have I looked at the code, I've also debugged it quite a bit.
Granted most of my problems had to do with handling paths on Windows
(i.e. string manipulations).

Let me snip "C is better than C++" part ...
> [ snip ]
... and explain where I'm coming from:
My goal is to *use* Git. When something does not work *for me* I want
to be able to fix it (and contribute the fix) in *shortest time
possible* and with *minimal efforts*. As for me it's a diversion from
my main activities.
The fact that Git is written in C does not really contribute to that goal.
Suggestion to use C++ is the only alternative with existing C codebase.
So while C++ may not be the best choice "academically speaking" it's
pretty much the only practical choice.

"Democracy is the worst form of government except for all those others
that have been tried." - Winston Churchill

Now, I realize that I'm a very infrequent contributor to Git, but I
want my opinion to be heard.
People who carry the main weight of developing and maintaining Git
should make the call.
-- 
- Dmitry

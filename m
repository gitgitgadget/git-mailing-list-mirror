From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Thu, 17 Jan 2013 21:18:50 -0600
Message-ID: <CAEUsAPZr+bNNA-pqrQbBGvku4T3h58Ub66mK2zLeHqghEKw5Aw@mail.gmail.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
	<DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
	<7vsj61xez2.fsf@alter.siamese.dyndns.org>
	<7vobgpxeel.fsf@alter.siamese.dyndns.org>
	<CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
	<7vehhkuwg5.fsf@alter.siamese.dyndns.org>
	<CAEUsAPYAL6TD_nzu-YumRK_b-kFy7mNz1VivmSxGeuFYVxVL4g@mail.gmail.com>
	<20130118010638.GA29453@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 04:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tw2UF-0001ou-0j
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 04:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab3ARDSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 22:18:55 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:50096 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab3ARDSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 22:18:52 -0500
Received: by mail-la0-f51.google.com with SMTP id fj20so3334164lab.24
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 19:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=kUIqIVIAVH/wDUu1+ZVYk3MM6PmKVkTMsfClBW1dPrw=;
        b=ajE8fKggU8tZ6QKC5apJm7X1Q0qhtyvYM5/i9CTxiXreGehY+iLSncwyeQLyBBBgii
         /bgB0gY7pc6bVLz4YUhkRHjOPKwlH6hMKS933wo0xTkUCAwTLTlS4gesM/cL2agnwcBU
         /HJD1peVlKRmb3Mzz+FjKkiJC9uO4pcLYZ52Mwodmb03QAf1vPrgp41jh9jO4ihne5hP
         w58zU3o2gV0E9ZLUCqNaMu9vACceVGEycJJ/507Pn4RCHodG0kBzAMZMs9Y4lfs+5neE
         bQa231f8f5rFYJtAQLASCJwUOfdVqPHXg6cVHHAABL5w8IFQqCT8ArOmAiNHSrW7ly7/
         uaEg==
X-Received: by 10.152.145.37 with SMTP id sr5mr7024567lab.33.1358479131000;
 Thu, 17 Jan 2013 19:18:51 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Thu, 17 Jan 2013 19:18:50 -0800 (PST)
In-Reply-To: <20130118010638.GA29453@sigill.intra.peff.net>
X-Google-Sender-Auth: KisYRXJfTwl4SJxp416PviBcw90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213897>

On Thu, Jan 17, 2013 at 7:06 PM, Jeff King <peff@peff.net> wrote:
> However, if instead of the rule being
> "blobs on the remote side cannot be replaced", if it becomes "the old
> value on the remote side must be referenced by what we replace it with",
> that _is_ something we can calculate reliably on the sending side.

Interesting.  I would have thought knowing reachability implied having
the old object in the sending repository.

> And
> that is logically an extension of the fast-forward rule, which is why I
> suggested placing it with ref_newer (but the latter should probably be
> extended to not suggest merging if we _know_ it is a non-commit object).

Sounds great, especially if it is not dependent on the sender actually
having the old object.  Until this is implemented, though, I don't
understand what was wrong with doing the checks in the
is_forwardable() helper function (of course after fixing the
regression/bug.)

Chris

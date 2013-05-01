From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Thu, 2 May 2013 01:20:51 +0530
Message-ID: <CALkWK0mfHVBLPdU7jyiBR=-kSguCBFOhsEsXYYthBuQbtX7MuA@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-5-git-send-email-artagnon@gmail.com> <CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
 <CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com> <CAMP44s34X+6c2V0iU_+dfNR9ULXD+Q0CDFk0S9qdK0n8AC81DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXd3z-0002JI-RR
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab3EATve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:51:34 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:39239 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab3EATvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:51:32 -0400
Received: by mail-ia0-f173.google.com with SMTP id 21so1663318iay.4
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tgWadIE1jVvfUDcGfEiLIs7AtqEd/h2GauXGZ0zL09g=;
        b=VjVVviABDhtx/+t/TGzkmAZtXpoD3pZ/7ZRIYVqv85wOxofoKirOd6MWUa0GyKeQqe
         r21XNawDbASw3cVlPEL2DUSj6IT9gimA54Ekwifn1/tTWGVsSOEPsr1BxZmLIrHBMo7R
         eL2djSYphZKW2lDJ9z7Ix6jh8fv+31+qdDNvw3QtzjCfxbDaWHTK9QBNXlhFKCYb3m45
         ylzhIFODTbJLSk7MuabvK8iPFY7bfndZE5RFJwRa3tyCaoWr6kSU0Ulj/o+cakRORasI
         +29IHoGwYAQe59QAG4XcalKCFdAbk5OIJsu39dcXTEX2Jvuut2zho4oFaWHCjaaJ5rpM
         plgQ==
X-Received: by 10.50.57.116 with SMTP id h20mr7339133igq.49.1367437891984;
 Wed, 01 May 2013 12:51:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 12:50:51 -0700 (PDT)
In-Reply-To: <CAMP44s34X+6c2V0iU_+dfNR9ULXD+Q0CDFk0S9qdK0n8AC81DQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223131>

Felipe Contreras wrote:
> As I said, the @@{u} thing can be fixed through other ways.

It's not just @@{u}.  I can have lots of custom symbolic refs working
properly; I might choose D for my deleted-reflogs, M for master and so
on.

    $ git log M..

The point is that my solution solves the problem in the more general case.

> Moreover, "HEAD" is still a special case in remote.c::branch_get()
> that you just modified.

It's not.  It's just a quick shortcut for the common case because
read_config() already sets it up.

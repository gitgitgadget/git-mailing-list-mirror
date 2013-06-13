From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] rebase -i: write better reflog messages for start
Date: Thu, 13 Jun 2013 16:02:54 +0530
Message-ID: <CALkWK0=o0OxTjim=+qoBhpHkWQoVWLWjkJPqknPbr29T5ax46Q@mail.gmail.com>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
 <1370881332-9231-4-git-send-email-artagnon@gmail.com> <7v8v2hizpc.fsf@alter.siamese.dyndns.org>
 <CALkWK0mmSKDH2vrz4a8Qb8=++NSAp2x5mCUEuLpPo9HLfmgFLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 12:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un4qa-0001fM-3t
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 12:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab3FMKdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 06:33:36 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:40431 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab3FMKdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 06:33:35 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so6548410oah.10
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OsPtPfN9/PkOCKU27mAGDXbJkOdfR4LN4jZUjFZPwgU=;
        b=nOsK/6ZjaHNMOqiq/E+XM6j3SoFMwW2LjAABEDV7Ir0hp0TOzV74ScL46MIa3fZogZ
         WXFoUe2Lh6GLRuV7uYf7lkks6m8pZfiJCSZx0NB7EN8V+89jZJPNrlyUKvX9GfYIT6i7
         gaO3/0TR13pL+qxINX122dFyu7qllUOKXBEZ9CnVbSbFPY2TjmDjUa8UuB/fjkBrs/Yu
         35EZXyZuFn2yHBBggJmNW59dinaMmhMUWCOLipKeXhC3lE0+W0xuqrlBRJE5wckBHASd
         492er/2qdfNTpHNdPh1sJfsVvSpVdtS0d1ii+0dtGBrRvmJPXtAfE6Cg0ZUXarJVXOTZ
         nxMg==
X-Received: by 10.50.25.194 with SMTP id e2mr19560igg.111.1371119615174; Thu,
 13 Jun 2013 03:33:35 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 13 Jun 2013 03:32:54 -0700 (PDT)
In-Reply-To: <CALkWK0mmSKDH2vrz4a8Qb8=++NSAp2x5mCUEuLpPo9HLfmgFLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227717>

Ramkumar Ramachandra wrote:
> t/status-help.  Looks seriously unrelated, and I'm breaking my head
> over it.  Any clues?

Damn it!  A recent commit is responsible for this avalanche in test
breakages: b397ea (status: show more info than "currently not on any
branch", 2013-03-13).  It re-implements a backward version of
grab_nth_branch_switch(): grab_1st_switch() essentially _relies_ on
the random unintended pollution that rebase writes to the reflog to
print a more useful (?) status :/

I have no choice but to completely redo this bit, and update all the
tests.  Let me know if there is some easy way to work around this that
I'm missing.

Thanks.

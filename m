From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 22:12:28 +0530
Message-ID: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Apr 07 18:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOsgV-0001ok-ME
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 18:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934080Ab3DGQnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 12:43:11 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:64993 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934075Ab3DGQnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 12:43:09 -0400
Received: by mail-ia0-f170.google.com with SMTP id j38so359794iad.29
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MCzDCNmvM6KtHm1DFKETUOs1VEfPNlZOL+LtNDn2O14=;
        b=EdMeEKPldQFobbxza9yJN+wXTb92qc1Xi//aWK55ciRbEkxAowbFCQ3GDwW1+6yyUc
         59BVGqLQieviIOa/ylR/k8v6e+CdZ5J1qcrvfT+HDEh7XJGlv+uy43V+00skBlkHBo5R
         0Nm9sekbZsPuRuX/2I0MbRWKp43Vwrs7xBHU9gysIR70KRgjCKb30xAt8sLnWWx+WqDJ
         lvfGtLwon5b9G/J5Wy10eTOYDlr7VKEKZwHrRczMmL1VLo2XTDqga1q14/lmtk6ZRgek
         94kkoEBeY+ByE4TOUnnUkK9mW2cAcQzITC/INx9ozGGT1JM1g3pfWibyfLJWcoTfO/PN
         1LRA==
X-Received: by 10.43.9.68 with SMTP id ov4mr10016908icb.22.1365352989197; Sun,
 07 Apr 2013 09:43:09 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 09:42:28 -0700 (PDT)
In-Reply-To: <20130407161209.GG2222@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220326>

John Keeping wrote:
> Meaning that every repository using submodules need to have a flag day
> when all of the people using it switch to the new Git version at once?

No, I would be totally against a migration that involves a flag-day.
What I meant is that having old-style submodule side-by-side with
new-style submodules is confusing (think about people using an older
version and getting confused), and that we should disallow it.  Users
will still be able to use existing repositories with new versions of
git with a few caveats:
1. They won't be able to add new new submodules without migrating all
existing submodules.
2. git ls-tree will show the in-tree object incorrectly as a link (ie.
not commit).

That's about it, I think.  Obviously, everyone working on the
repository has to upgrade to a new version of git before they can use
new-style submodules.

> I think you need a much better argument than "it makes the
> implementation more beautiful" to convince users that a flag day is
> necessary.

There is no flag day necessary, and that is not my argument at all:
new-style submodules brings lots of new functionality to the table.

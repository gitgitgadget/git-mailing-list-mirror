From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: git-am doesn't apply the rest of the email after a partial patch fail?
Date: Tue, 9 Apr 2013 11:34:06 -0700
Message-ID: <CAPKkNb6tbGtcpiYGpj6mSPnp_-aXO=HTvAjOEKJ1f-cgPOHBDA@mail.gmail.com>
References: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
	<7vppy4ykse.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdN0-0004AC-4E
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934736Ab3DISeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:34:09 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50682 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761628Ab3DISeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:34:07 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so7165287lbi.28
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RIiLQWTENkaRC/TySzEeB8CbinS4i30U1yrPkcFuJK8=;
        b=Wm9joTFA+D6kDD4vla9x/Dt002HHbhzc8ZZ5ADv/fHgS5mw+TSrDUgSpaew3XmtKFd
         LQEPACi1cxo2rt60mGNAnwfpVkn3Pcqip97M6+LB/rZJ8aja/MU07nVYWQgLhHskehcX
         L+0b6cDmPJCPUKUsV2GKnmFu3xvrsV+MjonhnEFgSSy5SJld1omT8tLbbtlmwMbVcG/f
         5ejXp3HnTurPXklMxOhl6iJ0rWm1hP/+v7tu2lfu2q42FNxkVqBovmu/HwfP51/l0m5Z
         cE/maI11qEQYPMrxIG4+w1LamyxI/onQGJcWlpF6tEFohnlPXKjkeKT8G2y2KgB448TQ
         ghjg==
X-Received: by 10.112.82.164 with SMTP id j4mr14451722lby.112.1365532446245;
 Tue, 09 Apr 2013 11:34:06 -0700 (PDT)
Received: by 10.114.92.105 with HTTP; Tue, 9 Apr 2013 11:34:06 -0700 (PDT)
In-Reply-To: <7vppy4ykse.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220611>

On 8 April 2013 10:49, Junio C Hamano <gitster@pobox.com> wrote:
> "Constantine A. Murenin" <mureninc@gmail.com> writes:
>
>> However, what I've faced with, is that when a conflict happens, and I
>> resolve, and do `git add`, and `git am --resolved`, then the rest of
>> the `format-patch` email where the conflict has occurred is discarded,
>
> That is unusual.  Are you using any other options when running "git
> am"?  You said `git add`, but what did you add?
>
> By default, its patch application is all-or-none, so when it stops,
> saying "I cannot apply this patch---please help me with it", it
> expects that all the changes the email wanted to give you has been
> applied by you to your working tree, perhaps using GNU patch or "git
> apply --reject", followed by manual editing, and to your index using
> "git add", when you run "git am --resolved".  Not just the file (or
> hunk) it detected issues with.

Well, I now know this, but it wasn't clear from the documentation that
that was the behaviour.

Also, I've now noticed that "--reject" doesn't automatically do `git
add` of any new files that were added, so, once you resolve the
conflicts, and add those files that used to result in a conflict,
you're still missing out.

C.

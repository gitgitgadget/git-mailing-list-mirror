From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 22:09:46 +0100
Message-ID: <CAHkRjk6x9ToVzY7jv1ZxPt57F6agcH7SfHZpZNpHC3QP3PZp3Q@mail.gmail.com>
References: <20121016223508.GR2616@ZenIV.linux.org.uk> <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk>
 <alpine.LFD.2.02.1210232232070.2756@ionos> <20121023205119.GA27729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Chris Metcalf <cmetcalf@tilera.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Tue Oct 23 23:11:06 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TQlke-00015K-Qe
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Oct 2012 23:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965605Ab2JWVKM (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Oct 2012 17:10:12 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42777 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933722Ab2JWVKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Oct 2012 17:10:07 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so600650qaa.19
        for <multiple recipients>; Tue, 23 Oct 2012 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=PyGf1OLeR9PJ7yVMvcS1ZSHvkXR2//QrG6W2RGssSqk=;
        b=ny3bUihEQAQKUsYCYacM5u9lO6VC2luYFRdQe9iSrbNF0AeIITtsiubEXpX//wV1jD
         MF96H4Fj1gxZWOo3E0zaeVUCXvJHKwOjFUsVrkFmmQsXSpav54zFJWUhPi7NJjTtUOv/
         WOAolR4at+ZsR3gEpNPN9mEli1lf3Keg3fQ5okQl1zRbOfmnTwJee0AUAAga+CxVp1dI
         KwxrP8BflyD78+TENbtlWevzX71zzj59tMmlifXMfNJMwdY1cMEnMkb5KgE8FNUUU7A1
         HnqW8ZT84KaQVQ+P6HiavvV1RiLm5Z+hoIoFz8/nEmXLHCemnB175TF/kKS8b/Lmb/mk
         Nsrw==
Received: by 10.49.133.97 with SMTP id pb1mr7678752qeb.31.1351026606225; Tue,
 23 Oct 2012 14:10:06 -0700 (PDT)
Received: by 10.49.28.72 with HTTP; Tue, 23 Oct 2012 14:09:46 -0700 (PDT)
In-Reply-To: <20121023205119.GA27729@sigill.intra.peff.net>
X-Google-Sender-Auth: Dot6xnI8alIPh-6gbJ0kxY2EZl4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208251>

On 23 October 2012 21:51, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 23, 2012 at 10:47:28PM +0200, Thomas Gleixner wrote:
>
>> I agree that this is a common issue. Acked-by/Reviewed-by mails come
>> in after the fact that the patch has been committed to an immutable
>> (i.e no-rebase mode) branch or if the change in question already hit
>> Linus tree.
>>
>> Still it would be nice to have a recording of that in the git tree
>> itself.
>>
>> Something like: "git --attach SHA1 <comment>" would be appreciated!
>
> It is spelled:
>
>   git notes add -m <comment> SHA1
>
> The resulting notes are stored in a separate revision-controlled branch
> and can be pushed and pulled like regular refs. Note, though, that the
> default refspecs do not yet include refs/notes, so you'd have to add
> them manually. The workflows around notes are not very mature yet, so if
> you start using them, feedback would be appreciated.

What would be nice is that notes are pushed/pulled automatically with
standard git push/fetch/pull commands. Usually git walks the DAG
starting with the pulled commit or tag and following the parents. With
notes, the reference is reversed, the note pointing to the commit and
not the other way around. So handling this automatically in Git would
be really useful.

The other feature I'd like is that notes are automatically folded in
the log during git rebase (maybe similar to the squash option). If you
rebase, you lose all the notes (though this depends on the workflow,
it may not be needed with published branches).

-- 
Catalin

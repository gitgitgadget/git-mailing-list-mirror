From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Wed, 4 Jul 2007 14:44:16 +0200
Message-ID: <e5bfff550707040544l6272bdeao3a891c1793d29eae@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
	 <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	 <20070701122625.GC26243@efreet.light.src>
	 <e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
	 <20070702180309.GA4400@efreet.light.src>
	 <7vy7hwlpo4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 14:44:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64DV-00038x-Ak
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 14:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbXGDMoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 08:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbXGDMoS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 08:44:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:13433 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887AbXGDMoR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 08:44:17 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1553013nze
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 05:44:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cokVxNoFsorPY+4QknxIgPkY6bv7dESATfd8gV2ABi/CMXfpdmGU0YSdyJpBCy6XH4Qk1sgqTif2y14tPTajvBAjlZoK2KjFI0CCns6hjbT6WoDEUpqx850aQs9SDm+04vE4zfPc2QRdksL99qOCV2q0vdoEIhyUdoWwosfVxt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9oMBMd/KYz3d2os8fyU/tyCTZ4vUPGuUAGJTbXS/AW8CKl877Fw/DnjK3DCwovlfBP854q2R0b2sOtAyVi2rEK5JDJpvy2ERIwFM1wN8mXgFI0bFHs+fQgg3OKtvhcBEsWeTirVOUUNvOoBJBkOWWbtG6EtSJ0oFqfYIeRQsgA=
Received: by 10.115.74.1 with SMTP id b1mr7165885wal.1183553056131;
        Wed, 04 Jul 2007 05:44:16 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Wed, 4 Jul 2007 05:44:16 -0700 (PDT)
In-Reply-To: <7vy7hwlpo4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51602>

On 7/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>
> >> P.S: Why 'git-commit --amend -F' it's explicitely forbidden?
>
> The reasoning goes like this (here, I am not particularly trying
> to justify it, but am merely explaining the original reasoning
> and intended use case as a historical background):
>

Thanks for your explanation, of course ;-) I think you will agree that...

>
> There is no room for -F, -c, nor -m to make sense for these use
> cases, and giving them to "commit --amend" is most likely a user
> error, and diagnozed as such, because "commit --amend" is an
> end-user level Porcelain program.
>

Why an 'end-user' should _erroneusly_ write '-F' option to 'git commit
--amend' ?

An error IMHO could occur if user *forgets* to write something, not if
he intentionally writes a very specific '-F' option, in that case I
would say user knows what it writes.

And speaking about errors one can always write 'git reset HEAD^' with
worst results.

Probably you agree it's very _artificial_ try to guess what is in the
head of the user and what is not, especially if this guess is made by
a tool.

So I would dare to say this could be a good occasion to remove that
illusory and obscure check.

> But if a Porcelain like StGIT or Qgit would want to do that kind
> of operation for different use case than "amending", it can and
> should use plumbing commands, just like the implementation of
> "commit --amend" does, with different constraints and error
> checks.
>

I always prefer qgit to use the highest level commands as possible because:

1- Less error prone
2- Easier to implement
3- More robust to API change
4- Less easy to break by changes in git.


Having said that, from '-F' option documentation:

-F <file>::
	Take the commit message from the given file.  Use '-' to
	read the message from the standard input.


Jan, what about to use '-' and feed message from stdin?

Indeed the full signature of run() is:

bool Git::run(SCRef runCmd, QString* runOutput, QObject* receiver, SCRef buf)

Where the last parameter 'buf' it's a string that, if not empty, is
passed to the launched program stdin.

I don't know if it is already too late, but I would suggest to stick
to git-commit if possible, I see only downsides in not doing so. But
of course who writes the code decides.

Marco

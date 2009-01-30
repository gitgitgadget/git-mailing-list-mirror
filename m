From: Elijah Newren <newren@gmail.com>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 15:55:28 -0700
Message-ID: <51419b2c0901301455h32775947rfc4483fd5a5b6c2a@mail.gmail.com>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
	 <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com>
	 <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com>
	 <20090130194727.GA31927@coredump.intra.peff.net>
	 <51419b2c0901301221n45cde1abw7a57a13bfa74b34@mail.gmail.com>
	 <20090130202917.GA3370@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 23:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2IR-0002Iw-Rd
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 23:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbZA3Wze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 17:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756238AbZA3Wzc
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 17:55:32 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:8421 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbZA3Wz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 17:55:29 -0500
Received: by el-out-1112.google.com with SMTP id b25so309247elf.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PMUa0tz45fpSRIj1JIMMg4laZfN78AKJa2bahW112z8=;
        b=sOl5sDzaRnXXvn21J3G3POcWs+hXJWGxJYUYp2zzM49eIF1tlE1/+xkQHycN8YtEuu
         3zxDTjrsAVpm38iGqR8xEv+PFTS5dzCTVaiAHmLbFOzISZfgvSCCaBlVf7xQKb0vA9mE
         kcQ4QeROs5yJL3mBxsO5zMDHr839NIxLP5IZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DbttlBslzwxZnrT/q2e1IwbTN0+N+FHyfkc/kXswwHPo0YP5WA/q5WCh3BFyTUsSKO
         C8ZctJ6anR101KxvwIcV7gEmaE9lMtjASwsW6nPF+CUNduJwn1mO4DdxGozaLuyMsZvx
         8AgQnkG/Sh4q33JbMX7xTY3nDMhI/ZSb716as=
Received: by 10.150.139.8 with SMTP id m8mr1615689ybd.219.1233356128084; Fri, 
	30 Jan 2009 14:55:28 -0800 (PST)
In-Reply-To: <20090130202917.GA3370@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107882>

On Fri, Jan 30, 2009 at 1:29 PM, Jeff King <peff@peff.net> wrote:
> If you pass --color on the command line, it is equivalent to "color =
> always" (whereas the default is "auto", which turns it on only if output
> is to a tty).
>
> So you would have to read color.diff yourself and then decide whether to
> add --color.

It looks like I can also set the environment variable GIT_PAGER_IN_USE
to achieve the same effects (and I don't even need to do so for most
commands, such as diff, just those whose output I'm parsing and
possibly tweaking).

> Note that in general you are playing things a bit risky with these sorts
> of outputs. You are calling porcelain (like log and status) and piping
> it into your program. There's no guarantee that user config might not be
> affecting the results of those programs.
>
> But I think that is sort of the nature of "eg": to be a thin wrapper
> around git. So maybe it is OK for your use.

Right, I considered switching eg to use git plumbing commands to
insulate from issues like this, but the problem is that if git output
changes then the eg output really should change too (or else I should
have a very specific reason for not changing it).  This almost
certainly means that I'll have to bump the minimum git version to be
used with eg at some point, but that seemed the most reasonable path
for eg.

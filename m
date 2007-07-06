From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Fri, 6 Jul 2007 09:54:54 +0200
Message-ID: <e5bfff550707060054qdbe7e50ic217b8ed6927408e@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
	 <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	 <20070701122625.GC26243@efreet.light.src>
	 <e5bfff550707010909p4eba184ekff2025fb158a4aee@mail.gmail.com>
	 <20070702180309.GA4400@efreet.light.src>
	 <7vy7hwlpo4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550707040544l6272bdeao3a891c1793d29eae@mail.gmail.com>
	 <20070704182806.GA3268@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jul 06 09:55:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ieh-0005TX-T5
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 09:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069AbXGFHy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 03:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755783AbXGFHyz
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 03:54:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:41883 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbXGFHyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 03:54:54 -0400
Received: by wa-out-1112.google.com with SMTP id v27so172425wah
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 00:54:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MzOvo71GPoKNRp7dwNS33xztTKc/T+r7C4zTzd9Ij28IWqydMndwN5ysZRDr2ehBMLqbYxk8VCAPsEpn1zN2K7lUla9jz+6VTXcxlVwhpKQLs5RGeWuLWVEBfqx2+ARjdKBBJaFv03+qfXFqgk0UmhqYkC5V+ha5OueOgwjz3hU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSu7LLwUy2uP+2AW2EdBhfk7E7DwxMlLm01DaVOGiugy+xMUfSHIIbtBrQhzhgy3L1T4vDNqB6djge4j8Qv/iG908DsUttPfVq2TWMNQ2bpjLWW6V8V9d3K05Pws48hDrKkJWO9P/0mOgJrbLnB9Rlk5FUqk5cL7QJiMrYCfaAM=
Received: by 10.115.76.1 with SMTP id d1mr402571wal.1183708494509;
        Fri, 06 Jul 2007 00:54:54 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 6 Jul 2007 00:54:54 -0700 (PDT)
In-Reply-To: <20070704182806.GA3268@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51728>

On 7/4/07, Jan Hudec <bulb@ucw.cz> wrote:
>
> > 3- More robust to API change
> > 4- Less easy to break by changes in git.
>
> Actually, no. The porcelains are more likely to change than the plumbing.
>

Well, changing internal API does not break compatibility, _modifying_
user commands behaviour yes and you need to release a new version for
this.

If for "change" you mean adding stuff then, yes, I agree with you, but
adding stuff is not a problem.

> > Having said that, from '-F' option documentation:
> >
> > -F <file>::
> >       Take the commit message from the given file.  Use '-' to
> >       read the message from the standard input.
> >
> > Jan, what about to use '-' and feed message from stdin?
>
> I actually am, because I am rewriting it to use plumbing, which means
> git-write-tree and git-commit-tree directly. And git-commit-tree always reads
> commit message from stdin.
>
> > Indeed the full signature of run() is:
> >
> > bool Git::run(SCRef runCmd, QString* runOutput, QObject* receiver, SCRef
> > buf)
> >
> > Where the last parameter 'buf' it's a string that, if not empty, is
> > passed to the launched program stdin.
>
> ... except if I read the code correctly, it will create a temporary file
> anyway. The comment in QGit::startProcess says it is because of windows, but
> there is nothing to disable it in Unix, so to me it seems temporary file is
> used anyway.
>

Yes you are right, but the file is redirected to process stdin by the call

proc->setStandardInputFile()

just below the comment you reported. I can assure you it works because
to read file names it is used "git diff-tree -r -C --stdin" without
problems.


Sorry for mt late reply, but I'm abroad this week and can access the
email only seldom.


Marco

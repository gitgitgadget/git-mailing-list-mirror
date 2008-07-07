From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Mon, 7 Jul 2008 08:01:31 +0400
Message-ID: <20080707040131.GC1721@dpotapov.dyndns.org>
References: <20080620082034.GA24913@elte.hu> <m3d4mcmq20.fsf@localhost.localdomain> <37fcd2780807060916h7d8c4e6mba7f30570d527dc3@mail.gmail.com> <7vprpqdbjx.fsf@gitster.siamese.dyndns.org> <20080706203951.GB1721@dpotapov.dyndns.org> <7vbq1ad4nn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 06:02:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFhvw-00070n-2X
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 06:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbYGGEBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 00:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbYGGEBi
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 00:01:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:11898 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYGGEBh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 00:01:37 -0400
Received: by nf-out-0910.google.com with SMTP id d3so598817nfc.21
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=32ULG1GR3Rit0pnvMV0otABeP+BqZ94Qg5+503tlRNA=;
        b=vcMpC6tw7Tb4ZtTJ2LCX5iGxeRlurdwuYEIIE/KS+d6Dzsg7bdCsJcMTK9P9KplqVD
         nSIMNDYVbTV//JwDR+5GeRFYXzj7TdsrJ/a4pbC0wXYdPIofnTDkFwEELRoFz7v4Q4dQ
         0aZ9rayoPeXfDVifDuizpYsNqKcrR5ngI6M4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bWOMb8JYkH5pRr38Wyi1U069P6k1Xcew9SU+oulTxIaAUk4f5aVEtgbyc6SgC1Mg+N
         W/8AylTrExwoN+H7KJxeBMjxkBPwXvez1JzoLIaVhRBdBJv5+jxEKdpfpCX04QJXwmfN
         ZLEZ1nLWQugVDRfS17i3m9qxP/ZclWQBxWLe4=
Received: by 10.210.102.12 with SMTP id z12mr2723137ebb.52.1215403296195;
        Sun, 06 Jul 2008 21:01:36 -0700 (PDT)
Received: from localhost ( [85.141.151.81])
        by mx.google.com with ESMTPS id z37sm5869603ikz.6.2008.07.06.21.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 21:01:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbq1ad4nn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87574>

On Sun, Jul 06, 2008 at 03:33:16PM -0700, Junio C Hamano wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > git rev-list 7ac749c^@..7ac749c
> > fatal: ambiguous argument '7ac749c^@..7ac749c': unknown revision or path
> > not in the working tree.
> >
> > yet "^rev^@ rev" syntax does:
> >
> > git rev-list ^7ac749c^@ 7ac749c
> > 7ac749c96d143ba4f76723959892cbaddbe8ed07
> >
> > Is it a bug or feature?
> >
> > Puzzled...
> 
> After reading these paragraphs from "SPECIFYING RANGES":
> 
>         History traversing commands such as 'git-log' operate on a set
>         of commits, not just a single commit.  To these commands,
>         specifying a single revision with the notation described in the
>         previous section means the set of commits reachable from that
>         commit, following the commit ancestry chain.
> 
>         To exclude commits reachable from a commit, a prefix `{caret}`
>         notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
>         from `r2` but exclude the ones reachable from `r1`.
> 
>         This set operation appears so often that there is a shorthand
>         for it.  "`r1..r2`" is equivalent to "`{caret}r1 r2`".  It is
>         the difference of two sets (subtract the set of commits
>         reachable from `r1` from the set of commits reachable from
>         `r2`).
> 
> it is obvious to me that the third paragraph talks about r1 that is a
> single rev (refer to SPECIFYING REVISIONS section, which does _NOT_ talk
> about rev^@ nor rev^!)  and r2 that similarly is another single rev.  So I
> think it is fairly clear that your "r^@..r" example is nonsense.

I think both second and third paragraphs talk about r1 as a single
revision. Yet, it is allowed to use "^r^@ r", and it works fine while
you cannot use "r^@..r". Of course, this behavior does not contradict
documentation, as it says _nothing_ about what will happen if you use
"r^@" instead of r1. That is why asked whether it is a bug or feature.
It still escapes me though, why you consider "r^@..r" as nonsense while
"^r^@ r" as correct syntax. Not that I am trying to argue with how it
should work, but I am just trying to understand your logic here.

Dmitry

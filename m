From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 21:24:51 +0100
Message-ID: <87abcnb14c.fsf@krank.kagedal.org>
References: <20081029003931.GA7291@sigill.intra.peff.net> <1225241048-99267-1-git-send-email-dsymonds@gmail.com> <C0BD1E4B-130F-4A16-8865-8EEABE1431FD@wincent.com> <alpine.DEB.1.00.0810291604200.22125@pacific.mpi-cbg.de.mpi-cbg.de> <08FC4756-8890-449D-BB55-90E4761C9B93@wincent.com> <alpine.DEB.1.00.0810291801580.22125@pacific.mpi-cbg.de.mpi-cbg.de> <E4E10B61-FA92-417C-9046-F9DE3B48C2A6@wincent.com> <878ws7w8xc.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Wincent Colaiuta <win@wincent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, gitster@pobox.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:26:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHcd-0005nu-0c
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbYJ2UZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbYJ2UZE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:04 -0400
Received: from main.gmane.org ([80.91.229.2]:39278 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753718AbYJ2UZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KvHb9-0001Xy-HX
	for git@vger.kernel.org; Wed, 29 Oct 2008 20:24:59 +0000
Received: from 87.96.142.66 ([87.96.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 20:24:59 +0000
Received: from davidk by 87.96.142.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 20:24:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.66
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:M0G3V7PdOt8sUMvLRIMaxvwfRgg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99401>

Teemu Likonen <tlikonen@iki.fi> writes:

> Wincent Colaiuta (2008-10-29 18:42 +0100) wrote:
>
>> El 29/10/2008, a las 18:03, Johannes Schindelin escribi=C3=B3:
>>> I completely disagree. If the existing set of commands causes
>>> confusion, we need to deprecate those parts and add new commands.
>>> Even if we have a ton of commands already.
>>
>> The confusion isn't at the command level; it's at the switch/option
>> level. The solution isn't to add a new command.
>
> I don't remember being confused in particular area but I think it's a
> _very_ good thing that the following three are behind the same "diff"
> command:
>
>     git diff
>     git diff --cached       (or --staged)
>     git diff HEAD

One irregularity hear is that there is no way to explicitly say what
you want to compare against the index (the staging area).  Diff
compares two things to each other, and a more regular and general way
to express what it does would be something like

    git diff STAGE WORKTREE   (like "git diff" today)
    git diff HEAD WORKTREE    (like "git diff HEAD" today)
    git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
    git diff HEAD STAGE       (like "git diff --cached" today)
    git diff commit STAGE     (like "git diff --cached commit" today)

To me, it isn't obvious that --cached changes the thing you *compare*
rather than the thing you compare *against*.  I think it would be
useful to have a way of explicitly stating what you compare, something
like what I wrote above, and then having useful shortcuts for common
cases (like that no arguments compares the work tree against the
stage).

--=20
David K=C3=A5gedal

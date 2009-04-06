From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 06 Apr 2009 15:20:19 +0200
Message-ID: <871vs5kjfw.fsf@krank.kagedal.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	<200904052358.53028.markus.heidelberg@web.de>
	<94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
	<200904060117.24810.markus.heidelberg@web.de>
	<fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
	<20090406032457.GA14758@gmail.com>
	<7v63hie4yh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:22:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqomE-0004Zv-AU
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbZDFNUf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 09:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbZDFNUe
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:20:34 -0400
Received: from main.gmane.org ([80.91.229.2]:44110 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753894AbZDFNUe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:20:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LqokY-0005tP-4h
	for git@vger.kernel.org; Mon, 06 Apr 2009 13:20:30 +0000
Received: from 87.96.142.66 ([87.96.142.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 13:20:30 +0000
Received: from davidk by 87.96.142.66 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 13:20:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.96.142.66
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:NpLvmgm8DhTiEchk3eYgGqHgYrI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115822>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> Hello
>>
>> Here's an interesting email from a while back:

Thanks, I would have brought it back up myself if you hadn't.

>> http://kerneltrap.org/mailarchive/git/2008/10/29/3857134
>>
>> The above mentions the following suggestion:
>>
>>     git diff STAGE WORKTREE   (like "git diff" today)
>>     git diff HEAD WORKTREE    (like "git diff HEAD" today)
>>     git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
>>     git diff HEAD STAGE       (like "git diff --cached" today)
>>     git diff commit STAGE     (like "git diff --cached commit" today=
)
>>
>>
>> From a consistency and usability perspective, the above
>> example seems very appealing because:
>>
>> a) it does not introduce any new commands, and
>>
>> b) it is consistent with the way git-diff's command-line
>>    interface works today.
>>
>> All we'd have to do is teach git-diff to special-case
>> 'STAGE' and 'WORKTREE'.  Now, whether we'd want to do
>> that is a completely different discussion, but I figured I'd
>> throw the old thread out there.
>
> How would you express operations the current --index option does in s=
uch a
> scheme?  Yet another WORKTREEANDTHEINDEX token?

What do you mean? This was a suggestion for how git diff should
work. I fail to see how you would need a WORKTREEANDTHEINDEX there.

I think this is a basic usability issue for a high-level porcelain
command such as diff. Having the command syntax "git diff <something>
<somethingelse>" makes sure you never wonder what you are
diffing. "git diff --cached" makes me wonder what the index is diffed
against every time I see it.

We wouldn't have to use the "STAGE" or "WORKTREE" names, of course. It
doesn't have to look like refspecs even. The last example already has
a syntax that matches the suggestion:

     git diff --cached <commit>

So, extrapolating this to "git diff --worktree --cached" would mean
what "git diff -R" means today etc.

The obvious objection is that "git diff --cached <foo>" would mean the
inverse of "git diff <foo> --cached", but maybe that isn't so
unexpected by the user after all?

--=20
David K=C3=A5gedal

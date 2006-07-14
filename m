From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Sat, 15 Jul 2006 00:01:23 +0100
Message-ID: <44B82243.20604@atoker.com>
References: <11528726881431-git-send-email-alp@atoker.com>	<20060714215039.GA21994@diku.dk> <7vfyh3on6w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 15 01:01:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Wf3-0003Pt-PP
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 01:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWGNXB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Jul 2006 19:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWGNXB0
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 19:01:26 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:39686 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1030459AbWGNXB0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 19:01:26 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id 81B753A6AD;
	Sat, 15 Jul 2006 00:01:24 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyh3on6w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23914>

Junio C Hamano wrote:
> Jonas Fonseca <fonseca@diku.dk> writes:
>=20
>> This changes "[user@]" to use {startsb} and {endsb} to insert [ and =
],
>> similar to how {caret} is used in git-rev-parse.txt.
>>
>> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
>=20
> Looks nicer.  Alp?  Does this work with your version of
> asciidoc?

I'm using asciidoc 7.0.2, which came with Ubuntu Dapper.

The man page output now looks like this:

        =B7  ssh://[ # [user@] # ]host.xz/path/to/repo.git/
        =B7  ssh://[ # [user@] # ]host.xz/~user/path/to/repo.git/
        =B7  ssh://[ # [user@] # ]host.xz/~/path/to/repo.git

Still not correct.

Out of the three patches,

   (at) "ssh://[user@]host.xz/path/to/repo.git/"
   (jc) "ssh://+++[user@+++]host.xz/path/to/repo.git/"
   (jf) "ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/"

I'd say (at) is still most readable, not requiring +++ markup (jc) or=20
hacks to asciidoc.conf (jf). And it's the only fix that's compatible=20
with older versions.

That's unless I've missed out on some detail that makes (at) unworkable=
=2E=20
  If it's the dozen or so modified lines that are a problem, we can wor=
k=20
on a wdiff merge strategy or something in the time we save looking for=20
the asciidoc escape sequence that works for everyone. Junio?

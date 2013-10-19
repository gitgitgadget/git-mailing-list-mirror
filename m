From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v8] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible
Date: Sat, 19 Oct 2013 08:24:57 +0200
Message-ID: <87mwm5vkue.fsf@linux-k42r.v.cablecom.net>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
	<89A4E8C6-C233-49E2-8141-837ABDBBC976@gmail.com>
	<FB9897CC-EDC7-4EBB-8DAB-140CEB5F93B3@gmail.com>
	<C876399C-9A78-4917-B0CF-D6519C7162F6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 08:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXPyP-0003kx-CC
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 08:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423Ab3JSGZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 02:25:11 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:35759 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab3JSGZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 02:25:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id C57724D659D;
	Sat, 19 Oct 2013 08:25:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0XQk1ftHAiP0; Sat, 19 Oct 2013 08:24:57 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EDA6A4D658A;
	Sat, 19 Oct 2013 08:24:56 +0200 (CEST)
In-Reply-To: <C876399C-9A78-4917-B0CF-D6519C7162F6@gmail.com> (Yoshioka
	Tsuneo's message of "Fri, 18 Oct 2013 12:35:02 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236387>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> "git diff -M --stat" can detect rename and show renamed file name like
> "foofoofoo => barbarbar".
>
> Before this commit, this output is shortened always by omitting left most
> part like "...foo => barbarbar". So, if the destination filename is too long,
> source filename putting left or arrow can be totally omitted like
> "...barbarbar", without including any of "foofoofoo =>".
> In such a case where arrow symbol is omitted, there is no way to know
> whether the file is renamed or existed in the original.
>
> Make sure there is always an arrow, like "...foo => ...bar".
>
> The output can contain curly braces('{','}') for grouping.
> So, in general, the output format is "<pfx>{<mid_a> => <mid_b>}<sfx>"
>
> To keep arrow("=>"), try to omit <pfx> as long as possible at first
> because later part or changing part will be the more important part.
> If it is not enough, shorten <mid_a>, <mid_b> trying to have the same
> maximum length.
> If it is not enough yet, omit <sfx>.
>
> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
> Test-added-by: Thomas Rast <trast@inf.ethz.ch>
> ---

Can you briefly describe what you changed in v7 and v8, both compared to
earlier versions and between v7 and v8?

It would be very nice if you could always include such a "patch
changelog" after the "---" above.  git-am will ignore the text between
"---" and the diff, so you can write comments for the reviewers there
without creating noise in the commit message.

Also, please keep reviewers in the Cc list for future discussion/patches
so that they will see them.

-- 
Thomas Rast
tr@thomasrast.ch

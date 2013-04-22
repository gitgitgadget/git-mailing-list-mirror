From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 14:17:14 +0200
Message-ID: <87r4i2pxo5.fsf@linux-k42r.v.cablecom.net>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
	<vpqa9oqpxx7.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:17:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUFgP-0003Zh-Rs
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab3DVMRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:17:17 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:20787 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab3DVMRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:17:16 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Apr
 2013 14:17:13 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Apr 2013 14:17:13 +0200
In-Reply-To: <vpqa9oqpxx7.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 22 Apr 2013 14:11:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222008>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>  was checking it out: a 'git log <pathspec>', when referring to a file
>>  inside the subtree, doesn't work as expected: it only displays the
>>  HEAD commit.
>
> This is somehow expected: the subtree merge changed the filename during
> merge (it is subtree/file.txt after the merge, and just file.txt
> before), so "git log" without --follow just considers the file appeared.
>
> OTOH, I think this is a known limitation of "git log --follow" that it
> does not follow renames done by subtree merges.

Umm, it should follow the rename.  The big limitation is that it is
unable to follow more than one name at a time, so if the file exists on
both sides of the subtree merge, it will follow the original name.  And
that's the common case; only the very first merge of the subtree has the
files only on one side.

You can see this by comparing

  git log --oneline --follow gitk-git/gitk

with

  git log --oneline -- gitk gitk-git/gitk

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

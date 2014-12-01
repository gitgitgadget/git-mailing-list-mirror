From: David Kastrup <dak@gnu.org>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 19:30:29 +0100
Message-ID: <87zjb7jk8q.fsf@fencepost.gnu.org>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
	<874mtfl1hx.fsf@fencepost.gnu.org>
	<xmqqwq6bp8ey.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 19:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvVk5-0003y4-Hp
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 19:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbaLASad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 13:30:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:39972 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbaLASad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 13:30:33 -0500
Received: from localhost ([127.0.0.1]:39012 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XvVjy-00049x-Af; Mon, 01 Dec 2014 13:30:30 -0500
Received: by lola (Postfix, from userid 1000)
	id DE025E0A95; Mon,  1 Dec 2014 19:30:29 +0100 (CET)
In-Reply-To: <xmqqwq6bp8ey.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 09:49:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260503>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> I disagree that --exit-code does nothing: it indicates whether the
>> listed log is empty.  So for example
>>
>> git log -1 --exit-code a..b > /dev/null
>>
>> can be used to figure out whether "a" is a proper ancestor of "b" or
>> not.
>
> Hmph.
>
>     $ git log --exit-code master..maint >/dev/null; echo $?
>     0
>     $ git log --exit-code maint..master >/dev/null; echo $?
>     1
>
> That is a strange way to use --exit-code.  I suspect that if you did
> this, you will get 0 from the log between HEAD~..HEAD
>
>     $ git checkout master^0
>     $ git commit --allow-empty -m empty
>     $ git log --exit-code HEAD~..HEAD
>
> even though HEAD~ is a proper ancestor of HEAD, so it is not giving
> us anything useful.  Isn't it a mere artifact that "log" happens to
> share the underlying machinery with "diff" that --exit-code shows a
> non-zero exit when there is any single commit in the range that has
> any change?

Possibly: I haven't checked the underlying code for the details.  At any
rate, it is an option git log accepts for whatever reason.

-- 
David Kastrup

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git help error
Date: Tue, 04 Dec 2007 11:40:15 -0800
Message-ID: <7vr6i245b4.fsf@gitster.siamese.dyndns.org>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com>
	<7v1wa25oqc.fsf@gitster.siamese.dyndns.org>
	<874pey9uow.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar" <aneesh.kumar@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 20:40:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzddN-0000fX-Go
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 20:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXLDTkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 14:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbXLDTkY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 14:40:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38696 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXLDTkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 14:40:24 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C28082F2;
	Tue,  4 Dec 2007 14:40:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DA939BE9D;
	Tue,  4 Dec 2007 14:40:39 -0500 (EST)
In-Reply-To: <874pey9uow.fsf@osv.gnss.ru> (Sergei Organov's message of "Tue,
	04 Dec 2007 21:33:03 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67075>

Sergei Organov <osv@javad.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>>
>>> git help gives me the below error.
>>>
>>> [master@git]$ git help add
>>> No manual entry for git-add
>>> See 'man 7 undocumented' for help when manual pages are not available.
>>> [master@git]$
>>>
>>> I have the git binaries installed via --prefix
>>>
>>> ./configure --prefix=/home/kvaneesh/bin-local/git/
>>> and to see the man page i have to say
>>>
>>> man -M /home/kvaneesh/bin-local/git/share/man/
>> ...
>> When you run "man" from the command line, can you say
>>
>>      $ man git-add
>>
>> and make it work?  If it fails the same way, then what you are missing
>> is MANPATH environment variable, isn't it?
>
> I think what the OP asked for makes sense. git-help should better find
> corresponding version of manual pages automatically. This way, if one
> invokes different versions of git-help, he will get corresponding
> version of help text.

I do not necessarily agree.  Read what Aneesh wrote originally again,
and read what he _didn't_ write.

Not only he needs to run his "man" with -M (and my point was that it is
not the only way, by the way), he needs to futz with his $PATH to
include $HOME/bin-local/git for _his_ installation to work.

I think my suggestion to use $MANPATH is in line with what he is already
doing.  If you install things in non-standard places, you can use
environments to adjust to what you did, and that's the reason PATH and
MANPATH environments are supported by your tools.

Having said that, I do not mind accepting a patch that prepends the
nonlocal path to MANPATH in help.c::show_man_page().

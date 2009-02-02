From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] Add log.mailmap as configurational option for
 mailmap location
Date: Mon, 02 Feb 2009 00:40:05 -0800
Message-ID: <7vr62hjkpm.fsf@gitster.siamese.dyndns.org>
References: <cover.1233520945.git.marius@trolltech.com>
 <ce94ea88e3182e97997c23f71e184e0db64fa708.1233520945.git.marius@trolltech.com> <7vwsc9o82r.fsf@gitster.siamese.dyndns.org> <4986A539.3080606@trolltech.com> <7vr62hl1a3.fsf@gitster.siamese.dyndns.org> <4986AE47.3010305@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 09:42:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTuN7-0001V3-WF
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZBBIkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZBBIkM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:40:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbZBBIkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 03:40:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9100A955F7;
	Mon,  2 Feb 2009 03:40:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6B378955F6; Mon,
  2 Feb 2009 03:40:07 -0500 (EST)
In-Reply-To: <4986AE47.3010305@trolltech.com> (Marius Storm-Olsen's message
 of "Mon, 02 Feb 2009 09:26:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A16AF72-F105-11DD-B6EF-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108073>

Marius Storm-Olsen <marius@trolltech.com> writes:

> Junio C Hamano said the following on 02.02.2009 08:56:
>> Marius Storm-Olsen <marius@trolltech.com> writes:
>>> Junio C Hamano said the following on 02.02.2009 04:01:
>>>> Should it always be a wholesale override, or should it also
>>>> support augmenting the repository version with a private copy?
>>> Sure, I can rewrite it to be augmenting, rather than overriding. I
>>> assume that the normal .mailmap file should be parsed first,
>>> then the log.mailmap one?
>>
>> Augmenting one would behave that way.  I was more wondering if
>> people would want to be able to choose either, perhaps from the
>> command line option or something.
>
> Oh, I see. *ponder* maybe, though you could say that about any option
> in the .git/config file, right?

I was more thinking along the line of how .gitignore works, accumulating
exclude patterns we find from .gitignore files along the way while
descending into the directory hierarchy, and all the while honoring what
the user added in .git/info/excludes.

> I'm not sure of the use case of the command line option. In which case
> would you want to only use the mailmap for that one command? It
> doesn't normally affect your git commands, so it doesn't hurt to just
> set the log.mailmap option. The environment use case would be just
> like setting it in your ~/.gitconfig, other than you can have a
> different one for each console, I guess.

Yeah, that is exactly why I suggested you to say that is overengineered
and is not useful ;-)

> Now, if we extended the mailmap feature even further, to report the
> mappings from the rev-list code ((optional of course)), so that any
> log viewer would show the mapped information; _then_ I would consider
> the command-line and environment variables as mandatory. Since, then
> you might want the feature off by default, and only use the mappings
> when you need to figure out a breakage, thus need a quick way to
> enable it.

Now you mention it, it might be wonderful if "git log --author" honored
the mailmap file, but I do not think command line nor environment do not
have much to do with it.

In any case, it is an independent issue from how mailmap maching and
rewriting should work, which was the main point fo your series.

> So, unless anyone raises their hand that they need
> command-line/environment ways of setting the mailmap file used, I'll
> leave it as is for now. Ok?

My point was that you should drop the second always-NULL parameter if the
plan is not to have any command line filename.  And I agree with your
reasoning that a command line filename is not useful, so...

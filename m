From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Fri, 21 Sep 2007 23:54:26 -0700
Message-ID: <7vhclngpgd.fsf@gitster.siamese.dyndns.org>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sat Sep 22 08:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYysv-0007ZJ-MY
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 08:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684AbXIVGyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 02:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbXIVGyc
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 02:54:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbXIVGyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 02:54:32 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A09211396C3;
	Sat, 22 Sep 2007 02:54:50 -0400 (EDT)
In-Reply-To: <20070922035434.GA99140@void.codelabs.ru> (Eygene Ryabinkin's
	message of "Sat, 22 Sep 2007 07:54:34 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58917>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> By the way, my FreeBSD is 7-CURRENT, but I'll test on 6-STABLE
> and perhaps on 4-STABLE on Monday.
> ...
>> That is, what does the shell say if you do this?
>> 
>> 	case Ultra in
>>         Super)
>>         	false ;;
>> 	Hyper)
>>         	true ;;
>> 	esac &&
>>         echo case returned ok
>
> It says 'case returned ok', so I will try to understand why it
> works here and does not work in the 'while' construct.

I vaguely recall somebody else had exactly this issue and he
concluded that the shell was busted.  I do not recall the
details of the story but interestingly, if he did something that
accesses "$#" before the problematic "while case $# in ..." the
shell behaved for him in his experiments.

Just to make sure you do not misunderstand me, I am not trying
to be difficult.  I am trying to assess (1) if it is sensible to
support that broken shell, and (2) if so what the exact breakage
is, especially because as the above shows the breakage does not
look like what your "fix" literally suggests, and what is
involved in working it around.

Also by my comment about "/bin/sh and bash not being the only
shells available on FreeBSD", I did not mean that you should
change your /bin/sh.  You can build git with SHELL_PATH make
varilable pointing at a non-broken shell, which does not have to
be installed as /bin/sh.

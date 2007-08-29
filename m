From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn tags and branches
Date: Wed, 29 Aug 2007 01:59:44 -0700
Message-ID: <7v4piisolb.fsf@gitster.siamese.dyndns.org>
References: <faulrb$483$1@sea.gmane.org> <faurcl$p0o$1@sea.gmane.org>
	<46D38B3D.6070809@vilain.net> <85absc6we7.fsf@lola.goethe.zz>
	<cb7bb73a0708280209r36136128x7bce310bf4fd4f66@mail.gmail.com>
	<86sl64nhc1.fsf@lola.quinscape.zz>
	<cb7bb73a0708280237v6f248517h183174bc41296df3@mail.gmail.com>
	<46D4A664.4070007@vilain.net>
	<cb7bb73a0708281620v41383ed8w728af0112d2a6360@mail.gmail.com>
	<46D4ECE2.9020806@vilain.net>
	<cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Sam Vilain" <sam@vilain.net>, "David Kastrup" <dak@gnu.org>,
	git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 11:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJP1-0001dJ-Gj
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbXH2I7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbXH2I7w
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:59:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbXH2I7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:59:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2ED7912A5C5;
	Wed, 29 Aug 2007 05:00:08 -0400 (EDT)
In-Reply-To: <cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
	(Giuseppe Bilotta's message of "Wed, 29 Aug 2007 10:41:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56913>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> BTW can git have a tag and a branch with the same name? If
> not,...

This is "Yes but".

You can have a tag foo and branch foo.

- "git checkout foo" would switch you to foo branch

- Anything else that lets you use an abbreviated refname 'foo',
  e.g.

  . git branch newbranch foo
  . git log foo
  . git diff foo

  will scold you that 'foo' is ambiguous, while it does not
  outright fail, and takes the first match from the list defined
  in sha1_name.c (ref_fmt[]), so a tag wins over a branch.  You
  can clarify yourself to avoid ambiguity like so:

  . git branch newbranch heads/foo ;# I mean "branch from foo branch"
  . git log tags/foo ;# "show history starting at that tag"

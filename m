From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Mon, 02 Feb 2009 20:30:48 -0800
Message-ID: <7vvdrsdtvr.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
 <20090202124148.GB8325@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUCxd-0005Vc-O1
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZBCEa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZBCEa7
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:30:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbZBCEa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:30:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A40B49632C;
	Mon,  2 Feb 2009 23:30:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C159C96329; Mon,
  2 Feb 2009 23:30:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 73DC1514-F1AB-11DD-9698-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108142>

Jeff King <peff@peff.net> writes:

> In both cases, you have a sequence of commands that does one thing with
> one git version, and something else with another git version. The only
> difference is whether your sequence includes git init.

I vaguely remember arguing against different behaviour between a new
repository and an existing one in the past on a different topic myself.  I
am not married to the idea of effectively flipping the default to "refuse"
in a new repository early, and do not mind dropping the "git init" change
at all.  I do not like the inconsistency myself.

The only reason why I did that "git init" patch was because I just thought
that it might be a good way to help new people sooner, who will start
using git after 1.6.2 gets released but before 1.7.0 flips the default for
everybody, while explaining people older than 1.6.2 what is happening in
the warning/error message during the transition period.  I suspect it
could be argued that with an extra line that says "the default will change
to 'refuse' in 1.7.0 for all repositories, but we are making the change
early for newly created repositories to help new people", the main idea of
the patch may be salvageable, but I do not deeply care either way.

By the way, I just realized one thing.

When we flip the default to "refuse" in 1.7.0 for everybody, we will need
the explanation and instruction on how to get a non-default behaviour and
how to squelch the message when we "refuse by defaut", just like my first
patch did when we "warn by default".  It is entirely possible some people
simply skip 1.6.2 and directly jump to 1.7.0, and while we cannot help
them avoid the surprise caused by the change in behaviour, we cannot be
silent in such a situation.

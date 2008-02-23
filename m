From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 14:46:30 -0800
Message-ID: <7vve4fz3y1.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <200802232113.40100.johannes.sixt@telecom.at>
 <7v63wf2yzt.fsf@gitster.siamese.dyndns.org>
 <200802232209.41428.johannes.sixt@telecom.at>
 <20080223211536.GA13280@coredump.intra.peff.net>
 <7vmypr1gmh.fsf@gitster.siamese.dyndns.org>
 <20080223223933.GA13683@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:47:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT39T-0001bD-FK
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbYBWWqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbYBWWqw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:46:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbYBWWqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:46:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FA431A99;
	Sat, 23 Feb 2008 17:46:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ADFE41A98; Sat, 23 Feb 2008 17:46:39 -0500 (EST)
In-Reply-To: <20080223223933.GA13683@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 23 Feb 2008 17:39:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74872>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 23, 2008 at 01:56:38PM -0800, Junio C Hamano wrote:
>
>> > Well, the trap I wanted to avoid is that "/bin/sh" specifically is
>> > broken. But yes, I think losing the ability to run the tests from the
>> > commandline is bad.
>> 
>> We never had it.  "make t3404-rebase-interactive" is the way to
>> do so.
>
> Well, that is a surprise to me, since I have been using it for almost
> two years with no problems. And I know I am not alone because others
> have posted snippets on the list invoking a test via "sh -x", including
> both Dscho and you.
>
> Is there a good reason not to do so?

I think our messages are crossing, but (1) currently we do not
export much from t/Makefile and the only people who can get
affected are on platforms that do need custom configuration, and
the difference being subtle and rare makes it more surprising
and harder to diagnose when the difference does matter, (2) I'd
like to place some stuff in t/Makefile in such a way that no
tests that runs a server that listens to a network port is not
run by default, among other things, which means the difference
between "sh tXXXX-name.sh" and "make tXXXX-name" will get
bigger not smaller.

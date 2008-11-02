From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Sun, 02 Nov 2008 10:30:16 -0800
Message-ID: <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
 <20081029164253.GA3172@sigill.intra.peff.net>
 <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
 <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081029171122.GA12167@sigill.intra.peff.net>
 <20081102123519.GA21251@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 02 19:32:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwhk0-0003c5-NP
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 19:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbYKBSaq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 13:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbYKBSaq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 13:30:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbYKBSaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 13:30:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EEEF779B8;
	Sun,  2 Nov 2008 13:30:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B9CBE7799D; Sun,  2 Nov 2008 13:30:24 -0500 (EST)
In-Reply-To: <20081102123519.GA21251@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Sun, 2 Nov 2008 13:35:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C63CD7E-A90C-11DD-8EEE-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99859>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Looking at --cached/--index we have basically three things:
>
>   --cached to refer to the state of the index (diff, grep, [stash], .=
=2E.)
>   --cached to _work on_ the index only (rm, apply, ...)
>   --index to _work on_ both the index and the working tree (apply, ..=
=2E)

I think the earlier two are the same thing.  The only difference betwee=
n
them is that in the first one, the definition of your "work on" happens=
 to
be a read-only operation.  Am I mistaken?

> A quick look through Documentation/ revealed only one problematic cas=
e,
> which is ls-files that already has a --stage option. And that looks l=
ike
> a dealbreaker :-(

'ls-files' is primarily about the index contents and all else is a fluf=
f
;-)

You could say --show-stage-too if you wanted to, but the command is a
plumbing to begin with, so perhaps if we can identify the cases where
people need to use the command and enhance some Porcelain (likely
candidate is 'status' or perhaps 'status --short') to give the informat=
ion
people use ls-files for, we hopefully wouldn't have to change ls-files
itself at all.

The only case I use ls-files these days when I am _using_ git (as oppos=
ed
to developing/debugging git) is "git ls-files -u" to get the list of st=
ill
unmerged paths during a conflicted merge.

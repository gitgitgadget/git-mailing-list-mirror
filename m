From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 12:50:28 -0800
Message-ID: <7v1w732y97.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <20080221000044.GB6429@coredump.intra.peff.net>
 <200802232113.40100.johannes.sixt@telecom.at>
 <20080223204005.GA12502@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 21:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1L9-00010E-FG
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 21:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbYBWUur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 15:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbYBWUur
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 15:50:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbYBWUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 15:50:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2FD58151E;
	Sat, 23 Feb 2008 15:50:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 369C8151D; Sat, 23 Feb 2008 15:50:37 -0500 (EST)
In-Reply-To: <20080223204005.GA12502@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 23 Feb 2008 15:40:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74850>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 23, 2008 at 09:13:39PM +0100, Johannes Sixt wrote:
>
>> > -cat > fake-editor.sh <<\EOF
>> > -#!/bin/sh
>> > +echo "#!$SHELL" >fake-editor
>> 
>> Did you mean fake-editor.sh here?
>
> Gah, yes. Not sure how I was even able to run the test with that error.

Simple.  fake-editor.sh does not begin with #! anymore and exec
causes /bin/sh to run, and your system happens to have a sane
shell there.  If you used $SHELL not $SHELL_PATH and wrote to
fake-editor.sh, you would have noticed that using $SHELL there
was wrong as it would have said "#!bash" for you ;-)

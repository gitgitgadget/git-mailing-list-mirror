From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/.gitattributes: only ignore whitespace errors in test
 files
Date: Fri, 13 Jun 2008 03:00:35 -0700
Message-ID: <7vod65wt6k.fsf@gitster.siamese.dyndns.org>
References: <1213310159-28049-1-git-send-email-LeWiemann@gmail.com>
 <20080613060629.GC26768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 12:01:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K766L-00087m-Pl
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 12:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbYFMKAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 06:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbYFMKAu
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 06:00:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbYFMKAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 06:00:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F4E222CB;
	Fri, 13 Jun 2008 06:00:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B3AF922CA; Fri, 13 Jun 2008 06:00:44 -0400 (EDT)
In-Reply-To: <20080613060629.GC26768@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 13 Jun 2008 02:06:30 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 99045764-392F-11DD-8FE1-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84859>

Jeff King <peff@peff.net> writes:

> On Fri, Jun 13, 2008 at 12:35:59AM +0200, Lea Wiemann wrote:
>
>> Only ignore whitespace errors in t/tNNNN-*.sh and the t/tNNNN
>> subdirectories.  Other files (like test libraries) should still be
>> checked.
>
> Why?
>
> What is the difference between test-lib.sh and tNNNN-*.sh that makes one
> subject to whitespace checking and the other not?

Eventually we would want to make all of the t/*.sh not exempt from the
whitespace rules.  Some currently do have trailing whitespaces as part of
their embedded test vectors, but there are many that are more carefully
written to avoid trailing whitespaces, by marking the EOL explicitly with
a non whitespace characters in the source, and running sed to produce the
actual vector that is used in the test.  That style is vastly preferrable
than having actual lines that end with trailing whitespaces, because it
makes it much clearer what is being fed to the scripts and what are
expected output when reading the source.  You do not have to "cat -e" to
see what they exactly do.

So I think this is one step in the right direction.  I do not want to keep
tNNNN-*.sh exemption forever.

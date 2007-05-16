From: Junio C Hamano <junkio@cox.net>
Subject: Re: testing vger handling of charsets (part 2)
Date: Tue, 15 May 2007 23:34:02 -0700
Message-ID: <7vmz05ffad.fsf@assigned-by-dhcp.cox.net>
References: <20070515test.2@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kha@treskal.com, bfields@fieldses.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 16 08:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoD5O-0001EF-AQ
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbXEPGeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757714AbXEPGeG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:34:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33910 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274AbXEPGeF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2007 02:34:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516063403.IYWU14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 16 May 2007 02:34:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zia21W00T1kojtg0000000; Wed, 16 May 2007 02:34:03 -0400
In-Reply-To: <20070515test.2@coredump.intra.peff.net> (Jeff King's message of
	"Tue, 15 May 2007 03:13:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47417>

Jeff King <peff@peff.net> writes:

> This is a test message to check how vger reacts to seeing 8bit
> characters (like Hasselstr=C3=B6m) in a message _with_ the right mime
> header.
>
> If your mail server doesn't advertise the 8BITMIME extensions, I expe=
ct
> this message to come through OK, since vger will (hopefully) respect =
the
> existing content-type header. Karl and Bruce, can you please report?

I think you are trying to figure out how vger adds/munges the
headers, and the above is not very useful for people but
yourself unless you explicitly say what headers you gave on your
end in the body of the message, is it?

Judging from the list responses, I am guessing the situation is
like this.  Does that match your understanding?

botched one:

	outgoing:
        	body in utf-8
        	Content-type: text/plain; charset=3Dutf-8
                no MIME-Version: header

	vger relayed to recipients:
        	body untouched
                Content-type: text/plain; charset=3Diso-8859-1
                MIME-Version: 1.0

good one:

	outgoing:
        	body in utf-8
        	Content-type: text/plain; charset=3Dutf-8
                MIME-Version: 1.0

	vger relayed to recipients: everything intact.


I am not sure what exactly you meant by with/without "the right
mime header", but the above is based on my guess that you meant
only MIME-VERSION header.

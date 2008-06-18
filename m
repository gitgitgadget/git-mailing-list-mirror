From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
 further processing
Date: Tue, 17 Jun 2008 22:13:02 -0700
Message-ID: <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
 <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
 <20080618033010.GA19657@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	madcoder@debian.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 07:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8pzj-0000wb-Nl
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 07:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbYFRFNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 01:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYFRFNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 01:13:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbYFRFNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 01:13:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D9C412FE5;
	Wed, 18 Jun 2008 01:13:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DDDC812FE0; Wed, 18 Jun 2008 01:13:05 -0400 (EDT)
In-Reply-To: <20080618033010.GA19657@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 17 Jun 2008 23:30:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F958846-3CF5-11DD-A4B8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85362>

Jeff King <peff@peff.net> writes:

> I think the only right way to accomplish this is to convert the revision
> and diff parameters into a parseopt-understandable format.

Not necessarily.  You could structure individual option parsers like how
diff option parsers are done.  You iterate over argv[], feed diff option
parser the current index into argv[] and ask if it is an option diff
understands, have diff eat the option (and possibly its parameter) to
advance the index, or allow diff option to say "I do not understand this",
and then handle it yourself or hand it to other parsers.

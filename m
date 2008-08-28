From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Use %as and %cs as pretty format flags
Date: Thu, 28 Aug 2008 16:36:51 -0700
Message-ID: <7viqtkd84s.fsf@gitster.siamese.dyndns.org>
References: <d77df1110808280409o9445f9fybcab2c8d1066a8d8@mail.gmail.com>
 <20080828231547.GD29609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Panike <nathan.panike@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:38:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYr4D-0005R6-N0
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbYH1XhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbYH1XhA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:37:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42025 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbYH1Xg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:36:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BBA2E6C3F5;
	Thu, 28 Aug 2008 19:36:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BBDFA6C3F4; Thu, 28 Aug 2008 19:36:53 -0400 (EDT)
In-Reply-To: <20080828231547.GD29609@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 28 Aug 2008 19:15:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 346441CC-755A-11DD-9F27-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94213>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2008 at 06:09:37AM -0500, Nathan Panike wrote:
>
>> The patch series below allows git to use %as and %cs as flags for
>> pretty-printing the format of a date.
>
> Your description leaves a little to be desired (here and in the patches
> themselves). I had to read the patch to figure out that these are
> formatting specifiers for the date format "short".
>
> That being said, I think this is probably reasonable just for the sake
> of completeness (and I doubt we are wasting a useful formatting combo,
> since %a* is likely to remain dedicated to author information). I wonder
> if there should be "%al" for "local".
>
> However, it makes me wonder even more if '%ad' should simply respect the
> --date= parameter (this wouldn't allow you to mix and match dates in a
> single format, but I don't think that is what is desired). Or whether we
> should have some syntax for "%ad(short)" or something, where the
> argument would be handed off to the date format parser. But that is
> probably overengineering.

I was actually thinking about rejecting this, asking for something that
allows to express all the other %[ai][dDri] format can express, and
perhaps more.  So I think "%ad(short)" is a good direction to go, except
that 'd' is already taken.  Perhaps %a(date), %a(shortdate,local),...?

Oh, and before anybody asks, even if we do %a(specifier), you can keep
writing "%ad" if you are used to it.  I am not talking about deprecating
the existing ones, but making future extensions easier without forcing
people to remember cryptic one-letter format specifiers.

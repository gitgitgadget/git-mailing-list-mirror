From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 03:21:11 -0800
Message-ID: <7v1w9la7o8.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<20071213102636.GD12398@artemis.madism.org>
	<7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
	<20071217090749.GC7453@artemis.madism.org>
	<7vir2xa8z7.fsf@gitster.siamese.dyndns.org>
	<20071217105834.GG7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4E2h-0002dr-SD
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765981AbXLQLV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbXLQLV3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:21:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbXLQLV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:21:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D6EE3C85;
	Mon, 17 Dec 2007 06:21:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EF12E3C82;
	Mon, 17 Dec 2007 06:21:17 -0500 (EST)
In-Reply-To: <20071217105834.GG7453@artemis.madism.org> (Pierre Habouzit's
	message of "Mon, 17 Dec 2007 11:58:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68544>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Dec 17, 2007 at 10:53:00AM +0000, Junio C Hamano wrote:
> ...
>> This is just a quick idea before I go back to sleep, but your earlier
>> comment on "--no-<an-option-that-is-not-even-boolean>" made me realize
>> that the alternative I was suggesting earlier would actually work much
>> nicer, if you introduce "--<an-option-that-take-optional-arg>-default"
>> magic.
>
>   meeeow I love the idea !

There is a bit more serious issue than coding, actually.

Short options.

A script wants to use default rename detection threshold for unknown
commit $foo whose name might look like a number.  IOW, this

	git diff -M $foo

could be ambiguous.  Obviously, "git diff -M-default $foo" would not fly
very well.

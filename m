From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 15:11:03 -0700
Message-ID: <7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Sep 17 00:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2Kp-0005PX-GM
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbXIPWLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbXIPWLR
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:11:17 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbXIPWLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:11:16 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B41A21344A2;
	Sun, 16 Sep 2007 18:11:27 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
	(david@lang.hm's message of "Sun, 16 Sep 2007 14:45:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58357>

david@lang.hm writes:

>> I'd rather not implement it at such a low level where a true
>> "checkout" happens.  For one thing, I am afraid that the special
>> casing will affect the normal codepath too much and would make
>> it into a maintenance nightmare.
>
> as I understand it, at this point you already choose between three
> options.
>
> 1. write to a file (and set the write bit if needed)
> 2. write to stdout
> 3. write to a pager program
>
> I am suggesting adding
> ...
> or am I missing something major here?

I do not think we are choosing any option in the codepath at
all.

What I mean by the normal "checkout" is what checkout_entry in
entry.c does.  There is no other option than (1) above.  I would
want to see an extremely good justification if you need to touch
that codepath to implement this fringe use case.

I do not think there is nothing that writes file contents to
stdout/pager other than "git cat-file" or "git show"; I do not
think they are what you have in mind when talking about managing
the files under /etc.  So unfortunately I do not understand the
rest of the discussion you made in your message.

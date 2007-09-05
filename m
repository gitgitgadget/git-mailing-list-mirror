From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 04 Sep 2007 17:16:59 -0700
Message-ID: <7vd4wym0ec.fsf@gitster.siamese.dyndns.org>
References: <46DD6020.4050401@gmail.com>
	<7v642qnwr7.fsf@gitster.siamese.dyndns.org>
	<1b46aba20709041632x60ee4d3eweae9f5217d2f3b86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 02:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISiZz-00046r-K8
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 02:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbXIEARH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 20:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755497AbXIEARG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 20:17:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbXIEARG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 20:17:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 81B0012E9B2;
	Tue,  4 Sep 2007 20:17:23 -0400 (EDT)
In-Reply-To: <1b46aba20709041632x60ee4d3eweae9f5217d2f3b86@mail.gmail.com>
	(Carlos Rica's message of "Wed, 5 Sep 2007 01:32:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57662>

"Carlos Rica" <jasampler@gmail.com> writes:
>>  - Why doesn't "or_error" side allow "flags" as "or_die" one?
>>    Could the 'quiet' option become part of "flags" perhaps?
>
> I saw that the only code that needed the flags was the
> builtin-update-ref.c, and it also needed to die(). The
> others I saw only want that parameter set to 0.
> builtin-tag.c was doing die() also, not using flags, though.

Ok, when other built-ins start using these functions, they might
want to pass different flags, but it is easy enough for us to
extend the interface later.

>>  - They look quite similar.  Is it a good idea to refactor them
>>    further, or they are so small it does not matter?
>
> The function die() returns 128 and terminates the program,
> prepending "fatal: " in the message, while error() doesn't exit
> and prepend "error: ", so they were very different and I
> resolved to separate them.

Fair enough.

>>  - Why isn't lock released with unlock_ref()?
>
> I inspected this some weeks ago, and I finally came to think
> that it is released in the write_ref_sha1 call after the lock.

Ah, that's right!

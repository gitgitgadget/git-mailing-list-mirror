From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] sequencer: add "do_fast_forward()" to perform a
 fast forward
Date: Sat, 22 Aug 2009 13:15:34 -0700
Message-ID: <7viqgf38rd.fsf@alter.siamese.dyndns.org>
References: <20090822041157.4261.92491.chriscool@tuxfamily.org>
 <20090822041616.4261.40442.chriscool@tuxfamily.org>
 <7vab1s5mtc.fsf@alter.siamese.dyndns.org>
 <200908221319.37737.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 22:16:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mex0Q-0007S7-DC
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 22:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933321AbZHVUPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933304AbZHVUPw
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 16:15:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300AbZHVUPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 16:15:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C776833F44;
	Sat, 22 Aug 2009 16:15:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iyqhfyjH8ViGGTcVXxIfVyLG2IY=; b=jjqeIV
	ar5rnuEEkyeNJLgFglajmLUJyGa5pGEcLf/pfISxPDBfQvbhtFF39c4gD+X1Rntq
	lUDxG/rIe//J1GvUHUshbgEfg9Mpm4sixfIMA0djPWjRnjZ12Y1JmU5QxGH+ZPTt
	YkxeLgmNKaZwFBt1q8TCbl0TFvOkbt17DDBGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=txrXXub69k/c3ud0IW/kUffzcjzLRbFJ
	gHcICf2WI6sp8mRav58ioF/BdiAGvXir0hLarLWXJzgeHCC6P+7RwbCHgJsbWGwG
	pJAK8sQxA79OLjEdKWloMJBXC3RlrmFdjkWgjEscosD9jcex3/ZM2tKMDThpaoSf
	mU6eTR8rS20=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A79A33F43;
	Sat, 22 Aug 2009 16:15:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 375A733F42; Sat, 22 Aug 2009
 16:15:36 -0400 (EDT)
In-Reply-To: <200908221319.37737.chriscool@tuxfamily.org> (Christian Couder's
 message of "Sat\, 22 Aug 2009 13\:19\:37 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 930B1E62-8F58-11DE-AEEC-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126817>

Christian Couder <chriscool@tuxfamily.org> writes:

>> Hmm, forgot to amend, or perhaps you sent out a wrong series?
>
> Your comments on the v2 series were in a message replying to patch 5/9, so I 
> amended only 5/9 and after it, because I thought that you had already 
> reviewed those before 5/9 and they were ok.

Sorry, but in general I expect readers of this list to be intelligent
enough and capable of extrapolating, so that I do not have to spell out
the same issue over and over again ;-)

> As you merged the series in pu, I thought that it was ok.

Heh, being queued to 'pu' does not mean any more than just that we do not
want to lose what the author spent efforts to produce, and we want to give
reviewers easier access to the end result.  If it is Ok, it would have
been in 'next'.

That's why topics initially queued in 'pu' sometimes move to 'stalled'
state in "What's in" report and then eventually get ejected.

The comment you added only says what it does, namely, that it does two
different things, based on the allow_dirty global variable that is
underdocumented.  It does not explain _why_ it is a good thing, in what
circumstance the caller would want "almost" semantics and in what other
circumstance the caller would want a "real" hard reset.

>> I am afraid that the whole cc/sequencer-rebase-i series needs a serious
>> reroll before it gets near 'next'.
>
> Ok, I will reroll everything to try to improve commit messages.

It would be a good idea; it may expose a wrong abstraction or an
insufficient refactoring (e.g. adding yet another function to make a
commit object that runs parallel to what we already have).

Thanks.

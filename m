From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
  with various fanout schemes
Date: Thu, 27 Aug 2009 18:43:42 -0700
Message-ID: <7vocq0d86p.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <20090827212710.GV1033@spearce.org> <7vy6p5ncz0.fsf@alter.siamese.dyndns.org>
 <200908280103.06015.johan@herland.net>
 <20090827233900.GA7347@coredump.intra.peff.net>
 <7viqg8hj98.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 03:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgqVm-0002K2-Qn
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 03:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbZH1BoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 21:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbZH1BoI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 21:44:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZH1BoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 21:44:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D408139F50;
	Thu, 27 Aug 2009 21:44:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0z5/3CduUk/ISIvO7qEt2Guh+y8=; b=wYWuaA
	nhm44UD2lIzEKb0sNcqJIqwnq7pt9sBzzdg0wQMsa0Ilss/NF06LSNjtwKzvAzDk
	I7qSxLiAVYrnbT/dkd3Y+kBX0SXHnrHaFsSRzkZ40aWVSpDNfvpmVI2KFnfZYEcm
	ITuE8ZN4XUcbd9GYKewoxL54Q8oJGxsu3T2PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qk2gjbbwvkCm7dUM2SWLVPsbLUPZSVqT
	k0vm/zwWjko8WcYywX/V7/nnGw6t65zlw10mPYQPioOH67sHXQ1FjoFNFmLPsyDY
	ErxQTUL1ppl1ovUeRk/9sqh0KTFHD1ICGtGpQPdGInGmdRdL/jomm4qMVciST8G6
	Yie23/jPAQM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4332839F47;
	Thu, 27 Aug 2009 21:43:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8114D39F42; Thu, 27 Aug 2009
 21:43:44 -0400 (EDT)
In-Reply-To: <fabb9a1e0908271740i53ec7d69td696d955366ad23c@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 27 Aug 2009 17\:40\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41832998-9374-11DE-90A2-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127241>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Thu, Aug 27, 2009 at 17:30, Junio C Hamano<gitster@pobox.com> wrote:
>> So, how?
>
> A note in branch foo (which you do not follow) was referenced by a
> commit in branch bar (which you do follow)?

Sorry, I do not follow.  How does a note be _in_ branch foo, and how does
a commit _reference_ a note?

Did you mean "a commit in branch bar referred to a commit in branch foo",
similar to the way the "cherry-picked from X" comment can refer to a
missing commit?

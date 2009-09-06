From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 06 Sep 2009 14:11:55 -0700
Message-ID: <7vzl97ye04.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
 <7vab191dz1.fsf@alter.siamese.dyndns.org>
 <7vzl98vrmt.fsf@alter.siamese.dyndns.org>
 <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061053330.8946@localhost.localdomain>
 <7v3a6z3lsg.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061248470.8946@localhost.localdomain>
 <7vws4bzu7w.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 23:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkP20-0008Jr-Qc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 23:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758702AbZIFVMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 17:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758554AbZIFVME
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 17:12:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534AbZIFVMD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 17:12:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F5C5468FB;
	Sun,  6 Sep 2009 17:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3kvem+S1ZCVvY8gVTJf1V5Jtwv4=; b=gPYfvq
	UjDUvTGTED8X9LTCBQN1FW7O3h4iD+o3j4KqXkjECQ5ABNre9xogzfZF9xRY7Tdw
	ca89QKwtQeBU2ErKZkjBLn19p8NyeAUu2IRF95gQseqXIKRzZldgqUCukqZ5cD3T
	zZGxE4AciF6KmIiU8vMAizBVVmkbntDuJhy9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L4IZpNXJw6LSl/BcJFTIfNVjr6jkhoxp
	9GoFFDqVT0mtwY1pRCKoI5FteTqv++MpTKZYQf6TYMrovJDEq9Emmh7j3NvolBBz
	2MCKPrnd6FkMuoc115UOBlXmeV9CvKU7SqiQaMUN/bJqrB9NCYEufLifWLIHBUw0
	stnVwzHun9Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4836A468FA;
	Sun,  6 Sep 2009 17:12:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FA3C468F9; Sun,  6 Sep 2009
 17:11:56 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0909061338350.8946@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 6 Sep 2009 13\:42\:24 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC8A6916-9B29-11DE-BD26-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127870>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The index case is slightly easier, as we can go back-and-forth in the 
> source index (we do try to avoid it right now, but that's a small 
> optimization rather than anything fundamental),...

Almost true, but there is the final "Any left-over entries in the index?"
phase in unpack_trees() that relies on o->pos being correct.

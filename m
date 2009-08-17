From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 11:39:13 -0700
Message-ID: <7vws52uvxq.fsf@alter.siamese.dyndns.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <200908142223.07994.jnareb@gmail.com>
 <7veird4yyi.fsf@alter.siamese.dyndns.org>
 <200908160137.30384.jnareb@gmail.com>
 <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
 <7vtz06xxao.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md77C-0000mJ-Bf
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 20:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbZHQSjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 14:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757767AbZHQSjU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 14:39:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbZHQSjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 14:39:19 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1D55EC1D;
	Mon, 17 Aug 2009 14:39:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D356CEC1A; Mon, 17 Aug
 2009 14:39:14 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon\, 17 Aug 2009 18\:19\:54 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 470A6E72-8B5D-11DE-9965-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, my illustration of the scenario was only to one end, namely to 
> convince all of you that assume-changed != sparse.
>
> And maybe to the end to explain that sparse checkout could help this guy.

How?  If sparse is _not to check it out_, then that is not what the person
is doing either.  It feels to me that you are suggesting an inappropriate
hack to replace another inappropriate hack, suggesting to use a hacksaw
because an earlier attempt to use a hammer did not quite work to drive the
screw in.

I never said assume-unchanged _is_ sparse.  You cannot mark an index entry
that does not exist, obviously you need more (either the earlier "hook
that tells what should/shouldn't exist", or "the pattern").

But I think the work-tree semantics you need to _implement_ sparse matches
what you would want from assume-unchanged.  Not the original, draconian
one that updates the work tree by saying "you promised me you wouldn't
change them", but the updated one that tells git to pretend that the local
change is not there but still keep the local modification, including
deletion.  The work-tree "local changes" sparse makes is a small subset of
possible local changes assume-unchanged would need to support.  It only
deletes work tree files.

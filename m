From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Allowing push --dry-run through fetch url
Date: Fri, 06 Nov 2009 00:49:49 -0800
Message-ID: <7vtyx82g2a.fsf@alter.siamese.dyndns.org>
References: <20091106073707.GA14881@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 09:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6KWC-0007sM-On
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 09:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbZKFIty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 03:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZKFIty
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 03:49:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbZKFItx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 03:49:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 877FF947EF;
	Fri,  6 Nov 2009 03:49:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZPx8TT162KZTPr18uMhIarxrVY=; b=q0f3pp
	b5o41Cc8S1bCctq3EwTP61TUsRRLGcHShU8BQZ+Apy3r7xS8GOyK772BXD5+k2V+
	jLrJ8YGmEB/csia8PlsWRKKNl/VG1TBUhjnTFNlGu6IDuTV5AM75NDK1AFExgK2V
	hKKlYEzSukViq669i6TmYHqV1lzJPbz6eLwcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jeb3fBSgAfJkrsFHWgijTygpCHDlqbdz
	L74GoGzs582QQi4p2cgiDx+983BrVBBp9+LVNfRvYlMblWRHOOUt/mtwsriyaUTA
	/Oc1Ltlz1W0Zm84+nvFaGMv3+UJGMKB675Io+Ra5PbrzG5/4bJfoNhWp4rBpszKU
	ABJdBMm12aw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68812947EE;
	Fri,  6 Nov 2009 03:49:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71FE2947ED; Fri,  6 Nov 2009
 03:49:51 -0500 (EST)
In-Reply-To: <20091106073707.GA14881@glandium.org> (Mike Hommey's message of
 "Fri\, 6 Nov 2009 08\:37\:07 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A7CD57E-CAB1-11DE-B499-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132286>

Mike Hommey <mh@glandium.org> writes:

> So, before I dive in, what would you think about such a feature?

The daemon sitting on the other end to serve "git://" URL won't understand
an attempt to push into.  What goes over the wire in the fetch protocol
does not give your updated "git push" enough information to guess what
would happen if you pushed.

Of course, it is open source and everything can be modified.  You _could_
change the daemon whose primary purpose has been to serve fetch requests
to also support dry-run only push to make what you outlined work.

But isn't it adding unnecessary complexity for no real reason?  It would
be a tough sell, I would imagine.

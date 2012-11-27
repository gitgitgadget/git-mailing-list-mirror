From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 14:06:34 -0800
Message-ID: <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 23:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdTIs-0004eR-2L
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 23:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab2K0WGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 17:06:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab2K0WGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 17:06:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C1AA1C4;
	Tue, 27 Nov 2012 17:06:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RuSK2cYb5nR8hlKHRA6uXqWpwo8=; b=FwGRMO
	tFBmDdD60nwWUBr6jg7wacIq+gNbnvs/4BH0tBp3stmBd/MQHarR28i4GcmS6m2N
	ttYLNqIihxZgCJZanXsiob1OzUzhBhwhLd4sIRJpDLDBHgjC0NSqgTXw6csI6h+V
	yCZu9m11N+W7LA0YCP48IAbtciIZ73Q5IJBsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uMKoAV58+yfDwB4gnGkpcg49FWF4GXMn
	vrdLzHl4KKA//DGvdYyaK6jNUhpYYwMRn42zwr/0TQFsr/y5mTqNC+WUn1Dh9PRO
	kMs53VuypfnktevmbAp1JaLDUV4ueA+jYqZk8afGl9X+phd2xgrRtwv7qXCBTc3h
	+DKen08Fv/c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0186EA1C3;
	Tue, 27 Nov 2012 17:06:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75324A1C0; Tue, 27 Nov 2012
 17:06:36 -0500 (EST)
In-Reply-To: <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com> (Shawn
 Pearce's message of "Tue, 27 Nov 2012 13:41:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B62DC600-38DE-11E2-ABA2-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210610>

Shawn Pearce <spearce@spearce.org> writes:

> JGit would fortunately ignore a floating point timestamp specification
> if given in a commit, but I don't know about other Git
> implementations... like say git. :-)

fsck_ident() in fsck.c rejects anything but " [1-9][0-9]* " after
the author and committer ident (i.e. the timestamp has to be
integral number of seconds since the epoch, not before it, nor
with fractional seconds).

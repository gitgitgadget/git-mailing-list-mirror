From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] fetch doc: update introductory part for clarity
Date: Fri, 30 May 2014 14:27:00 -0700
Message-ID: <xmqq61kn7yaj.fsf@gitster.dls.corp.google.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com>
	<1401403350-7122-2-git-send-email-gitster@pobox.com>
	<5388972C.5020307@xiplink.com>
	<xmqqioon9msf.fsf@gitster.dls.corp.google.com>
	<5388D857.7010705@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:27:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqUKm-0006Lc-Pn
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934188AbaE3V1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 17:27:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58165 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbaE3V1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:27:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D8571AE87;
	Fri, 30 May 2014 17:27:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IEVjWPD0G2cthzZJvHlcHXBOluo=; b=u42aFP
	yd8Ruz4dNEBznh0U/I/Y2mXE/ZtGvJVPNM/Chy8WIsXymIXiBwH0neB9yITSjHbx
	4dVyegZtAUGQONyfJOgpxMX4OppqhObuiyyB5zEFMWo3Gv7FZ3F49ZfRMJVCTpSS
	7yeO8mUGO6AN2OVH3rLzcoKCWONTErTqUBIX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J6aLBweFED991cLjy4jxpH3Ogg88GHyK
	08w8QahHZ0/kJS0gTI2vdWPbbsSvv5XxtR4/xYFeEnNhPT0j8F4cxf0z68lTHV/2
	9RcQ/Pjwy3h8QM/9VCcop9d9pxFoMgbcV3FOar5cTAyBAIQcv3L90621yhUgz6Kg
	55njxruuNRU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43B411AE86;
	Fri, 30 May 2014 17:27:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC8691AE81;
	Fri, 30 May 2014 17:27:01 -0400 (EDT)
In-Reply-To: <5388D857.7010705@xiplink.com> (Marc Branchaud's message of "Fri,
	30 May 2014 15:13:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2390ECD2-E841-11E3-8CF3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250486>

Marc Branchaud <marcnarc@xiplink.com> writes:

> The docs say that all the fetched refs are written to FETCH_HEAD (perhaps a
> more accurate name would have been FETCH_HEADS?).  If that's truly the case,
> it seems weird to use FETCH_HEAD in log and merge commands.  (My FETCH_HEAD
> file currently has 1434 lines in it -- what does that mean, and what does it
> imply for those log and merge commands?)

The "fetch" that was run by "pull" would have arranged the single
remote ref that your "pull" merged to your then-current branch to
the very beginning of FETCH_HEAD, so "git log FETCH_HEAD" would show
the line of development from that ref, and "git merge FETCH_HEAD"
would also merge what your "pull" would have merged.

> Perhaps FETCH_HEAD shouldn't be mentioned at all in the introductory part of
> fetch's man page.

A possible downside is that unreasonable people can use the lack
of mention of FETCH_HEAD as an excuse to start making noises about
removing the feature.

Also, a natural way to peek into somebody else's history without
making a permanent damage to your own repository, is:

    $ git fetch $repository_of_marc master && git log FETCH_HEAD

As such a one-shot fetch from a random place does not use (and does
not want to use) any remote-tracking branch, knowing that FETCH_HEAD
is available for such a purpose would help people who want to script
such a thing.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] format-patch: show notes as message after the
 ---
Date: Tue, 26 Apr 2011 10:39:57 -0700
Message-ID: <7vsjt4ewsy.fsf@alter.siamese.dyndns.org>
References: <cb2af8d1ef663a68ea96dbb916dcfa0aee71abcb.1303808057.git.git@drmicha.warpmail.net> <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmFF-0006gr-6p
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 19:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837Ab1DZRkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 13:40:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757781Ab1DZRkK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 13:40:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0C8D347C;
	Tue, 26 Apr 2011 13:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zlCdAydYm2HHSXX/xLwXXxBuWv0=; b=bqBiYE
	1BpCyPVpmBwdw7DTYGI9SwE+uaBQHozDijkywFLIF02PmrH2ggFsjrOIc55AkmTk
	MHO3uUR9Rt0egPcnqdHFrMxI2wXovcAhmQKL8mZmQeH32XwiylMbgFRAJGOugw7i
	nC5YZJAjwIHGwsIAd9KRBfmhfZuLKkWzuW3H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhJrVfKvqnleBI87Kj0m/3l+rRJqcT0A
	xa0o3f288Tu5/FI5bk7myqWP91cO6kUkkDbOXiPrIj10a56l31869wN/6rKFDQ4U
	c+7svGX4tI3LH+KnUAd6myXFtPYyLICJSa2vCUUjPlmhkA0gdkJO+zvyGuuAJeRb
	40LzubVTTac=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AB72F347B;
	Tue, 26 Apr 2011 13:42:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AC189347A; Tue, 26 Apr 2011
 13:42:01 -0400 (EDT)
In-Reply-To: <826def15eb7204ee30fc4c358f72103ec75b4e42.1303808057.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 26 Apr 2011 10:54:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FCE6E24-702C-11E0-AD8C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172117>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When requesting notes with "--notes", "format-patch" produces notes
> within the commit message which "am" misunderstands as being part of the
> message.
>
> Change this so that notes are displayed after an additional "---". Any
> "am" (old or new) will ignore that, so that it is a safe place for
> additional comments:
>
> Log message
> "---"
> notes
> "---"
> diffstat
> patch
>
> (The first "---" appears only when there is a note, of course.)
>
> Later on (say with "--format-notes") the output format can be changed
> easily to accomodate a future "am" which knows how to create notes from
> such patches.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Reducing the output format to one "---" only is not only complicated (the notes
> separator is generated in a quite different place from the patch separator)
> but also unnecessary (am reads the patch anyways) and not even preferable (to
> give a clear separation of the parts).
> ---

If you show more than one note, separating them with "---" in between
would be a good idea so that reader can tell where each note ends, but I'd
rather not to see the "---" after the last note.  Put just a blank line
here instead.

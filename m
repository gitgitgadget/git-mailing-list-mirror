From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of
 commit header in $GIT_EDITOR
Date: Sun, 11 Jul 2010 23:05:56 -0700
Message-ID: <7vbpadfd4r.fsf@alter.siamese.dyndns.org>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
 <1278764821-32647-2-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYC9e-0000js-JC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab0GLGGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 02:06:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0GLGGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:06:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14025C36A8;
	Mon, 12 Jul 2010 02:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VxFP8jwof3LIw/MYRN1wCVRQ8yU=; b=E6/Vnw
	D3d5h6BVJZ/o7F+99yBg6CWZn7OKE0uo4odqHC/UG6irZiE0kNWnQxZyxI6Z/Cf5
	SEeoUXdwVPDEOvHmqcvfHWi/qcIBiC2XSkLltqdvzq6JPcF60FBxb1HltGvMTyK2
	1wX9GMVLJmLUgRawRT8rq31lJ3fdDBTPqT3Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JIzcbPuzn4Zck1Uh8qrjM9tSK1kiytpD
	OypSK5GDueLc3vTrAO54Mjlu9vYTGvSACTKujGPza9Y40HLghFMf4fedUxJrf4aJ
	zOHmbYMXJeaI5k54e+218Mn2YNipVTu4hk1g+7i4lXZUKJwVvr6FhOGaTcE3DERP
	o0p/mm7nntQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D09D6C36A7;
	Mon, 12 Jul 2010 02:06:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EBC9C36A6; Mon, 12 Jul
 2010 02:05:57 -0400 (EDT)
In-Reply-To: <1278764821-32647-2-git-send-email-ayiehere@gmail.com> (Nazri
 Ramliy's message of "Sat\, 10 Jul 2010 20\:27\:01 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C45A88C-8D7B-11DF-AC08-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150794>

Nazri Ramliy <ayiehere@gmail.com> writes:

> During "git rebase -i", when the commit headers are shown in the editor
> for action (pick/squash/etc), the whitespace (if any) at the beginning
> of commit headers are stripped out due to the use of "read shortsha1 rest"
> for reading the output of "git rev-list".
>
> The missing beginning whitespace do not pose any harm but this could be

If the current code removes whitespaces at the beginning, I would actually
say that it is cleaning up the mess while preparing the instruction sheet
for you to edit, i.e. it is a good thing, and the patch might be making
things worse.

I find it difficult to come up with good reasons to convince myself that I
should be interested in what this patch tries to do.  Here are some of the
things that came to my mind while doing so.

What happens if you have trailing whitespaces, excess whitespaces in the
middle, etc. with or without this patch?  What _should_ happen in an ideal
world?

What happens if you have a malformed commit object whose first line is
blank (i.e. no "Subject" line), or there is _no_ commit log message
whatsoever with or without this patch?  What _should_ happen in an ideal
world?

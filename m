From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Mark files for later commit?
Date: Mon, 28 Mar 2011 23:49:07 -0700
Message-ID: <7voc4uto9o.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel =?utf-8?Q?Nystr=C3=B6m?= <daniel.nystrom@timeterminal.se>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:49:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Sjx-0001HT-4g
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1C2GtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 02:49:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab1C2GtQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:49:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 863BF244F;
	Tue, 29 Mar 2011 02:51:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HDDrSXQp3AXz
	9Z0Xcrc4vDJ8hIY=; b=a7y3GG2V3ps+HOXfb9RYcrsG/qOo5j9xUdcq1QEhXVyX
	2XA60Jo9ox/ODSKdCNVoMzZXEsNIglv1oDsE4Ap9rdb++ROl6XAiRzqerry6idxW
	VTkGZLF7VS76kP7kJUXcA/1IDjsfbMxNxv4XBW394iGgsVtbIRXmEuR1L65LdsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=O/lfzk
	mPyzh8LRwbjSkDgpolqogcQzabCrVXJrgJRfgtmRZ5emHQHv+zw8z4WkVtjZ/Sou
	0qKaCmxqdqiPX50ALdOTSfUCR9FTxT5lo5Kw1WNuBKW7RMo49dEmcXRpR0nJ+VlL
	yja877Bgv/yZD5cwGkTCygTZuSFOyNziiXY8A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CB4C244E;
	Tue, 29 Mar 2011 02:50:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 52BD1244D; Tue, 29 Mar 2011
 02:50:56 -0400 (EDT)
In-Reply-To: <AANLkTi=rPAQas3gvHJ+EFYTXP_YXuULQMk8o8pgkj=9T@mail.gmail.com>
 ("Daniel =?utf-8?Q?Nystr=C3=B6m=22's?= message of "Tue, 29 Mar 2011 08:04:00
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E77D9CCE-59D0-11E0-9FC2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170231>

Daniel Nystr=C3=B6m <daniel.nystrom@timeterminal.se> writes:

> So this makes me wonder, is there a way to mark certain files for
> being committed later on? Which does not automatically get added to
> the staging area (on "git commit -a" or "git add ." and so on) unless
> it's specifically mentioned by "git add"?
>
> We've discussed making it generated automatically, but that's not as
> easy as it may sound.
>
> How would you like a git feature like described above, marking files
> for later inclusion?

That does not sound like a feature but merely a source of confusion.

So far, "commit -a", "add", "add ." etc have _all_ been a way to tell g=
it
to add the current state of the content to the index.  What is the poin=
t
of making it more complex by letting the user say "I am telling you to =
add
everything in the working tree by explicitly saying 'git add .', but I =
do
not really mean it"?

In the meantime, some misguided souls might suggest assume-unchanged, b=
ut
that is not guaranteed to work for this purpose, so ignore them.  This =
is
because assume-unchanged is a promise you make git that you will _not_
change the working tree files, and that promise implies a permission fo=
r
git to use blob object recorded in the index that corresponds to such a
path instead of reading from the working tree files while doing certain
operations (such as "git diff") if it is more convenient.

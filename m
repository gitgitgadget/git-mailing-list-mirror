From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] apply: apply works outside a repository
Date: Sun, 22 Nov 2009 09:28:59 -0800
Message-ID: <7v3a46ii3o.fsf@alter.siamese.dyndns.org>
References: <4B0964A1.2040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 18:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCGFZ-0001S7-Jk
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 18:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbZKVR3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 12:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755550AbZKVR3C
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 12:29:02 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbZKVR3A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 12:29:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 68C68A0D4C;
	Sun, 22 Nov 2009 12:29:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=GT0Jz9VN1uMJVYnZ1RkMl0ZmR
	yM=; b=Jai1CRL7SxgdTXFIsFk9MvdKArY+4RX7XoYcJqUy1rVWv9PPtrqc6CNnl
	x4luRpxXfshSfqTbpBybOqtgrGetlYHbPeZ3jTEP0wOG2OZiC08A6AC96iHb1lp2
	Bw94OxcKhd1BCtCcDr9GYo/pTo3lyB2Fm+9xKVt2Ns+LXvz9EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Xuol/+ZiDfx9WatnMab
	HpW3OBneIe1CENQiMbZlaVl2PGfIRqlV+MhudaSzSxGKgPDJL01J1QxkD/OLdPqQ
	nEeM3cvFSBeZ63ygTKPzJv+VNklXGN1+5C9dJ+0wxYeDg7kWx/cLVHRx4dZAAzMk
	dVVi0TuSVVmQ8I9HAlDYDvBU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 474A6A0D4B;
	Sun, 22 Nov 2009 12:29:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54C39A0D48; Sun, 22 Nov 2009
 12:29:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87DD0B78-D78C-11DE-B43A-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133447>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> The documentation for 'git apply' talks about applying a
> patch/diff to the index and to the working tree, which seems
> to imply that it will not work outside a git repository.

Thanks.  I think the headline should also be reworded.  It currently
reads:

    Apply a patch on a git index file and/or a working tree

but historically and still in real life practices, when you use apply (=
as
opposed to am), you apply primarily to the files and optionally to the
index, so this should read something like:

    Apply a patch to files and/or to the index

We could say "to files in the work tree", but that would give a wrong
impression that the files we talk about must be in a directory that is
part of the work tree of some repository, so it probably is better with=
out
it.

The same comment applies to the beginning of the DESCRIPTION section.  =
I
actually think your added text should reword the current two-liner ther=
e,
instead of being added at the bottom.  Here is my attempt.

    Reads supplied diff output (iow "a patch"), and applies it to files=
=2E
    With --index (--cache) options, the patch is also (only) applied to
    the index respectively.  Without these options, the command applies
    the patch only to files, and does not require them to be in a git
    repository.

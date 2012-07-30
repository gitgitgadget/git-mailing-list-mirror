From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-tag documentation enhancement
Date: Sun, 29 Jul 2012 18:13:52 -0700
Message-ID: <7vvch6t5in.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6TDDmvtt1cc3_mGG9hZtSVp-ecNXzCQrPj6-e4DU6HMGA@mail.gmail.com>
 <CAHtLG6SQ3DeexriXRtV4ys7x12iKQtq7OCrZdC+A8SSH6Tokow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:14:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SveYa-0002U0-IH
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab2G3BNz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 21:13:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab2G3BNz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 21:13:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A41D4803E;
	Sun, 29 Jul 2012 21:13:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8peS7EoUk11E
	nip8ARYCdK/ryg4=; b=W+BXzo0jeLb81ktof03Qc2Y0Cv5oHPXfVICHJbNc7xRN
	TWq10NX2E2cRDR6eRvpn2zpkZq82xy+PWVz8bioL0jaVI3DhMyvRoyNdacg9S/eF
	AmftYWrI9ImAMcRJ1R2VnzJw1oaXDm8tdQPP7dvCsSnFBKJukGsRaBGzCEmpLn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ed8Pa1
	HiNLW1Qm3R6tFKdYl4XERO3hMYdgkrE0yJcChYv7+v1PQpKYNIIjALoyiajihA5D
	HwQGOinxBMt1yeANKEGVfUxBdnMq8OX3vXXoKcIvxxvl3POXuAE2LbgH+czzUy0d
	Y5SYAiAern4K68aJ4ZNpkGloiuAVGb6MA4WSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91D0D803D;
	Sun, 29 Jul 2012 21:13:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A2ED803C; Sun, 29 Jul 2012
 21:13:53 -0400 (EDT)
In-Reply-To: <CAHtLG6SQ3DeexriXRtV4ys7x12iKQtq7OCrZdC+A8SSH6Tokow@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Sun, 29 Jul 2012 20:33:24
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D44DBAAA-D9E3-11E1-B3B0-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202514>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> I would like to enhance git-tag documentation
>
> --Unless -f is given, the tag to be created must not yet exist in the
> .git/refs/tags/ directory.
> ++Unless -f is given, the tag to be created must not yet exist in the
> .git/refs/tags/ directory or inside .git/packed-refs file.

I think the updated text is technically correct, but I do not think
it is a good direction to go.  The root cause of the problem was
that the original text assumed ".git/refs/tags/ directory" will
forever be the only way to have a local tag, and the description was
left behind when packed refs mechanism was introduced to improve the
file system usage.  It shouldn't have relied its description on such
an implementation detail in the first place.

The updated text still shares the same problem.  I think the right
fix is to say something like this:

        Unless -f is given, the tag to be created must not yet exist
        as a local tag.

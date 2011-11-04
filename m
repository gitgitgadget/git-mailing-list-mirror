From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: allow to specify diff pathspec in addition to prune
 pathspec
Date: Fri, 04 Nov 2011 15:04:29 -0700
Message-ID: <7vwrbfa6j6.fsf@alter.siamese.dyndns.org>
References: <1320314474-19536-1-git-send-email-pclouds@gmail.com>
 <1320322556-32675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 04 23:04:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMRsM-0005kR-Qz
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 23:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab1KDWEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Nov 2011 18:04:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab1KDWEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Nov 2011 18:04:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A80D45786;
	Fri,  4 Nov 2011 18:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DWVR1pQPYYR5
	Mbne8ShaBtgrCbY=; b=G7qSCxJSY3vpOFQD5EjnuwUbg76gD1i5XZm8Q9jhDxwh
	bMTeSNG0tQ9Gmw0yCEbO4XUXMoYQhsPYZNZOAbG3Op3hNwVAM0eddvGugj+0neXi
	+8tCTA9Dik5a6Y1bBIGWd6aTLXo3ySNbZZxY2zu85BIGjA+9mYMZJbQf/F1t/Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B/FKeP
	XP2ek6UWQ/wlOxBLUgPIfEEE7TrTqVE3QTj7Y0gB4qDKcVGCds/6B5/zvZaLxsOJ
	W/HE3QXF/CcnD+sFfAqScQtKBd2hLOUzywCgnsVqWTi7grRWlR9aonzVblNf7Bzi
	3HlOhKNj85jlpuya/5mzjLZ0OLqx4naClsbPY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FD7E5785;
	Fri,  4 Nov 2011 18:04:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B6D55781; Fri,  4 Nov 2011
 18:04:31 -0400 (EDT)
In-Reply-To: <1320322556-32675-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 3 Nov
 2011 19:15:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8E1BF50-0730-11E1-BFA3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184806>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Pathspec in "git log -p <pathspec>" is used for both commit pruning
> and diff generation. If --full-diff is given, then diff pathspec is
> reset to generate complete diff.
>
> This patch gives more control to diff generation.  The first pathspec=
 in
> "git log -p -- <pathspec> -- <pathspec>" is used as commit pruning
> as usual. The second one is used for diff generation. So --full-diff
> now is essentially "git log -p -- <pathspec> --".

I agree that giving more control to diff generation is a good idea, and
this certainly is better than the previous round that nobody reviewed
before you rerolled this round.

But I have doubts about declaring "--full-diff is equivalent to giving =
the
'output' pathspec that is empty".

Have you thought about the interaction between this and -M/-C options?

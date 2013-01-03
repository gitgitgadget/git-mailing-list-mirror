From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Thu, 03 Jan 2013 10:38:32 +0100
Message-ID: <50E55198.5080202@kdbg.org>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com> <7vsj6mdqeo.fsf@alter.siamese.dyndns.org> <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com> <7vfw2kbs4h.fsf@alter.siamese.dyndns.org> <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com> <7vk3rwaa3r.fsf@alter.siamese.dyndns.org> <CAC_01E2iHgNvh5PnBh3TcNKr2pLazZwRojVK9ksaE3x0a1QHmQ@mail.gmail.com> <7v623f18ci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?R3LDqWdvcnkgUGFrb3N6?= <gpakosz@visionobjects.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 10:39:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqhGM-00086N-B5
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 10:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3ACJij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 04:38:39 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:35813 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751134Ab3ACJih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 04:38:37 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1B93113005B;
	Thu,  3 Jan 2013 10:38:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 4119619F45D;
	Thu,  3 Jan 2013 10:38:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7v623f18ci.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212576>

Am 03.01.2013 00:19, schrieb Junio C Hamano:
> Gr=C3=A9gory Pakosz <gpakosz@visionobjects.com> writes:
>=20
>> So we have an annotated tag that points to a commit that is rewritte=
n
>> to nothing as the result of the filtering. What should happen?
>=20
> If the user asked to filter that tag itself, it may make sense to
> remove it, rather than keeping it pointing at the original commit,
> because the commit it used to point at no longer exists in the
> alternate history being created by filter-branch.

IOW, if the command was something like

  git filter-branch ...filter options... -- v1.0 master ...

and v1.0 is an annotated tag, then it is reasonable to expect v1.0 to b=
e
deleted if the commit it points to goes away. But if the commit did not
go away, but was rewritten, then it is equally reasonable to expect tha=
t
the tag is also rewritten. But I don't think that we currently do the
latter.

Therefore, IMO, a change that implements the former behavior should als=
o
implement the latter behavior.

-- Hannes

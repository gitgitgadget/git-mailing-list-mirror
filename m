From: Brandon Casey <drafnel@gmail.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Thu, 3 Jan 2013 12:52:31 -0800
Message-ID: <CA+sFfMcRsD-4QwPTw6edJdUOJxdqR71oQaT9vz3QL5oCnfLTsQ@mail.gmail.com>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
	<7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
	<CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
	<7vfw2kbs4h.fsf@alter.siamese.dyndns.org>
	<CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
	<7vk3rwaa3r.fsf@alter.siamese.dyndns.org>
	<CAC_01E2iHgNvh5PnBh3TcNKr2pLazZwRojVK9ksaE3x0a1QHmQ@mail.gmail.com>
	<7v623f18ci.fsf@alter.siamese.dyndns.org>
	<50E55198.5080202@kdbg.org>
	<CAC_01E2HXSnXBgDm=Cbwgi5PbiuHp_qPpoaqT_=pdDWDMnC5jA@mail.gmail.com>
	<50E55E94.2090401@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Gr=C3=A9gory_Pakosz?= <gpakosz@visionobjects.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:53:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqrmf-0003kf-H0
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3ACUwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 15:52:36 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:43226 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab3ACUwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jan 2013 15:52:33 -0500
Received: by mail-vc0-f172.google.com with SMTP id fw7so15863416vcb.17
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 12:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=w2SSHypMv5rP1p4iz7U4eCG/d0RZt6u8f9KqFHxqjM8=;
        b=0hPwzmcpmLkxlasFyRneCn/QA9+wwEWaPk89qFoqMRCcBeyXRtkccEJKoQikm/A5uq
         e7/86aogRr0yCIBNQCIhGf2i28NRFhAfq64nM7FylRb40qd3mGO9VvNztRvojVLRTEnD
         zzZ4Jm/UA5fQ0Ygmr7CDLtU061GpcztP6iOZrAlJ904MndVUIreMEWl+4EPY5xJVndw+
         0y+YIqUQ2NFmEUl8FggF7Qdx0GmYCd09m+PAQpDsY+ItUxitfwWsluJBs/uvTomMtCI1
         F4KxIS4dHzOjTqm4zn2DCwtGKAV9giP5t2ctjzCTyQGq2+o3Wy3pBvBKO7w1rd7qtw8I
         3GJQ==
Received: by 10.220.115.72 with SMTP id h8mr74045352vcq.43.1357246351395; Thu,
 03 Jan 2013 12:52:31 -0800 (PST)
Received: by 10.58.215.106 with HTTP; Thu, 3 Jan 2013 12:52:31 -0800 (PST)
In-Reply-To: <50E55E94.2090401@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212611>

On Thu, Jan 3, 2013 at 2:33 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 03.01.2013 10:50, schrieb Gr=C3=A9gory Pakosz:
>>>
>>> IOW, if the command was something like
>>>
>>>   git filter-branch ...filter options... -- v1.0 master ...
>>>
>>> and v1.0 is an annotated tag, then it is reasonable to expect v1.0 =
to be
>>> deleted if the commit it points to goes away. But if the commit did=
 not
>>> go away, but was rewritten, then it is equally reasonable to expect=
 that
>>> the tag is also rewritten. But I don't think that we currently do t=
he
>>> latter.
>>>
>> When the commit doesn't go away, the tag is currently being rewritte=
n properly.
>
> Indeed, but only if a --tag-name-filter was specified.
>
>>> Therefore, IMO, a change that implements the former behavior should=
 also
>>> implement the latter behavior.
>>>
>> The patch in my latest email does both. (yet lacks unit tests for no=
w)
>
> If it deletes a tag only when --tag-name-filter was specified, than t=
hat
> should be fine.

Hmm, if a tag name filter _other_ than 'cat' is supplied, I think a
user will expect that the original tags will _not_ be touched, and
especially not deleted.

Rather than blindly deleting the original tag ref, maybe we should
still call the user's tag name filter, and then attempt to delete the
"new" name provided by the filter, if it exists.  If the filter was
'cat', then the new and old names will be the same.

-Brandon

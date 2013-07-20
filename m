From: Junio C Hamano <gitster@pobox.com>
Subject: Re: One question about git-format-patch
Date: Fri, 19 Jul 2013 17:32:46 -0700
Message-ID: <7vehaut6j5.fsf@alter.siamese.dyndns.org>
References: <804161F448B352478D7503429A0B7F27CA94AC@ex10-mbx-36002.ant.amazon.com>
	<CAPc5daW6ohYxJP0eyfW0DT_Q-E8v0quweRBwJCAZOVrEMWchjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Hua\, Siyuan" <siyuahua@amazon.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 02:32:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0L6T-0004v3-Pl
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 02:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab3GTAcu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 20:32:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab3GTAct convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 20:32:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B385426321;
	Sat, 20 Jul 2013 00:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZafneFBjExX9
	bk/2LkxBCpvN8Gg=; b=xe29FOOWJTcoonnVpJj4cqtlOmTcP2QFa2nbMbHEWNFu
	olZo/lCfPCDJIxkSmZKF8NYQXTzPmw6PbpyjAGvHsWIwFlLb1tCoLwa4Hd8ZXLxm
	knv6lMSUtS1MYsrh+SBGvelf7Xfk6cBVijIfwF97H4TPYAlTxpkx11uj1YbhHjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DOJPls
	0NSC/oUD1/TNKu3IuK2oLK1FBg1Z9kXcOtr9nH+1AArgDhD0rK1essTjXyDJIGzu
	s73H+meZOO62NC6ci2KCxWHOzfaAUPhixrNRY1Mg36YLkXk5K2DVLzbbB1j2tdtt
	9WRWG4cvZnos4g3+0Z/JdBFVZ+roMfVxVoidE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A84AE26320;
	Sat, 20 Jul 2013 00:32:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 087E82631E;
	Sat, 20 Jul 2013 00:32:47 +0000 (UTC)
In-Reply-To: <CAPc5daW6ohYxJP0eyfW0DT_Q-E8v0quweRBwJCAZOVrEMWchjA@mail.gmail.com>
	(Junio C. Hamano's message of "Fri, 19 Jul 2013 16:06:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E718AAFC-F0D3-11E2-A46C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230868>

Junio C Hamano <gitster@pobox.com> writes:

>> I=E2=80=99m a git user, and recently I=E2=80=99ve noticed there=E2=80=
=99re some differences between
>> =E2=80=9C$ git format-patch =E2=80=93n=E2=80=9D and =E2=80=9C$ git f=
ormat-patch HEAD~n=E2=80=9D. According to the
>> documentation: =E2=80=9C-<n> Prepare patches from the topmost <n> co=
mmits.=E2=80=9D
>
> Correct.  However, HEAD~n will prepare patches for commits that are
> not ancestor of HEAD~n.
>
> And there may well be a lot more than n such commits, unless you are
> working on a strictly linear history.

Every once in a while, a illustration would help new folks. =20

In this history (as always, the time and ancestry topology flows
from left to right):

           E-------F---G
          /       /
     A---B---C---D

imagine that your HEAD is at commit G.

 - G~1 =3D=3D G^ =3D=3D F
 - G~2 =3D=3D G^^ =3D=3D E (suppose F is a merge of D made on E)
 - G~3 =3D=3D G^^^ =3D=3D B
 - G~4 =3D=3D G^^^^ =3D=3D A

so "git format-patch HEAD~4" will give you B, C, D, E and G (five
commits).

Asking for "git format-patch -n 4" does not make much sense in a
history like this, but it will give you G, D, C, E and at that point
you have seen 4 commits, so you won't get B.

Note that if F were a merge of E made on D, that would make

 - G~2 =3D=3D G^^ =3D=3D D
 - G~3 =3D=3D G^^^ =3D=3D C
 - G~4 =3D=3D G^^^^ =3D=3D B

And "git format-patch HEAD~4" will give you C, D, E and G (four
commits).

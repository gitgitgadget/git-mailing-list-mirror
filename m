From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 12:03:39 -0400
Message-ID: <4BA0FD5B.5090408@xiplink.com>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock> <4BA07DC7.9070502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 17 17:02:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrvhG-0007g5-2N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 17:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab0CQQCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 12:02:09 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:40157 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab0CQQCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 12:02:07 -0400
Received: from relay18.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay18.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 9C2DD16F1D8E;
	Wed, 17 Mar 2010 12:02:07 -0400 (EDT)
Received: by relay18.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1CC9216F1E9B;
	Wed, 17 Mar 2010 12:02:07 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4BA07DC7.9070502@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142406>

Johannes Sixt wrote:
> Jonathan Nieder schrieb:
>> If I am understanding properly, your idea is that this would be used=
 on
>> a branch after =E2=80=9Cunmerging=E2=80=9D it from master:
>>
>>     B --- C --- D [topic]
>>   /              \
>>  A ---  ...   --- M ... --- U [master]
>>
>> Here M is a merge commit and U a commit reverting the change from M^
>> to M.
>=20
> If I were to re-merge topic into master a second time after this
> situation, I would install a temporary graft that removes the second
> parent of M and repeat the merge. After the graft is removed, the his=
tory
> would look like this:
>=20
>      B --- C --- D --------------.   [topic]
>    /              \               \
>   A ---  ...   --- M ... --- U ... N [master]
>=20
> Are there any downsides? I don't know - I haven't thought it through.

I'm not sure I follow how to create that graft.

But the original point (which I hadn't made clear) is that at least one=
 of
the topic's commits needs to change in some substantial way.  So it's n=
ot
just a straight re-merge but a new take on the topic.

Consider that if the topic's first commit (B) needed to be rewritten th=
en the
repaired topic would contain only new commits and it could be merged in=
to
master without reverting the first merge's reversion.

What "rebase -i --no-ff" does is allow you to ensure that this will alw=
ays be
the case, even if you don't actually need to change the topic's first c=
ommit.

		M.

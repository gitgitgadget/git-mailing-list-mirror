From: David Christensen <david@endpoint.com>
Subject: Re: [PATCH] Revert "git.el: Set process-environment instead of invoking env"
Date: Tue, 3 Jun 2008 10:54:02 -0500
Message-ID: <7011F840-D6E2-4BB0-9538-601DA4DF54C3@endpoint.com>
References: <7vod6nk05c.fsf@gitster.siamese.dyndns.org> <20080602223907.9612.84564.stgit@yoghurt>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clifford Caoile <piyo@users.sourceforge.net>,
	=?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 17:55:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Yqt-0006Gn-3T
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 17:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYFCPyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 11:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753001AbYFCPyP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 11:54:15 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:37475 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbYFCPyO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 11:54:14 -0400
Received: from [192.168.0.121] (wsip-70-168-112-209.ks.ks.cox.net [70.168.112.209])
	by mail.endcrypt.com (Postfix) with ESMTP id 604AF349A8B;
	Tue,  3 Jun 2008 15:54:06 +0000 (UTC)
In-Reply-To: <20080602223907.9612.84564.stgit@yoghurt>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83677>

> This reverts commit dbe48256b41c1e94d81f2458d7e84b1fdcb47026, which
> caused mis-encoding of non-ASCII author/committer names when the
> git-status mode is used to create commits.
>
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>
> ---
>
> On 2008-05-30 13:27:43 -0700, Junio C Hamano wrote:
>
>> Karl Hasselstr=F6m <kha@treskal.com> writes:
>>
>>> How are things going with this fix? Junio, I expect you're waiting
>>> for a properly cleaned-up patch, possibly with acks from relevant
>>> people?
>>
>> You expected correctly.
>
> In case no one who understands how, why, and whether the fix works
> comes forward, here's a revert of the commit that introduced the
> problem.

This likely is due to the process-coding-system selected by emacs; =20
the correct functioning of this command will rely on both the current =20
buffer's coding system and the coding system of the data returned by =20
the invocation of git-status.  In order for this to function =20
properly, these should match.  Both of these are variables which can =20
be customized local to the buffer as part of the routine, so this =20
could be fixed if we are able to determine at invocation time what =20
coding system the git-status command will return in (presumably some =20
form of utf-8, but I believe this is configurable per repo).

I'd be glad to take a more in-depth look at this, but I'm not up on =20
the code at this point.

Regards,

David
--
David Christensen
End Point Corporation
david@endpoint.com

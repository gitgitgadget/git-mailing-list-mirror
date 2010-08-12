From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [SOLVED] `git fetch tag NAME' into mirror repo does not update
 HEAD, what to do?
Date: Thu, 12 Aug 2010 14:32:41 +0200
Message-ID: <4C63E9E9.7070105@dbservice.com>
References: <201008120954.27648.brian.foster@innova-card.com> <201008121238.51983.brian.foster@innova-card.com> <4C63D579.507@dbservice.com> <201008121416.35887.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 14:32:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjWxr-0003YV-Cl
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 14:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933619Ab0HLMcq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 08:32:46 -0400
Received: from office.neopsis.com ([78.46.209.98]:33292 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933525Ab0HLMcp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 08:32:45 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.036,BAYES_00: -1.665,TOTAL_SCORE: -1.629,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 14:32:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <201008121416.35887.brian.foster@innova-card.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153369>

On 8/12/10 2:16 PM, Brian Foster wrote:
>  NO.  =E2=80=98get checkout ...=E2=80=99 does not work in a bare repo=
sitory.
>  (You can modify my trivial posted script to prove this.)
>=20
>  However, your comment got me to thinking.  This _does_ work:
>=20
>     git reset --soft FETCH_HEAD
>=20
>  (And, I presume without testing, so would =E2=80=98... v2=E2=80=99 ?=
)
>  Given that git-reset(1)'s purpose is to change the branch's
>  head (or to change HEAD as I've been incorrectly describing
>  it), that does make sense.

I expected git checkout to work even in a bare repo - as you can see I
don't work that often inside bare repos :).

You should use update-ref instead of reset. The problem with reset is
that it changes the branch and not HEAD. Say initially your mirror had
HEAD as symref pointing to refs/heads/master. When you run reset --soft
v2 your master branch will now point to the same commit as the tag v2
(and HEAD will be still pointing to refs/heads/master). When you use
'git update-ref --no-deref HEAD v2' it will modify HEAD directly and
have it point directly to the same commit as v2 (also called detached H=
EAD).

tom

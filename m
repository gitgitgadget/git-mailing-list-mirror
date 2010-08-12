From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [SOLVED] `git fetch tag NAME' into mirror repo does not update
 HEAD, what to do?
Date: Thu, 12 Aug 2010 15:34:24 +0200
Message-ID: <4C63F860.2090600@dbservice.com>
References: <201008120954.27648.brian.foster@innova-card.com> <201008121416.35887.brian.foster@innova-card.com> <4C63E9E9.7070105@dbservice.com> <201008121522.55020.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 15:34:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjXvX-0004ID-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 15:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760121Ab0HLNe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 09:34:29 -0400
Received: from office.neopsis.com ([78.46.209.98]:34662 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074Ab0HLNe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 09:34:29 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.035,BAYES_00: -1.665,TOTAL_SCORE: -1.630,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 12 Aug 2010 15:34:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <201008121522.55020.brian.foster@innova-card.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153374>

On 8/12/10 3:22 PM, Brian Foster wrote:
> On Thursday 12 August 2010 14:32:41 Tomas Carnecky wrote:
>>                                                         When you use
>> 'git update-ref --no-deref HEAD v2' it will modify HEAD
>=20
>  NO, it gets an error (following is from a modified version
>  of my previously-posted script):
> + git update-ref --no-deref HEAD v2         =20
> error: Trying to write non-commit object 2bc324e6a68cb3704448c9f63ddc=
3bc0260c0b48 to branch HEAD                                            =
                                   =20

Oh the subtleties when working with plumbing:
git update-ref --no-deref HEAD v2^{commit}

>  Using =E2=80=98git update-ref --no-deref HEAD FETCH_HEAD=E2=80=99 do=
es
>  not error, and, as you say (below), does seem to give
>  me a detached head.
>=20
>> 'git update-ref --no-deref HEAD v2' it will modify HEAD directly and
>> have it point directly to the same commit as v2 (also called detache=
d HEAD).
>=20
>  I do_not_ want a detached head!  This has perhaps been
>  confused by my improperly saying =E2=80=9Cupdate HEAD=E2=80=9D when =
I
>  meant =E2=80=9Cupdate the master branch=E2=80=9D.  If you look back =
at
>  my originally-posted diagrams, it's a reasonable guess
>  I don't want a detached head.  Having HEAD continue to
>  be a symref to refs/heads/master (which, in this case,
>  is the same commit as v2) is correct.

Just make sure your tools and scripts don't break when you reset the
branch like that (especially when the update is non-fast forward as
fetch+reset won't warn you when this happens).

tom

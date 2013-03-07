From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What I want rebase to do
Date: Thu, 07 Mar 2013 11:08:50 +0100
Message-ID: <51386732.1020708@viscovery.net>
References: <201303042058.r24KwwEx012408@freeze.ariadne.com> <7vtxoqx3s1.fsf@alter.siamese.dyndns.org> <87sj4aoo3s.fsf@pctrast.inf.ethz.ch> <7vppzex2pq.fsf@alter.siamese.dyndns.org> <201303061855.r26ItKtM018797@freeze.ariadne.com> <87r4jra942.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 07 11:09:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDXlM-0006uu-6X
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab3CGKI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 05:08:58 -0500
Received: from so.liwest.at ([212.33.55.24]:12929 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049Ab3CGKI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 05:08:58 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UDXko-00029w-GY; Thu, 07 Mar 2013 11:08:50 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 332291660F;
	Thu,  7 Mar 2013 11:08:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <87r4jra942.fsf@pctrast.inf.ethz.ch>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217585>

Am 3/7/2013 9:48, schrieb Thomas Rast:
> worley@alum.mit.edu (Dale R. Worley) writes:
> [...snip...]
> 
> Isn't that just a very long-winded way of restating what Junio said
> earlier:
> 
>>> It was suggested to make it apply the first-parent diff and record
>>> the result, I think.  If that were an acceptable approach (I didn't
>>> think about it through myself, though), that would automatically
>>> cover the evil-merge case as well.
> 
> You can fake that with something like
> 
> git rev-list --first-parent --reverse RANGE_TO_REBASE |
> while read rev; do
>     if git rev-parse $rev^2 >/dev/null 2>&1; then
>         git cherry-pick -n -m1 $rev
>         git rev-parse $rev^2 >.git/MERGE_HEAD
>         git commit -C$rev
>     else
>         git cherry-pick $rev
>     fi
> done
> 
> Only tested very lightly.  Dealing with octopii, conflicts and actually
> preserving the commit's attributes is left as an exercise to the
> reader[1].

I proposed this long ago, but by modifying preserve-merges rather than
with a new option (--first-parent):
http://thread.gmane.org/gmane.comp.version-control.git/198125

It works very well. I'm using it frequently in the field.

-- Hannes

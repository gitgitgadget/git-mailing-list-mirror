From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Thu, 26 Mar 2015 21:28:37 +0100
Message-ID: <55146BF5.7040008@gmail.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com> <xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 21:29:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbEOT-0004nQ-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 21:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbbCZU2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 16:28:42 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36958 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbbCZU2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 16:28:41 -0400
Received: by wiaa2 with SMTP id a2so3912735wia.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XPntkwWtfMibcTubgD41tRxHDM+m9dTVWrrJ3fgfOFo=;
        b=cGBYre7sePX1Ui5L+BGFVcNOL/m9Olj0F+10sl5yC1gNiqWV6cinqDJHXMvqYXIvH8
         hiiMzyZGOiOfBk/mF1Qn/ldsYzxbrDnYWHBikHbfPS21ejuwalNoB6qBToA9yp5vWpNz
         8/qgkLWqZw6R1QlusFYlE3bTO2HkeCWltFbOG2VAFjIoof5YW31Wij3x3M8dM2lfpcJp
         3RSfDJY2IOKVUTHXbr8ubRff/wZmF0x+FvKqv5rr7YRJ9yk+M8Vyo6In8A+lflemHq2c
         rCzRl13a0+gniPGcUVbeoAfcGeApFDmnPKS0UVDOrc3IiHFTZ5ep1RHTGX+p97y08269
         +WIw==
X-Received: by 10.194.85.129 with SMTP id h1mr31822622wjz.147.1427401720095;
        Thu, 26 Mar 2015 13:28:40 -0700 (PDT)
Received: from [192.168.188.20] (p4FF45F99.dip0.t-ipconnect.de. [79.244.95.153])
        by mx.google.com with ESMTPSA id l4sm444445wiw.6.2015.03.26.13.28.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 13:28:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266345>

On 26.03.2015 19:18, Junio C Hamano wrote:

>> Also, do not say that merge commits are *tried* to be recreated.
>
> Good point.  "We will try but it might fail" is better left unsaid
> as that is true almost everywhere.

Exactly.

>>   -p::
>>   --preserve-merges::
>> -    Instead of ignoring merges, try to recreate them.
>> +    Recreate merge commits instead of replaying commits a merge
>> commit introduces.
>
> Hmm, is this line-wrapped?

Probably, I had to send this via GMail.

> Although I fully agree that the new text is better than the original,
> I think the new text fails to point out one major aspect by not
> mentioning "linear" or "flatten" anywhere.  The point of "git rebase"
> without "-p" is not just to replay but to flatten
>
> 	Instead of flattening the history by replaying each
> 	non-merge commit to be rebased, preserve the shape of the
> 	rebased history by recreating merge commits as well.
>
> or something along that line, perhaps?

Hm, I'm not sure about the "as well" here. Non-merge commits basically 
are just picked, not recreated in the same sense as merge commits. I'll 
come up with another proposal.

> I think the current preserve-merges considers everything between
> <upstream> and <branch> as "commits to be rebased", and recreate
> merges across these rebased tips of branches that are merged.  There
> however were repeated wishes (or wishful misunderstandings ;-) that
> there were a mode to rebuild the trunk, considering only the commits
> on the first-parent chain as "commits to be rebased", recreating the
> history by replaying the merge commits (whose first parent might be
> rewritten during the rebase, but the tips of side branches these
> merges bring into the history are kept intact).

I guess I'm a victim of that wishful misunderstanding then, as I indeed 
though that's exactly what the current -p is doing. Well, modulo the 
special case where the second parent is the tip of a branch whose 
fork-point with the trunk is part of the rebase, see "Example 1" at [1].

In other word, you're saying that the current preserve-merges does not 
keep the tips of side branches intact. If that's so, what is is doing 
with the tips of the side branches?

> without such a feature in the system, I would be happier if we made
> sure that the description we are discussing to update makes it clear
> that the current behaviour is "everything between <upstream> and
> <branch>", and cannot be misread as "do not touch side branches
> instead of dropping merged commits".

Agreed. As soon as I understand the difference between the two :-)

[1] http://stackoverflow.com/a/15915431/1127485

-- 
Sebastian Schuberth

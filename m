From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 4 Apr 2013 14:35:18 -0600
Message-ID: <CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
	<1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
	<87y5cyqhya.fsf@59A2.org>
	<CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com>
	<87ppyaqcie.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:35:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqsv-00009G-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759565Ab3DDUfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:35:20 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:52876 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756978Ab3DDUfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:35:20 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so3149774lbd.38
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=iCjephvVDazcHQQ6Xs6Eg6Qx+CO7S1QuaxNSIddXE+s=;
        b=TH5Nh22oEWrdQ3e61NDfilvtsV3zrhuoI5wtvMulvCc6kyJhcIqRCCmudnWK7ojGzC
         hR4GITTxvsiIqmzfDouv0vXDyPX4SkHrduSncz5oVzZG9OGxnOem4pAJgttx/ZZ6jbgq
         k+1lnuKyJdRi3BY2DG9g7b9o2YAyuIykNJ9OD6MSlWQBktVldQZpzbXUhKIkydFG/GJ0
         YVBE4iE+BjPGhbv5c04S9qxgfSlC8H7X1wqxsMjcSajMn8K1+EJi1/O4Tm2Zflopie/Y
         KQE0c8Lh+JBgzSiqo9a1H9oJBwhuRPsLVKKE8lYEA3ljYZ1rmk6o+Wpt+1vAK7j+iFk4
         lZMQ==
X-Received: by 10.112.132.166 with SMTP id ov6mr2765803lbb.71.1365107718084;
 Thu, 04 Apr 2013 13:35:18 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 13:35:18 -0700 (PDT)
In-Reply-To: <87ppyaqcie.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220094>

On Thu, Apr 4, 2013 at 2:14 PM, Jed Brown <jed@59a2.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If that's the case, they should disable in the server, just like some
>> people disable non-fast-forward pushes in git.
>
> I don't know how to make Hg allow new branches and bookmarks, but not
> new anonymous heads.

It's not possible to push new bookmarks without pushing new heads
(unless they are all reusing the same commits), and all the drawbacks
of doing that, Merucrial's UI make sure of that.

> Vanishly few Hg projects use a workflow anything
> like topic branches so it's normally not a common thing to be creating
> new heads.  If someone is using remote-hg, we can be pretty sure they
> are not the primary maintainer, so if they are pushing, they'll be aware
> of upstream policy and

> will need to play by those rules.

No, we don't. The fact that you say so doesn't make it so.

I create a branch felipec-bookmarks, and I push as many heads as I
wish. Who will get affected? Nobody. I already explained that, and you
conveniently avoided that paragraph in the reply.

>> The problem is Mercurial, purely and simple, without forcing the push,
>> how do you expect this to work?
>>
>> % git clone hg::whatever
>> % git checkout -b feature-a master
>> # do stuff
>> % git push -u origin feature-a
>
> There is a difference between pushing a new branch (see 'hg push
> --new-branch -b branch-name') and creating arbitrary new heads.

feature-a is not a branch, it's a bookmark, and bookmarks cannot be
pushed without creating new heads (essentially).

> Normal workflow in case of new commits upstream

And who says we are committing upstream?

> Note: I don't know of any way to avoid the race condition when pushing
> a bookmark that creates a new head since there is no 'hg push --new-bookmark'.

This is not about the race condition, and the race condition cannot be
fixed with the current design.

-- 
Felipe Contreras

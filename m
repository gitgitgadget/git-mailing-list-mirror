From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 07:21:52 -0400
Message-ID: <CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
	<CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
	<CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
	<508E532F.2010109@alum.mit.edu>
	<20121029103837.GA14614@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 12:22:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSnPz-0003pB-Av
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 12:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758681Ab2J2LVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 07:21:54 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46406 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668Ab2J2LVy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 07:21:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1902524bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mYsubj3mkb5s+zOzm0Lf1rc2RVgfgpUvq/o0xxhlzyA=;
        b=o9B8UGizcxOBGzzfZiPn7Vgizj7hPrqdjSuqwzVvZhPy8rWONQLaVIDJQg4apP8UA1
         7Pkc0SycPN8zn1QuUqSvutSJzYn/lMIRDTWQ78/reOjYIj84xU+qoHutHCjO5cYjBU6u
         G2aBHgYVVgXMooA3e89p9YEuK0FT8ie14tz6uDrUM5dR7asyCK/7rsod7NN8DTBUHxSI
         VQDZeAlQduRpYZs0P+JpG8Ie1yvvOpfgHHSVHjiPgQomBWr2woM6SV6gsJkkGKX5dD4Y
         eE1wI8g156YCy14eoxmUV/vsiVjdN86BDNk5osnFlfSKQ0CiVxXEOKKqoNGq/xHfelBT
         KOzw==
Received: by 10.204.9.3 with SMTP id j3mr9338880bkj.15.1351509712745; Mon, 29
 Oct 2012 04:21:52 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Mon, 29 Oct 2012 04:21:52 -0700 (PDT)
In-Reply-To: <20121029103837.GA14614@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208616>

On Mon, Oct 29, 2012 at 6:38 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 10:58:07AM +0100, Michael Haggerty wrote:
>
>> I agree with you that it is too easy to create chaos by changing tags in
>> a published repository and that git should do more to prevent this from
>> happening without explicit user forcing.  The fact that git internally
>> handles tags similarly to other references is IMO an excuse for the
>> current behavior, but not a justification.
>
> I would have expected git to at least complain about updating an
> annotated tag with another annotated tag. But it actually uses the same
> fast-forward rule, just on the pointed-to commits. So a fast-forward
> annotated re-tag will throw away the old tag object completely. Which
> seems a bit crazy to me.
>
> It seems like a no-brainer to me that annotated tags should not replace
> each other without a force, no matter where in the refs hierarchy they
> go.
>
> For lightweight tags, I think it's more gray. They are just pointers
> into history. Some projects may use them to tag immutable official
> versions, but I also see them used as shared bookmarks. Requiring "-f"
> may make the latter use more annoying. On the other hand, bookmark tags
> tend not to be pushed, or if they are, it is part of a mirror-like
> backup which should be forcing all updates anyway.

Would that be an endorsement of continuing to build a patch set
including the snippet that Kacper posted earlier (1) in response to my
comment about not being sure how complicated all of this would be or
not?

[1] http://article.gmane.org/gmane.comp.version-control.git/208473

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59

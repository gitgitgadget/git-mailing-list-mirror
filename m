From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 1/5] Add test-script for git-merge porcelain
Date: Sun, 23 Sep 2007 12:24:03 +0200
Message-ID: <8c5c35580709230324m65c5399ds8c7ce21df4461e66@mail.gmail.com>
References: <1190421186-21784-1-git-send-email-hjemli@gmail.com>
	 <1190421186-21784-2-git-send-email-hjemli@gmail.com>
	 <7vwsuidx1a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 12:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZOdK-0008U9-9y
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 12:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbXIWKYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 06:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbXIWKYH
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 06:24:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:47943 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbXIWKYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 06:24:04 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1631215wah
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s85SwdsL6tMqDilbv1h7QChL7jjHLPulDsqMmo21e1E=;
        b=hFmC97NC/rQxr+P8NmUJrbNkTxlDWYol+NaSK3DTxTSv5NxvPryLjBvo98606eKgMna/QRvQhDMZIMMX45QjDkQ5o3VTmeMMSkokG4brV2u/67m6kR6SHHLAZV/fdQJJ4+18MDjM8QHOf9/fTukYtC+bBgLcPna2s2JokEGY5YU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J8/VMeF5oyq/4jx/dfYWoqF+o/ZynQg/rA41LmwqKC4mrVUrB00P5zXOqfn8G79IDpyySpTv+DXtcyrWY7Ij0iV2KKYrZ/AdJUlP2A2nujjahATpg05M5XXUSjQjRTf/JjuI06GawjebIHBQ1wkeERVLZhlW/uYjrlJS+NouRJk=
Received: by 10.115.72.1 with SMTP id z1mr4722977wak.1190543043516;
        Sun, 23 Sep 2007 03:24:03 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 23 Sep 2007 03:24:03 -0700 (PDT)
In-Reply-To: <7vwsuidx1a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58959>

On 9/23/07, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > This test-script tries to excercise the porcelainish aspects of git-merge.
>
> It does exercise; no need for "tries to" ;-).

Heh, ok

> > +     cmp -s file result.1
> > +'
>
> Unless there is a compelling reason otherwise, I'd prefer tests
> with a test vector like this to be spelled like this:
>
>         diff -u result.1 file
>
> That is, compare to show the difference actual output might have
> from the expected result.  It's easier to spot the difference
> when you later break things this way.

Good point, I'll change it.

>
> > +test_expect_success 'merge c1 with c2' '
> > +     git reset --hard c1 &&
> > +     git merge c2 &&
> > +     test "$c1" = "$(git rev-parse HEAD^1)" &&
> > +     test "$c2" = "$(git rev-parse HEAD^2)"
> > +'
>
> We might also want to test:
>
>  - the index is merged;
>
>  - the working tree matches the index;
>
>  - the merge message (e.g. "git show -s --pretty=format:%s
>    HEAD") is as expected;

Yes, sorry for being lazy ;-)  I'll add more thorough verification

>
> Otherwise I think it is a good idea to add these tests.
>
> By the way, I think squash_message() leaves a wrong message
> template for an Octopus, which might be worth fixing.

Ok, I'll try to detect it in the test-script and send a proper fix.

Thanks for the review.

-- 
larsh

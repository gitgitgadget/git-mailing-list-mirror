From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Mon, 27 May 2013 17:36:46 +0700
Message-ID: <CACsJy8Ct-ei7qbAW4qviQ6=q93ygxDcxRs9F3iHHV4-4Qz6qUA@mail.gmail.com>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org> <CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
 <7vk3mtwrq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 27 12:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uguns-0003iy-CI
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 12:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab3E0KhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 06:37:18 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47102 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab3E0KhR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 06:37:17 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so780359obb.22
        for <git@vger.kernel.org>; Mon, 27 May 2013 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=N8wzOWYxlqziteS7aUzXV8zMv5luFCo/2Fd04y2Ucjw=;
        b=BXKm1A6NOQV7o4YhjLy0+2yPH5L+PiBkaS8tcPY44RuVHLNULKbn0Sn51PvIWGeb7H
         66hdtFNgtt9slxF1/iD8MEuW/b1Ts08FBRZ6qzT3ftj2Hxon/FU2ImB7OOhv0Zt3BAsQ
         O117K9e6UBbQ9yRKkCKQZw++u1ZovHQXEUFf+OG0btCW42UT3hb8EsqFXE2HcX8m2+F7
         rr4ljbExQor2ZwuJWprDPMNm35RU5XWY1CsZZ+ByTY+/1DaO2tlxQ3ZGshakt2bxaCxG
         8sNcazc9uJMIKEU2YH4auMHZ9WPgKAJHlGMT40nYrCQQS22AhuXLm7pv6of/qrwcZvGv
         grxQ==
X-Received: by 10.182.118.226 with SMTP id kp2mr17582301obb.48.1369651037019;
 Mon, 27 May 2013 03:37:17 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Mon, 27 May 2013 03:36:46 -0700 (PDT)
In-Reply-To: <7vk3mtwrq9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225585>

On Mon, May 20, 2013 at 11:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Think why the user has such a hard to type ref in the first place.
> The user may have done this previously, thinking that he is detaching
> the HEAD to fix an earlier mistake in a branch:
>
>     $ BAD_COMMIT=$(git rev-parse nd/magic~8)
>     $ git checkout $BAD_COMMIT
>
> but by mistake gave a "-b" after "checkout", i.e.
>
>     $ git checkout -b $BAD_COMMIT
>
> After this, commands that want to work on branch name would still
> work as "expected", with the expectation being the user would be
> working on the refs/heads/$BAD_COMMIT branch, e.g.
>
>     $ git checkout $BAD_COMMIT
>     $ git branch -m $BAD_COMMIT nd/magic-fix
>
> but commands that want to work on commit object name will resolve it
> to the $BAD_COMMIT object (i.e. nd/magic~8), e.g.
>
>     $ git log $BAD_COMMIT
>
> and needs disambiguation if the user wants to work on the commit at
> the tip of the branch, e.g.
>
>     $ git log heads/$BAD_COMMIT
>
> So we really do want the users to notice and take corrective action,
> and one way to attract the attention of the users is to phrase the
> message more explicitly to let them know what is going on.

Point taken. I guess the message would be something like this?

Refname '%.*s' is ignored. It may be created by mistake.

Or should we be more elaborate?
--
Duy

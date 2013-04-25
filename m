From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 11:24:14 +0530
Message-ID: <CALkWK0mr55QwrcsvyeRzq1K0RgEB7YOxMRhz2kjckRGZe-Tz7A@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 07:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVF92-0002NG-DF
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 07:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab3DYFyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 01:54:55 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:38179 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3DYFyy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 01:54:54 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so3171792iej.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 22:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NzfUhpq8eHFKpnPz3s/aoOQhfI8hQQUa5QoRoWnmte0=;
        b=R79bYvfpX9Ynw/Eq+QA78QqKPueQD9Iewbfax55hHCEAtqqU3ec1FXX+Tn8uWuWWTe
         EvqihTYHB/2GxLUvrt3Do1PtI5C9xKJlHnvARVG7xH1i30utwjQIcASSw4t1wDdDKUV8
         fI9ycl2zxfI31+xLb6i8cqNXc3Iw2uz4VGg7Km4/pXHr0arLmNFv8N7WVnx247RxIX//
         ren0z9xZ90b6MbtZlohKi/gIoFt8ppgaVGkf/abaTW37VnKBuPsGzE3EyPXhtrcUH0o1
         7Q0h3fps6FKspZfLQewnz50Fs/1CP/ehYRll7rdbPZc4C3IM/wKRT1+A3WX1ZRl/rFjk
         5zlw==
X-Received: by 10.50.57.116 with SMTP id h20mr1628183igq.49.1366869294345;
 Wed, 24 Apr 2013 22:54:54 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 22:54:14 -0700 (PDT)
In-Reply-To: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222345>

Ramkumar Ramachandra wrote:
> 3. Even though I lashed out strongly against 'git diff A..B' because
> of inconsistency, I can't say that it's not useful (omit specifying
> HEAD on one side).  If we were to start over today, I would argue that
> 'git diff A ^B' and 'git diff B ^A' be handled as special cases to
> mean 'git diff B $(git merge-base A B)' and 'git diff $(git merge-base
> A B) B' respectively.  The normal 'git diff A B' should have nothing
> to do with this.  Plus, 'git diff A...B' is really an eyesore.  So I
> ask again: what can be done to improve the situation?

Okay, so my solution to this is:

1. Change the meaning of 'git diff A..B' (and A ^B, ^A B for
consistency).  Existing users might be using 'git diff master..' on
their feature branches to get meaningful output, and this will not
change.  'git diff featurebranch1..' on another feature branch doesn't
give meaningful output anyway, and I find it hard to believe that
users will complain if we change the meaning of this.  Okay, maybe we
want to do it in git 2.0?

2. Document (1) properly in gitrevisions.txt.

3. Deprecate 'git diff A...B'.

What do you think?

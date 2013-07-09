From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the incoming
 object to commit first
Date: Tue, 9 Jul 2013 18:12:14 +0530
Message-ID: <CALkWK0mJCGN3SzXTBksgeDZnA=bvEi-yeLn0mT_X9Z0o805+bw@mail.gmail.com>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
 <1373236424-25617-5-git-send-email-gitster@pobox.com> <20130709050615.GF27903@sigill.intra.peff.net>
 <7va9lwxpp5.fsf@alter.siamese.dyndns.org> <20130709053533.GA4395@sigill.intra.peff.net>
 <7vr4f8vtwc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 14:43:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwXFz-0006mm-Jy
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 14:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab3GIMmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 08:42:55 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50073 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3GIMmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 08:42:54 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so12885066ieb.10
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t8s+A+dKCRnBbjPG/h5oP21nKFM0D9XrdLszbyFTMEA=;
        b=CFgv1nFQv+8BfurNguyITL0yHieT4BoW9EHNYHhQF3idBWGBCMnm9cqQi1mDQ/nKAm
         ycp3ZbhJjalwUoNJTr3BWe/DIpXj8NwV+G7NBlCu32mtCGfb3LUKVcvv5t46ZziwAkBO
         7lLXFTMxJpS46OBt/5U6UzhRsQmvuoucpggL+anLD7/9g9GlNfG71NZD6F5V6qxE7mUs
         44dGjw1jflNiEP0o4BAd97aciyqV1Se8zz+eopSbQGNrrp+zEWsf4Em4VgUcfYMA7Oo1
         6UcIvvt1chPxFMeaj8n9CfSqveqzMgeDFr5a7+9/Y3OjCKalv1mfaKW5hWVC4JunQWjg
         VyAw==
X-Received: by 10.50.134.9 with SMTP id pg9mr1781237igb.29.1373373774480; Tue,
 09 Jul 2013 05:42:54 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 9 Jul 2013 05:42:14 -0700 (PDT)
In-Reply-To: <7vr4f8vtwc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229952>

Junio C Hamano wrote:
>     $ git describe $(git rev-parse v1.8.3)
>     v1.8.3
>     $ git describe --contains $(git rev-parse v1.8.3)
>     v1.8.3^0

This is a correct observation, and I've already submitted the correct
fix: "name-rev: strip trailing ^0 in when --name-only".

>     $ git describe --contains $(git rev-parse v1.8.3) a717d9e
>     v1.8.3^0
>     v1.8.3.1~9
>
> and these are internally consistent (they both roundtrip via
> rev-parse).  Stripping "^0" from the former will break the
> consistency, even though it may make the output look prettier, but
> the "--contains" output is not even meant to be "pretty" in the
> first place.

Incorrect.  The "--contains" output _is_ meant to be pretty.  That's
the whole reason name-rev --name-only was invented.

[2/4] is correct in that it fixes --stdin for annotated tags (although
the implementation could be simpler, and the commit message is
completely misleading).

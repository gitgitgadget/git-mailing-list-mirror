From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 17:43:24 +0530
Message-ID: <CALkWK0nho2SgK3sBibqvPJLhEQw=cSmX3rdQ5LiQTEQkMhRnoQ@mail.gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
 <1371130349-30651-6-git-send-email-artagnon@gmail.com> <7vvc5hubox.fsf@alter.siamese.dyndns.org>
 <CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
 <7vd2rpu3kf.fsf@alter.siamese.dyndns.org> <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
 <7vppvosstl.fsf@alter.siamese.dyndns.org> <CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
 <7v38sksq14.fsf@alter.siamese.dyndns.org> <CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
 <7vsj0kpsb0.fsf@alter.siamese.dyndns.org> <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
 <7v7ghwmi9x.fsf@alter.siamese.dyndns.org> <7v38skmgu8.fsf@alter.siamese.dyndns.org>
 <CALkWK0mCK_-bUapAvcrwtNgGnT1=x1d=+J9RO1GK6ssHWP2ztA@mail.gmail.com> <7vobb7lmpi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 14:14:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnpMw-0003a0-8Z
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 14:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab3FOMOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 08:14:06 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55676 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab3FOMOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 08:14:05 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so3327057ieb.24
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XP7CEIHKcJ5G0sm86R+SLDRTB02ymo1gIMhpjpgLCzA=;
        b=VGw4+fUlrlGy2D+jud4gwyjPpqq0+DzfcrzNNgZ9Mo6txlMSB4nDGgnzGUFq1ur3s4
         aTDxTmAyPzcgh8Eyct/spIhLYLWLjq+xKBiajxoUfsMwjp1u1IIn6KA2SPyjyJ8QOEAW
         39iYH97RsZ8w0foAQ1Ew/upqlf265HdDzdHb93cB9s0Di0fu9Sl8fQhabfXWiXO8pBBV
         vCOiLaLKaHDDHrLZin82EVWPibXn9kDmp28XCzj5YpAvfYlc2ToBoQ0nRs5mVbYzoC7K
         9Dyp1ysGaCZrRo3jOJFMxuUlV0W44orK9gifVmCHVnOMI9x4c6I+rLfmWOStQ00cnMH3
         /CEw==
X-Received: by 10.50.79.231 with SMTP id m7mr944272igx.40.1371298444367; Sat,
 15 Jun 2013 05:14:04 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 15 Jun 2013 05:13:24 -0700 (PDT)
In-Reply-To: <7vobb7lmpi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227944>

Junio C Hamano wrote:
> The first line from status in the middle of
> a rebase is secondary.  End-user initiated "checkout" to detach is
> the primary thing.
>
>> 3. The problem is not unique to rebase at all; yet you have
>> special-cased it.  If this isn't a band-aid, what is?
>
> It is an illustration for approach (2) in the other message.
>
> In the longer term, you would want richer status output for various
> detached state, and that "how about this" patch shows where new code
> to support other cases should be added.

Fine.  If that is what you want, we'll have to special-case every
known script-in-progress to stop writing the usual "HEAD detached
from" message.  That'll leave out only the "end-user cases", where you
argue that the message is helpful.

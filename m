From: Elijah Newren <newren@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Wed, 15 Sep 2010 17:34:43 -0600
Message-ID: <AANLkTi=FePrE6gpwiaxqDfw0f7Jk=mb-sTe-XR6-sKXM@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
	<7v62y661pl.fsf@alter.siamese.dyndns.org>
	<AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:34:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow1V4-0006lo-7W
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab0IOXep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 19:34:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60490 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316Ab0IOXep (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 19:34:45 -0400
Received: by bwz11 with SMTP id 11so1067937bwz.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aBaFJhf+mTLQ2RKLt6SacxGq/gXlcMkZTLYdTDaSTkc=;
        b=gDZSeDvyg1X1a+yXeEYjgPhSquzw8/8ADQUN2qLEpxU3JFqfK+2yngRC+26I4C85cY
         AOvefZmXEzMeIYoTJogEfRQKgQrIG4tSzXlkMKGsh2H20ISXdMwVF6uB48+FqyJp+9UR
         pj4TODOSYlq/ct8Pn4H3NsVQWGGK4h4tkmbQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lqpSdMhfsyvM7t2xraOko3YGGoxkRxMDekwLmh305kncwOr7xHAuKqoCEQbcS4j2lK
         56EIo4HVpP0z7+ngSqNnCo8y6CKwzcGvzesE1sALKCiX4WCT+le819Q9Bjzr0LX8Avv9
         OOvJ6wnanWa/wdojXsI9CQaAkTs8ton3nAaOo=
Received: by 10.223.122.143 with SMTP id l15mr1040044far.44.1284593683722;
 Wed, 15 Sep 2010 16:34:43 -0700 (PDT)
Received: by 10.223.120.131 with HTTP; Wed, 15 Sep 2010 16:34:43 -0700 (PDT)
In-Reply-To: <AANLkTimYNtU7sHn4_Vx50evTWDpMK_=XgshU3ZzT+eVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156276>

On Wed, Sep 15, 2010 at 5:19 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> I want cached paths, minus the exclude pattern. Using -c -x \* gives
> the same result.
>
> There is no indication in the man page that -x doesn't apply to -c.

That caught me too.

<snip>
> Bah, what use is that? Minimally ls-files shouldn't accept -x unless
> given either --ignored or --others if that's all it applies to. I
> guess this is my itch to scratch.

I ran into the same thing earlier this week and came up with a patch
similar to Nguyen's (though I just restored it closer to what Johannes
originally had there), before I discovered that this was an
intentional change by Jeff.  (And then I tabled it to get back to work
on fixing up merge-recursive some more)

I can't say I really understand the changes from b5227d8 and 500348,
though; I found (and find) it confusing as well.  I did notice that
restoring the old behavior didn't work very well with items below the
current directory, so it'd take a bit more work than just restoring
the original behavior.


Elijah

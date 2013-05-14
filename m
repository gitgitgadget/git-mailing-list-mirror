From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 17:39:02 -0500
Message-ID: <CAMP44s0u0WPNneM-GoiqCkWTC-CT_Xa2z3on=smRiFJdd9ffeQ@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
	<7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNsI-0007hj-QM
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565Ab3ENWjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:39:06 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:42562 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab3ENWjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:39:05 -0400
Received: by mail-la0-f41.google.com with SMTP id lx15so1119193lab.14
        for <git@vger.kernel.org>; Tue, 14 May 2013 15:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Fzw0TbGrnNAbsbLmFak6Bn7EhoO4/XNNkG2jKgE2r/U=;
        b=if6AWilU2hbutP+xDJg0YWQFJ47xVY+TMOQ4SAo1XcxfjOfoEY2pN42tX6250hA3qG
         /bw1L3oWi1h1wcuqfOtwngK0XTKJ32AMDO+OnEYtUfCk5fMX5z3QQ5y7vTF7jwko2tBL
         M+CNJaahUZHVZ/Q0RBY10Gt6YlkKnL1VDaoTjD/MIKmX2s6uiUQ4QO3Yix2PqruyZEXR
         dgzJ/HxQsOzI4qESjsrDSktS4rM7oldE/xpA3xKaSSB//vMNo1xDsQo8nAUL0xi6GiGp
         vAwaWmxaT2DxUnD6cGQZxJL5OZjHE155WE4mYlG28levw+cM1NLScXLqseShBQrZSvJ/
         eESw==
X-Received: by 10.152.120.4 with SMTP id ky4mr16681406lab.5.1368571142329;
 Tue, 14 May 2013 15:39:02 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 15:39:02 -0700 (PDT)
In-Reply-To: <7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224363>

On Tue, May 14, 2013 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, May 14, 2013 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Without this fix, the user would never ever see new bookmarks, only the ones
>>>> that (s)he initially cloned.
>>>
>>> Now, think again and realize how long it took you (the original
>>> author) to discover issues and come up with these fixes and
>>> explanation since the series was merged before -rc0.
>>
>> This issue has *always* been there, it's not a regression.
>
> Then why are you rushing it?  -rc is a "regression-fix-only" period.

I'm not rushing this patch, I'm rushing the regression fix. I added
the cleanup patches because they help the fix, and I added this patch
because it's obviously good.

>> Define "ready". It's probably more "ready" than any other bridge
>> tool out there.
>
> Anything that needs "oh, we need to push these ten patches to avoid
> regressions at the last minute" is not mature enough to be relied
> upon by end users for everyday use.  That is what I meant.

Only a single patch is needed to fix the regression and I sent that
patch standalone in v2 of this series, but you didn't pick it, so I
sent the cleanups as well.

> But now you are saying these are not regression fixes, in which case
> they have to wait because the users have known about the limitations
> that existed for a long time and learned to live with them.  That is
> a sign of mature (not "not ready") software.

No, they don't have to wait. And we don't have to mindlessly apply
guidelines as dogma.

The reason for the "only regression" period is to avoid more
regressions. If you show me how any of the fixes I sent in this series
could potentially cause a regression, I would agree with you, even if
remote, the possibility would be there, therefore the patch wouldn't
be material for 1.8.3.

But the fact of the matter is that the possibility is not there, we
are not decreasing the possibility of regressions, we are simply
removing a feature users could enjoy for no gain at all.

> You cannot be both.  Which is it?

I marked the patch that fix a regression as such, I marked the patches
that are obvious fixes with no possibility of regressions as such, and
I marked the trivial cleanups with no possibility of regressions as
such.

-- 
Felipe Contreras

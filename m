From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 09:35:08 -0700
Message-ID: <xmqqd20ecw1v.fsf@gitster.dls.corp.google.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<CAP8UFD0Zzjcc94qcUJOpfSrTej-o6hRKzZOuTufzAbOPkjUr_A@mail.gmail.com>
	<vpq7fqppn5h.fsf@anie.imag.fr>
	<xmqq8ub5f0z2.fsf@gitster.dls.corp.google.com>
	<vpq381aetas.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:35:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9c1e-0003ku-6U
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 18:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbF2QfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 12:35:14 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36141 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbbF2QfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 12:35:11 -0400
Received: by igrv9 with SMTP id v9so32926525igr.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QwFLLeobweXHUVOw+qZRda830avLctsLoivSw0jng8Y=;
        b=yjbmL2atal4MzSwC5HjaOoOTh2vzqbV+vaIu5XTTcqiI7u7w6H4bFn22L6k9pnKPu4
         rp+A/9ywYYfBEfUsbZjoGD/gofXQ57h6wWhKkFdqL+aEI/KGPwjux637xbhTyEpIUGfL
         dbZeCczFx9Vx3+nVNJhO1DkaBqIDyZXSmOb2cQWonpeNuVIbei/poPUlIdBRntRUZV2w
         abO2l68GBf5aYPArocJqZf2gvlXCe62wqpxeSh5Au01VBPWanEKy+GuCt5LcG+jJ7HSy
         x1hR2utCA8tWFjeWbKLRrtrb/B6T8tk3pt76LsqmpIJrXy7DyaUOqhkVE+69g7hCRhq1
         R3zw==
X-Received: by 10.43.33.142 with SMTP id so14mr18589117icb.36.1435595710981;
        Mon, 29 Jun 2015 09:35:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id e69sm28042324ioe.11.2015.06.29.09.35.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 09:35:10 -0700 (PDT)
In-Reply-To: <vpq381aetas.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	29 Jun 2015 11:51:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272970>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I moderately hate to see both from aesthetics point of view, but can
>> we at least lose "--name-" prefix?
>
> I changed it to --term- prefix, but I'd rather not drop it. When reading
> "--old=foo", it is not clear to me whether the meaning should be "the
> term used for old is foo" or "mark foo as old". The longer version does
> not have this problem.

Yeah, my suggestion was based on one assumption I did not mention,
which is that we do not need to crowd "bisect start" with this
option when we have "bisect terms", as long as "bisect start" does
not have to take both "what are the terms" and "which commits are
painted using which one of the two terms" on its command line, the
"--name-" prefix was unnecessary.

But if you are dropping "bisect terms" and allowing the terms
specified only from "bisect start" as you mentioned in the cover
letter of v11, that changes the equation.  And I think "start is the
place that sets up a clean slate, and that is the only place where
you can optionally declare your custom terms" is a very sensible
design.  I do not have a problem with "--terms" prefix in that case.

Thanks.

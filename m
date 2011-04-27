From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Use floating point for --dirstat percentages
Date: Tue, 26 Apr 2011 21:53:00 -0700
Message-ID: <BANLkTikWhRiDaojR2NipcP0kpP49we5iUQ@mail.gmail.com>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-6-git-send-email-johan@herland.net> <7vpqo9ez03.fsf@alter.siamese.dyndns.org>
 <201104270402.29085.johan@herland.net> <7vipu0b8zy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 06:53:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEwkl-0001zy-4e
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 06:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab1D0ExZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 00:53:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34496 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989Ab1D0ExZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 00:53:25 -0400
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3R4rNuP027775
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 26 Apr 2011 21:53:24 -0700
Received: by eyx24 with SMTP id 24so395205eyx.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 21:53:20 -0700 (PDT)
Received: by 10.14.1.71 with SMTP id 47mr716513eec.128.1303880000157; Tue, 26
 Apr 2011 21:53:20 -0700 (PDT)
Received: by 10.14.124.148 with HTTP; Tue, 26 Apr 2011 21:53:00 -0700 (PDT)
In-Reply-To: <7vipu0b8zy.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-103.466 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172165>

On Tue, Apr 26, 2011 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If that is the case, I would rather not see us use floating point for
> this.

Considering that we still just output with a tenth of a percent
granularity, I'd suggest just continuing with using permille
internally - including for the limit.

So instead of actually using floating point, just parsing a single
digit worth of fractional percent would be beautiful. IOW, being able
to say

  --dirstat=1.5

to give a 1.5% cut-off point would be really nice - but then
internally just saying "15 permille" and using integers all the way?

Doing all the fake floating point by hand also obviously then avoids
the whole LC_NUMERIC locale issue.

                        Linus

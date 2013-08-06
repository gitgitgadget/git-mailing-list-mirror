From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/3] OS X: Fix redeclaration of die warning
Date: Tue, 6 Aug 2013 04:30:35 -0700
Message-ID: <CAJDDKr5_SU_yyWCyOHtP2nTYVe48e8-JOvR0hG5=WJjLBkOHWw@mail.gmail.com>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
	<1375718364-13824-3-git-send-email-brian@gernhardtsoftware.com>
	<7vwqo0j9us.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 13:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6fTM-0004i6-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 13:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab3HFLag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 07:30:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:60213 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492Ab3HFLag (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 07:30:36 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so599333pab.21
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DWZx3KcQR1+1kd/sfbdAxKqnSuCsdIwPtfgzLVvTd3s=;
        b=0VCsXmsMVNMsO90zq5Rqi03WpFuSHKG1RYGKBnFbg4jExYF88Hl5uBy7QrRXk3HHvX
         pp8VG4DQWPJWiHgopvxkbBS7JR1YTpkX55TwnGog2Vf24qVyVF5oOZQN1Op7nKg+MGqf
         rIhfQW8Vj+dc/htzx/hvvdxDXUuSkukE63V73MfuoW1PyPFMOY7x0FDxmlZiEuAFZQaM
         etgoGXSuciNuWke5klhffdf8VzVK6soOLL8ez5G1pG7Bad9n19+XXvIWZg54bca1Yesx
         V2jFmII9TrqrjHoLDD0q0WjdrLrVug2fmqI92GfWwDxqkXf3oqo6VGrhOnMjQ/gjUG1p
         Hzfg==
X-Received: by 10.66.155.102 with SMTP id vv6mr2698272pab.89.1375788635583;
 Tue, 06 Aug 2013 04:30:35 -0700 (PDT)
Received: by 10.70.95.230 with HTTP; Tue, 6 Aug 2013 04:30:35 -0700 (PDT)
In-Reply-To: <7vwqo0j9us.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231734>

On Mon, Aug 5, 2013 at 11:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
>
>> compat/apple-common-crypto.h uses die() in one of its macros, but was
>> included in git-compat-util.h before the definition of die.
>>
>> Fix by simply moving the relevant block after the die/error/warning
>> declarations.
>
> Puzzled.  What needs fixing???
>
> Ahh, that one is not just making #define macros, but defining static
> inline functions.
>
> I wonder if they need to be static inlines to be duplicated at each
> call sites in the first place.  Wouldn't it be better to create a
> compat/something.c file to be linked with?

IMO it's not worth it right now because there's only a single call
site (imap-send).  The moment another call site is introduced then
compat/apple-common-crypto.c would be the natural home for it.
-- 
David

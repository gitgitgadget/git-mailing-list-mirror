From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH 3/3] Makefile: avoid deprecation warnings on OS X 10.8
Date: Thu, 9 May 2013 16:21:55 -0700
Message-ID: <CAJDDKr5=tQu-TWaBKiwUzCKF5+=P6360puEgY_o9DtsbfQz1Vw@mail.gmail.com>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
	<1368090810-40596-2-git-send-email-davvid@gmail.com>
	<1368090810-40596-3-git-send-email-davvid@gmail.com>
	<20130509151436.GJ25912@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	"Theodore Ts'o" <tytso@mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 10 01:22:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaa9x-0004TH-Ok
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265Ab3EIXV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:21:57 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:63965 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab3EIXV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:21:56 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so3426155wgg.8
        for <git@vger.kernel.org>; Thu, 09 May 2013 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ahRzM+O4OfK7fQmpqwKZ4tYKaqB8Z0GF5UVGc6YKFyA=;
        b=y2qzRFp6AgeE7MqQ9v/1pVeeF5/KzgEax75Yb8XesDHH4quEH+rpahp9LcgpYb881G
         n+Edo5sXP9S/ykcGvvK+xuTR3wvIX8vS+aWTVoaBSkHpWwOVBstYQcCjVWH9xCH03lrR
         ViBrg1knews//HsGF36E99bSXATgwvXt/IL8Tf49/wC0BGzYLnTGfqcyc4D2IiS1fhRR
         ZZJW2t93OS6fwQMma8Q8ghXMQpWCc3zJhuXDYkuoj13ee89c5uZ0vC+DYfMCH00/xTBI
         MfrH6/4EtV1MepU3Y9ld7i4M+uTuU3HBeqwbah7e8jt1lZU05M3RRzVpgrjJCridrNpn
         Jfvg==
X-Received: by 10.180.105.195 with SMTP id go3mr269361wib.2.1368141715529;
 Thu, 09 May 2013 16:21:55 -0700 (PDT)
Received: by 10.194.240.195 with HTTP; Thu, 9 May 2013 16:21:55 -0700 (PDT)
In-Reply-To: <20130509151436.GJ25912@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223802>

On Thu, May 9, 2013 at 8:14 AM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, May 09, 2013 at 02:13:30AM -0700, David Aguilar wrote:
>> Mac OS X Mountain Lion prints warnings when building git:
>>
>>       warning: 'SHA1_Init' is deprecated
>>       (declared at /usr/include/openssl/sha.h:121)
>>
>> Silence the warnings by disabling OpenSSH in favor of BLK_SHA1.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> I know I can create config.mak, but do we prefer to have the default
>> settings be warning-free?  I do not see any other platforms that tweak
>> NO_OPENSSL themselves, hence "RFC".  Is there a better way to do this?
>> Are there any Darwin/PPC users that would be harmed by this patch?
>
> Disabling OpenSSL also has the effect of disabling SSL support in
> git-imap-send.  Does enabling BLK_SHA1 instead also remove the warnings?

Thanks.  Yes, setting BLK_SHA1 does eliminate the warnings.

I'll re-roll this patch and send it independently.
It's unrelated to the mergetool stuff so apologies for the wide
initial Cc: list.

> Alternatively, it seems that the recommended update is to use Apple's
> CommonCrypto library, as in this patch:
> https://gist.github.com/anonymous/4466305

It seems like we'd want something like this in compat-util.h or
somewhere similar.  That'll be a bigger change so I'll try the
BLK_SHA1 approach first since it is minimally invasive.  This would be
nice to tackle once the dust has settled a bit.
--
David

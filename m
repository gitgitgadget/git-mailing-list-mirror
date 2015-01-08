From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] configure.ac: check for clock_gettime and CLOCK_MONOTONIC
Date: Thu, 8 Jan 2015 00:54:38 -0500
Message-ID: <CAPig+cSHTuNv8nFiZ4yKrypGW4n4EMtucX-SfZE927d=u40P=Q@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-3-git-send-email-reubenhwk@gmail.com>
	<CAPig+cSx9FZtn=RH25OX97EBmbnKfVT66WsgtqenVZpm8LBjHQ@mail.gmail.com>
	<CAD_8n+TzLhQh0MaE6NJado-mb=ceywWGSA=fhUViR6D3woVXbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 06:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y963Z-0007QR-W4
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 06:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbbAHFyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 00:54:39 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:53449 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbbAHFyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 00:54:39 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so352367yho.5
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 21:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9R3l8WOO+eP3/M+AuNbWbAPEByjju34WwqN/r7kyz+M=;
        b=EvrlpoGXEcgMmHWGEDCd14ZoLfEtS++7fEYifWh9n/8nT/L1+fiFIDR6bmMVtqctC3
         xu0T75p0FPbVit8K6PP8aWz34W0xWebMJ/KyJ4G+TGnKzz8SYzCha9THdgOfZSthTQn6
         SimpBEo8trTZwgxW4vGRBOqJj8UYYGAD1BPx/zmmIkLNleduNzhyb77SJkbNYAcBCoFL
         +/RLCwKVnYvdkAA5YIUE7JZgLDOMl/s/zq0wzmvcmDSGNoISDGmQzWajW0spClqFxzuz
         JdoqKtXsbOBO1qwwwduXEx1oWQe7RyKGFluTSfWcyuFboW7foA9wcx4mVwiUL1NTxZuL
         eSDg==
X-Received: by 10.236.8.6 with SMTP id 6mr5190719yhq.112.1420696478563; Wed,
 07 Jan 2015 21:54:38 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Wed, 7 Jan 2015 21:54:38 -0800 (PST)
In-Reply-To: <CAD_8n+TzLhQh0MaE6NJado-mb=ceywWGSA=fhUViR6D3woVXbg@mail.gmail.com>
X-Google-Sender-Auth: ypoNIeHyM6_VBtyKV6WF5xrZVTo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262183>

On Wed, Jan 7, 2015 at 5:31 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
> On Wed, Jan 7, 2015 at 1:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
>>> +GIT_CHECK_FUNC(clock_gettime,
>>> +[HAVE_CLOCK_GETTIME=YesPlease],
>>> +[HAVE_CLOCK_GETTIME=])
>>> +GIT_CONF_SUBST([HAVE_CLOCK_GETTIME])
>>
>> You could simplify the above four lines to this one-liner:
>>
>>     GIT_CHECK_FUNC(clock_gettime,
>>         GIT_CONF_SUBST([HAVE_CLOCK_GETTIME], [YesPlease]))
>>
>>> +AC_MSG_CHECKING([for CLOCK_MONOTONIC])
>>> +AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
>>> +       [AC_MSG_RESULT([yes])
>>> +       HAVE_CLOCK_MONOTONIC=YesPlease],
>>> +       [AC_MSG_RESULT([no])
>>> +       HAVE_CLOCK_MONOTONIC=])
>>> +GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC])
>>
>> Ditto regarding simplification:
>>
>>     AC_MSG_CHECKING([for CLOCK_MONOTONIC])
>>     AC_COMPILE_IFELSE([CLOCK_MONOTONIC_SRC],
>>         [AC_MSG_RESULT([yes])
>>         GIT_CONF_SUBST([HAVE_CLOCK_MONOTONIC], [YesPlease])],
>>         [AC_MSG_RESULT([no])])
>
> I *think* there's an issue with this simplification as used right
> here.  In the 'no' case, HAVE_CLOCK_MONOTONIC *must* be undefined by
> setting it equal to nothing
>
> HAVE_CLOCK_MONOTONIC=
>
> So that the setting in config.mak.uname 'HAVE_CLOCK_MONOTINIC =
> YesPlease' will be overridden.
>
> So this one needs to stay as is.

Yes, you're right. That means that the HAVE_CLOCK_GETTIME
simplification also suffers the same shortcoming. So, neither
simplification is appropriate in this instance. Sorry for the noise.

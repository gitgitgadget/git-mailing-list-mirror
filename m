From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t5004: test ZIP archives with many entries
Date: Fri, 28 Aug 2015 12:47:30 -0400
Message-ID: <CAPig+cQzpo=dXxaWmR6AZ2UerZXYzTfMXZQwckrkPmWdDp_wqQ@mail.gmail.com>
References: <20150811104056.16465.58131@localhost>
	<55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost>
	<55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
	<CAPig+cSNSfpt7gOLvz7P4oDrNF5fTQ38v1pfncJU3h7a6FjMyQ@mail.gmail.com>
	<xmqqwpwf2z8c.fsf@gitster.mtv.corp.google.com>
	<xmqqsi732yod.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Schauer <josch@debian.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVMoR-0002Hw-Kw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 18:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbbH1Qrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2015 12:47:31 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:36456 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbbH1Qrb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2015 12:47:31 -0400
Received: by ykek5 with SMTP id k5so7286587yke.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=1hRo/lOnZoWl0Y7i+kD8M5MRZnDsvBwSFrjh9Z53uR8=;
        b=TSociZJfM/Kgh1KnSb8truCjvR6EHiOEinEIY1R29BL7gN70mI9dT7BWvA58FNgWAO
         BQu94oPx5KSUCrSQuHX2HsprThiidw7CqCdqDPWy9ubHKiaN9YdQIEjvPNMoi7r1lJEv
         DlRAEYgKAGFqmXCNhqcmna6OPHR2rhGr9ZKye4TN4NiYTXkjKaR2/ik5JxAfQzXE1Sh6
         l/kD2v6m/XNICU6fK6srT6OttyUVV20EGwSZybs7D4deH8oa31CV04Vha3DLbHZ9KAz/
         pIVCwcfnpQm6vOziE7oSLfjl62Ck9D1iYOM3GEPrB1e0tax55kP9RIwRag51svG3K1aW
         mQwQ==
X-Received: by 10.129.83.136 with SMTP id h130mr10033392ywb.95.1440780450456;
 Fri, 28 Aug 2015 09:47:30 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 28 Aug 2015 09:47:30 -0700 (PDT)
In-Reply-To: <xmqqsi732yod.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: d1EXekbEhEOIFEsBFdC7iYllSfo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276728>

On Fri, Aug 28, 2015 at 11:57 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> On Sun, Aug 23, 2015 at 5:29 AM, "Ren=C3=A9 Scharfe" <l.s.r@web.de>=
 wrote:
>>>> I suspected that zipinfo's output might be formatted differently o=
n
>>>> different platforms and tried to guard against it by checking for =
the
>>>> number zero there. Git's ZIP file creation is platform independent
>>>> (modulo bugs), so having a test run at least somewhere should
>>>> suffice. In theory.
>>>>
>>>> We could add support for the one-line-summary variant on OS X easi=
ly,
>>>> though.
>>>
>>> Probably, although it's looking like testing on Mac OS X won't be
>>> fruitful (see below).
>>
>> Can we move this topic forward by introducing a new prerequisite
>> ZIPINFO and used at the beginning of these tests (make it a lazy
>> prereq)?  Run zipinfo on a trivial archive and see if its output is
>> something we recognize to decide if the platform supports that
>> ZIPINFO prerequisite and do this test only on them.
>
> Heh, that is exactly what the patch under discussion does.  So...
>
>> After all, what _is_ being tested, i.e. our archive creation, would
>> not change across platforms, so having a test that runs on a known
>> subset of platforms is better than not having anything at all.
>
> ...I'd say we can take this patch as-is, and those who want to have
> a working test on MacOS can come up with an enhancement to the way
> the script parses output from zipinfo that would also work on their
> platforms.

Right, the new test is correctly skipped on Mac OS X and FreeBSD, so
the patch is suitable as-is. We might, however, want to augment the
commit message with some of the knowledge learned from this thread.
Perhaps modify the last sentence of the second paragraph and then
insert additional information following it, like this?

    ... at least provides
    *some* way to check this field, although presently only on Linux.

    zipinfo on current Mac OS X (Yosemite 10.10.5) does not support
    this field, and, when encountered, caps the printed file count at
    65535 (and spits out warnings and errors), thus is not useful for
    testing. (Its output also differs from zipinfo on Linux, thus
    requires changes to the 'sed' recognition and extraction
    expressions, but that's a minor issue.)

    zipinfo on FreeBSD seems to have been retired altogether in favor
    of "unzip -Z", however, only in the emasculated form "unzip -Z
    -1" which lists archive entries but does not provide a file
    count, thus is not useful for this test.

(I also snuck a s/can// fix in there for the last sentence of the
second paragraph.)

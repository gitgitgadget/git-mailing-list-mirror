From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 04/10] ref-filter: support printing N lines from tag annotation
Date: Sun, 26 Jul 2015 10:45:09 +0530
Message-ID: <CAOLa=ZRGNPBA6bOOG+KQafW02bjcTEJdU4BJ7hVzNDL7n9Hf7Q@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-5-git-send-email-Karthik.188@gmail.com> <CAPig+cS92cJ=OmaG2_HWNXNq9-D5V4f032WqeU0SVh_XCtxpXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 07:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJEHr-0002lc-Fq
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 07:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbbGZFPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2015 01:15:41 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34998 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbbGZFPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2015 01:15:39 -0400
Received: by oihq81 with SMTP id q81so37485520oih.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 22:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C71nGMeiFcPEYLxlV0krnXB1Y2HqDmHsL2At73hrUKs=;
        b=LWhpiiD8lw7XQ1y/3P5Ljq/A2BVtslRItKTupx8HNGz8rA2bEhVfPnbKMHE0eGjzbW
         TyvUvMN84Wg+8e8LzAW+bi29UylsUxnuJticxEboKX4iLFAYnGrf5gKa4EIqirB/AYU7
         LG3Ylz7O9lpPCSiY67Bz8PZOe77JEbnrNfDKLxi4QE2/Abj1+oUdKgIeN4E1DnK5Bbm/
         WjjDNdBMPwjL6diDNKaU1y1K8P1pPMEJ1WPI0LhXHiMDdjhbm3G1Vsdm7hiZ3kyuPhZP
         cU121VYG4jF966AnZDrKbrMJuBBCIk+yEysED4DaQQqjeaFvV4TTKZzBNnT4LG7Aec8J
         pPHw==
X-Received: by 10.202.73.198 with SMTP id w189mr21189099oia.102.1437887738521;
 Sat, 25 Jul 2015 22:15:38 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 25 Jul 2015 22:15:09 -0700 (PDT)
In-Reply-To: <CAPig+cS92cJ=OmaG2_HWNXNq9-D5V4f032WqeU0SVh_XCtxpXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274634>

On Sun, Jul 26, 2015 at 10:16 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jul 24, 2015 at 3:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> In 'tag.c' we can print N lines from the annotation of the tag using
>> the '-n<num>' option. Copy code from 'tag.c' to 'ref-filter' and
>> modify 'ref-filter' to support printing of N lines from the annotation
>> of tags.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  builtin/for-each-ref.c                             |   2 +-
>>  builtin/tag.c                                      |   4 +
>>  ref-filter.c                                       |  51 ++++++++-
>>  ref-filter.h                                       |   9 +-
>>  ...ter-add-option-to-align-atoms-to-the-left.patch | 124 +++++++++++++++++++++
>>  5 files changed, 186 insertions(+), 4 deletions(-)
>>  create mode 100644 v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
>
> Somehow you managed to "git add" and "git commit" your v3 patch 1 file
> inside this v4 patch 4/10.

Ya! removed it, thanks.

>
>> diff --git a/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
>> new file mode 100644
>> index 0000000..350acae
>> --- /dev/null
>> +++ b/v3-0001-ref-filter-add-option-to-align-atoms-to-the-left.patch
>> @@ -0,0 +1,124 @@
>> +From 3a07ca1f56f74ca54b7f3c30e3dfd9fe2fed1cc3 Mon Sep 17 00:00:00 2001
>> +From: Karthik Nayak <karthik.188@gmail.com>
>> +Date: Wed, 10 Jun 2015 17:19:55 +0530
>> +Subject: [PATCH v3 1/9] ref-filter: add option to align atoms to the left
>> +
>> +Add a new atom "align" and support %(align:X) where X is a number.
>> +This will align the preceeding atom value to the left followed by
>> +spaces for a total length of X characters. If X is less than the item
>> +size, the entire atom value is printed.
>> +
>> +Helped-by: Duy Nguyen <pclouds@gmail.com>
>> +Mentored-by: Christian Couder <christian.couder@gmail.com>
>> +Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> +Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> +---
>> + ref-filter.c | 41 +++++++++++++++++++++++++++++++++++++++--
>> + ref-filter.h |  1 +
>> + 2 files changed, 40 insertions(+), 2 deletions(-)



-- 
Regards,
Karthik Nayak

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed, 8 Jun 2016 04:13:15 -0400
Message-ID: <CAPig+cR8+ekOv3xuj1Nn9ftA5smHG78wdFp1Xnfz_qyrstKRqw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com> <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
 <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:13:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYcH-0005ZD-FX
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbcFHIN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:13:27 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35369 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161760AbcFHINR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:13:17 -0400
Received: by mail-io0-f194.google.com with SMTP id n127so373708iof.2
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2xS3qNqhNl0cnogqw99267CcmoEzVsdOj8stas9CZmw=;
        b=rWkCPACmltdVTr0JJifz9QNKUtJg5Ja4ZJ7KMi8tSHJMETBoMuD4DBZNWdGcplNJdV
         Zbot6mvEC7MC6T62wHmmGRcrNo2JTWdcZZ0nrdk7BB/64A2OypGYIL0zlVT8YCHY/aKL
         L+NmNxmOgzcwYSvNnflLlmMhAb0XmQIE8j2laXKT+u+7IZ7UHtJse5LXkrrOJEOS/gMS
         sdPQxBfkdLstCuzYoVEAvD5E5EY1xVB7croCqSJSNlPtZV9m+NLOJQ11w1INojYKyDUZ
         OELAGjG4T/tv5b7HUO/lKaljSOBjqM0PXVKkBqr04rp1+l04o/qUxIgEPUwmx5KFrdz+
         v6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2xS3qNqhNl0cnogqw99267CcmoEzVsdOj8stas9CZmw=;
        b=da32mNbxFqCqTh9BkXrL/GrYn6RzA0TN/SdHefmr/P2u9BR8JLqYX1Q1LD/GB+PWNV
         nERXMiNPF0VkeMq4KDRpq2dt3Pbwv7SkzHieBxWotUyY6K1gxuhY2RmgraSJtipgoiYc
         Nc7xmMOPJDGtgeCRiMdQOmYpxFfJq4QhnAtxtXHdD237OdhEbwAZdezsGHn6f2J/qG+j
         d6on0bIDSxcLHQr7sF6v4Mt1TMrzINwMOGMOnnCjKdcjzkgwbl48JEW2pNes5HhLKbmp
         eaw+sUHQn2AK2pAeeJe+4VVRcncTYzeROSMu+tUUkX+bFv8XG5rx/0hOjvScXB024lSS
         PdHA==
X-Gm-Message-State: ALyK8tL3wLldTKJxhtAn72nJFpRYV4Welg7u3ebtMBq8FLITTzDbHVt6DtKOmX/eIUybO8eaFeL0tYNvHd0u8w==
X-Received: by 10.107.132.40 with SMTP id g40mr6680208iod.34.1465373596523;
 Wed, 08 Jun 2016 01:13:16 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 01:13:15 -0700 (PDT)
In-Reply-To: <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com>
X-Google-Sender-Auth: IteVWm2w4ayw4kE8a7ISHZULKfM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296768>

On Wed, Jun 8, 2016 at 3:57 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 1:07 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> dir: introduce file_size() to check the size of file
>>>
>>> At times we require to see if the file is empty and get the size of the
>>> file. By using stat we can get the file size without actually having to
>>> open the file to check for its contents.
>>
>> The sole caller of this function in patch 4/4 does so only to check if
>> the file exists; it doesn't even care about the file's size, thus
>> neither this function nor this patch seem justified and probably ought
>> to be dropped unless some better and stronger justification can be
>> shown.
>
> Umm, actually there is a subtle difference between file_exists() and
> file_size(). file_exists() *only* checks whether the file exists or
> not while file_size() can also be used to check whether the file is
> empty or not also see the implementation of both of them which shows
> the difference. In fact it doesn't care at all about the file size.
> Now there are a lot of instances in shell scripts where there are
> quite some differences with -f and -s and some places *do care* about
> this subtle difference. For eg. in bisect_reset() we test whether the
> file .git/BISECT_START has some contents in it. But I guess I can add
> some more justification in the commit message. What do you think?

See my review of patch 4/4 which points out that C bisect_reset() does
*not* presently care about the file size, which is probably a bug
since that doesn't match the behavior of the shell code it's replacing
(which does care that the file is not empty).

I think this would be clearer if you instead added a function to
bisect--helper.c which operates at a semantically higher level than
what you have here (and drop this file_size() function). Specifically,
add a function which tells you precisely what you want to know:
whether the file exists and has non-zero size. For instance, in
bisect--helper.c:

    static int file_empty_or_missing(const char *path)
    {
        struct stat st;
        return stat(...) < 0 || st.st_size == 0;
    }

Or, if you have more cases where you want to know that it exists with
non-zero size, then name it file_non_empty() and reverse the sense of
the return value.

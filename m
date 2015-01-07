From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: Re: [PATCH 1/3] configure.ac: check tv_nsec field in struct stat
Date: Wed, 7 Jan 2015 14:19:39 -0800
Message-ID: <CAD_8n+RkCWzz0VSPb+3XkR-qbms1csGBbFRJtc-HwMp823QdCQ@mail.gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
	<1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
	<1420662236-27593-2-git-send-email-reubenhwk@gmail.com>
	<CAPig+cSrht0fovEWhEknxPPzwZhA7vzeLcM+omaM7PR752GfGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8yx6-0006FN-7m
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 23:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201AbbAGWTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 17:19:40 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:58845 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbbAGWTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 17:19:39 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so5460331obc.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 14:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PXwglZosyC/t4Hj1Lv5ehfXyEhuHtiZ9CuaAGPLzk3w=;
        b=t7cUKcQ12XPkuR/8W7ygxHO/UPTKsqOIFoN2iMglQMFwSQ/jcLEqD34fGx0PjKDB5b
         YOEjguyyqF5GPD5HX1N9Na2YfDoM//5CdSMVQ/GrniOThTgxEUhvKnw8kbYBo4oId4py
         3Htc9JEn0jCL62hqAeVbYx5R37v7U8b+nKchBE96f9DNskyjOxQcCtC3rPWoG0dSbUfa
         zz+Dcipcv0abuuzhfT58RYWbvuoo2oAzwjJbzOAirs9LSd+9RoELSXfNVX1UnYK32MaB
         a6easwmY+ZuDL1TQk63dw0k3wqzHx473VfQGEV8boX4G1UlJxZKgXcIb+mNZU2zOYp3n
         /KFA==
X-Received: by 10.202.186.193 with SMTP id k184mr3345237oif.45.1420669179291;
 Wed, 07 Jan 2015 14:19:39 -0800 (PST)
Received: by 10.202.69.215 with HTTP; Wed, 7 Jan 2015 14:19:39 -0800 (PST)
In-Reply-To: <CAPig+cSrht0fovEWhEknxPPzwZhA7vzeLcM+omaM7PR752GfGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262164>

On Wed, Jan 7, 2015 at 1:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 7, 2015 at 3:23 PM, Reuben Hawkins <reubenhwk@gmail.com> wrote:
>> This check will automatically set the correct NO_NSEC setting.
>
> This commit message neglects to mention the important point that
> you're also now setting USE_ST_TIMESPEC when detected. You might
> revise the message like this:
>
>     Detect 'tv_nsec' field in 'struct stat' and set Makefile variable
>     NO_NSEC appropriately.
>
>     A side-effect of the above detection is that we also determine
>     whether 'stat.st_mtimespec' is available, so, as a bonus, set the
>     Makefile variable USE_ST_TIMESPEC, as well.

I see you're single quoted 'tv_nsec' and 'struct stat'.  Should I also
use single quotes in the first line of the commit msg like this...

configure.ac: check 'tv_nsec' field in 'struct stat'

?

>
> Also, your sign-off is missing (as mentioned in my previous review[1]).
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/261626
>
>> ---
>>  configure.ac | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 6af9647..dcc4bf0 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -754,6 +754,18 @@ AC_CHECK_TYPES([struct itimerval],
>>  [#include <sys/time.h>])
>>  GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
>>  #
>> +# Define USE_ST_TIMESPEC=YesPlease when stat.st_mtimespec.tv_nsec exist
>
> It would be slightly more accurate to drop the ".tv_nsec" bit from this comment.
>
> Also: s/exist/exists./
>
>> +# Define NO_NSEC=YesPlease when neither stat.st_mtim.tv_nsec nor stat.st_mtimespec.tv_nsec exist
>
> Perhaps wrap this long comment over two lines.
>
> Also: s/exist/exist./
>
>> +AC_CHECK_MEMBER([struct stat.st_mtimespec.tv_nsec])
>> +AC_CHECK_MEMBER([struct stat.st_mtim.tv_nsec])
>> +if test x$ac_cv_member_struct_stat_st_mtimespec_tv_nsec = xyes ; then
>> +       USE_ST_TIMESPEC=YesPlease
>> +       GIT_CONF_SUBST([USE_ST_TIMESPEC])
>> +elif test x$ac_cv_member_struct_stat_st_mtim_tv_nsec != xyes ; then
>> +       NO_NSEC=YesPlease
>> +       GIT_CONF_SUBST([NO_NSEC])
>> +fi
>> +#
>>  # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
>>  AC_CHECK_MEMBER(struct dirent.d_ino,
>>  [NO_D_INO_IN_DIRENT=],
>> --
>> 2.2.0.68.g8f72f0c.dirty

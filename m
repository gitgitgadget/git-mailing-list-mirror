From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v7 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 23 May 2016 23:29:21 +0530
Message-ID: <CAFZEwPNrAj0-8W150Yg1E+7y-y6_XB_=m2BLpaZqAOBRbksPCg@mail.gmail.com>
References: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1464014928-31548-1-git-send-email-pranit.bauva@gmail.com>
	<1464014928-31548-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cSOOv9sGGCTD7=5As9Opu3=e9ofkTpFhCzXC9cJPK21Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 23 19:59:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4u8V-0006m3-AU
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbcEWR7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 13:59:24 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36343 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbcEWR7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 13:59:22 -0400
Received: by mail-yw0-f193.google.com with SMTP id u62so24433234ywe.3
        for <git@vger.kernel.org>; Mon, 23 May 2016 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=h3Thwm1YPufccXPn1QL56fCzVw7T0Ey7bsPb1M3cWfk=;
        b=00dpPSKOs+M+rgXEdkjb7zQAaMzkzA3OBT5v53qpw8NI7OOwx5edBOs3S4G3RsavDK
         1Ojzhza5Vuf0qJKk9lzm3Bmeis6uM9Ldeuur27Es/Q4J/JJEno5Ksnw60ncxv4X/oQDZ
         xERaMnohcGLJfVtOmlFpJj+Hx+v1akjo2ry3Z/KWZ52SjjJQWHmXvllK/+ql9IK109V0
         8WSXtGKSiXCpM/sdSatKcKw6ajCvxGLLoSIakS63ekO9RF+sCy773+eNgVlbA/0uhG/Y
         +DJJOpf9bgPvKRkGf91g5EsBH0mRqxy0z5Mjn6MGfdgYcF0zrDNtNDyNXshcouBLr6gt
         ngcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=h3Thwm1YPufccXPn1QL56fCzVw7T0Ey7bsPb1M3cWfk=;
        b=Znm3ol8H6uMti0b38jnq1X4Jbi9m+K90ipXOPb8NCeoSy4YoEZjE1pUG9Bpm/1VKmf
         IrU5/3+j/eZUscd8P20eMH4xwxxEDJwRASn/T18TjiFOUrPob7IU7HZfaZSU6L+JflUu
         qlLNNM9P9hpRzR3nFkyect3/KiiGLlygQsF+wOSbwf3JIW9bjkunTWnhVxdOlmIJZvxz
         jQgM5jw7X2KWbhtmKUqJLNbVb6DKScZI9Src+7VXJQT0ACZrFcMA5j0PSZ+5bSsMlgS0
         3SqPc+TBj7UmxbWac50dnx6Vup+Qxv0Y6rz80i6jD/TN4IlCj0SNiz5kTw7iQSQWLWFb
         9yFg==
X-Gm-Message-State: ALyK8tIIze4nwul/68Rb0ro2VHacL14EVoyyfpeqWwFDpJJpcJCoCfBrka3Muk+2E9aWTj77yRTyacLNUd7MmQ==
X-Received: by 10.129.134.133 with SMTP id w127mr70233ywf.252.1464026361810;
 Mon, 23 May 2016 10:59:21 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 23 May 2016 10:59:21 -0700 (PDT)
In-Reply-To: <CAPig+cSOOv9sGGCTD7=5As9Opu3=e9ofkTpFhCzXC9cJPK21Tg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295342>

On Mon, May 23, 2016 at 9:31 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, May 23, 2016 at 10:48 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Reimplement the `write_terms` shell function in C and add a `write-terms`
>> subcommand to `git bisect--helper` to call it from git-bisect.sh . Also
>> remove the subcommand `--check-term-format` as it can now be called from
>> inside the function write_terms() C implementation.
>> [...]
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> @@ -56,18 +58,38 @@ static int check_term_format(const char *term, const char *orig_term)
>> +static int write_terms(const char *bad, const char *good)
>> +{
>> +       FILE *fp;
>> +       int res;
>> +
>> +       if (!strcmp(bad, good))
>> +               return error(_("please use two different terms"));
>> +
>> +       if (check_term_format(bad, "bad") || check_term_format(good, "good"))
>> +               return -1;
>> +
>> +       fp = fopen(git_path_bisect_write_terms(), "w");
>> +       if (!fp)
>> +               return error(_("could not open the file to write terms"));
>
> By adding two pieces of information, you could make this error message
> much more helpful for anyone trying to debug the failure.
> Specifically:
>
> (1) the pathname for which open() failed
> (2) the actual system-level error
>
> For (2), you could use strerror(errno) or, better yet, error_errno()
> which recently graduated to 'master'.

Yes it would definitely be better to make the error message more
helpful. I will dig more into this.

>> +       res = fprintf(fp, "%s\n%s\n", bad, good);
>> +       fclose(fp);
>> +       return (res < 0) ? -1 : 0;
>> +}

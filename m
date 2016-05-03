From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 74/83] builtin/apply: make try_create_file() return -1 on error
Date: Tue, 3 May 2016 18:24:30 +0200
Message-ID: <CAP8UFD2Qc4h+PjZSXBFDoYBXVj7dkvf5j-aAuZs0-ZxbHQfuMA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-75-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cQsS7x2qb8SphaAgdfpCLBQ-z=joL3w8RZH0HC9xRG54g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:24:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axd7l-00049G-0F
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 18:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933558AbcECQYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 12:24:33 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35533 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbcECQYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 12:24:32 -0400
Received: by mail-wm0-f46.google.com with SMTP id e201so153920713wme.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=S18aW4R7hi5ec2Kj4ml5wIAtioPpi9VcL3gZPkSL4Kw=;
        b=N28Z/OXvPJwEN5cEB5x61dLLDDgaXAELphsgX1vNHaSdnqhC1ol3zROwUgZDFnAugj
         eVPpv9/m0GmhoBmBB5nG1eiJYPr3Lxg9n8aKvm+w7eD0KXAVgoQbInTx5rRSdS6+Ma10
         enzx7hwmPPEAHAaxBdF1ynKZBXmoDc5LmdW4DTxVP7eT1sC7X3m23b0mkgj7FuNdC7sh
         IOJ76VYF9tzLN1d5cr2js3ggQx0yOeeCYwo8hb8kKmMldbZ41VodNRhRH1aoXIONNFzi
         cKVEA46LOrgAf6pAkvDSJcuy4gVNVOxw8m5vbBmwaUCGaY1x5o+D6eNjwBFWnFpA8JrO
         B/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=S18aW4R7hi5ec2Kj4ml5wIAtioPpi9VcL3gZPkSL4Kw=;
        b=SYoR8tPO1Ekn3hj6Z+V+WJThouIFSjam2LCrSoqhkGhMsaFCl/7TQr1e8pIXbwIIK6
         ju2n471uVrTUbPnbGcXvTXgpZZT/uSFt6nD2ijZEQRFMbBiS7Rrj5EobRQi31muMT0nG
         aUUhcLwTJFdlyy0pybMsIYo2nlEhulsKQwCUNIDH5JuLJo0yV24X2cadHuudz1jXxbWb
         zeycPdhoBplI5BoCJFCa6a4v+uJwYKGt/VSTjjPr28ek/9xjIRzMh0p9t+cK1hqMQQN8
         tLV+KZzOzzx1lUBUkH+hMWpi/MfEDMJQHq3InQqjo6PTFwXJCW9smbU4mN0lp39CkVKP
         MuWw==
X-Gm-Message-State: AOPr4FXoFiviRcUq3MfbSFCa66CTGgMD7IWBQ/u30NxmZFytqF2c1l4+DAuy8a+/8oMk2xFoleEkMGDAmgnlCg==
X-Received: by 10.28.54.33 with SMTP id d33mr4585211wma.62.1462292670597; Tue,
 03 May 2016 09:24:30 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 09:24:30 -0700 (PDT)
In-Reply-To: <CAPig+cQsS7x2qb8SphaAgdfpCLBQ-z=joL3w8RZH0HC9xRG54g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293413>

On Mon, May 2, 2016 at 8:01 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4145,28 +4151,32 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
>>         fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
>>         if (fd < 0)
>> -               return -1;
>> +               return 1;
>>
>>         if (convert_to_working_tree(path, buf, size, &nbuf)) {
>>                 size = nbuf.len;
>>                 buf  = nbuf.buf;
>>         }
>> -       write_or_die(fd, buf, size);
>> +
>> +       if (!write_or_whine_pipe(fd, buf, size, path)) {
>> +               strbuf_release(&nbuf);
>> +               return -1;
>
> This is leaking 'fd'.

Ok, fixed.

>> @@ -4208,12 +4227,15 @@ static void create_one_file(struct apply_state *state,
>>                 for (;;) {
>>                         char newpath[PATH_MAX];
>>                         mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
>> -                       if (!try_create_file(newpath, mode, buf, size)) {
>> +                       res = try_create_file(newpath, mode, buf, size);
>> +                       if (!res) {
>>                                 if (!rename(newpath, path))
>>                                         return;
>>                                 unlink_or_warn(newpath);
>>                                 break;
>>                         }
>> +                       if (res < 0)
>> +                               exit(1);
>
> Two issues:
>
> Getting the error case out of the way early (moving this 'if' just
> after 'res=...') would make it easier to reason about the remaining
> logic.

Ok, I moved up the error cases.

> It's already difficult to understand what the below 'errno' check is
> testing. try_create_file(), rename(), or unlink_or_warn()? Plopping
> this new error handling conditional in front of it divorces the
> 'errno' check even further from whatever it is testing.

Yeah, but I don't see what I could do about that.

From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP 4/8] am: split out mbox/maildir patches with git-mailsplit
Date: Tue, 2 Jun 2015 22:27:41 +0800
Message-ID: <CACRoPnRei3VPDSrD1ppkr_YoeiC-V5qp=KXkaO-OyMz9YkX8-Q@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-5-git-send-email-pyokagan@gmail.com>
	<CAPig+cSK_yEabXJFF4UvKkbcisgpZGV0aX7jExcnK=Q-Ozm-eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YznAX-0003hy-IE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759362AbbFBO1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:27:45 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:35433 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027AbbFBO1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:27:43 -0400
Received: by labko7 with SMTP id ko7so123264834lab.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jt4k+yNJ1uwQyYXSb1NU0vn7KADjW+7+z7Jm21i4XEI=;
        b=XDP5WnyjVKF/A4pBHAKW9pbrZXy5c4cfluiLf0ot9eAQStWWtR96z7gYIkCuqfEaB+
         vrvo4DhpuFQ8qFWmAzQAj4edFUhV7YO6Qq/SNIqsrmmY3S6y1q6SZqcALMJOkDzJUd6Y
         UuaBKoo8uU3nGow9HaUsW3auPVDxpl9XyXoVdXt+Tqrv0SI6T25HPnkNbmbECc8i64cZ
         fbnD+QrP9Pg6cRTdjvpNx4YwYVT7N7mZUJRkbqUIiGl3ci/0hgAPfHPWxggg1Rw3g7aS
         Ydmb3F+wTPae+vOc75tR71swKpo8su0O+WCZs3NSM2WiQ1ERQwaicJxjoG6Te3jETIBL
         MPtg==
X-Received: by 10.112.199.133 with SMTP id jk5mr27142196lbc.32.1433255261603;
 Tue, 02 Jun 2015 07:27:41 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 2 Jun 2015 07:27:41 -0700 (PDT)
In-Reply-To: <CAPig+cSK_yEabXJFF4UvKkbcisgpZGV0aX7jExcnK=Q-Ozm-eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270548>

On Fri, May 29, 2015 at 7:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 27, 2015 at 9:33 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> @@ -128,13 +190,32 @@ static void am_next(struct am_state *state)
>>   */
>> +/**
>> + * parse_options() callback that validates and sets opt->value to the
>> + * PATCH_FORMAT_* enum value corresponding to `arg`.
>> + */
>> +static int parse_opt_patchformat(const struct option *opt, const char *arg, int unset)
>> +{
>> +       int *opt_value = opt->value;
>> +
>> +       if (!strcmp(arg, "mbox"))
>> +               *opt_value = PATCH_FORMAT_MBOX;
>> +       else
>> +               return -1;
>> +       return 0;
>> +}
>> +
>>  struct am_state state;
>> +int opt_patch_format;
>
> Should these two variables be static?

Whoops. Yes, they should.

Thanks,
Paul

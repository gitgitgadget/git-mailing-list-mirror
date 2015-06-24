From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v3 06/31] am: detect mbox patches
Date: Wed, 24 Jun 2015 16:41:09 +0800
Message-ID: <CACRoPnSoFDnuJC-q3nR7xwpqOcpmzYReDPPPao1NJdY11TV0cQ@mail.gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-7-git-send-email-pyokagan@gmail.com>
	<xmqqy4jgd92l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 10:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7gFV-0005cR-0V
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 10:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbbFXIlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 04:41:22 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34548 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbFXIlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 04:41:11 -0400
Received: by lbnk3 with SMTP id k3so21976838lbn.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VSwnwix62SpqySZz5Bg6/0Z6J+pXox5GrGYqnqPP7hw=;
        b=SezRtVdCLRyEAxAJQwDHtQb3T2IFys8UYR+RjoUPlXSF7hZkG031t7dqSxZUSbZmFa
         WahFwkvQE0GfI2+Itj6A7mVIL81BEYLoMu7EjpyokVBQFYm1onAe3/hr7f18kt0QcaM8
         FWeU4Bj/7xW1NRIM7SvgvNkWy50Qo8/qYxCLq6xntnUkwD/DSDM2bV4MU2IkWd1AsP43
         ztB4VqQKOnSCIF+kEjC80k4OFwir4algcVnGGQg3+XE+J+17pNJKU+Gpj/XaeY8q/YbY
         u8Oef30NcrWZoeHADycsoEWJ3Q5ongFSqaa67zd/s3J99kqHOA8Ynq+1jMG8oZVctprP
         4Iug==
X-Received: by 10.152.164.193 with SMTP id ys1mr39036300lab.65.1435135269378;
 Wed, 24 Jun 2015 01:41:09 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 24 Jun 2015 01:41:09 -0700 (PDT)
In-Reply-To: <xmqqy4jgd92l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272540>

On Fri, Jun 19, 2015 at 5:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> +static int is_email(const char *filename)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     FILE *fp = xfopen(filename, "r");
>> +     int ret = 1;
>> +
>> +     while (!strbuf_getline(&sb, fp, '\n')) {
>> +             const char *x;
>> +
>> +             strbuf_rtrim(&sb);
>
> Is this a good thing?  strbuf_getline() already has stripped the LF
> at the end, so you'd be treating a line with only whitespaces as if
> it is a truly empty line.
>
> I know the series is about literal translation and the script may
> lose the distinction between the two, but I do not think you need
> (or want) to be literally same for things like this.
>
> Same comment applies to other uses of "trim" in this patch.

No, the uses of strbuf_trim() are not good at all. Will remove them.

Thanks,
Paul

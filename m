From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] t1500: avoid changing working directory outside of tests
Date: Tue, 17 May 2016 18:48:16 -0400
Message-ID: <CAPig+cQ19DXqZx_D29qeQNz5pTVe-OGWFJG_2xWRX0XWCLk_ZQ@mail.gmail.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-4-sunshine@sunshineco.com>
	<xmqqeg90v2ss.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTAgB6DXoEeJaDVy7_J7QiqNOm6AJqZTiSowO6_jqa8_w@mail.gmail.com>
	<20160517215214.GA16905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 18 00:48:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2nmo-0007zd-45
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 00:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbcEQWsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 18:48:18 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36242 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbcEQWsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 18:48:17 -0400
Received: by mail-ig0-f194.google.com with SMTP id c3so3103081igl.3
        for <git@vger.kernel.org>; Tue, 17 May 2016 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=2oThkWEnwfY+799jUh18lGxjI8tX+XSGeMMGfEAojdU=;
        b=dMxdJhUNtZpFtQsPeEXjVyLL8/EDMvR4Vu4r/u4OQnaSlTGUDoaA19LVmQcl3znpLX
         S2Qrnfli7dY0KroHXFi/Z3OazbdLwyNap6erqtZwx8G0k9LCZggK3VgBhDcwYPJSUBbm
         PbiLekgEcuzizqfqwaPyrg4HEEosb1KdkRxi2wgiQIoEgNvohmvqD/kyDaH5paM8G2hl
         GuaWnteXW1I9pxeZI/R3ypuQPPWup/SOqw0lYaXy6Me4wPKENTPiwcVi3/hoCtfdmgZ+
         k0KjLKKWPx+LEnyLVHyZCBy/3MV9vmmyJuvM1Q4jrFjfYe1B8fxMwG3vkrqIwjfShBKs
         wUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=2oThkWEnwfY+799jUh18lGxjI8tX+XSGeMMGfEAojdU=;
        b=Ny8/+kWX1+rKBfBOe7AoSk0Wqjlpz+YzWmf4NcZnnHW3f7/Qxc3bgvLfTWaVGKsQwZ
         5SFMnEG1m3grGO5ob+loOFzmWD0aBmvWtSgEOFvGmcZa73XZ7YIqmbBn7+XTPNPS0E/g
         n6zKqWuH+RWguEjkN1WORHKYr4/6odAKcaSv6zUqAOcRziSb2GZKRnUEH0v0/6Q+WkjS
         o6GmpAfZ3H8uyuShlNbvRBcd/Y59LoR8u2/DdspCbEs9ksCUUSQttdfZAnX559lAf/RD
         i2P+hCkE9CGXh8bhG7qovXq/3NUgplnTjqPKKXSeF4ChYly5eQUDkeA6Wm2zCZzOYkdw
         1ETA==
X-Gm-Message-State: AOPr4FWbCgLENeNiuOGMA4DcTN67duxi3RDVpWKA2XosquHSZO82bA9sxJQWwZxc4ZEX0y+igakofCYwTCDU4w==
X-Received: by 10.50.0.233 with SMTP id 9mr12242936igh.17.1463525297025; Tue,
 17 May 2016 15:48:17 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Tue, 17 May 2016 15:48:16 -0700 (PDT)
In-Reply-To: <20160517215214.GA16905@sigill.intra.peff.net>
X-Google-Sender-Auth: BBSfBvVf1oUgH1g6EEicsDPzbik
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294921>

On Tue, May 17, 2016 at 5:52 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 17, 2016 at 04:48:33PM -0400, Eric Sunshine wrote:
>> On Tue, May 17, 2016 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Eric Sunshine <sunshine@sunshineco.com> writes:
>> >> +                     git ${dir:+-C "$dir"} rev-parse --$o >actual &&
>> >
>> > This is kosher POSIX, but I vaguely recall some shells had trouble
>> > with the SP between -C and "$dir" in the past.  Let's see if anybody
>> > screams; hopefully I am misremembering or buggy shells died out.
>>
>> I also am bothered by a vague recollection of some issue (possibly
>> involving the internal space and lack of quotes around the entire
>> ${...}), but couldn't remember nor find a reference to the specific
>> details. Perhaps someone reading the patch has a better memory than I.
>
>   http://thread.gmane.org/gmane.comp.version-control.git/265094

Thanks for the link. I just tested with FreeBSD 8, and the shell
indeed exhibits that broken behavior. The workaround in Kyle's patch
isn't the prettiest (and is a bit verbose), but it gets the job done.

I can send v3 using that workaround unless Junio wants to patch it locally(?).

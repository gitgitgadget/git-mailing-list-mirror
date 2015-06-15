From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/WIP v2 03/19] am: implement skeletal builtin am
Date: Mon, 15 Jun 2015 17:49:57 +0800
Message-ID: <CACRoPnR28kNvxk6sdYaNkPYx7wi=j4wCbaXYrx62AGhjpQiPVA@mail.gmail.com>
References: <1434018125-31804-1-git-send-email-pyokagan@gmail.com>
	<1434018125-31804-4-git-send-email-pyokagan@gmail.com>
	<xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 11:50:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4R1r-0005Y9-B3
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 11:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbbFOJuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 05:50:00 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:33945 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbbFOJt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 05:49:58 -0400
Received: by labbc20 with SMTP id bc20so17904592lab.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z5Zbh+kbGOE4ZoOXXkQP+NWV0rfznZSr1xFQysrOabU=;
        b=DBu9C0+yAoWckF+K3eatoaPN/V/P0tv51Kp675O9Y6p/rYci84Vawd8yMIP0wit8VK
         uMXG0Cg0fKLD2vF4cLzY3cVGc2AkgmGNERWFNsOSOKfH1E6DgBPvLK10N4PaZmvu0pyC
         1Br/Z2rjZjRySlHbreHLZ/+cAko73z0glR+TMORkxfo60FsUkVhNwzpDMpY/YjV5EGQ0
         nvgeGV/nRTgOk2f7ctnqLd8YTH/q2WbskkerSLT9LQ8+tWP3HSNTXuBeK5imgKBuaa49
         vA60haLb2bPUyfXsTQkabWf8zXw8CZPxyFsQoPHWrnpSFCVcSAnSXTUFxlA3LmndkRiK
         TsUg==
X-Received: by 10.112.27.238 with SMTP id w14mr26733830lbg.80.1434361797141;
 Mon, 15 Jun 2015 02:49:57 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Mon, 15 Jun 2015 02:49:57 -0700 (PDT)
In-Reply-To: <xmqqzj42kkol.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271668>

On Mon, Jun 15, 2015 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>> diff --git a/git.c b/git.c
>> index 44374b1..42328ed 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -370,6 +370,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>>
>>  static struct cmd_struct commands[] = {
>>       { "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>> +     { "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
>
> Would this, especially having RUN_SETUP, keep the same behaviour
> when the command is run from a subdirectory of a working tree?
> e.g.
>
>         save messages to ./inbox
>         $ cd sub/dir
>         $ git am ../../inbox
>

Yes, in 05/19, where the splitting of patches is implemented, we
prefix the mbox paths with the path to the working tree.

There are also tests in t4150 to catch this, introduced in bb034f8
(am: read from the right mailbox when started from a subdirectory,
2008-03-04).

Thanks,
Paul

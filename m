From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 6/9] ref-filter: introduce format_ref_array_item()
Date: Mon, 5 Oct 2015 13:19:13 +0530
Message-ID: <CAOLa=ZTMf9i=+9Rgi9oO==vr_JGtG3J9DvQWk18Zx-yd5_35XA@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-7-git-send-email-Karthik.188@gmail.com> <vpqoagg9n2l.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 05 09:50:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj0XJ-0007qe-EI
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 09:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbbJEHto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 03:49:44 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:32833 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbJEHtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 03:49:43 -0400
Received: by vkgd64 with SMTP id d64so91528340vkg.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P1kP/r4Nl61t+NFEdyrhbXp7vFIGn14NNiOOAX/BW1M=;
        b=HFNoM3IFDHGb6Ud7XBWdrj0v4HwmkAIKtKRRRClwIUlCLaSscwLhEW1P2zt+w9vzD7
         0312wYy84hkDuQJYnWZ89eGf1TurvSBeFvt0LyZu/tbVk7R2MwX0+AVVP/MkDfSXiX95
         GEMs47WkbP39H0EnZGBEV2mG3RdqfPM0wC9x81xT9OhjQqIlwc3nds8pXDvAX+TqpBuG
         2mtve3CZtIBrzTwCi/pjCqrqAuBBJnXuN5pwc8CTbOuK4ekcA76dvFfNaEvgGDf+m5GZ
         KAGfB9xdoNeBsp40BrLjtUXoddVwTjyb08dv+BGxwkPq8CguUMqwusrGw1LWpGR8sob6
         UQSw==
X-Received: by 10.31.173.136 with SMTP id w130mr16539987vke.72.1444031382272;
 Mon, 05 Oct 2015 00:49:42 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 5 Oct 2015 00:49:13 -0700 (PDT)
In-Reply-To: <vpqoagg9n2l.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279040>

On Sat, Oct 3, 2015 at 5:32 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Introduce format_ref_array_item() which will output the details of a
>> given ref_array_item as per the given format and quote_style to the
>> given strbuf.
>
> Why do you need it in this series and you could do without for tag?
>
> Going through PATCH 8/9, I guess there's something related to --column,
> but tag also has --column so I'm puzzled.
>

The problem is with colors which tag.c doesn't use by default.
Here we need to print colors only if we're printing to a tty which supports
colors. which does not play well with the implementation of --column as
done in tag.c. Where, If I'm not wrong the --column option captures all
output, formats it and then prints it to stdout. Hence when using colors, we're
told that the printing isn't done to a tty which supports colors, hence we lose
out on colors.

I was trying something where we have a variable which knows when the column
option is used and hence explicitly lets us use colors, but seemed like a mess.
This was a clean of going about it.

-- 
Regards,
Karthik Nayak

From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 16/19] pathspec.c: move reusable code from builtin/add.c
Date: Fri, 28 Dec 2012 21:15:40 +0000
Message-ID: <CAOkDyE_706JwjY24xHvyMb1YGNhJOo_L3T8+V4hHgDJYxdLeiA@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-17-git-send-email-git@adamspiers.org>
	<7vy5ghhpi0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:16:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TohHd-0001pB-G8
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 22:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab2L1VPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 16:15:43 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:44049 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab2L1VPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 16:15:42 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so4376707wgb.2
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 13:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=T/Gp/h46emHuSZuFHgRulN4NMcyKzg1qLtt9buGK0bA=;
        b=dP9ZN32mPKdUrUH4dOAF1KOwK1cGuNVkvrVWDSX1RmPvmrxzeYHawMvHdRYOksLW3L
         oBvDfu3szuF5vYZLh0ZM5V6nxpx+zKxSWTa9PwKzWNnN9z/iKLHx13NYfj9/Ff4dxyX/
         byEgMzzSmgfbjTiP4Y9hcRzSZriPg+0i1yLAm0As26CVhEqLvSiYHkBtFPL0zgU0o+yZ
         HpK55pKvN4ly0RvieEW0Qq/J0QxuRSx1qC3AZpQhUSd4yaDJQ6e1zibO12C2X+qtXJul
         bCZfAu0jAlVzC3ysqmt7pCKgKGAcm1secI3fFcchPlZ5wFWa3JelNc2PbD8pHcSm1v38
         Eprg==
Received: by 10.180.82.69 with SMTP id g5mr54892873wiy.21.1356729340448; Fri,
 28 Dec 2012 13:15:40 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 13:15:40 -0800 (PST)
In-Reply-To: <7vy5ghhpi0.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: e57dG4hIrEa30U25gc9tGXh4a_0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212265>

On Fri, Dec 28, 2012 at 8:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> diff --git a/pathspec.c b/pathspec.c
>> new file mode 100644
>> index 0000000..8aea0d2
>> --- /dev/null
>> +++ b/pathspec.c
>> @@ -0,0 +1,99 @@
>> +#include "cache.h"
>> +#include "dir.h"
>> +#include "pathspec.h"
>> +
>> +void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
>> +{
>
> It did not matter while it was an implementation detail of "git
> add", but as a public function, something needs to clarify that this
> "fill"s matches *against the index*, not against a tree or the files
> in the current directory.  The same comment applies to all the
> internal functions this patch exposes to the outside world.

Prior to submitting the v3 series, I attempted to understand
fill_pathspec_matches() and find_used_pathspec() well enough to
document them all, but I failed.  Perhaps some kind soul could explain
what is the exact purpose of these functions, and in particular the
role of char *seen in both?

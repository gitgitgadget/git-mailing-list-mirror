From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 17:22:30 -0400
Message-ID: <CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCcKy-0006ep-90
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab3HVVWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:22:32 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:46218 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab3HVVWb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:22:31 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so1921827lab.34
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QGNIiBEw7/Ui0NOaCKXGnvFzDyw91GcDC8x5c2T08+Q=;
        b=nFNUYpFdVbFa4/iepT4XANt6lE0OxIuwGfbsoey6k00Q6/zCoHjHBiK7ll+ur/JWlx
         WCCoVQHEZQeJxw0J6K2zEROajacHkdrxRj6ZLfKBQQ2qwRLX9nW3wNdJFf4VF4/4Wlo1
         cZBz37srU9pf+kD+zoK1LjUOB/iJugbjhFQBfF8xRyNXc4QPBdXM9CuV/VXEEZzLtIKg
         Diy5TnqYwACkrcAu1VT7ryb+SEG5AnI70q3ZADPlkjbcSUr5DqX+vgfKPpCV/gT7759K
         aieaBEWWioL1+LRJXrtSqL0UYyoWGjFIrbUpVy9OCEtw3CAClKF4vgUA2bNyCOiZTm0o
         h0jg==
X-Received: by 10.112.154.70 with SMTP id vm6mr4367761lbb.1.1377206550275;
 Thu, 22 Aug 2013 14:22:30 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 22 Aug 2013 14:22:30 -0700 (PDT)
In-Reply-To: <xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: k72vRsh2MxebNrk83_fieljim7I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232779>

On Thu, Aug 22, 2013 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> I can confirm this failure on OS X, however, I am somewhat confused by
>> the follow-up t3010 changes in 3c56875176390eee. Are the t3010 changes
>> supposed to fail without 2eac2a4cc4bdc8d7 applied? For me, on Linux,
>> the tests succeed whether 2eac2a4cc4bdc8d7 is applied or not. On OS X,
>> the tests succeed without 2eac2a4cc4bdc8d7 but fail with it applied.
>
> The 2eac2a4c (ls-files -k: a directory only can be killed if the
> index has a non-directory, 2013-08-15) is NOT a correctness fix.
>
> It is an optimization to avoid scanning directories that are known
> not to be killed when "ls-files -k" is asked to list killed
> paths. The original code without the patch is correct already; it
> just is too inefficient because it scans all the directories.  It is
> not surprising if the test added by 3c568751 (t3010: update to
> demonstrate "ls-files -k" optimization pitfalls, 2013-08-15) passes
> without 2eac2a4c.
>
> As its log message explains, 3c568751 (t3010: update to demonstrate
> "ls-files -k" optimization pitfalls, 2013-08-15) is to catch a case
> where an earlier "something like this" patch (which is the draft for
> 2eac2a4c) posted to the list would have broken.  That draft patch
> was correct only for the case where the top-level directory is
> killed, but was broken when a subdirectory (e.g. pathx/ju) is
> killed.

Thanks for the explanation.

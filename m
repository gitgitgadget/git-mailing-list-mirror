From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH 0/3] Make git more user-friendly during a merge conflict
Date: Mon, 17 Mar 2014 19:25:00 -0400
Message-ID: <CADgNjakRSw-S4VbKnLC9PpmAcEi7iO=r0SBEy2XO3XhtDq=uJg@mail.gmail.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<xmqqha6wa0ln.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:25:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPguW-0007GK-R3
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbaCQXZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 19:25:18 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:62501 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbaCQXZC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 19:25:02 -0400
Received: by mail-qg0-f46.google.com with SMTP id e89so18795343qgf.5
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rdcpu3xrOR3bmoRwWqxYCLaf121MhfZrqompJQKoBSI=;
        b=x0no0MBHGxI6H+WlhIpqgcek+nHZz7D2vJhpEKuqo6kKgI9hDa5Fiwb2R+UVVuFqAs
         79PQuXeOUKvby4pgfH5JHl+zfYRk9oEfsPWjaoE3fxGwYIQbJwoKQSrz+0rZoauqBw4S
         DP89H1015PoxdbkpTbjQ8aNArM+1H0JpEdTAUGoGzSoF7wJacRTuoYXycZoINoFf1Psa
         61z1Zk7sEZKpu9yZ8KgUO76zz95sTI4ER7cowhLujlUkpMPOtdLvqjvdpfevTyLHz5WB
         hMeGcnR27Ix94HFQBIn296UcELPRHJqfr+fQII803xfr68xXfuX18iD3NXwecX9ft7KI
         PqCA==
X-Received: by 10.224.22.147 with SMTP id n19mr5756533qab.93.1395098700759;
 Mon, 17 Mar 2014 16:25:00 -0700 (PDT)
Received: by 10.224.72.140 with HTTP; Mon, 17 Mar 2014 16:25:00 -0700 (PDT)
In-Reply-To: <xmqqha6wa0ln.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244312>

On Mon, Mar 17, 2014 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Has this series been tested with existing test suite?  I tentatively
> queued it to 'pu' but then had to revert because many tests started
> failing, causing me to redo the today's integration cycle for 'pu'
> once again.

I tested it during RFC, but missed it when I sent it as patch. The
problem is here:

@@ -1559,6 +1563,8 @@ int cmd_merge(int argc, const char **argv, const
char *prefix)
        if (merge_was_ok)
                fprintf(stderr, _("Automatic merge went well; "
                        "stopped before committing as requested\n"));
+       if (advice_merge_hints)
+               printf(_("  (use \"git merge --abort\" to abort the merge)\n"));
        else
                ret = suggest_conflicts(option_
renormalize);

I'll fix the problem. Sorry about that.

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Wed, 26 Sep 2012 09:19:36 +0530
Message-ID: <CALkWK0=1Bep0gBJAQQefDiZ7LMkXqXt91jPkgYkac0QkMBgOGw@mail.gmail.com>
References: <505CCA55.6030609@gmail.com> <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net> <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net> <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home> <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
 <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com>
 <7vwqzm3bhf.fsf@alter.siamese.dyndns.org> <CALkWK0nTWQ3g75fN5wQLwgeW986vAzGdXajSGCY5SdpK8W=0aA@mail.gmail.com>
 <CALkWK0kWJ3ndEMGzyGGMEa+ko3BTShC7_o-HVsXzFCGwRem5Jw@mail.gmail.com> <7vobkx3j9i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 05:50:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGidU-0006ZB-4y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 05:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab2IZDt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 23:49:58 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44577 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab2IZDt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 23:49:57 -0400
Received: by qcro28 with SMTP id o28so127629qcr.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 20:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0SUCt+2hwk3IP0EsUZqxDR7PFHtzYG7xb4G6u7WHcn8=;
        b=pofKA5LRLTaXUJmRoTj1sNf0tRbjMSSRwuDWcGIVTmorXnuSWITxxCERzVL76iYpDk
         DGz/+PgAbvADfgqG5F49HK4nhZZ3EtSrNdr7TVPRrEKaUl5zgnUpec5QpecCwlbraAF7
         yB0SQDHCwfTa6nXpXY3xrr9QPTOgITiqImofqFH/NWK3CrGUAWMdCYEaDQUHMk3/LGV/
         ySa61A93A1X8a3Oe/vHjRyacdANIblQlFeAsixI0Cl5fCGBduUE1fTnncDKABwnNEj/C
         +HiQPKrLrpAqrSngfJckRCBjItCo+cU8rYs6h9x34ZRVZuawH1m/ODZCqdM0UG4v7UAz
         0cTA==
Received: by 10.224.58.147 with SMTP id g19mr44828777qah.77.1348631397119;
 Tue, 25 Sep 2012 20:49:57 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 25 Sep 2012 20:49:36 -0700 (PDT)
In-Reply-To: <7vobkx3j9i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206392>

Hi Junio,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Here's a patch.
>>
>> -- 8< --
>> From: Ramkumar Ramachandra <artagnon@gmail.com>
>> Date: Sat, 22 Sep 2012 10:25:10 +0530
>> Subject: [PATCH] test-lib: do not trust $SHELL
>>
>> Do not trust $SHELL to be a bourne-compatible shell.  Instead, use the
>> Makefile variable $SHELL_PATH.  This fixes a bug: when a test was run
>> with --tee and $SHELL was set to ZSH, $PATH on line 479 was not
>> getting split due to ZSH not respecting $IFS.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>
> The part that this starts letting run, which the original "Re-run
> the command under tee as early as possible" wanted to avoid running,
> does not affect anything that would affect how we run that tee magic
> (e.g. "mkdir -p test-results" will still create it directly inside
> the directory the test script was started in), so I think this patch
> is safe _for now_.
>
> However, it forces people who need to update earlier parts of this
> script to be extra careful; it has been true before the patch, and
> the patch makes it even more so.
>
> I am not opposed to queuing this as an interim solution, but I
> wonder if we can get rid of that double-launch altogether.

I see you've queued it in `pu` after rewriting the commit message.

> Instead of re-launching the script with its output piped to "tee",
> can't we do the same by redirecting our standard output to the file
> in the file, and spawn a "tail -f" that reads from the file and
> outputs to our original output?  Something along the lines of:
>
>         mkdir -p test-results
>         tee_base=test-results/$(basename "$0" .sh)
>
>         # empty the file and start "tail -f" on it ...
>         : >"$tee_base.out"
>         ( tail -f "$tee_base.out" ) &
>         tee_pid=$!
>         trap 'kill $tee_pid; exit' 0 1 2 3
>         # ... and then redirect our output to it
>         exec >"$tee_base.out"
>
> and wrap it in a shell helper function that is called from where the
> parsing of the command line arguments for "--tee" happens, and don't
> forget to kill $tee_pid when we exit.
>
> Hrm?

Good idea.  I'll write a patch to do this once the interim solution
graduates to `master`.

Ram

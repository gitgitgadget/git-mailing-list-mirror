From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: error: git-fast-import died of signal 11
Date: Tue, 16 Oct 2012 16:12:12 -0400
Message-ID: <CADgNjanD=gYF_J7onuY6gK2mXuj1XGjWWX28nb2aAYPfmWH3PQ@mail.gmail.com>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com>
	<CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com>
	<507C7C35.7080906@gmail.com>
	<CAMJd5ARTmud_nrUKF8USXJAKVwvLH1gSmhys2o_mjimTW5B+Vg@mail.gmail.com>
	<507C95A3.8010704@gmail.com>
	<CAMJd5AT51oSGer2JAhCPGnjWqCR-M2b1_4ULF7LeTob8xLcjVw@mail.gmail.com>
	<CADgNjakqUL+66t7=Fkd69GPYOq54Z49RQchBLSSVGRv+4=5eGQ@mail.gmail.com>
	<CAMJd5AR2gsyymKhT_hK9=4bHbcVnn+qEaDSxrZeJL1dfbmDxTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 22:12:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TODV3-0003dt-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 22:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773Ab2JPUMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 16:12:15 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:37740 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab2JPUMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 16:12:14 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4474129lag.19
        for <git@vger.kernel.org>; Tue, 16 Oct 2012 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=em5k4hU1X/MHm1thaSHMZ2u9sUd6f5SdHFW+XB+ICV4=;
        b=PEW/NXxbojVwRNqFTTEBIBM41NbM5pY5U0wk9G9LVo6q1/hqQFxdfFqjdMb1g+jrsr
         dlAcUnFJOUcNXbPbFWXBnKOaMHs7+/A99G/1ttwLPajfgZZCy4PvF6BxNAve6/ZlWKAf
         5PwxkaTELunOw7YWsM+PtKLEQquzKJQ79mgzjGL5ox9g4J6Pu77ZI+PZtARnrqZhYAWJ
         2WGKEeetYP9qpwveSihSZvXwHCZYQgUobXCoAEiWikVHWY5ZwLimbxApyzgWWEcZ7jKQ
         0snBAc1D6emNKn5UUr4dC4L0tVp1ffduTMSBZUyqO+l02Go5CC+UxZW6bOrGPtMjGl+1
         L3Og==
Received: by 10.152.112.136 with SMTP id iq8mr13598280lab.18.1350418332837;
 Tue, 16 Oct 2012 13:12:12 -0700 (PDT)
Received: by 10.112.106.164 with HTTP; Tue, 16 Oct 2012 13:12:12 -0700 (PDT)
In-Reply-To: <CAMJd5AR2gsyymKhT_hK9=4bHbcVnn+qEaDSxrZeJL1dfbmDxTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207879>

On Tue, Oct 16, 2012 at 3:41 PM, Uri Moszkowicz <uri@4refs.com> wrote:
> I can do that if it still fails tomorrow. How do I build a debug version of git?
>
> On Tue, Oct 16, 2012 at 2:35 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>> Yea, it's a difficult problem to diagnose. It'd be really helpful if
>> you can run a debug version of git and run the import process under a
>> debugger.

After getting git's source, you can simply run "make", and it'll
compile with debug info by default. When compiling is done, you will
see all the binaries in the source's root folder. Then, from the
source folder, you can start gdb by the command:
    gdb ./git-fast-import

When you're inside gdb, put a breakpoint on "die_nicely" by entering:
    b die_nicely

Then, you can finally run your import process by entering:
    r < your_cvs_dump

When fast-import crashes/dies, you can find the stacktrace by entering:
    bt

And that should tell us where it crashed, and, hopefully, where the
memory error happened.

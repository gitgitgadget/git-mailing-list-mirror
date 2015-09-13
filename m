From: Jeffrey Walton <noloader@gmail.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Sun, 13 Sep 2015 14:37:11 -0400
Message-ID: <CAH8yC8nNUMCfgzd2sb1PUxjTPEuPaqe3XtW-yyi=X3+c3_im7g@mail.gmail.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
	<20150913101727.GB26562@sigill.intra.peff.net>
	<CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
Reply-To: noloader@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbC9R-0006wr-3m
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 20:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbbIMShO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 14:37:14 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36717 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbIMShN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 14:37:13 -0400
Received: by ioii196 with SMTP id i196so145167675ioi.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MMm4F4Ss7HjqBsX2QtP+3knboPGriyq8ZJctao7PnHA=;
        b=JYKuJ+w+j/sBt1bJjUtHaUYMJUvn/w1hrGYLR0fIFNw4y+OCxM7M42yFILthg+4ti6
         ZazaMlfKx6O3k+Z8Kb3Xs8dUw+iqhLfTMMFqMfmxmumeRVyMRbzKRPMrXmAw63IDkFGH
         cOzxwf4VCLOOnHJJ8mM2MWYiVHK8eb5F2eEY1z85BqnJzT4i0Z+vpK9OjwokiqJOkeHL
         gPiOVFej7hWl3UHVxotdKwiQCYQSIDm6ZwG9GlQZX9MN4ontTe4wxld54G/uz0l53pnF
         zPjfRjsydCFHR5x9t6oqnxlpOEB8XffVeeFWGSTNvDqt0DAH7HMLnm1RGxPK3eHGJN1O
         2lvw==
X-Received: by 10.107.9.194 with SMTP id 63mr21487671ioj.122.1442169431977;
 Sun, 13 Sep 2015 11:37:11 -0700 (PDT)
Received: by 10.36.123.131 with HTTP; Sun, 13 Sep 2015 11:37:11 -0700 (PDT)
In-Reply-To: <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277792>

On Sun, Sep 13, 2015 at 1:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Sep 13, 2015 at 6:17 AM, Jeff King <peff@peff.net> wrote:
>> On Sun, Aug 30, 2015 at 05:34:59PM -0400, Jeffrey Walton wrote:
>>> I'm working on an old OS X machine. I needed to perform:
>>>
>>>   AR=libtool
>>>   ARFLAGS="-static -o"
>>>   ...
>>>   make configure
>>>   ./configure ...
>>>   make
>>
>> Hrm. Your "$(AR)" is not really "ar" then, is it? It has been a long
>> time since I played with libtool, but what is the reason that you are
>> calling libtool and not "ar" in the first place. Is it that you do not
>> have "ar" at all, and libtool performs some other procedure? If so, is
>> there a more ar-compatible wrapper that can be used?
>
> This isn't GNU's libtool. It's Apple's libtool, an entirely different
> beast, which is an 'ar' replacement and is needed when linking
> Universal binaries containing code for more than one architecture,
> such as 'ppc' and 'i386', so the same executable can run on multiple
> architectures. This tool dates all the way back to at least NextStep
> 3.1 when NeXT ported NextStep to Intel hardware (i486) from NeXT
> computers (m68k). The name "Universal" is an Apple invention, but back
> in the NeXT days, they were called Multi-Architecture Binaries (MAB)
> or, colloquially, just FAT (for "fat"); there was a corresponding
> "lipo" command (short for "liposuction") to "thin" out "fat" binaries.
> NeXT's libtool predates GNU's libtool by a few years: May 1993 vs.
> July 1997, respectively. When an attempt is made to use 'ar' on
> Universal object files, it errors out saying that it can't be used
> with such files and recommends 'libtool' instead.

Thanks Eric. You did a much better job than I would have done.

JW

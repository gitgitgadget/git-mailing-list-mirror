From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] revert: make commit subjects in insn sheet optional
Date: Sat, 10 Dec 2011 01:14:50 +0530
Message-ID: <CALkWK0ki1r5AqYb8qyGHUNupTAhCa2TKwVgkrCpLr+zo_pCy9g@mail.gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-3-git-send-email-artagnon@gmail.com> <20111207070223.GC11737@elie.hsd1.il.comcast.net>
 <CALkWK0nkPB5WptJ9nSkSOif5_0R_f39Dg_HR3Rmg02hG_4Q1Tg@mail.gmail.com> <20111209193527.GD20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:45:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6Nk-0002zf-3b
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231Ab1LITpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 14:45:13 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38058 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1LITpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 14:45:12 -0500
Received: by bkbzv3 with SMTP id zv3so3270045bkb.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aUHMQ2RaYt81fXOVtHVSgh/rugR2rD7QDJDL5LEauLg=;
        b=n04sC6BFIuKWPvqPjCfOf1fpMX6/D4fJslTdmMIg6r3EdClAH/zwBocVm4quD3mzaN
         ErM8K2U9XPDYO8eT6Zznp6e2x9G1djApH5/SFUrDFGdaC9WaGS2Cbs0GN7Ex+19acbMw
         aMGzhvFDl2aaAX/a8tKQMeR627HUSiLuBgUtc=
Received: by 10.180.90.6 with SMTP id bs6mr11798454wib.63.1323459911235; Fri,
 09 Dec 2011 11:45:11 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Fri, 9 Dec 2011 11:44:50 -0800 (PST)
In-Reply-To: <20111209193527.GD20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186672>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder wrote:
>>> Ramkumar Ramachandra wrote:
>
>>>> [...]
>>>> While at it, also fix a bug: currently, we use a commit-id-shaped
>>>> buffer to store the word after "pick" in '.git/sequencer/todo'. =C2=
=A0This
>>>> is both wasteful and wrong because it places an artificial limit o=
n
>>>> the line length. =C2=A0Eliminate the need for the buffer altogethe=
r, and
>>>> add a test demonstrating this.
>>>
>>> Reading the above does not make it at all obvious that I should wan=
t
>>> to apply this patch because otherwise my prankster friend can cause=
 my
>>> copy of git to crash or run arbitrary code by putting a long commit
>>
>> Working backwards:
>> get_sha1() is what will finally misbehave: how?
>
> Not sure what you're talking about. =C2=A0I was saying that any commi=
t that
> goes from "git can segfault in such-and-such circumstance" to "git no
> longer segfaults in that circumstance" should loudly proclaim so!

That's what I'm confused about: how can I make git misbehave (let
alone segfault) after applying this commit?  In the previous message,
I was trying to work backwards to figure that out -- I clearly didn't
get anywhere.  In other words: what happens if an overly long (a
length that doesn't fit into a size_t) line is present?  How does
strchrnul() behave?  How do we work around this without imposing some
kind of artificial hard limit?

Thanks.

-- Ram

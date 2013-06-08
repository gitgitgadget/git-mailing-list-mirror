From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 07:25:32 -0500
Message-ID: <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 14:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlIDP-0006Vm-DT
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 14:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab3FHMZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 08:25:36 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:58829 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3FHMZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 08:25:34 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so4453006lab.2
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2nqWxPW+YiL1cJxnPJe4kJlhuWQd+E4jhEHdTl/tG+I=;
        b=a/C8970Oq6tRfyyJDGRFWQRs3bytzAomO9z9Ft05YVVdFNlTlJzOssQlte1vPKITzK
         9wqusC75L365GXMI4jO+gAORLgfTyG8xf8PyZTzRUQfkteYgWDSp6rmbxk5DslC8VZL9
         p3IpswCs7YfHG6sqH/zudhLid+H9gLaV5Sz3kf5upP7MCCpTc5WIdOCNQlHcf3H0o0Xc
         +vEP54jYwBjA2Dj0yJf00Kv/LAVOE/m5Z/oMCeWH1ac1Ea0HbcqXTZRc3jMfbN9JEpbw
         tjA9QdpjWJphXGi4yHjbST0fbM9GMptMG/V34RVX5RL7x8TMi+qzACXLBAfSbGXGcYlE
         WrXg==
X-Received: by 10.152.27.170 with SMTP id u10mr1295652lag.45.1370694332692;
 Sat, 08 Jun 2013 05:25:32 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 05:25:32 -0700 (PDT)
In-Reply-To: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226811>

On Sat, Jun 8, 2013 at 6:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jun 8, 2013 at 5:14 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, Jun 7, 2013 at 9:35 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Jun 8, 2013 at 5:16 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> This code is only useful for cherry-pick and revert built-ins, nothing
>>>> else, so let's make it a builtin object, but make sure 'git-sequencer'
>>>> is not generated.
>>>
>>> As you can see, the convention is builtin/foo.c corresponds to git-foo
>>> (and maybe more). Why make an exception for sequencer?
>>
>> Why not?
>
> And while we are at "why not", why don't you fork git?

That's not an answer.

>>> I ask because I moved
>>> fetch-pack from builtin out because of linking issues and I don't want
>>> the same happen to sequencer.c.
>>
>> I'm sure those linking issues can be solved.
>
> Yeah, I scratched my head for hours and finally gave in. Maybe you are
> better at the toolchain than me.

I gave it a try, but transport.c needs fetch_pack(), and transport
does belong in libgit.a, so fetch_pack() belongs there too.

This is not the case for sequencer.c.

>> I don't see why libgit.a couldn't eventually be the same as libgit2.
>> We need better organization tough (e.g. builtins/lib.a).
>>
>> If you are arguing favor of a more messy setup, then we should link
>> all the builtin/*.o to libgit.a, because the current situation just
>> doesn't cut it.
>>
>> For example, init_copy_notes_for_rewrite() cannot be accessed by
>> sequencer.c, and while it's possible to move that function (and
>> others) to libgit.a, it doesn't make sense, because it can only be
>> used by builtins.
>
> libgit.a is just a way of grouping a bunch of objects together, not a
> real library

That's what a library is.

> and not meant to be. If you aim something more organized,
> please show at least a roadmap what to move where.

I already did that; we move code from libgit.a to builtin/*.o until
libgit.a == libgit2. Done.

-- 
Felipe Contreras

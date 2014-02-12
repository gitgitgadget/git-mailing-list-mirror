From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 10:20:12 -0800
Message-ID: <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 12 19:20:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDeQT-00066F-Rx
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbaBLSUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:20:17 -0500
Received: from mail-ve0-f173.google.com ([209.85.128.173]:54753 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744AbaBLSUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:20:13 -0500
Received: by mail-ve0-f173.google.com with SMTP id jw12so435045veb.32
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o45mw9DG9b6Yn3aekAr82nxHbD3r9MR/WeOjLBtUu0Y=;
        b=XGi9GrxFEVdWaH9oOChHNgJtIxNaq9ksUdAz73rEi238/4paDxSqitsBSh54/Z77wC
         kvwk0ObxRBmfqg2TlHbBxSVsWASfjAE5xyMjqPMbNt3ZsyQw/FHzX+cQc1mTdldoxZe9
         q6k4JLJlykTM5E5+xBt42g06/+7S93XGIj0KRCHrHntpfITP0PE/BlWRcNkPLvhOU1VA
         j8bl6X6v0r/7Vx4dy9WktPr/vjoCgnFWb8H/FHLpH3FTfvL2d56I0TEyLDYEabeX6j9h
         CqifaCZffeEx6RpG0Rft/0IYvY8EAzSzLo5CFZPPFWTQQGEy4/Kk/ME6VfgcoUneHKGG
         wmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=o45mw9DG9b6Yn3aekAr82nxHbD3r9MR/WeOjLBtUu0Y=;
        b=CgSKJd4kF+xkcsbhtqdjGEUXJqrQFdTNPPcftiHJ1CX+W5Jdt5tfydakWoQzmQTkrh
         SkW38LYPPkQcsPIDOWJ11/dWJ9rp0gziAZmmJAxro6JJ0TEqXwe9PSKtB3pwWXG8dv6y
         t11cKKBuVSI40qxSPOzSVDoSki5bsBWDs9BlUFaddqlPLtBTDbe2JXuBr4NYNnUOShhw
         e43nQrEmPff3LMsIMeUStamaGBCvGY4Zn2KnPz8RA/TPNyuN6P/pfdCjAaBUynXp/Dnx
         sjqu6Gr8xMkeNKEZ/zizYil+7OHWgmsh58i+16VyYekGG+9bu6bViUcKk8U2JJ5mnRxL
         H+mw==
X-Gm-Message-State: ALoCoQmsm1RFlN0X9MZvE6yxVnmNWL/03+N7/jqSfEQ3R4B6n6IGfYR4BLduU9MYLm5Hv7NRiySZvz7izGkVP3FuCg7StioTZTXKIA4h7sUeBXupQB6K5ZpWdHT2OrcCZ7tt+2h7FpaGNrwC8yJFJfIhuSZMnkeXHPCTfWSEKDBzxPCR1mGoZEM6W+DFimj43ZTt4LhdcgGn
X-Received: by 10.220.164.80 with SMTP id d16mr33228277vcy.15.1392229212392;
 Wed, 12 Feb 2014 10:20:12 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 10:20:12 -0800 (PST)
In-Reply-To: <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242002>

On Wed, Feb 12, 2014 at 3:59 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Wed, Feb 12, 2014 at 2:54 AM, Stefan Zager <szager@chromium.org> wrote:
>>
>> We are particularly concerned with the performance of msysgit, and we
>> have already chalked up a significant performance gain by turning on
>> the threading code in pack-objects (which was already enabled for
>> posix platforms, but not on msysgit, owing to the lack of a correct
>> pread implementation).
>
> How did you manage to do this? I'm not aware of any way to implement
> pread on Windows (without going down the insanity-path of wrapping and
> potentially locking inside every IO operation)...

I don't want to steal the thunder of my coworker, who wrote the
implementation.  He plans to submit it upstream soon-ish.  It relies
on using the lpOverlapped argument to ReadFile(), with some additional
tomfoolery to make sure that the implicit position pointer for the
file descriptor doesn't get modified.

Stefan

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] On the --depth argument when fetching with submodules
Date: Mon, 8 Feb 2016 12:38:20 -0800
Message-ID: <20160208203820.GA22317@google.com>
References: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
 <xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
 <FA2DA97F-D944-4784-8297-E2885F197AC0@gmail.com>
 <CAGZ79kYT8EWv6T=3bW_fH+_Q8p74p=JyzbErB+TOPO2VtVQHgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:38:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSsaG-00060M-MO
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 21:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbcBHUiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 15:38:52 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34329 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356AbcBHUiv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 15:38:51 -0500
Received: by mail-pa0-f49.google.com with SMTP id uo6so80304169pac.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fe7b3Co81PSioB5Al0GiFMQf04Vtp3F0O0JSSOvN/7o=;
        b=KyEMptasMDfiNz59rQCxJzlt7feazg0SKAsNqXfncfPVmU8L6SWw75J7LzTJfRFu6T
         fppIsytR5kTrOsUy52djPDflBIR8Z4x0N7/uBdHP/LP+E2SrU0oyOZgSob4FhRPrh0NE
         JttcKbtpcNBGYn7CXQ7+Qfm6Eo8wwLBl3U+6Tkiv7hv6VerH1NMrmilgv6cyoTDbcXiP
         yDHhI3LV6RbkMwXBWMS9kIe+Q/YCT2DBmhawO3Z7KD0CcLe+VTg6KBWPXI93VrhJOtaX
         9KZitDGInB+jAZWtMopaHktgfcByZUXsiIVGHZy8rSx6yCb767udQA7gH6wWBB4wAMGY
         N50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fe7b3Co81PSioB5Al0GiFMQf04Vtp3F0O0JSSOvN/7o=;
        b=giQgw1eQ56HPaYVujCtoyldeovAP3yblupk0+o4OMV5ZKqXaV8d25pc655XYusGEo8
         IsxM/+0YWIR9Z4f3lj60YUaoJnNIUeg1lzhiqrVp52GsT1k7ygaI9jJdKKXkHgwAzqWH
         OTm7NonvOV4+Lc8UmooEFjuzZNUlVO8EnubN/f0dAT1QGZ1X8bGDtpz0XI9IQV8eSIyy
         /ZHYYHwJzmVRV44/hx34mePsgObyYgosF8xJe8ELY8WYppGNpaRoQtsPD+o3z7uMBeBs
         ZjgKt2jPxnj4K5QqVuJuKB9hFqbKbxiSLGwDf+ApgWasyFbPKpc8fcV3rkownCyxlfj5
         h2QA==
X-Gm-Message-State: AG10YOQxm9Wq2yVlfKi/WOmYVUSFeGPBYnwLiaZWq887YI8fCbRmYQhx+BrS+NBIsPBJ0A==
X-Received: by 10.66.233.197 with SMTP id ty5mr3998549pac.145.1454963930661;
        Mon, 08 Feb 2016 12:38:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:7449:5660:2e6d:5285])
        by smtp.gmail.com with ESMTPSA id tp6sm45443579pab.25.2016.02.08.12.38.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Feb 2016 12:38:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYT8EWv6T=3bW_fH+_Q8p74p=JyzbErB+TOPO2VtVQHgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285802>

Hi,

Stefan Beller wrote:

> 1) You work on the superproject and don't care about the submodules.
> In this case you want the superproject non-shallow and the submodules
> may be just fine with depth 1. (Think of libraries pulled in via Git instead
> of via the build system)
>
> 2) The superproject is a collection of submodules, i.e. not much content
> in the superproject except for the submodules. You want to work
> in the submodules, i.e. you want the suberproject shallow, and all
> submodules deep.
>
> 3) same as 2, but you're interested in only one (or a few) submodules,
> which means you want superproject and most of the other submodules
> shallow, but one submodule needs to be deep.
>
> So covering 1 and 2 is easy, 3 is complicated.
> For 1) we can make it so, that the depth argument is not passed on,
> but only covers the referenced submodule commits, and then we
> introduce another switch "--submodule-depth" to cover 2).
>
> For 3 we don't know which submodules the user is interested in,
> so the user needs to unshallow the interesting submodules themselves
> after doing a "--depth 1 --submodule--depth 1" clone. "--depth 1" sort of
> implies "--submodule--depth 1", though.

What does a --submodule-depth other than 1 mean?  For example, if I pass 2
there, does that mean I want depth 2 in all sub-sub-submodules, and
sub-sub-sub-submodules, etc?  This has similar problems to the existing
"--depth=2 --recurse-submodules" options.

If I understood the use cases you are describing correctly, you'd want two
relevant options when cloning:

 --depth: how deep of a history to fetch in the superproject
 --shallow-submodules: whether the history in submodules is interesting

If the history in a submodule is uninteresting and the submodule
supports fetch-by-sha1, then a fetch-by-sha1 with depth 1 for any
commits needed by the superproject would get all objects needed.

--depth could imply --shallow-submodules in the same way as it implies
--single-branch because when people pass --depth they are usually
trying to avoid transferring too much data (for disk space or clone
time reasons).  Then someone wanting non-shallow submodules can
explicitly pass --no-shallow-submodules with --depth.

[...]
> So for fetching I think we need to have a "--try-to-get-commit <sha1>"
> argument for fetch, which depending on the server capabilities and
> the history obtained otherwise may try again to fetch the exact sha1.

The case of servers without fetch-by-sha1 is a hard one.

 1. One approach would be to use the ls-remote response to see if
    there is a ref pointing to the particular SHA-1 needed.  If there
    is one, we're all set.

 2. If there is no ref pointing to the desired SHA-1, fetching HEAD
    (or the branch named in the submodule.<name>.branch configuration)
    with full history is possible to work as a fallback.

 3. If the history of HEAD also doesn't contain the desired SHA-1,
    fetching the refs named in the default refspec (refs/heads/*,
    refs/tags/*) might work.

 4. If even then the desired SHA-1 is unreachable, then there's
    nothing left to try --- it's time to error out and have the user
    contact their server admin (as they'd already be doing today
    without --depth).

Perhaps some people would want to error out earlier.  Some
configuration or a --strict-shallow-submodules option could be useful
to error out if step (1) fails.  That would allow the user to be sure
that the submodules are actually fetched without history.

The missing functionality from fetch/ls-remote/etc is a way to read
the server capabilities that were sent with the ref listing to tell
whether the server supports fetch-by-sha1.

> On Sun, Feb 7, 2016 at 5:32 AM, Lars Schneider <larsxschneider@gmail.com> wrote:

>> On top of that I think Git's error message is really confusing if
>> you clone a repo with "--depth" that has submodules and Git is not
>> fetching the necessary submodule commits:
>>
>> Unable to checkout '$SHA' in submodule path 'path/to/submodule'

Yep.  Thanks for working on it.

This confusing error can appear without --depth, too (if the commit
named in the submodule is not an ancestor of anything in refs/heads/*
or refs/tags/*).  For example, this happens in gerrit when people try
to check out a change under review in a parent project that imports a
change in a subproject that has not been accepted yet (it is reachable
from refs/changes/* but not refs/heads/*).

Thanks,
Jonathan

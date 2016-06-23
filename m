Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB7B1F728
	for <e@80x24.org>; Thu, 23 Jun 2016 04:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbcFWEOt (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 00:14:49 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35766 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcFWEOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 00:14:48 -0400
Received: by mail-io0-f180.google.com with SMTP id f30so61650045ioj.2
        for <git@vger.kernel.org>; Wed, 22 Jun 2016 21:14:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=87INyCSLoxyd0AatgSefE4pAjBpI0DowRUJ1mfBuQZA=;
        b=Q0o3++NnzU6aqPxxI/lX6ve0SQ4UNcYVCLo8tBBX1o1zVImG5Yji/DQijVGdCevwT1
         8u8e6Z+DHLFU2BfVuP5pmZTBwC9xtWW4n4LEBKtKw0HcWrBcRECyNTNJOc7DdDJ5Y9v+
         jM3xD7UYLX5rT4RzCut6wtFjQjb+hPjDMXLNncIl8G5L/2v9ndubr2wks1oZG3PQA8e9
         jd0PBJ031MGfDS9e/b9IkmLJ9jjLxjNoJEyqEy7i00Xz2cCqRqzRqXGsbvzHxKjn1AM8
         6n8+aakvMA3s+A1y3UlR4C02dFelisqD7U/qBfq57nalaBLLm00SYSDQzeL39+xc+jw0
         Etvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=87INyCSLoxyd0AatgSefE4pAjBpI0DowRUJ1mfBuQZA=;
        b=KzOgjO4KvKpz4Jmht7NwNnje/xVEnTpwWKL5Nhg6rSYz66IP6+nJWRc0PklriaTmv/
         FphG3gkzBNSetuQGCZZgCqJpFFe3fWowJ1i91Bhv4JbJHm5ZzCe31ije+rasqx1ixJlk
         BrHoM0M/KHo2zyYQmdOKpyvjUKWHa/4pjUQJVUixe9BmcQ0GE1KY4jN2Rar+k0gDHr+c
         JcazW0eiOTRDOVMd0UUv2YbcJNL+Oyy+6WGkYp5wHpxVLHKo8pfZ3vW0CFuZMlBg3KgN
         MBceEJCDHh62eW/IY3r9mFdjNM/CSZlSbWMHo4xglgED0EEUZdZmTB3M8lXAytFLpY38
         LnVQ==
X-Gm-Message-State: ALyK8tLoQWamH2l4/m7v73Vez+ZQ+rXRUJaRTYh5gmgJOLI5DCHs37gJ3Lt/hmn2okxbGUmcQ6XmsqgINz//sQ==
X-Received: by 10.107.8.220 with SMTP id h89mr44773895ioi.95.1466655287703;
 Wed, 22 Jun 2016 21:14:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 22 Jun 2016 21:14:18 -0700 (PDT)
In-Reply-To: <20160622195932.GC1697@sigill.intra.peff.net>
References: <20160622190154.GA17442@duynguyen> <20160622195932.GC1697@sigill.intra.peff.net>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Thu, 23 Jun 2016 06:14:18 +0200
Message-ID: <CACsJy8Dig1ENn7A5RsMd7YqqYEKOX5xXVh8ahFQy-KjW+m_nWQ@mail.gmail.com>
Subject: Re: Use docker for _some_ testing?
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 9:59 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 22, 2016 at 09:01:55PM +0200, Duy Nguyen wrote:
>
>> Which makes me think, could we use something like this to make sure
>> people (on Linux) can test more obscure cases? Sometimes there are
>> featues that require some dependencies that are not always present on
>> the developer's machine (http server is a big one, locales come close
>> second, then there will be lmdb and watchman in future...). With this,
>> said developer can do a final test run in docker covering as much as
>> possible.
>
> Neat idea. This should also cover some other distro-specific issues like
> "what's your /bin/sh look like", etc. It's a lighter-weight alternative
> to testing alternate distros in a VM.

It's lighter-weight and also helps skip preparation. Everything is
scripted, if you want distro X, it's just one command away. The VM way
would require you to go through installation process with lots of
clicking and typing (unless you go full cloud solution like OpenStack,
not really suited for single dev use).

It's not just distro-specific. Not every developer has enough stuff
installed to run all tests. My machine is svn-free for example so I
never run those tests. Same story for pcre (have it but not enable it
in git...). We can try to run both gettext and no-gettext
configuration... Devs still have to install docker this way, but at
least i could keep my laptop "clean" from unwanted stuff and still be
able to run lots of tests.

> But I think most of the interesting cases are more exotic than
> distro-to-distro. Things like HFS+ normalization, or weird shell
> toolchains on proprietary Unixes (but maybe there are docker images for
> those systems?).

I don't follow docker closely, but if it's still a container
technology (i.e. sharing host kernel) then different OSes are out of
question.

> So I dunno if it would prove that useful for day to day use or not.
-- 
Duy

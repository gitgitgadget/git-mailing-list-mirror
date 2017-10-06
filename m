Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8200B20372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdJFW5W (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:57:22 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:48043 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdJFW5V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:57:21 -0400
Received: by mail-qk0-f172.google.com with SMTP id m189so15289902qke.4
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qltC46WW9tYIqLqxDHI4TBa7bDeA76dnR5jf8RNoO7k=;
        b=PNshNbX7yATN0jBOnMMyPvYNJHgz8ZnIUW6tfwGwtsYIVMz5AXG2FITXSppb2SkqN+
         gcDL9h5FWbVln+FpztY0jNaNJgkCOpNIZU792woL7BpSL7qmkkldpdhtYNCD4c4ZlOJR
         0fsy7pSBKXCZ0lSO+l8DtpcoXFag2C6G6jUW8qgdaFxFQgan4LJi1Ln/ZuCa6SHjZRp7
         8Vk9jtLNwEpBtvN6PxkvBh1NhQDewo7H4WtNxmQ/SN7lJYiAUHSKatWFmXzdm6QvTNlO
         hnfUGGEd20duu3m4ftLrDsKQC82d+AZ5Ug4mgOzjoKikTvCOYwioCFIf4qTpAX8eK5qG
         v4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qltC46WW9tYIqLqxDHI4TBa7bDeA76dnR5jf8RNoO7k=;
        b=mhpBHhSH/2kfpju2MqFtfth0OMc9HRk/N5YUlMNFvOWfpVMiQzl8ie4HMI0LePVMVq
         q6Kq7+ud9DVZsBlIbrIcDHu454BoEqQykaM13FY5jM40Zixbmm6qAkeS8ldCYQrla9E5
         RPJ7Q86eCMREiSZESMxvDcLAtbV77NCijysC1Lvr8PVIrgETcCV/2cizpk76vhP3kMY9
         qtJD1e46G05CKyuvaH8xN9WGk7OwEOAoogLMAyl3ZhLlO+GTua+Ix8jU3Q6klCjs0e4Y
         Xq+VBklimGK6zxYV1kOBNwx1W5h+cE+6g5ppHvMefCHLGzdRcvV6dlvsH82gRYghxji0
         6QWg==
X-Gm-Message-State: AMCzsaUxf4BQiYHD/4IdLcJlfmDzX/QntUpD2qVO9kxeKne7Xsg4Y/Bc
        WCvnBteEtOre3wJGZj+H5qg/fuXWwUzBV3r3Ax/hzg==
X-Google-Smtp-Source: AOwi7QAeY0LQt5O1Afa27GQcSpJbOAbnzKMc8/F7wp4Lrp4OGvrwSbj1raZYIBKjJU8OFJNSPXKQSxlLYvrG1j5a1CQ=
X-Received: by 10.55.127.7 with SMTP id a7mr566614qkd.45.1507330640138; Fri,
 06 Oct 2017 15:57:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Fri, 6 Oct 2017 15:57:19 -0700 (PDT)
In-Reply-To: <20171006222544.GA26642@sandbox>
References: <20171006222544.GA26642@sandbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 6 Oct 2017 15:57:19 -0700
Message-ID: <CAGZ79kZofg3jS+g0weTdco+PGo_p-_Hd-NScZ=q2UfB7tF2GPA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] implement fetching of moved submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 6, 2017 at 3:25 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> The last iteration can be found here:
>
> https://public-inbox.org/git/20170817105349.GC52233@book.hvoigt.net/
>
> This is mainly a status update and to let people know that I am still
> working on this.

Cool. :)

> I struggled quite a bit with reviving my original test for the path
> based recursive fetch (first patch). The behavior seems to haved changed
> and simply setting the submodule configuration in .git/config without
> one in .gitmodules does not work anymore. I did not have time to
> investigate whether this was a deliberate change or a maybe a bug?

I think it is deliberate. (We wrote this man page "gitsubmodules"[1] and there
was so much discussion on "What is a submodule?". Key take away is this:
* a gitlink alone is not a submodule.
* a submodule consists of at least
  -> the gitlink in the superproject
  -> a mapping of path -> name via
      $(git config -f .gitmodules submodule.<name>.path)
  -> Depending on config in .git/config or the existence of its git directory,
      it may be [in]active or [de]initialized.

[1] not to be confused with "gitmodules" or "git-submodule"

Sometimes we accept a plain git-link without the config in .gitmodules,
(a) due to historic reasons or (b) because it seems sane even for
a repo "that just happens to exist at the gitlinks location"
(example git-diff)

> So the solution for now is that I write my fake configuration (to avoid
> skipping submodule handling altogether) into a .gitmodules file.

I'll try to spot what is fake about the config.

> The second patch (cleanup of a submodule push testcase) was written
> because that currently is the only test failing. It is not meant for
> inclusion but rather as a demonstration of what might be happening when
> we cleanup testcases: Because of the behavioral change above, on first
> sight, it seemed like there was a shortcut in fetch and so on-demand
> fetch without submodule configuration would not be supported anymore.
>
> IIRC there were a lot more tests failing before when I implemented my
> patch without the fallback on paths. So my guess is that some tests have
> been cleaned up to use proper (.gitmodules) submodule setup.

I don't remember any large recent activity for submodule things lately.

> So the thing here is: If we want to make sure that we stay backwards
> compatible by supporting the setup with gitlinks without configuration.
> Then we also should keep tests around that have the plain manual setup
> without .gitmodules files. Just something, I think, we should keep in
> mind.

But do we want this?

Without the name<->path mapping, we can only have the "old style"
submodules, that have their git repo inside its tree instead of inside
the superprojects git dir.
So renaming/moving "old style with no name<->path mapping" will not
work. (That may be an acceptable trade off. But then again, just providing
the mapping, such that the superproject can absorb the git directory
of the submodule for this use case, doesn't seem like a big deal to me.
Something you want to have anyway, for ease of use of the superproject
w.r.t. cloning for example)

So while I do not try to deliberately break these old behaviors, I'd rather
want us to go forward with a saner model than "if we happen to have
enough data around, the operation succeeds", i.e. ignore anything
that is not following the rather strict definition of a submodule.

FYI: Once upon a time I found "fake submodules"
http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
Last time this was discussed on list, this was considered a bug not
worth fixing instead of a feature IIRC. (Personally I think this is
a rather cool hack, which we may want to abuse ourselves for
things like "convert a subtree into a submodule and back again",
but we could also go without this hack)

> Apart from the tests nothing has been added in this iteration. Since I
> finally have a working test now I will continue with reviving the
> fallback to paths.

I'll have a look.

Cheers,
Stefan

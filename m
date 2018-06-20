Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544611F403
	for <e@80x24.org>; Wed, 20 Jun 2018 19:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeFTTK4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 15:10:56 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38369 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFTTKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 15:10:54 -0400
Received: by mail-yw0-f193.google.com with SMTP id w13-v6so240366ywa.5
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l8Q4EFdXD0MXWcb4ytS40vXyZFKyFgfUrzfx5Bj6sEY=;
        b=beqYVN09LK40V38r9uA8CAw9ZZ5lcA6fauNSqJS+uWc2wGw+6xlAg/tgmOagbaXieu
         qluUnHi4UV7Fxt45b4689YC18eGOg/dIpvLiWJ2h8MSvazQj7cfApfRyqy2t2dcuZuv8
         LAJKjNY8y7VXcc6RtNwx4RXh/PV3Cf4z9mB75ePSK9T1fRvYh3FwK0b0t8A4U2IKgKfn
         s+D7+ns0kxls21wlYdfTmznPrSdT3mPCX8GMPFQGnzxqh9EaDpgua9WgSQRTlSW8yEnE
         dZXcHebS7bBZKtMViVXlyw33QkNrIZ9/5n5seOLu69M/7L4csa+1MZcBuQ9inufBO0ng
         ZKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l8Q4EFdXD0MXWcb4ytS40vXyZFKyFgfUrzfx5Bj6sEY=;
        b=bovjZqaD0cj1cF0SwVsG2Vko4fxB9jJOkLNXXx7LgvZRO+VLlkO5c1ZMVKn1mmTP95
         3yICEnsl1T5f9g/Azr/b2KMRr0XpQfnn2h/jTAsId8YTBS1ThyBMWpgtc345/fDuZAUD
         iflXoa7O/i0Irx4VH5xxpPfn85tZByayAIgQaO+ll0SBivJFdUUtbv5zumWKhLe/AWwT
         kjoPSruzcDqRDJOpWAEAQMve/QL351FrZnOJcljb+0d5eaduXgBQ+EGEPnNb3hcvWfBM
         8YuXzuntv6i5GfLANQDizR167Z69Jrtu8EMzMd5lffQMe9q4ws7QhCjC7uYNC+Lwuu87
         fkbg==
X-Gm-Message-State: APt69E3QRq4jGH2xfrWlsrZg8sdW8+0gyYPpIT2fsvUwetG6Jshh8/Dr
        NoVKu/iM3UaDHV7bxjEwCMQYtiIyI2jaU+4khVssYw==
X-Google-Smtp-Source: ADUXVKIB5G2b7exppkPVyXmdGEpGI+eFP9VrDDx6WyyK0sRyLrN26+vbaeq75qzOp9M0liIFgTi4gZsBSPoJTFMxk4k=
X-Received: by 2002:a81:3743:: with SMTP id e64-v6mr8906824ywa.340.1529521853852;
 Wed, 20 Jun 2018 12:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-2-ao2@ao2.it>
 <CAGZ79kag=1h506FGg72_F9Rmz4nqPN19kaywfTtD3WnNWnxD9w@mail.gmail.com> <20180620200634.13b47725cfd1e2dfb1cd482e@ao2.it>
In-Reply-To: <20180620200634.13b47725cfd1e2dfb1cd482e@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Jun 2018 12:10:42 -0700
Message-ID: <CAGZ79kaMbGdJjooqWLiNOabmujhNKKKJQb_HrZ4YUMVMQ--KbA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally useful
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio!

On Wed, Jun 20, 2018 at 11:06 AM Antonio Ospite <ao2@ao2.it> wrote:
> I get that the _content_ of .gitmodules is not meant to be generic
> config, but I still see some value in having a single point when its
> _location_ is decided.

I agree that a single point for the _location_ as well as the _order_
(in case there will be multiple files; as of now we have the layering
of .gitmodules overlayed by .git/config; IIRC I explained having
an intermediate layer in our conversation to be useful; See one of the latest
bug reports[1], where an intermediate layer outside a single branch would
prove to be useful.) parsing are useful.

[1] https://public-inbox.org/git/DB6PR0101MB2344D682511891E4E9528598D97D0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com/

Sorry for not explaining my point of view well enough, let me try again:

Historically we did not store any config in the repository itself.
There are some exceptions, but these configurations are content related,
i.e. .gitmodules or .gitattributes can tell you meta data about the
content itself.

However other config was kept out: One could have a .gitconfig that
pre-populates the .git/config file, right? That was intentionally avoided
as there are many configurations that are easy to abuse security wise,
e.g. setting core.pager = "rm -rf /"

And then submodules entered the big picture. Submodules need quite
a lot of configuration, and hence the .gitmodules file was born. Initially
IIRC there was only a very simple config like url store:

  [submodule.<path>]
    url = <url>

and that was it as it was just like the .gitignore and .gitattributes
related to the content and transporting this configuration with the
content itself seemed so natural.

However then a lot of settings were invented for submodules and some
made it into the .gitmodules file; only recently there was a discussion
on list how these settings may or may not pose a security issue. It turns out
we had a CVE (with sumodule names) and that got fixed but we really want
to keep the .gitmodules file simple and ignore any additional things in there
as they may pose security issues later.

With that said, how would you write the code while keeping this in mind?
If you look at builtin/submodule--helper.c and builtin/fetch.c, you'll see that
they use

  config_from_gitmodules(their_parse_function);
  git_config(their_parse_function);

and config_from_gitmodules is documented to not be expanded;
the config_from_gitmodules is singled out to treat those settings
that snuck in and are kept around as we don't want to break existing
users. But we'd really not want to expand the use of that function
again for its implications on security. Right now it is nailed down beautifully
and it is easy to tell which commands actually look at config from
the .gitmodules file (not to be confused with the submodule parsing,
that is in submodule-config.{h, c}. That is actually about finding
submodule specific name/path/url etc instead of the generic
"submodule.fetchjobs" or "fetch.recursesubmodules".

----
So far about the background story. I would rather replicate the code in
repo_read_gitmodules in the submodule-config.c as to mix those
two lines (reading generic config vs. reading submodule specific config,
like name/url/path). And to not mix them, I would not reuse that function
but rather replicate (or have a static helper) in submodule helper,
as then we cannot pass in an arbitrary config parsing callback to
that, but are bound to the submodule helper code.

> > I think extending 'repo_read_gitmodules' makes sense, as that is
> > used everywhere for the loading of submodule configuration.
>
> I would follow Brandon's suggestion here and still use
> 'config_from_gitmodules' from 'repo_read_gitmodules' to avoid code
> duplication.
>
> I will try to be clear in the comments and in commit message when
> motivating the decision.

Rereading what Brandon said, I agree with this approach, sorry for writing
out the story above in such lengthy detail.

Thanks for picking up this series again!
Stefan

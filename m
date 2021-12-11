Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84752C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 10:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhLKKq3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 05:46:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44451 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhLKKq3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Dec 2021 05:46:29 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9914E5C00A3;
        Sat, 11 Dec 2021 05:46:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 11 Dec 2021 05:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=vRS0M9d1M2/6+x1HBw8I8f7bEIv
        gGETwIWhc7TLUS8s=; b=dCX12Hugs2pAPTXFjYCMjntARMfr+9gjadsxIK3pTCw
        X/FEjLhWujGD8w7ih/qlvBjzLQ27DunRdYy7iEGHWn8PATjfMWce/I0/H92HGnY0
        U3jxJWMPdsA+P6mqVnd2Kg7UOSzXDO3K9bs/8f+Ku1njY5tuhBkkqNn7sNL4ciIC
        7s4GGbdwvm/mlrvxuwhdjjrBM+WZFlaV63SFb21RdIa9EAR72vuLfnVVgO32BuCb
        6dV+geoRKWW5kcFxxRPlbdt163OXF2V0nwHxrrPVwSRGvTHpOWjRVL+6plix+LH2
        h1UoDBiqp1jImMx5bQEXImcY9WPJzNIkd1BARzrgBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vRS0M9
        d1M2/6+x1HBw8I8f7bEIvgGETwIWhc7TLUS8s=; b=bPysIU37X/GckwcxhYYhgm
        bDLplXmsjKv5FJzjaihXw1dKn8gD5td9R2foa1UuQZeQIaEWelcfGxRRBbyuF3Cs
        NZUgXSIQGxmfdeANs/Vd5/pPbagMG4isWmqZEiIAYraMY6ZHDoQfTBr0wtUsAMJC
        32Ur1ihT+ZijScqywMhBi07b2gHXZwg/AcoGVcP6KpxWxUYINsUbE18vPlLWHpww
        WhwCyuohgfKPsAFpmotzqC4sIhVbEQJc8BnSLh/FgNYii6ewVjcXya5cpjO2AEH9
        xUGhqqoh0y/ZNGg0ifLaFsKtohx6+pXwOz9/xLtZZFkymt+uedBkCu1RxOpBuBvQ
        ==
X-ME-Sender: <xms:hIG0YUq5Y32D2RnDJnUwNt6reuCr1BCwFOdf34mQegFT5n2ZjnNz3Q>
    <xme:hIG0Yap8HEBiGTRzzJOHVRu_TDgF7rNgMSvJMQZXcE9R6n31ONi_0NbLli_Wpvn6y
    SEqQETxWq4oY3fhBg>
X-ME-Received: <xmr:hIG0YZMoOjTyqkVRU9BvQPU-WTCdM89P6eu8WCO_20EltRGXwcSbnvInU6HdstwuIIcyDaSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeeggdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhnrghn
    ughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvg
    hrnhepvdejieeflefhteeihffhtdfhfeekhffhuedttedvgfevgfevfeehfffgkeejfeeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvg
    gvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:hIG0Yb7EnqMTONv9s-LAyOnAo505BoZpWb_o-zftdmAOQzqBHTNMtw>
    <xmx:hIG0YT49yK6D2uiyat4LSCW7qi6Ov2zxeXvYS-oxIXwr4dW7mOWHcg>
    <xmx:hIG0YbhjVgw3y8uc2CASk4dkTxWAtbuoVo15V5N4LZM8Z01SChSuUw>
    <xmx:hIG0YQsFuv58oZfeJL7z1o0k08DVpXcmz4YgW-IZv_evTVk1NsBB-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Dec 2021 05:46:25 -0500 (EST)
Date:   Sat, 11 Dec 2021 11:46:23 +0100
From:   Fernando Ramos <greenfoo@u92.eu>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v4 2/3] vimdiff: add tool documentation
Message-ID: <YbSBf0eLh3AXiGnV@zacax395.localdomain>
References: <20211204090351.42369-1-greenfoo@u92.eu>
 <20211204090351.42369-3-greenfoo@u92.eu>
 <CAJDDKr77YQKJj15V52Rs=LPRMZVSkbpV8MWFDWNuYf4jqqCajg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJDDKr77YQKJj15V52Rs=LPRMZVSkbpV8MWFDWNuYf4jqqCajg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/09 06:58PM, David Aguilar wrote:
> On Sat, Dec 4, 2021 at 1:04 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> >
> > Running 'git {merge,diff}tool --tool-help' now also prints usage
> > information about the vimdiff tool (and its variantes) instead of just
> > its name.
> >
> > Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> > ---
> >  Documentation/git-difftool--vimdiff.txt  |  40 +++++
> >  Documentation/git-mergetool--vimdiff.txt | 195 +++++++++++++++++++++++
> 
> 
> Should these be referenced from elsewhere in the Documentation/
> tree in order to make them more discoverable?
> 
> Documentation/git-{difftool,mergetool}.txt seem like they should
> include or link to these.

Those files (Documentation/git-{difftool,mergetool}.txt) contain this piece of
text:

    --tool-help
        Print a list of diff tools that may be used with --tool.

When you then run with "--tool-help", not only the list of available tools is
listed, but also a short message explaining how to obtain more details is
presented (for those tools that have more information):

    vimdiff 
        Run 'man git-difftool--vimdiff' for details

In other words: there is one level of "indirection" that decouples the
documentation of each tool from the generic documentation contained in
Documentation/git-{difftool,mergetool}.txt.

Thanks to this, when documentation for a new tool is created in the future, as
long as the "diff_cmd_help()/merge_cmd_help()" functions are overwritten,
everything will "just work" without having to edit
Documentation/git-{difftool,mergetool}.txt each time.

I thought this was the best option but I have not problem adding a reference to
it if you prefer that (maybe at the end, in the "SEE ALSO" section?)

Let me know what you think.


> > +merge_cmd_help() {
> > +       echo "Run 'man git-mergetool--vimdiff' for details"
> > +       return 0
> > +}
> > +
> > +
> 
> My understanding is that we prefer "git help" instead of "man" when
> providing hints.
> 
> That means we should suggest something like this instead:
> 
>         echo "Run 'git help mergetool--vimdiff' for details"

I originally typed that, but then I noticed something in my system: all entries
in "Documentation/" seem to be available as "man" pages, but only a subset of
them are also available through "git help". Examples:

  * man git-mergetool        --> works
  * man git-mergetool--lib   --> works

  * git help mergetool       --> works
  * git help mergetool--lib  --> does not work!

That's why I ended up using "man".

PS: Now that I have revisited the issue, it looks like the command that is
failing is trying to run "man gitmergetool--lib" under the hood (notice there is
a missing "-"). The problem seems to be in "builtin/help.c:cmd_to_page()":

   if is_git_command(x) 
       return xstrfmt("git-%s", x);
   else
       return xstrfmt("git%s", x);

Because "mergetool--lib" is not a regular git command, it removes the "-". The
same would happen to the new "git help mergetool--vimdiff" if I add it. Is
this the intended behavior?

There are two options:

  A) This is actually an error in help.c logic that needs to be fixed and then
     I can update the docs to "git help mergetool--vimdiff".

  B) This is the intended behavior and I leave "man git-mergetool--vimdiff" in
     the docs.

I would say the right option is (A), but need your input regarding how to fix
it.

Thanks.



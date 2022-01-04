Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F96C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiADUi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:38:58 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35361 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231175AbiADUi5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jan 2022 15:38:57 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E24CB5C02E7;
        Tue,  4 Jan 2022 15:38:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Jan 2022 15:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=y8gLVTfnV9pG84u35RJJLaxcoZw
        F5fT1wPl/7TgMeGg=; b=ZZKY7uLugabXLDcAy3RGVR6GrQSgl9el/G5gbEjXhnw
        diEW6T5z2HJgrUgpB4lbULgida8WBgYSnGuBufUlYnUmbQtm5EaM5HJmToJOdBPQ
        Ahf2pilunQmycFBZTyNCALdwvpXxRqgKT7K4Do/cRmcx526kzKEOhSEI/xD49QaI
        DTYxeg3fXsIqs3ERDzac+R8XDVfUP4H0aMjyKRyrmMaDytOhA10eU/0F63PGreJi
        GASDh5fMiCFGNWNOjky2w5nFuzaLdiT512aB9bCR/kLI/dP/5/2dbjZbyLr8WX3P
        PviUA7wpJthhEHR7+2cupYfW49PNJon2hC47Cp2XRTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y8gLVT
        fnV9pG84u35RJJLaxcoZwF5fT1wPl/7TgMeGg=; b=ZJD/lPS/55jnypmXnpTVgv
        lz2f0hNkXNVKq8yPwqLxS29M0YDGaCVVzWU/gGswM2ODyeSUCCMCwrNEavitjj9b
        /N2zoAlEb1rXhr/XiOPkp4/8SqYNUdqtqKw8o5GtM96mxoBlIZJQp7gjlTNbMcvY
        k78A+23WoOWUhYx+LyHFC9w4aVKvjFBDj7TNveHZzFWcjOiSCZD6BPrlFv7Kumbu
        39yFRDgyDUd/9S9De3YyCfHqERu+Quk2fHk3vsz4sho8aGjUhU7QhDsQepjeyAZR
        QLRStNmlel2ntRr1WPvNk8QQhCuNexV75j3trsxsTVkvWQU5Z30FaxWsnglHiYdA
        ==
X-ME-Sender: <xms:YLDUYTGHsC_OnNUb0FT-BBI10PKEhnAF49NWSbYU98pIO5hb47vK4A>
    <xme:YLDUYQWywU6JNiXTq0fBRAVRHGusM7gXTrLJmXrv1xB6Q4TtHxT5XzubHWr__y6Y6
    xUMdTxrUBo4VvXZBw>
X-ME-Received: <xmr:YLDUYVKiZfjk__47TqDbCfpJnDPZWkxmI3Sk4sIKKlUit3DIfDLkHz83LHQ_Ocd3UmxbeT5R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeffedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepvdejieeflefhteeihffhtdfhfeekhffhuedttedvgfevgfevfeehfffgkeej
    feehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:YLDUYRE1lxfPVufk6Azt9eW8FFE1nEf0YOBdCzS2oErRAjk8i6VjiQ>
    <xmx:YLDUYZWi_srekRKWzeM8ZI8KYCZaNofhjh4tQ6LwtR8Yv0NoyFspSQ>
    <xmx:YLDUYcOzv8znonJeWAB9crqUFeM6MFVBid_n0EyPtCJfmzMS5oAYyw>
    <xmx:YLDUYbIagspD2OynSRcS6idajdPZfI9eyHhxChfupB3YQeknuRKGyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jan 2022 15:38:54 -0500 (EST)
Date:   Tue, 4 Jan 2022 21:38:52 +0100
From:   Fernando Ramos <greenfoo@u92.eu>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v4 2/3] vimdiff: add tool documentation
Message-ID: <YdSwXJzwuVM/MCAZ@zacax395.localdomain>
References: <20211204090351.42369-1-greenfoo@u92.eu>
 <20211204090351.42369-3-greenfoo@u92.eu>
 <CAJDDKr77YQKJj15V52Rs=LPRMZVSkbpV8MWFDWNuYf4jqqCajg@mail.gmail.com>
 <YbSBf0eLh3AXiGnV@zacax395.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbSBf0eLh3AXiGnV@zacax395.localdomain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/11 11:46AM, Fernando Ramos wrote:
> On 21/12/09 06:58PM, David Aguilar wrote:
> > On Sat, Dec 4, 2021 at 1:04 AM Fernando Ramos <greenfoo@u92.eu> wrote:
> > >
> > > Running 'git {merge,diff}tool --tool-help' now also prints usage
> > > information about the vimdiff tool (and its variantes) instead of just
> > > its name.
> > >
> > > Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
> > > ---
> > >  Documentation/git-difftool--vimdiff.txt  |  40 +++++
> > >  Documentation/git-mergetool--vimdiff.txt | 195 +++++++++++++++++++++++
> > 
> > 
> > Should these be referenced from elsewhere in the Documentation/
> > tree in order to make them more discoverable?
> > 
> > Documentation/git-{difftool,mergetool}.txt seem like they should
> > include or link to these.
> 
> Those files (Documentation/git-{difftool,mergetool}.txt) contain this piece of
> text:
> 
>     --tool-help
>         Print a list of diff tools that may be used with --tool.
> 
> When you then run with "--tool-help", not only the list of available tools is
> listed, but also a short message explaining how to obtain more details is
> presented (for those tools that have more information):
> 
>     vimdiff 
>         Run 'man git-difftool--vimdiff' for details
> 
> In other words: there is one level of "indirection" that decouples the
> documentation of each tool from the generic documentation contained in
> Documentation/git-{difftool,mergetool}.txt.
> 
> Thanks to this, when documentation for a new tool is created in the future, as
> long as the "diff_cmd_help()/merge_cmd_help()" functions are overwritten,
> everything will "just work" without having to edit
> Documentation/git-{difftool,mergetool}.txt each time.
> 
> I thought this was the best option but I have not problem adding a reference to
> it if you prefer that (maybe at the end, in the "SEE ALSO" section?)
> 
> Let me know what you think.
> 
> 
> > > +merge_cmd_help() {
> > > +       echo "Run 'man git-mergetool--vimdiff' for details"
> > > +       return 0
> > > +}
> > > +
> > > +
> > 
> > My understanding is that we prefer "git help" instead of "man" when
> > providing hints.
> > 
> > That means we should suggest something like this instead:
> > 
> >         echo "Run 'git help mergetool--vimdiff' for details"
> 
> I originally typed that, but then I noticed something in my system: all entries
> in "Documentation/" seem to be available as "man" pages, but only a subset of
> them are also available through "git help". Examples:
> 
>   * man git-mergetool        --> works
>   * man git-mergetool--lib   --> works
> 
>   * git help mergetool       --> works
>   * git help mergetool--lib  --> does not work!
> 
> That's why I ended up using "man".
> 
> PS: Now that I have revisited the issue, it looks like the command that is
> failing is trying to run "man gitmergetool--lib" under the hood (notice there is
> a missing "-"). The problem seems to be in "builtin/help.c:cmd_to_page()":
> 
>    if is_git_command(x) 
>        return xstrfmt("git-%s", x);
>    else
>        return xstrfmt("git%s", x);
> 
> Because "mergetool--lib" is not a regular git command, it removes the "-". The
> same would happen to the new "git help mergetool--vimdiff" if I add it. Is
> this the intended behavior?
> 
> There are two options:
> 
>   A) This is actually an error in help.c logic that needs to be fixed and then
>      I can update the docs to "git help mergetool--vimdiff".
> 
>   B) This is the intended behavior and I leave "man git-mergetool--vimdiff" in
>      the docs.
> 
> I would say the right option is (A), but need your input regarding how to fix
> it.
> 
> Thanks.
> 

Any extra thoughts on these considerations?

Thanks!


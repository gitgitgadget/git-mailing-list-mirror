Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476851F404
	for <e@80x24.org>; Wed, 27 Dec 2017 00:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbdL0Aub (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 19:50:31 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:41743 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdL0Au3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 19:50:29 -0500
Received: by mail-oi0-f50.google.com with SMTP id t78so24518666oie.8
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 16:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xQFYzouOKpoehCWIuC0EBz20M5lFdZvvFFsqZmFT1o=;
        b=F14UCIXCdkzksAQMMORAQ30pktKOIqrBQ9emtqZpiewhuel0Yz4n2KXkoS4/rS8bci
         XI/924m0fNWXGIOHfxxuSV7d8cL7sznaxR7PbUdBGDuB8mNUyBwaE8japsR65/wJocHQ
         8nk/Xo3pZ4yczDabyCXU0ymZhkZG0KT1omOR2ZxfBsGVJMZBOGBXWoI04z5zzNaP+Fpw
         KHG/9X1VtlB7/4MyypNOKzowIJQ4fPIGZgB0QxJtVbouRqYaUoNeLji0lSIaQ3vh9gpD
         3wdZnZHWXAnogcH+o/5Dyv/6SL7RM4h4qvnPGToHAenWBv3Y4YtBHuWcAMehLy3qusbg
         om/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xQFYzouOKpoehCWIuC0EBz20M5lFdZvvFFsqZmFT1o=;
        b=Ucyq5rzhi6P/jt8oH8rmFjbrt94ohgW1cXPCpAnWF7puikFkwSn158DkxCtTXAb+vp
         8d5TQhmeT0zclbQfea2ydeRrQSyyDu3K0P99r4AQBuBAeDmDTvxLY/wcSINF4CrIjGrW
         h6oSjnaQpucYRfzx6BwBbvorII7Xpa0zvtvGwwv603geXWj/S+RbZFVgNTGQPqjdDOdz
         CbU4XpcLGt1l9uDfaQG/fOVP+QQoXd3xCw6+I7B4ewrobgVZB+DpNgGLDUwviB3fQTUO
         RY2KZfsPfwlYfWLesWFaMIwIMzQK5vflxGNb6dnbv6XSveFbEG0vgoTbYy2o2BEinorR
         N0eg==
X-Gm-Message-State: AKGB3mJgDXdylQyiP/++rmnSWkPsshWJkxg458jXWzdzzPcEL0rw4STQ
        00QfM0p1bMmQdAAtOV9R9DqAgvOj6YEDkMe4SE4=
X-Google-Smtp-Source: ACJfBovxfApVDV/sWXVT9kRErD1LvoseDi1ujR55zzz+Dk7wnUKRZls/S8U+bPB96ewYHdrMVNJJOSCBMVoicPteD9A=
X-Received: by 10.202.82.196 with SMTP id g187mr12761677oib.183.1514335829204;
 Tue, 26 Dec 2017 16:50:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 26 Dec 2017 16:49:58 -0800 (PST)
In-Reply-To: <cd764b8d-8a85-964f-eaf2-3e6fb784a2ff@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com> <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-8-pclouds@gmail.com> <cd764b8d-8a85-964f-eaf2-3e6fb784a2ff@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Dec 2017 07:49:58 +0700
Message-ID: <CACsJy8B7P-ObwG8yDH8A6RXccUgk-HowJfa4t+yPJ0ovSoUazg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] wt-status.c: avoid double renames in
 short/porcelain format
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 5:14 AM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> Hi Duy,
>
> On 26/12/2017 10:10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> The presence of worktree rename leads to an interesting situation,
>> what if the same index entry is renamed twice, compared to HEAD and to
>> worktree? We can have that with this setup
>>
>>     echo first > first && git add first && git commit -m first
>>     git mv first second  # rename reported in "diff --cached"
>>     mv second third      # rename reported in "diff-files"
>>
>> For the long format this is fine because we print two "->" rename
>> lines, one in the "updated" section, one in "changed" one.
>>
>> For other output formats, it gets tricky because they combine both
>> diffs in one line but can only display one rename per line. The result
>> "XY" column of short format, for example, would be "RR" in that case.
>>
>> This case either needs some extension in short/porcelain format
>> to show something crazy like
>>
>>     RR first -> second -> third
>>
>> or we could show renames as two lines instead of one, for example
>> something like this for short form:
>>
>>     R  first -> second
>>      R second -> third
>>
>> But for now it's safer and simpler to just break the "second -> third"
>> rename pair and show
>>
>>     RD first -> second
>>      A third
>>
>> like we have been showing until now.
>>
>
> I lost you a bit here, partially because of what seems to be an
> incomplete setup script, partially because of this last sentence, as
> Git v2.15.1 doesn`t seem to be showing this, so not sure about "like
> we have been showing until now" part...?

Yeah I missed a "git add -N third" in the setup. And "until now" was a
poor choice of words. It should have been "before 425a28e0a4", where
"new files" could not show up, which prevented rename detection in the
"Changed bot not staged for commit" section in the first place.

Though it's not _exactly_ like before. If you replace
"ita_invisible_in_index =3D 1" with "ita_invisible_in_index =3D 0" in
wt-status.c, you effectively roll back 425a28e0a4 and "git status
--short" would show

    RD first -> second
    AM third

The second line is different and is what 425a28e0a4 tries to fix.

> Now, still using v2.15.1, let`s see porcelain statuses:
>
> (2) $ git status --porcelain
>     RR first -> second
>
> (3) $ git status --porcelain=3Dv2
>     2 RR N... 100644 100644 000000 9c59e24b8393179a5d712de4f990178df5734d=
99 9c59e24b8393179a5d712de4f990178df5734d99 R100 second        first
>
> Here, they both report renames in _both_ index and working tree (RR),
> but they show "index" renamed path only ("second", in comparison to
> original value in HEAD, "first").
>
> I`m inclined to say this doesn`t align with what `git status` shows,
> disrespecting `add -N` (or respecting it only partially, through that
> second R, but not showing the actual working tree rename, "third").
>
> Without influencing porcelain format, and to fully respect `add -N`,
> I believe showing two renames (index and working tree) as two lines
> would be the correct approach - and that`s what default `git status`
> does, too.

I agree. What worries me though, is the path in index seems to be be
the unique "key" of each line. Porcelain v2 shows this clearer when
"second" is always in the same column. By showing two lines with  the
same key (i.e. "second"), I'm not sure if we are breaking the
porcelain format. Perhaps this is undefined area that we can just
tweak?

> Now, let`s examine this patch series v2 outputs:
>
> (1) $ git status
>     On branch master
>     Changes to be committed:
>       (use "git reset HEAD <file>..." to unstage)
>
>         renamed:    first -> second
>
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>
>         renamed:    second -> third
>
> (2) $ git status --porcelain
>     RD first -> second
>      A third
>
> (3) $ git status --porcelain=3Dv2
>     2 RD N... 100644 100644 000000 9c59e24b8393179a5d712de4f990178df5734d=
99 9c59e24b8393179a5d712de4f990178df5734d99 R100 second        first
>     1 .A N... 000000 000000 100644 00000000000000000000000000000000000000=
00 0000000000000000000000000000000000000000 third
>
> Here, porcelain statuses make situation a bit better, as now at least
> `add -N` is respected, showing new "tracked" path appearing in the
> working tree.
>
> But, we now lost any idea about the rename that happened there as
> well - which Git v2.15.1 porcelain was partially showing (through
> RR), and which `git status` still reports correctly - and which we
> still differ from.

Sorry again about "now". Before 425a28e0a4 rename detection would not
kick in to find "second -> third" so people wouldn't know about rename
anyway.

>
> I don`t think this looks like what we have been showing until now
> (unless I misunderstood which exact "now" are we talking about), so I
> don`t see that as a valid argument to support this case.
>
> So, while we still changed output of what we were showing so far to
> two-line output, it seems there`s no real gain, as it looks like we
> replaced one partial output (recognize rename, omit path) for the
> other (recognize path, omit rename).
>
> Finally, let`s see your initial patch v1[1], with my exercise
> patch[2] on top:
>
> (1) $ git status
>     On branch master
>     Changes to be committed:
>       (use "git reset HEAD <file>..." to unstage)
>
>         renamed:    first -> second
>
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>
>         renamed:    second -> third
>
> (2) $ git status --porcelain
>     R  first -> second
>      R second -> third
>
> (3) $ git status --porcelain=3Dv2
>     2 R. N... 100644 100644 100644 9c59e24b8393179a5d712de4f990178df5734d=
99 9c59e24b8393179a5d712de4f990178df5734d99 R100 second        first
>     2 .R N... 100644 100644 100644 9c59e24b8393179a5d712de4f990178df5734d=
99 9c59e24b8393179a5d712de4f990178df5734d99 R100 third second
>
> Here, both "--porcelain" outputs (2) and (3) seem to much better
> replicate what default `git status` is showing, too - namely separate
> renames in comparison to HEAD for both "index" (2) and "working tree" (3)=
.

There is a problem with my v1 (or my misunderstanding of the code and
the porcelain v2 format). The first path column must always be the
path in index according to git-status.txt

    <path>      The pathname.  In a renamed/copied entry, this
                is the path in the index.

which means the paths in the second line are swapped to

    2 .R .... R100 second<tab>third

The current code ('master', before any of my changes) seems to also
key all entries by index path with those
"string_list_insert(&s->change,...". And it fits porcelain v2
definition. But it introduces this problem.

Perhaps keying by index path is just not intentional (and porcelain v2
accidentally exposes that), I don't know. If we relax this a bit like
in my v1 (and conclude that we are not breaking any porcelain
formats), then yes, the problem goes away. The new definition would be

    <path>      The pathname.  In a renamed/copied entry, this
                is the target path.

(and we leave the user to determine whether the target is in index or
in worktree using <XY> code). I like this actually, "R100 second
third" looks just weird, but I'm not porcelain user and don't know how
it's actually used.

> And if you don`t like two lines here in comparison to one (incomplete)
> line from Git v2.15.1, I would remark that patch series v2 prints two
> lines as well (so different from v2.15.1 in a same way), but with
> what looks like inferior output in comparison to v1 shown above, where
> both renames are correctly recognized and reported - and finally
> fully compatible with default `git status` output, too.
>
> And if we really think about it, what v1 shows is what actually
> happened - and more important, it`s possible to recreate hypothetical
> "first -> second -> third" change from there. With v2 output, that is
> impossible, that information is lost as second line doesn`t relate to
> the first one in any way.
>
> Now, unless I`m totally missing something here, the only thing left
> is that you mentioned v2 approach being "safer and simpler" than v1,
> something I`m not really competent to comment on, but just wanted to
> provide a second opinion, maybe helping to change your mind in favor
> of v1 outputs, which seem to be _the_ correct ones...? :)

Yeah it's "safe" to not break porcelain formats (and "simpler" than
changing them). But if it turns out I'm just paranoid, I'll happily
revert back to v1.

> If not that much more complicated/unsafe, of course.
>
> Thanks, Buga
>
> [1] https://public-inbox.org/git/20171226091012.24315-8-pclouds@gmail.com=
/T/#mf60e88fd351f7ff6a076279794c8343a79835f67
> [2] https://public-inbox.org/git/20171226091012.24315-8-pclouds@gmail.com=
/T/#m095c33d69994c6ecb4f1adbf80dd48eab66750d8
--=20
Duy

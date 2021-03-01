Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D57C43381
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D302264E87
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242692AbhCAUHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbhCAUFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 15:05:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A8C061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 12:04:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gt32so19064051ejc.6
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 12:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+fqn9RFQ8UAqU2OnpbooKgHnWXN0N4oo9H5yX5FZElQ=;
        b=XN7kZixro+jUOY/HOjlY2XxSZ7zJfyX8dKtu2xcQgDD4RMvF7w0vfRnIou1ZdZXtKO
         Ow3d7G1scVl8nffvymjQkkmt5/XFUhiuhWBgyIWdOakpk2SlwcfRmLiZphcpWbk+LLTg
         vUXekqe7oabqgY/14uepUPYPzrRoC0XctRiuIVhfzkTylvAZMVVErXF0z1qoHcUe/hsg
         rjddww3RAoj3sJqED9T60qoI/fK19oH8cTE9XaEZI1luQ8Zhh4pr7sTNJAZQjGjRNjbB
         7VXn2m0bFYQwCmu17yhzBuL3gwDghJp7/XpdTNpCQslFcSI2YOxcYGDhT8snlyB8m9R/
         hoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+fqn9RFQ8UAqU2OnpbooKgHnWXN0N4oo9H5yX5FZElQ=;
        b=EByTG/Puic2KbM1MpVEva8LdYFVAee2h0ADB6GBybO5ZfZxOtzxJm7lr6hdAQGTy6I
         +S/rkBCMBYQwqeeDljpP1omI4ENDQvf56o2K/TLDusQK4Qy2GPbud5783AcDvpuCpfjJ
         t7vhPh8UzX3F5r37GkqJ8f8Xi3/bA9i+pBXwdwpS4vR3Xb0MZ2GNtnaJ6XF7QAHTapOE
         oo2L0rFajpN4XplPZX2x6mouLXukp0vyWZC2SFKvnZZhUS//Ee4pV7OcSFFEm7rhBFtV
         TPA/cfHDTxW/mihptbbL9ktFwQ10QwUwua3KX3vZwwpUArucpOTWwk9nj9OuWQjOJoFW
         AdeQ==
X-Gm-Message-State: AOAM530hNggik1ICIZaXE7pMhk3XIWEqMZXLOjRAnrEFYcXepEegrUPB
        f9pm+n6RAZnDjf9K9Mv3U5iqcflCdZs=
X-Google-Smtp-Source: ABdhPJyva09UWOCEwSnSNB8DfdIlJHroxcddZf/8+hZm1INieP34JBizNNUZAjKKf2MXCfELDbVeBw==
X-Received: by 2002:a17:906:c08a:: with SMTP id f10mr17534342ejz.52.1614629068217;
        Mon, 01 Mar 2021 12:04:28 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bw22sm15483552ejb.78.2021.03.01.12.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 12:04:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     anatoly techtonik <techtonik@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Round-tripping fast-export/import changes commit hashes
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com>
 <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BE=9wzF6_VypoR-uEPHsLWdV7zyE13FOgLK0h8NOcMz3g@mail.gmail.com>
Date:   Mon, 01 Mar 2021 21:04:27 +0100
Message-ID: <87ft1ek5dg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 01 2021, Elijah Newren wrote:

> On Sun, Feb 28, 2021 at 11:44 PM anatoly techtonik <techtonik@gmail.com> =
wrote:
>>
>> On Sun, Feb 28, 2021 at 1:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> >
>> > I think Elijah means that in the general case people are using fast
>> > export/import to export/import between different systems or in
>> > combination with a utility like git-filter-repo.
>> >
>> > In those cases users are also changing the content of the repository, =
so
>> > the hashes will change, invalidating signatures.
>> >
>> > But there's also cases where e.g. you don't modify the history, or only
>> > part of it, and could then preserve these headers. I think there's no
>> > inherent reason not to do so, just that nobody's cared enough to submit
>> > patches etc.
>>
>> Is fast-export/import the only way to filter information in `git`? Maybe=
 there
>> is a slow json-export/import tool that gives a complete representation o=
f all
>> events in a repository? Or API that can be used to serialize and import =
that
>> stream?
>>
>> If no, then I'd like to take a look at where header filtering and serial=
ization
>> takes place. My C skills are at the "hello world" level, so I am not sur=
e I can
>> write a patch. But I can write the logic in Python and ask somebody to p=
ort
>> that.
>
> If you are intent on keeping signatures because you know they are
> still valid, then you already know you aren't modifying any
> blobs/trees/commits leading up to those signatures.  If that is the
> case, perhaps you should just avoid exporting the signature or
> anything it depends on, and just export the stuff after that point.
> You can do this with fast-export's --reference-excluded-parents option
> and pass it an exclusion range.  For example:
>
>    git fast-export --reference-excluded-parents ^master~5 --all
>
> and then pipe that through fast-import.
>
>
> In general, I think if fast-export or fast-import are lacking features
> you want, we should add them there, but I don't see how adding
> signature reading to fast-import and signature exporting to
> fast-export makes sense in general.  Even if you assume fast-import
> can process all the bits it is sent (e.g. you extend it to support
> commits without an author, tags without a tagger, signed objects, any
> other extended commit headers), and even if you add flags to
> fast-export to die if there are any bits it doesn't recognize and to
> export all pieces of blobs/trees/tags (e.g. don't add missing authors,
> don't re-encode messages in UTF-8, don't use grafts or replace
> objects, keep extended headers such as signatures, etc.), then it
> still couldn't possibly work in all cases in general.  For example, if
> you had a repository with unusual objects made by ancient or broken
> git versions (such as tree entries in the wrong sort order, or tree
> entries that recorded modes of 040000 instead of 40000 for trees or
> something with perms other than 100644 or 100755 for files), then when
> fast-import goes to recreate these objects using the canonical format
> they will no longer have the same hash and your commit signatures will
> get invalidated.  Other git commands will also refuse to create
> objects with those oddities, even if git accepts ancient objects that
> have them.
>
> So, it's basically impossible to have a "complete representation of
> all events in a repository" that do what you want except for the
> *original* binary format.  (But if you really want to see the original
> binary format, maybe `git cat-file --batch` will be handy to you.)
>
> But I think fast-export's --reference-excluded-parents might come in
> handy for you and let you do what you want.

...to add to that line of thinking, it's also a completely valid
technique to just completele rewrite your repository, then (re-)push the
old signed tags to refs/tags/*.

By default they won't be pulled down as they won't reference commits on
branches you're fetching, and you can also stick them somewhere else
than refs/tags/*, e.g. refs/legacy-tags/*.

None of the commit history will be the same, but the content (mostly)
will, which is usually what matters when checking out an old tag.

Of course this hack has little benefit over just keeping a foo-old.git
repo around, and moving on with new history in your new foo.git.

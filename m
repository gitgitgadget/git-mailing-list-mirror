Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D7C433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359172AbiAaVdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241365AbiAaVdl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:33:41 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917E4C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:33:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c23so28018559wrb.5
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CDLdx6Usy9Z/bPYCzd1GfbBJa4NFAD7zUwQcFTcHgy8=;
        b=Uw4ZgJw9U0yl8p2bXSnU0Y86SzEs7rM8V1l5WYhI38wFWirrNYQqMvVLKhQpMlQkys
         jq6eZhojIU5rJ/lGajkaX4ytP1yc+Ym0K5uPuh5gyROyyxuBgwdRYA9LJqnPr8sBMyOj
         hI076Nwi3RkqDt/54eOhDYRwAvBfrDSQFiRiOHzYhDmH/GTO1UnbDIJzDKfcUbbhIRXu
         u9oXW+GrV4GQvhn1mDCRsuOrDW1sk1A6e8QoS2irlAJhFJ1CgZptm8g5+3kwfsgBrQnO
         XPTmk139mmm3/rzOdl/sgt9PEn6Gn/8u4RQ2tQ0lABKHOkTWQUgEQqYTl8F4dQTsDHcx
         88tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CDLdx6Usy9Z/bPYCzd1GfbBJa4NFAD7zUwQcFTcHgy8=;
        b=UbfIcK0mSnZkGgx7OP7tMg3HkR3m0df9l73gRWRDxkvzLyMGt556cWW0ubJux6D+Jg
         N1RaJlTsGIgMrLdTQxleDqWkEcgL4w8JPmLIQEw19l3W20UHTp1FHA6/jMTL7tsCZ4cw
         cRuxyc/oqJTRZNySK7C08wN0y1lba/alnWMM2RexgRcFn3hHz6ASM6igF9ymP38HwCrN
         nPtxstwJbc1RTQZWCelJW/6afctpmomDLWxCYO6zq5DziGHH/UEmwuUwltWr5LhbnNyt
         5WLi6MklYJ3eUe9eWb1YLqSfDdVjMpz9pwq2p+ttmVcSR1I48mYlnGt9cH2v2mdp+Ng6
         2VZA==
X-Gm-Message-State: AOAM532kEm448uqYm+zw2k7BA8fqh41YlB7RUtdEjNjM/G5cL0L/tOJ0
        AU3aCa9oZSqq8IuFUCsW4A8=
X-Google-Smtp-Source: ABdhPJyoc09ZWA5nOhWqc5Nj8kmo/pkgiLmNqer8yOqLknKfd3qykJRFP+0yhsoAJqBWV8pB3lqUwg==
X-Received: by 2002:a05:6000:1848:: with SMTP id c8mr12775839wri.241.1643664820065;
        Mon, 31 Jan 2022 13:33:40 -0800 (PST)
Received: from smtpclient.apple ([2a01:e34:ec41:7980:c54:d02e:bc75:bfd])
        by smtp.gmail.com with ESMTPSA id k12sm13179682wrd.110.2022.01.31.13.33.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jan 2022 13:33:39 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Stage, test, and commit only some changes, then repeat
From:   =?utf-8?Q?G=C3=A9ry_Ogam?= <gery.ogam@gmail.com>
In-Reply-To: <87bkzrvpjv.fsf@osv.gnss.ru>
Date:   Mon, 31 Jan 2022 22:33:39 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <49031AA3-CDC3-4CF6-A04B-E3533907FCA4@gmail.com>
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
 <87bkzrvpjv.fsf@osv.gnss.ru>
To:     Sergey Organov <sorganov@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Le 31 janv. 2022 =C3=A0 17:27, Sergey Organov <sorganov@gmail.com> a =
=C3=A9crit :
>=20
> G=C3=A9ry Ogam <gery.ogam@gmail.com> writes:
>=20
>> Hello,
>>=20
>> I would like to stage, test, and commit only *some* changes of the
>> working tree, and then repeat this process with the remaining =
changes.
>>=20
>> My current solution (published at
>> https://stackoverflow.com/a/70914962/2326961):
>>=20
>> 1. Stage some changes:
>>   ```
>>   git add -p file
>>   ```
>> 2. Save away the remaining changes:
>>   ```
>>   git diff >patch
>>   git stash push -k
>>   ```
>> 3. Test the staged changes.
>> 4. Commit the staged changes:
>>   ```
>>   git commit
>>   ```
>> 5. Restore the remaining changes:
>>   ```
>>   git apply patch
>>   ```
>> 6. Go to step 1.
>>=20
>> It is not ideal because a) it uses a patch file for saving the
>> remaining changes; b) it uses the stash only for setting the working
>> tree to the index state.
>>=20
>> It would be ideal if I could save *only* the remaining changes in the
>> stash instead of resorting to a patch file. How to do it?
>=20
> It looks like you don't need patch file for this workflow. What's =
wrong with:
>=20
> git add...
> git stash push --keep-index
> ... check, git add fixes
> git commit
> git stash apply
>=20
> ???
>=20
> -- Sergey Organov

Hello Sergey,

`git stash` saves the transition from the HEAD state to the working tree =
state. It also sets the working tree to the *HEAD* state.

`git stash --keep-index` saves the transition from the HEAD state to the =
working tree state. It also sets the working tree to the *index* state.

`git stash pop` applies the last saved transition. So if the working =
tree was not in HEAD state (like after `git stash --keep-index`), there =
will be a conflict.

Best,

G=C3=A9ry Ogam=

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1461F405
	for <e@80x24.org>; Thu,  9 Aug 2018 20:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeHIXVW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:21:22 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55916 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeHIXVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:21:22 -0400
Received: by mail-wm0-f53.google.com with SMTP id f21-v6so1524747wmc.5
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6vlMztxSfW1CI8aDKrB+/bmNquMw1E5iNSWvCIrf490=;
        b=H5QestGHa4LJZXCqdvfJl2F5w5+wnQ4Te2ncNcRdaYeu2wr7bQvQUzMX3GXeVYzar2
         Ez+112Hf8QTp3KICKlW9Vy3OQU1BVFWXAmEfrZzHGnkJC3T1Sy7ab68FMHYNuyCW/MS1
         A9hJfXV7ATVPGfcLnhuo6dpIHeJ5c1D0bA8NWTEf6rBu7srp5pIzWNkVPu6tit5uPpQc
         Icn0CawFZnD5mCQ0ECJEbGhgKzzcPJwLFxsePi1CSzk6vhjPar/J9CVnKRAlxVz2GoGd
         T5EX8sbi22hvnsEOeVB73+KlGvuCzlqZnJF4eakaBiedBN53PbjjpMnD7K4ArB1KitMw
         UfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6vlMztxSfW1CI8aDKrB+/bmNquMw1E5iNSWvCIrf490=;
        b=BxvVtNHjwz6cZetEI7M2O07TRq5nRkYvyRnR5UtXQYACgGZjBEqQ1wXEtaAU8UESAe
         ADUCDTo0o73NUc6/NXBfvUA9MBdorezJPLrbAJOMOyMEHLAuXtqVvXzpwGu3SIp/R9XV
         4vzIa7fV8V6mwJ/PpwgG+ZIxegK11QMaIcObbrP3R6t7LsNCnHSwVgzfFzbJuNOlFyMK
         HQPemsZ94sSls23kTjkwGVtvpQwQRiQEKiKD68kRh7C1bPGYASmG6plejToMzCxPT92/
         Evh05QAx2nVCYi0kklIPW/TWBVUcuLsVucjDcQnwZvCA/ymcuN180UEyYQSkr1MWzVYP
         6Qng==
X-Gm-Message-State: AOUpUlGktA8ucHKVRDHqX90M4rxD9o01iwTT4crVeFywAYn6FTJ1euR+
        ZHMlsOccuOZT4JqlcXB02zu98tKu
X-Google-Smtp-Source: AA+uWPxbL5lHeEbwYmjEkpiI5G3vfeKB4MbvXHiPF5MmO29yRZKOd77D0e0b8p4PVXxJGaPkSEzT5g==
X-Received: by 2002:a1c:6c03:: with SMTP id h3-v6mr2450299wmc.38.1533848086485;
        Thu, 09 Aug 2018 13:54:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p11-v6sm5370023wrs.51.2018.08.09.13.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 13:54:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC/WIP PATCH 1/1] merge-recursive: make file/directory conflicts easier to resolve
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
        <20180806224547.8619-1-newren@gmail.com>
        <20180806224547.8619-2-newren@gmail.com>
        <xmqqbmabcuhf.fsf@gitster-ct.c.googlers.com>
        <CABPp-BH8oiJ17K6OHCikAxk8Jy9M7mSA=WCVX9KosTC+p4rE4w@mail.gmail.com>
Date:   Thu, 09 Aug 2018 13:54:45 -0700
In-Reply-To: <CABPp-BH8oiJ17K6OHCikAxk8Jy9M7mSA=WCVX9KosTC+p4rE4w@mail.gmail.com>
        (Elijah Newren's message of "Thu, 9 Aug 2018 12:26:44 -0700")
Message-ID: <xmqqk1ozb6qy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Of course, "git rm" and "git mv" must work sensibly, if we want this
>> change to be truly helpful--but if not, they need to be fixed ;-)
>
> That actually brings up an interesting question.  Right now, if given
> a path that appears in the index but at a stage greater than 0, git mv
> will fail with "not under version control".  Obviously, that error
> message is a lie in such a case, but what should it do?
>
> (Alternatively, if there is only one entry with stage greater than 0
> and it has no other conflicts, one could envision git mv doing the
> rename and dropping to stage 0 at the same time, but that sounds a bit
> dangerous to me.)

I do not particularly think it is "dangerous".  In fact, that sort
of behaviour was what I had in mind when I said "work sensibly".

When resolving a conflict that they added a new path at stage #3 to
remove that path, I can say "git rm $that_path", which removes all
stages of that path and make the index closer to the next commit.
Or I may decide to keep that path by "git add $that_path", which
adds that path at stage #0.  I think "git mv $that_path $over_there"
that drops that path at stage #3 to stage #0 of another path would
be in line with these two.


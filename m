Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E880AC77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 18:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjELSVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbjELSV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 14:21:28 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5361AA5EA
        for <git@vger.kernel.org>; Fri, 12 May 2023 11:21:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac733b813fso110165121fa.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683915679; x=1686507679;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pcO9o3QKPGIA74w+o7eG2+HCS8MlKtJ/RIx9i9okcA=;
        b=Mx13lloQk8CAB89cbHqe0gQdkZjuUXPcwQOzw+atAPHnBv5Iuctcvp2tiBdvTqYo3U
         OvCy8FyIiUeSeJj0tQ2qlM55cfUCzJTHKBeewu9cu8E3pgwP0OFFJCxa6z81oznIDcfH
         IgE+SbbRvorw51ufRwy5f2mCQVH3bdrdWU2J0GRPrayniGhWhJmWBEmN+oJ3CWmi+uEw
         a8L3ediiUCsFzb9rQgzgor9cC4hQn+LJEX8iflPqKjz5Bg3ZeqB4na8ZUN9Xm4YK4znv
         2LW2U9spuGQCpYveZTdPYcht4wuy8k7B/mMHAv6LKml+eJTWqndW4Y688pkmWLl2AdOU
         pmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683915679; x=1686507679;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pcO9o3QKPGIA74w+o7eG2+HCS8MlKtJ/RIx9i9okcA=;
        b=HIcuPO02UNkJG8z4od19Af8J6+XoiDvJ9u1ylqyJYN22Mbo8iJgaFlSkSI/5wDzBiO
         VvuFArQNlv7MWv2e7kI8rYk4X5Cduy/uZRoI/8uBCyiswTxlWjHpQxmEOQV4Isn3iLKa
         sMC1gojT7W0GyTHgfk5c6Nk2JtdTxZbzkY78zSLcr3shrDTKT40rWDVz56tiQtAL7m0j
         SRGMtG8ZmPOJh1mQcHKYxNzgibJiEC03SXfS106BPAras2f0dtp2BRJX+4FihhMlwIko
         AVnLq0tCri1Q9i5x3U26GUv5kqA3I3XuJJINCPFzFtmFtk3m7Jdv0npQQGua/CS17bq+
         pczA==
X-Gm-Message-State: AC+VfDw+XpjxYALZ10bjUNMbTXb0jxyLumzIrBQflfPHK6uX+cZ5MNKb
        8Ksq2IHGLFmUG/WP7IxK3mlIzjJ3NFL35A==
X-Google-Smtp-Source: ACHHUZ5o/MHcBtek9GU729vl4zvJJj8FF6w9slrTVGBtN0sVWWKlMp0R9wbYWhW/CxpkKsIoD19GZg==
X-Received: by 2002:a2e:908c:0:b0:2ab:d1b:dcb2 with SMTP id l12-20020a2e908c000000b002ab0d1bdcb2mr4329252ljg.38.1683915678935;
        Fri, 12 May 2023 11:21:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b7-20020a2e9887000000b002aa458a7a46sm2878345ljj.123.2023.05.12.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 11:21:18 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
        <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
        <xmqqo7mpqy6g.fsf@gitster.g>
Date:   Fri, 12 May 2023 21:21:17 +0300
In-Reply-To: <xmqqo7mpqy6g.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        12 May 2023 10:03:51 -0700")
Message-ID: <87h6shif6q.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:
>
>> https://public-inbox.org/git/51E3DC47.70107@googlemail.com/
>>
>> Essentially, Stefan Beller was using 'git show --format="%ad"' and
>> expecting it to show only the author date, and for merge commits it
>> also showed the patch (--cc). I suggested -s and noticed that the
>> option wasn't easily discoverable, hence the patch series to better
>> document it and add --no-patch as a synonym.
>>
>> Probably I did not get all the subtleties of the different kinds of
>> outputs. I guess I considered the output of diff to be the one
>> specified by --format plus the patch (not considering --raw, --stat &
>> friends), hence "get only the output specified by --format" and
>> "disable the patch" were synonym to me.

So --no-patch, if it were made to disable only --patch from the
beginning, would still serve the purpose of solving of the original
problem, right? Please notice that --cc produces no output without
--patch. Thus, making --no-patch a synonym for -s was a mistake in the
first place that leaked through review process at that time, and

   git show --format="%ad" --no-patch

will still work the same way even if we fix --no-patch to disable
--patch only.

>
> Thanks for double checking.  It matches my recollection that we (you
> the author and other reviewers as well) added "--no-patch" back then
> to mean "no output from diff machinery, exactly the same as '-s' but
> use a name that is more discoverable".
>
>> Looking more closely, it's
>> rather clear to me they are not, and that
>>
>>   git show --raw --patch --no-patch
>>
>> should be equivalent to
>>
>>   git show --raw
>
> Yeah.  If this were 10 years ago and we were designing from scratch,
> the "no output from diff machinery, more discoverable alias for
> '-s'" would have been "--silent" or "--squelch" and we would made
> any "--no-<format>" to defeat only "--<format>".
>
> It is a different matter if we can safely change what "--no-patch"
> means _now_.  Given that "--no-patch" was introduced for the
> explicit purpose of giving "-s" a name that is easier to remember,
> and given that in the 10 years since we did so, we may have acquired
> at least a few more end users of Git than we used to have, hopefully
> your change have helped them discover and learn to use "--no-patch"
> to defeat any "--<format>" they gave earlier as initial options in
> their script, which will be broken and need to be updated to use a
> much less discoverable "-s".

Fortunately, whoever used --no-patch are very unlikely to actually rely
on it being a synonym for "-s", as it was always enough for them that
--no-patch disables --patch, that will still hold after the fix.

Taking this into account it should be pretty safe to fix that old
mistake, and then to address "-s" discoverability issue separately.

Finally, this safety concern is even less attractive provided recent
"-s" fix changed behavior more aggressively yet gets no such resistance.

Thanks,
-- Sergey Organov

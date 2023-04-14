Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73753C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDNQqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDNQqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 12:46:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518C10B
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 09:46:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a67d2601b3so4859245ad.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681490780; x=1684082780;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dWx6YGWb2SZDL4qCWzjsbk9Du1JINZDK/+46yGT7JUQ=;
        b=OgtSnhXZQm42pb84jPrbTe47e3r5GGMte58+ZfRUEqMIkwgh4aBCTTc7YjVYkEzoxf
         I+ITGI036hwDqbzcBeq7EeyeHJicVWAo0DGKKOzE7kobV6Ch7iaxLQiLv3sX07mRTibe
         PLJf/4ugw6rV4T9zc7SJGq+WwM/su5EsYlgN+l98OHtT/wAalU9WnUwVbrXVfjZQ64Uu
         GlHMmF1SEAnDf7pQrpDFOMPMHeLJEXlDUed1WBnB/5QboC/Si0R8AOeeuEMe0jaAGuYL
         KFIqeWq9FhT2TNS3y197Yb81w/Sm2xIYqEbPNXBlCJH1adqIIuuAEn2XJjrwNQY6f8wZ
         /mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490780; x=1684082780;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWx6YGWb2SZDL4qCWzjsbk9Du1JINZDK/+46yGT7JUQ=;
        b=lMi+Gqs8WKko3etnK9bSyfBofbAxySOHlmi+rieKfraGkcdkAi9HU4hBv32+6mUsKG
         Zdg3zl90RwQTZ3Wk8ptC8+o9SttAU8GkAEJdxkzBE2G2G8P9ovbQ3BJz87HDvCPCXbKA
         pmZyEFLrEcazREX+ae56hpcTIVo3YogQpLEvYKHGJSLsKNMDQDuCV20aMizX2yBAxCw+
         gE2jCJAltgXabMReZavDHcu6mAtM5TsACVFrcmLy/orTdfsrslXU+90gJ05xRFLwQ1jq
         LlkMDaywFlALoirpYNoPoIF4qn/t5/nsHTLB9ug6rWOLOaGtIoFTMNo58ABO3fDwBGcZ
         KOjA==
X-Gm-Message-State: AAQBX9eoeuVtotCrJIBa4JYUKs+Y/4R0pKqdDG97iuF06vYnhInERxNQ
        6aVer35bFopKji6RRwJzwARM63zlghE=
X-Google-Smtp-Source: AKy350b8+IqXp93djcz38OG2zgJ0AP/kLKbs00nrBU4JsPoQkVqzdaHoWRUsRMqtONvoTiT51WPkbg==
X-Received: by 2002:a05:6a00:2401:b0:626:2ce1:263c with SMTP id z1-20020a056a00240100b006262ce1263cmr8741864pfh.5.1681490780039;
        Fri, 14 Apr 2023 09:46:20 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b00625ee4c50eesm3251643pff.77.2023.04.14.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:46:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] doc: set actual revdate for manpages
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
        <20230414070449.GA540206@coredump.intra.peff.net>
        <643949a57396c_5b7e62948d@chronos.notmuch>
Date:   Fri, 14 Apr 2023 09:46:19 -0700
Message-ID: <xmqqildys97o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> > diff --git a/Documentation/Makefile b/Documentation/Makefile
>> > index 3133ea3182..b629176d7d 100644
>> > --- a/Documentation/Makefile
>> > +++ b/Documentation/Makefile
>> > @@ -144,13 +144,16 @@ man5dir = $(mandir)/man5
>> >  man7dir = $(mandir)/man7
>> >  # DESTDIR =
>> >  
>> > +GIT_DATE := $(shell git show --quiet --pretty='%as')
>> 
>> What will/should this do in a distribution tarball, where we won't have
>> a Git repository at all? I think we'll just end up with a blank date in
>> the xml file, though it looks like docbook turns that into today's date
>> in the result.
>> 
>> That's not _too_ bad, but feels a bit inconsistent (and it uses the
>> format you're trying to get rid of!).
>> 
>> It would be nicer to populate the date variable in that case, like we do
>> for GIT_VERSION. I think that could look something like this:
>
> Indeed, that would be better, but that totally can be done in a separate patch,
> or a separate series even.

Seeing Peff's change, it sounds so small a thing that it feels a bit
unnatural not to do that in the same series, at least to me.

Having said that, I think that "we make progress one step at a time"
is perfectly acceptable and may even be preferred, as long as the
formatted manpages from the tarball would not change between with
and without this patch.  That way, we make the output from a
repository better while keeping the output from a tarball extract
intact, and make the latter match the former in a later effort.

So, I "wasted" (not really---this was a fruitful validation that is
a part of a review process) some time to play with this on top of
'seen' to see how well the tarball extract fares.  We get an error
message from "git show" complaining about "not a git repository" but
that is to be expected ("sh GIT-VERSION-GEN" does not share the
problem, though).

At least with the versions of toolchain picked by default in my
environment, I seem to be getting identical "04/14/2023" in a
directory extracted out of a tarball taken from 'seen' (with and
without this patch) in the formatted manpages, because we do not
have any record in the input either way.

Formatted output from a repository working tree changes from
"04/14/2023" to "2023-04-13".  The value change may be intended, but
I am not sure if the format change was intended or even welcome.  If
we want to correct the date format, it can totally be done in a
separate patch, or a separate series even, with some justification
in the proposed log message, I think.

Thanks.

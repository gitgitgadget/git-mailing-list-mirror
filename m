Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AD4C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 21:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjBCVtq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 16:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBCVto (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 16:49:44 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB6F2529A
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 13:49:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p26so18948133ejx.13
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 13:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/vcsDocGHtBZwQmixfQ05MQYTnwiKZKb6UIIID8UA0=;
        b=Ku0QPZjVEiqICxW84+o8mLRsybQLfNwhu5U0kzYUpVcjesf+L/kSrHhG1VgKA5tDQ6
         2TG4wjUmhq2mETkGwjmWJozOqmNhKq9cYAL01e/gwZunJCX34/RGsnC7wqn+dtWKHfO3
         wXHkUdjJCCPAjosuZjnMF7+qtwHFXFR8IDfYDNke6vtyHl+x+3foWjbpl73QsecnufrE
         jk2nbL0mSz1aPOySsPJ6iqMb5Dy0h2HdhR+0E/qhb03+Pd6QtaG4fqk5QNMbFJfcVkwP
         BHR4Zne572jZFvnYG6OHEv7+Y2lVXOdr37o/A6IaqMHJ1pZLdQY9pG84fhipIyVLgP4W
         Knig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/vcsDocGHtBZwQmixfQ05MQYTnwiKZKb6UIIID8UA0=;
        b=GQlJwoQ0d1mOQ97ncI+2BH+XVZj3Uz1fWzRJJX4uK6qKv/PbdxnLhWtadrsloc9GuH
         i9ryHn5rc51T3lBLVBcD4MyrGcgI8YigKCP5ePQbTxJbStZ0DOHdi18RXMgg6xQKl3oV
         p31C8SlWV249kUvQcO5L0uw4wlKTi6hkYrOO0U7MhwjdCMFcE38ipeLl8wEaPch9WgnE
         ABAbFxnjpRmymLVCwc3CJX/642Xpb1vTAjpB6ttcRRXTEaZZHn2Bq1P6hGCe6KNtscMS
         sZjdudTayQRqXyuYcVgAcd+lsbQhfmgUUMoYjem7v6rU2sPhzskLK/ZSZ/WoL9Dt4bho
         8LVA==
X-Gm-Message-State: AO0yUKUFem6ifx3HnAGsrEr2VZrnJ5YFEtRWi/JSdaHVPRGWjH/7RKqM
        +BhqG5zP5WCmx7jZ2Pc6lWk=
X-Google-Smtp-Source: AK7set8ILenkYJZ89nMs4B8DCoWe+7Evr0UUUVqNKIloAV4lX4E82S3BPkq3lXHbGOFvsDWQDj6i9g==
X-Received: by 2002:a17:906:8da:b0:87b:db53:3829 with SMTP id o26-20020a17090608da00b0087bdb533829mr11607203eje.46.1675460982011;
        Fri, 03 Feb 2023 13:49:42 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id s7-20020a1709064d8700b0087221268e49sm1905849eju.186.2023.02.03.13.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:49:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pO3wC-000TBq-2D;
        Fri, 03 Feb 2023 22:49:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/6] imap-send: make --curl no-optional
Date:   Fri, 03 Feb 2023 22:46:11 +0100
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
 <patch-v2-4.6-e9cc9bbed1e-20230202T093706Z-avarab@gmail.com>
 <xmqqfsbnu7dk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqfsbnu7dk.fsf@gitster.g>
Message-ID: <230203.867cwyberv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 02 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> In the preceding commit the old "USE_CURL_FOR_IMAP_SEND" define became
>> always true, as we now require libcurl for git-imap-send.
>>
>> But as we require OpenSSL for the "tunnel" mode we still need to keep
>> the OpenSSL codepath around (ee [1] for an attempt to remove it). But
>
> "(ee" -> ???

Should be "e.g.", will fix.

>> we don't need to keep supporting "--no-curl" to bypass the curl
>> codepath for the non-tunnel mode.
>
> We do not need to because...?

We don't have that code anymore, will clarify.

>> @@ -1519,12 +1519,8 @@ int cmd_main(int argc, const char **argv)
>>  	if (argc)
>>  		usage_with_options(imap_send_usage, imap_send_options);
>>=20=20
>> -#if defined(NO_OPENSSL)
>> -	if (!use_curl) {
>> -		warning("--no-curl not supported in this build");
>> -		use_curl =3D 1;
>> -	}
>> -#endif
>> +	if (!use_curl)
>> +		die(_("the --no-curl option to imap-send has been deprecated"));
>
> We used to force use of cURL when there is no other way to make the
> program work (i.e. there is no direct OpenSSL codepath available),
> instead of refusing to work (and forcing user to say --curl or to
> stop saying --no-curl, which is one unnecessary roadblock for the
> user).  Why do we want to change the error handling strategy that
> has been in place?

I can change this to a soft error, but it seemed more sensible to rip
the band-aid off an option that's never going to do anything now,
whereas before it would do something based on how you compiled git.

> I think I made the same comment in some other thread, but the
> principle is the same.  If there is no other choice the user can
> take, do we force users to stop and be explicit to choose that only
> available choice, or do we let the program choose the only available
> option for the user while clearly telling the user that is what we
> did?  Here, changing the behaviour sounds like a disservice to the
> users.

At best we can make --no-curl use curl anyway with a warning, would that
be better?

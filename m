Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F9C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 13:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiDPNJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 09:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiDPNJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 09:09:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B392E086
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:07:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c64so12719119edf.11
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7ZWwZtb8/nebqS3a3ohPm6LNs15HL7wyeUHpljIpT9Q=;
        b=qNC905K2mBCtThj11qAz2T4EXMP4iffhHgyaxaxMDYxizfB/7CksE14ic8HNq5DXrD
         hR/8qMGfiwmcFQmYomTN0x88HGmtXhJJ8kdn95dz0WFX2/EVopEIbiUDplwQwXuCI7OB
         KIojOPsdLQEAfesK/EUuQVMNenJ2Dajl45CoAmQTI1uM6wY6qQIplnBUTcflpIiGvQA7
         uhIpuqLc2BUt0OPtZItM7RfnLRkkJYTYRK8IqqD6oN2v1Vu5g2nNOVpFAR8wHQkqW3yq
         aQQzNi4bUU89XpdMS/aqMUXVVY97YHHuSEDEwsp7YgJ3aztXuBEn166DzLxwtT8JR4Tq
         h0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7ZWwZtb8/nebqS3a3ohPm6LNs15HL7wyeUHpljIpT9Q=;
        b=LcRXQf4NyWDOhSh9TXFoesQ/jRdx3iLEsMqmcBL4uHFVLO5n5wC6Gmqf5bbS0Dueb7
         LV3+cQQ4r3iq2r7J7tMYwnQGTo/+P5+Dx/H8QzH8hKfL/+0mqUNESmGZtb1RNVlu7y6x
         O6liSPo4gvfghPWPiLleGb8bSiiXC0uPbC5bnoh6TxG5za4/OJhGvrHusSM278OeVz3O
         1whBuw2Pp+ryxTNLV+c8zJTYGvovxkcnUdh/nl1crGzoAeI5zb4EPj4ksO1CzG+WnJZ/
         O8RdLUSLE5fNzOZqdHiY6+YzGUxogB3T11CZDuevOUnMttAIiAvgq5brEHMaw7Q4Ou6e
         tcwg==
X-Gm-Message-State: AOAM533jYI07H/cQt5mq6tDuFMKHyS7yZf+ReBBUx2hqkVPEfdWJe4vR
        uNeHIVRr56uP9lDwL503H/I=
X-Google-Smtp-Source: ABdhPJw0BOV8MsgEovfSiUGgVESxjYZ7mpQY68t+5HCYwIjeVqf8OmDeHkmabjx4TQTqkzw2qOsTlA==
X-Received: by 2002:a50:d6c9:0:b0:41a:68bf:ff26 with SMTP id l9-20020a50d6c9000000b0041a68bfff26mr3712199edj.102.1650114434221;
        Sat, 16 Apr 2022 06:07:14 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id el14-20020a056402360e00b0042121aee887sm3600798edb.77.2022.04.16.06.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 06:07:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfi8v-006Fz7-6F;
        Sat, 16 Apr 2022 15:07:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        phillip.wood@talktalk.net
Subject: Re: [PATCH 2/2] config.mak.dev: alternative workaround to gcc 12
 warning in http.c
Date:   Sat, 16 Apr 2022 14:50:07 +0200
References: <20220415123922.30926-1-carenas@gmail.com>
 <20220415231342.35980-1-carenas@gmail.com>
 <20220415231342.35980-3-carenas@gmail.com> <xmqqh76taplg.fsf@gitster.g>
 <CAPUEspj4zu-59qxoVPMDGwMvWmu977WRDe7=t0if7raz=H24AQ@mail.gmail.com>
 <xmqqwnfp98ix.fsf@gitster.g> <xmqq35id970u.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35id970u.fsf@gitster.g>
Message-ID: <220416.868rs59ny6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 15 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...  We can take
>> the patch you posted and then post release we can apply the "clear
>> the .finished member as we are done with the slot" fix, which is a
>> good hygiene regardless of any compiler warning issue.
>> ...
>> At this point, my inclination is to merge these two DEVELOPER_CFLAGS
>> changes before the 2.36 final gets tagged.
>
> So, the post release longer term clean-up with log message may look
> like this.
>
> ----- >8 --------- >8 --------- >8 --------- >8 -----

> [...] clear the
> finished member but make sure to limit it to the case where the
> pointer still points at the on-stack variable of ours (the pointer
> may be set to point at the on-stack variable of somebody else after
> the slot gets reused, in which case we do not want to touch it).

I'm still not sure I get this. So while we're in the run_active_slot()
will we have a nested or concurrent invocation of another
run_active_slot() (driven by the curl API?).

My reading of this code in get_active_slot() is that the "in_use" member
is guard in "struct active_request_slot" against any such potential
shenanigans, even if this was racily running multi-threaded (although
then the slot selection loop itself would need some mutexing).

Then in finish_active_slot() we have since baa7b67d091 (HTTP slot reuse
fixes, 2006-03-10) unconditionally clobbered "slot->finished" if it's
non-NULL, without any "is it ours?" check.

Which has been my analysis of this, i.e. that at this point we "own"
that member, and we won't race with anyone. We were even doing the
unconditional clearing already, it was just across a function
boundary. But GCC started warning about /how/ we did the clearing, so.

If it's just general paranoia OK, quite confusing though, because we're
doing this in 2 places, and this puts a guard on 1/2.

But I'm asking in case you see some path through this where "the slot
gets reused [by someone else, it's not our value, and] we do not want to
touch it".

I don't see how that could happen *within* run_active_slot() but not
between the existing code between run_active_slot() and
finish_active_slot(), which is doing that clearing unconditionally...

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  http.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/http.c b/http.c
> index 229da4d148..626b4051e1 100644
> --- a/http.c
> +++ b/http.c
> @@ -197,8 +197,10 @@ static void finish_active_slot(struct active_request_slot *slot)
>  	closedown_active_slot(slot);
>  	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
>  
> -	if (slot->finished != NULL)
> -		(*slot->finished) = 1;
> +	if (slot->finished != NULL) {
> +		*slot->finished = 1;
> +		slot->finished = NULL;
> +	}
>  
>  	/* Store slot results so they can be read after the slot is reused */
>  	if (slot->results != NULL) {

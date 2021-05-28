Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC589C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28B161163
	for <git@archiver.kernel.org>; Fri, 28 May 2021 15:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhE1PvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhE1PvA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 11:51:00 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BF1C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:49:24 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so3922974oto.0
        for <git@vger.kernel.org>; Fri, 28 May 2021 08:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=CP3T7Cu8tbof3rBRyd4nKN8iOpi+AwEbshvXfiHkQUg=;
        b=skf5zQasd4xAE8E53aQCIeNA0w3NH7YNDI35APM3BwlXAMMOKzN9TPjYTjZjMoScIk
         UXzYXhSQY3FRpL0pW0tKuRJXphQf1RDZMnfXG2zoism7SxaLRVY6rkJ+2GosSG4s1UIN
         q5m93aioSBphfa3gx9Egh0+jwBFD6Gc1+oCxSU7FbcVWGXEbznQah9U21an14qmV70Zy
         7n5/SXxf+gwkAExgatFol8cNuk7WYevfn2cOag69pxU0gR+VOoavV+FuUveZpKd60Kl1
         BRkDrbNkHzKDvakxnbFUWzh+84kEoHD/XxyN4ju3NUYkan8iIGlYzc4UDjaE7JXi9JFy
         wP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=CP3T7Cu8tbof3rBRyd4nKN8iOpi+AwEbshvXfiHkQUg=;
        b=qBWMLO/n3jV/OFmqhITFBqS+gb9fz36wgGFIM0WOuJV7RgJ57qnUSI5NP4XnahWMTE
         isX38VW/JzBES0F5V5iwWqryAj+jCznNZxlFbEd4DZYgne1SDfgnXollpA7WKyPJDSAx
         HZKb4NuFnOroAOSqY0iQWWik2sPFRUSKE6iLnL66sQN+/3mlWifv8LBCXvJ/9TCeiQbd
         KdIOJTvCjV5yjjK63Y3A/E8R2EpuP4BXM0YEtRJIOmmewef/s5wLR5TxTandXHqZBn75
         9k8n8NTr/z94DN+VxOHKGfXjtXEOEZHvIwqhcGmPvUhUVIcTpc9Mxk2qkoDymJfvkNIX
         yV+A==
X-Gm-Message-State: AOAM531U97v/DVYUxy9BZiDRfCKVLqqs2lYKzNtt/kp9Q/m7aISapi5N
        eP/IRpLm1IgTsAQh38ePsADk0fAmzArH8Q==
X-Google-Smtp-Source: ABdhPJwZiTfy5eklWv+Kb6NSywFjos3apf9jH5OTqFU1sCboNWHIgARFJTo7YRca504wMMwfNVHxTQ==
X-Received: by 2002:a9d:7286:: with SMTP id t6mr7460746otj.278.1622216963798;
        Fri, 28 May 2021 08:49:23 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t22sm1246103otd.25.2021.05.28.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:49:23 -0700 (PDT)
Date:   Fri, 28 May 2021 10:49:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>
Message-ID: <60b11101e5288_50514208b4@natae.notmuch>
In-Reply-To: <875yzcpo52.fsf@evledraar.gmail.com>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <cover-00.10-00000000000-20210520T081826Z-avarab@gmail.com>
 <YKYdeom6SgAHqojm@coredump.intra.peff.net>
 <xmqqv97drmge.fsf@gitster.g>
 <875yzcpo52.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v2 00/10] send-email: various optimizations to speed up by
 >2x
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Returning a flattened list is idiomatic in Perl, it means that a caller=

> can do any of:
> =

>     # I only care about the last value for a key, or only about
>     # existence checks
>     my %hash =3D func();

I was staying on the sideline because I don't know what's idiomatic in
Perl, but Perl and Ruby share a lot in common (one could say Perl is the
grandfather of Ruby), and I do know very well what's idiomatic in Ruby.

In perl you can do $ENV{'USER'}, and:

  while (my ($k, $v) =3D each %ENV) {
    print "$k =3D $v\n";
  }

Obviously it's idiomatic to use hashes this way [1].

It was a waste for Git::config_regexp to not do the sensible thing here.


You can do exactly the same in Ruby: ENV['USER']

  ENV.each { |k, v| print "#{k} =3D #{v}\n" }

And the way I would parse these configurations in Ruby is something like:=


  c =3D `git config -l -z`.split("\0").map { |e| e.split("\n") }.to_h
  c['sendemail.smtpserver']

And this just gave me an idea...

[1] https://perldoc.perl.org/functions/each

-- =

Felipe Contreras=

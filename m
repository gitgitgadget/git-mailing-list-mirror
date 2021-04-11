Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BACAC433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1644F610A6
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 15:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhDKPGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 11:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKPG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 11:06:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD0BC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:06:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x4so12030096edd.2
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ks8KWHQcmkUBjaOxHzDUJfDKHWVlWcJxJXME5PN96ag=;
        b=HwLHs/lbXMwamr+GNBVF5L1i7IkKkqq48TD92KyQROh0JxPOjlaOwjV3fU2aYmoNg4
         FtyUfmQjmBoLyTQoFE4Mr6xO/NYqnmGnax9vk2AJaqLsimO7yYiBPebnQfORP+Y4CFfA
         8Ams7SPgAqxlOLm7DTXOYuZv/ivfD4vgX00G5Crg5ARSEa3ivu990tZgC13cJnbuirDF
         MwFRSTDhDMOWxE1xjsorPr08xK4yTlA4w9oSMrMufZTLUB0FF92yjPQABAC89mseFpnu
         pYDo3hbb0S+7U+e/5t3pAZUOWOX4IKAKAzfHLO/3XyR9T4uIMyrM+OtrZVscvMN3trP6
         soEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ks8KWHQcmkUBjaOxHzDUJfDKHWVlWcJxJXME5PN96ag=;
        b=MrDo0HL4ogPLRL9dpEqTPBxxNVtmRnF2wytcOaKnMqpGJAAP+lxI6cL1MCyqyMahWZ
         Uyuu7qS1dYzCOIl6PXXz0/o1TKdHQP4T2ptw8xInC0aK71uil9d2fmvKyuk3e0F0TP30
         RziSQQX52n3CEXTgWZEmywrmrZUW1PzVbl2Y/XtRQ/FvPrdACnLmxtJB9l4iBM8cVqoh
         y9/EuQfdyvD/DvtSSWmNodLgbLQ9UnjQ90Wn2PjGtKhGmhd0ic3ODKUbgvcrhTjD9cdX
         ykngLOIyW2ZVuAwF/kaaVvYWSzNs9OEnW8/w3K7vxS0dMLBS+p1IO7jl4Df9aMl70lrp
         uMWQ==
X-Gm-Message-State: AOAM532Z2wS31GHABWITM8fj1cUnsJsHg9FBogH9pF7P2JCRRUa+bOmI
        /lss79E5ufPeDnSdg52YnSQ=
X-Google-Smtp-Source: ABdhPJxTDstMrdG+BT5wKIkvbkxPvpgl6rv1cnaXUsvbXq39fw0Kkyjulf0uBK86qiOdLHIRllBs3Q==
X-Received: by 2002:a05:6402:42c9:: with SMTP id i9mr25893387edc.35.1618153571493;
        Sun, 11 Apr 2021 08:06:11 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d6sm4947276edr.21.2021.04.11.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 08:06:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com>
 <87blakgaxr.fsf@evledraar.gmail.com> <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
 <878s5ogagz.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <878s5ogagz.fsf@evledraar.gmail.com>
Date:   Sun, 11 Apr 2021 17:06:10 +0200
Message-ID: <875z0sg8t9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sun, Apr 11 2021, Drew DeVault wrote:
>
>> On Sun Apr 11, 2021 at 10:20 AM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son wrote:
>>> >  # 'default' encryption is none -- this only prevents a warning
>>> >  $smtp_encryption =3D '' unless (defined $smtp_encryption);
>>> > +if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_enc=
ryption ne "tls") {
>>> > +	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls=
', or nothing.\n");
>>> > +}
>>>
>>> Having not tested this but just eyeballed the code, I'm fairly sure
>>> you're adding a logic error here, or is $smtp_encryption guaranteed to
>>> be defined at this point?
>>
>> I will admit to being ignorant of much of Perl's semantics, but I had
>> assumed that the line prior to my additions addresses this:
>>
>> $smtp_encryption =3D '' unless (defined $smtp_encryption);
>
> You're right, I just misread the diff. Nevermind.

So on a second reading.

So first, I've been sitting on some fairly extensive send-email patches
locally, but have been trying to focus on re-rolling some of my
outstanding stuff.

But I just sent two patches directly relevant to this series as
https://lore.kernel.org/git/cover-0.2-00000000000-20210411T144128Z-avarab@g=
mail.com/

Something felt a bit wrong about the approach in your series, I wasn't
quite sure what initially, but here it is;

So, the only reason we have that "encryption is none -- this only
prevents a warning" so late in the file (as opposed to setting it to ''
when we declare the variable) was because of the
smtp.{smtpssl,smtpencryption} interaction, i.e. we relied on it being
undef to see if we needed to parse the secondary variable.

But with it gone with my small series (it already didn't work) we can
get rid of that special case.

But, on the specifics of the "felt funny":

 1. Your 2/3 changes a long standing existing "any other value =3D no
    encryption" to "die on unrecognized". I happen to think this is
    probably a good idea, but let's be explicit in the commit message,
    e.g.:

        We don't think it's a good idea to silently degrade to
        non-encrypted as we've been promising just because your version
        doesn't support something, let's die instead.

 2. If we're breaking the "any other value" we should not be documenting
    the "or nothing", the distinction between "" and undef on the
    Perl-level was just a leaky implementation detail.

    But let's not conflate that with how we present something to the
    user. It's not the same to not set a variable v.s. setting it to the
    empty string.

    With my 2-part series it's even more trivial to detect that, but
    even on top of master you just move your check above the "set to
    empty unless defined".

 3. While I'm very much leaning to #1 being a good idea, I'm very much
    leaning towards introducing this "starttls" alias being a bad idea
    for the same reason.
=20=20=20=20
    I.e. let's not create a new 'starttls' if we can avoid it explicitly
    because we used to have the long-standing "anything unrecognized is
    empty =3D=3D no encryption" behavior.

    A lot of users read documentation for the latest version online, but
    may have an older version installed.

    To the extent that anyone cares about the transport security of
    git-send-email (I'm kind of "meh" on it, but if we're making
    sendemail.smtpEncryption parsing strict you probably disagree), then
    such silent downgrading seems worse than just not accepting starttls
    at all. I.e. to have a new behavior of something like:

        if (defined $smtp_encryption) {
        	die "we call 'starttls' 'tls' for historical reasons, sorry!" if $=
smtp_encryption eq 'starttls';
		die "unknown mode '$smtp_encryption'" unless $smtp_encryption =3D~ /^(?:s=
sl|tls)$/s;
	} else {
		$smtp_encryption =3D '';
	}

    I.e. I get that it's confusing, but isn't it enough to address the
    TLS v.s. STARTTLS confusion in the docs, as opposed to supporting it
    in the config format, which as noted will silently downgrade on
    older versions?

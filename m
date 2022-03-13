Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6714DC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 22:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiCMW6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCMW63 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 18:58:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F3457B9
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 15:57:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r11so16225719ioh.10
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=N3B5kK13nzhgHOHURxwyaXLgPcN95GiuIlVcBz77wWE=;
        b=JbdfC4QHrxojykxNG4NyDrJsNHYZ3GxdNZxh3+eCsTYbIiwmE8XFpVarv/i2St2Nkf
         fVhVZnBqprNpny0p/DlA1ONY6BEQsVMQEcMfx6dXLPDGMKeb1XtjdtQijzl4F82wcsE+
         ljxsPR9g2pl1ZkyvvcNk/Cf6v6mX9TICIjaLEZmXiUDp3Hhr33ajfjP+SvkumO8CE6wE
         f9Hhs8DXxfcy8bI7Wat8rOYvHnsdBxYN6oUYAjegNDAZ3u/2sy1G8CdNTQ0kvjjKMgNj
         tJE5iTkq7Wc3miOEvbiTrIU2NZzxko5qxCm94DIDcRDwpaciKMREiWeaL9rTGrR25us/
         YSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=N3B5kK13nzhgHOHURxwyaXLgPcN95GiuIlVcBz77wWE=;
        b=HiyQD/JMPzYJx4CG0T/xqizou6p+vwX+SU+Mp7E9yoQ0GP5Gssu8NCsqKjMewVdp6l
         4hZ1/UNovUgtHUzIhoJGZ18h8YyXni5eedE9UIafpclVRQwzqG6VcdLC7uBqMsOLPe9q
         +LHyj6coKUfg00s0zFSBZsHqO4gY59k06vwKAvWXTB/cCFHahF+fsmEVyPfvRB8io+Cv
         +Xu+22zkG5vc0RFKoLwipycu6hHJ74bJkwTtWQFKLATfPswHhsjMt4YzWHLX3DPmeCFl
         fsS8/3u2k3JXEm8o0zLioc2ejCCBjIMN0ZqzS9K+uemP7LnU8H9HIHRACNd5YeSAqcbp
         rIRQ==
X-Gm-Message-State: AOAM530/mmw6jIimzUYxUFELqhh4tFYREAZ2r62aXWMgCvkvYmQi8Eqd
        dMFS6BC5xy2fT4lNhupYyD1a8vy//LlVKQ==
X-Google-Smtp-Source: ABdhPJxmnwLk6x0vO6vYjf+EDdMIRmNZdqtJu55Ukc4SULQSTnFBoOFpGQHTmLVx3DZYVqunuap9NQ==
X-Received: by 2002:a05:6638:130f:b0:319:bc90:a885 with SMTP id r15-20020a056638130f00b00319bc90a885mr15294928jad.299.1647212239222;
        Sun, 13 Mar 2022 15:57:19 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id k15-20020a92c24f000000b002c79ec214f9sm1044177ilo.30.2022.03.13.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 15:57:18 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>
 <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 17:40:47 -0500
In-reply-to: <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
Message-ID: <87ilsha2b7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philip Oakley <philipoakley@iee.email> writes:
> The GDPR isn't as onerous as some suggest, as it isn't a set of black
> and white rules, rather in cases like these you need to have a real
> strong reason for why data is retained etc, such as being part of the
> verification and validation of the commit data. There have been various
> discussions around this in many of the technical journals.

That's good to hear that this has already been discussed in the
community (though I'm hardly surprised now that you mention it -- I'm
sure it was and remains a hot topic!).

> It maybe that your internal Git version could disable the particular
> `format` option ('%ae'?) for the original name, so only the designated
> ('redacted') mailmap entry is shown to casual users (assumes the repo is
> inside the corporate firewall). This would avoid invalidating the repos
> validation capability, while meeting the needs of GDPR type regulations.

I do want to note that at present we're not primarily concerned with
GDPR, but I am following up on that internally to see if there are any
considerations we need to make.  This is certainly an interesting tactic
for repositories that are hosted in GDPR-effective states, though.

> In the same vein, a local Git version could, being open source, add
> allowances for your extra mailmap entry details, such as adding a post
> fix " % <approxidate>" limits for the use of the particular name/email
> combo to allow date ranges to emerge.

I'd prefer the ability to agree on a pattern and merge support for it
upstream.  This way, forges can pick up support, too.  Bonus points if
the forge doesn't necessarily have to do more work than it already does.

Your " % <approxidate>" suggestion sounds a lot like the 'Valid-Before/
Valid-After' proposal from my original post in this thread (admittedly
not my idea).  Is there a compelling reason to use this approach over
UUIDs?  I ask not to suggest there isn't a compelling reason, but mostly
to make sure we consider the best arguments (and drawbacks) for any/all
approaches.

> I noted that all the .mailmap examples in the man page have ">" as the
> final character, but I haven't looked to see if the code always requires
> that the last element of the entry is an <email> address, or whether it
> currently barfs on extra elements.

FYI mailmap does support comment syntax (starting with # through \n).
It's worth noting that =C3=86var suggested earlier that perhaps we could
"(ab)use the comment syntax".  I tend to prefer their other approach,
though:

    > I.e. we simply ignore things we can't map now, so one way to do it
    > is to start with something that produces an invalid (but harmless)
    > mapping to current readers, [...]

rather than use magic comments :-) Adapting to your suggestion, this
might look like the following:

    A. U. Thor <foo@example.com> <ada.example.com> <[ approxidate ]>

Would be curious to know what other mailmap readers exist and how they
would react to this.

--
Sean Allred

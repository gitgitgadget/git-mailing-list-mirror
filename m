Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8481F404
	for <e@80x24.org>; Wed, 25 Apr 2018 08:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeDYIsp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 04:48:45 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37659 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDYIsk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 04:48:40 -0400
Received: by mail-wm0-f45.google.com with SMTP id l16so5376226wmh.2
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0Ft0iMjbKc3ZjAYvSGjYGcF/EJtaPYiBu9rvDvZIaPw=;
        b=b2xWSQsnUnXx4oavYcNYoQFqyQ9YFZ0KOw/UfyHLgfYsP1ZuX2C8bri1pZfVZSRYlJ
         h/7tw4RmGUzcec9zeNN9FwPOLXnIvhW1HpENZDBwiz8z9zhXB+zidS62BZuBabB9dXOy
         Y5VlOy8M3R+XNwI+0DwxWkUdc2+BwPOIkKTgU2EOr9xpi9FllLv0SbIgzTfSbgmxlByH
         WbAZILkERm7tdGgOrCC8ZFBe2PAqVu4WPMpMEc6N/sOUx92Z8kgm0wjncAD/s6Id8xLW
         VBRbdJTkigpfR8f7CUIviX9U2lUbd3eTW2UvekFYs5EoiVG7LGrvKvIX6EH8JcYVTOQV
         MX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0Ft0iMjbKc3ZjAYvSGjYGcF/EJtaPYiBu9rvDvZIaPw=;
        b=j18oe6mUUbK0NgzmVTkx+Ym2ieUR/d3p16Cq6frJ5dzW3DXW/Cvuymi+rsraSCb45L
         J6AfbT+V0sVmOo8SN8NawY4xcREdgeLmfMqDeWGIAcvTLAguLMJCSq4HFxJFemYHYNYB
         vyEvxFWrIDkUxxLIkeIze3O/PdJdLAM2RBEZU3GjOuY7osWJ1ZUj3FV1nzMy/hkkRM/O
         Y53rzDpe9id/do1uyz39gF9ZTmpkbTXbEaEg+2biVOkoXGKlOv5UtP9JvX0zcftgO66z
         GsVzaOPwnM+RMgYy1Q/Gfn9fNl8HEa5LhtFupBeY6Bt6sN0KjkAmy4FeiWZsc0yFloL9
         3YlA==
X-Gm-Message-State: ALQs6tAEBaqBEPpSKOULrj/voY2r9da84UAkQtVFm0XRogRA0bCVmqAq
        Fk/uv4Ox2maM0gprnXwnRWU=
X-Google-Smtp-Source: AB8JxZphzJWSaokejBB/cuuMbc9BZNSI2jFdkb7LCRIImZ4Rt0DeJQ4Z5XByZc9BGIKGys7+7LoauQ==
X-Received: by 10.28.88.195 with SMTP id m186mr15189090wmb.113.1524646118935;
        Wed, 25 Apr 2018 01:48:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q188sm16683637wmb.37.2018.04.25.01.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 01:48:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Ny?= =?utf-8?B?bnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
        <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
        <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
Date:   Wed, 25 Apr 2018 17:48:37 +0900
In-Reply-To: <robbat2-20180425T060717-325652820Z@orbis-terrarum.net> (Robin
        H. Johnson's message of "Wed, 25 Apr 2018 07:13:38 +0000")
Message-ID: <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> In the thread from 6 years ago, you asked about tar's behavior for
> mtimes. 'tar xf' restores mtimes from the tar archive, so relative
> ordering after restore would be the same, and would only rebuild if the
> original source happened to be dirty.
>
> This behavior is already non-deterministic in Git, and would be improved
> by the patch.

But Git is not an archiver (tar), but is a source code control
system, so I do not think we should spend any extra cycles to
"improve" its behaviour wrt the relative ordering, at least for the
default case.  Only those who rely on having build artifact *and*
source should pay the runtime (and preferrably also the
maintainance) cost.

The best approach to do so is to have those people do the "touch"
thing in their own post-checkout hook.  People who use Git as the
source control system won't have to pay runtime cost of doing the
touch thing, and we do not have to maintain such a hook script.
Only those who use the "feature" would.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4619FECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiIAPsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiIAPsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:48:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A218D3C6
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:48:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l65so7477978pfl.8
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=Uy4tAqKlN6M+d4XYl9bP+dPxilN379oYyjzkn4mL4s8=;
        b=EMjzc0sXy27y/8FZfhdWecB2Whb9dd4u6CDhf5F8q6vnI+ykwRbqBFW2BZZAdND0L0
         xunWs+SkjOgRIt7WWL0/jULiHbpZg0qBQKLMrLdcrkEplPb0D9z2YZtmVp/+Voo/7MI/
         44+Io+bS6BBoq1/ERrBl+RsGpHTifO6nSmZ+/4ihpT5kn77UvTwbPMgcOK7jmbM8oVP4
         72wYKmAqJzvbZS5zCi9qg956H5LMWA0Hkq2DWcb3Yf9evI7q5fZCG16XTPGFQJ70pFTY
         CugV3rx40HfUumYH2uyo97yTr0q0ar3V6H/gKIXQKVQQYp3TtU2y9P8d/9jobqmQwhp1
         eHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Uy4tAqKlN6M+d4XYl9bP+dPxilN379oYyjzkn4mL4s8=;
        b=MOXo9TmMk/uOh3d8KfjjZmf3ImP97PQQh+JXI7saQn+f8yBaqTXkHREanM4DLTAJWg
         AJHTzkvcD2U+0hW7RmA65NhOiub+uXFbqz5erDDON/JMxEwiNtZjg0MjKJKFO4+ZuRLi
         fsGxuceW+0cMNLKjSdSmVZTafTjtJlCHI+BYcrRVYB9obb+V5tP6upmr5Sp36X04FPDQ
         h1HTGUrF48534T5wk/pRESwzvFW/dkL1OzXN6MZ6N7m1pWVD+5TR1ZVE9IK9TOLkuL/1
         33JiDEhR1YZutc49ZNONKgUrXeG3HosG0kCu4JaA8EUGNEuccqqzW0sNusK1RGcaiutl
         eHrg==
X-Gm-Message-State: ACgBeo0/PHXnUQ+6hnz4sxsMF/QgSxCIym2Y+lQq5rmbpkp/zMfv3el2
        RICkEBNAO4anvP3/01VJ8PE=
X-Google-Smtp-Source: AA6agR6UA9Em8eYxkWfyW9vyQkh6WZsq3U+09OYuAnxm7FWMAlOnjbLX4WO/u9xUE5ke2klnU8OX3Q==
X-Received: by 2002:a65:6cc4:0:b0:412:35fa:5bce with SMTP id g4-20020a656cc4000000b0041235fa5bcemr26315770pgw.466.1662047319375;
        Thu, 01 Sep 2022 08:48:39 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 126-20020a620484000000b0053617cbe2d2sm13500154pfe.168.2022.09.01.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:48:38 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] Makefile: use $(OBJECTS) instead of $(C_OBJ)
References: <patch-v2-1.1-e77fd23a824-20220321T170412Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>
        <patch-v3-2.2-cb3bc8b5029-20220831T090744Z-avarab@gmail.com>
        <xmqqmtbkdr5n.fsf@gitster.g>
        <220901.867d2njg52.gmgdl@evledraar.gmail.com>
Date:   Thu, 01 Sep 2022 08:48:38 -0700
In-Reply-To: <220901.867d2njg52.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 01 Sep 2022 16:52:05 +0200")
Message-ID: <xmqqsflbayeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> This is a declaration that we would never ever build .o files out of
>> sources other than .c files.  While it does make sense to have it
>> outside the scope of [PATCH 1/2], I am not sure if it even belongs
>> to the same series.
>
> I think it does. Before this the C_OBJ would be:
>
> 	C_OBJ := $(filter-out $(ASM_OBJ),$(OBJECTS))
>
> but after 1/2 it's the same as $(OBJECTS). An earlier iteration of this
> did this cleanup "while we're at it" (which I do think makes sense as an
> atomic change), but I got the feedback that the cleanup wasn't strictly
> necessary.
>
> But as 1/2 has removed the ability to build those $(ASM_OBJ), as we had
> only one of those, I don't think keeping this particular bit of
> indirection makes sense.

You are not thinking for longer term to help project maintenance.

This change removes distinction between C_OBJ and OBJECTS, only
because the sources to the objects we HAPPEN TO have are only C
files.  It is premature and short sighted to declare that it has to
stay that way forever.  And such a declaration is not something we
would casually make "while at it" in a topic like this.

When we add a source written in another language, say xyzzy, to be
compiled into an object file, we'd add $(XYZZY_OBJ), and they will
become part of $(OBJECTS), but the current rule to create $(C_OBJ)
will not apply to $(XYZZY_OBJ).  But you do this:

    -$(C_OBJ): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
    +$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
            $(QUIET_CC)$(CC) -o $*.o -c ... $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

Right now, we know where this patch affected the build procedure,
because the patch highlights what is being changed.  But when future
developers need to produce some files that belong to $(OBJECTS) out
of source files that are not .c, they first need to locate the above
hunk and revert it.  I do not see the benefit of being hostile to
future developers with this patch.  Not before we know that it is
not likely that we would add any non-C sources in the future, by
running with 1/2 alone for a year or two.

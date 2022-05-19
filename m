Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D484C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiESKjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiESKjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:39:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFD64717
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:39:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h11so5307832eda.8
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oPjff5Qa7rHTW/9hYT+SIv31CJqWqv4cH23EI6T2M2I=;
        b=mCTRFLT3I4jOD+qM7T+B1krcHMgxkKIl+8GPtw7u8k5uze9v2ORt/vJjgJxnbBZN0+
         2m/u/aQxpv0fLrkZ2ZGhiqDfspu/xPdMntlq7zat/74pEEDanMZIbDr9stDqbc4VTS8p
         Kj4pQP9GUO5WeiyeBsJ1YvypcgBeKlXOujX5ImejT5zKF+SvwZztur8ByoMJBlSzGHuy
         wjiBP9NEZWklfY6b4zahoqx8Pa9CqxCfQhnfM1UvAkIURPbI7Ev144CyftJ5RxeqJzvr
         ih/VJTN9H7MZ16cNc1gr1QZ/PjA9q+t1hkj4WPwiMAhui6PUyT9+oJ/98Vt8/j9Jt8xf
         KeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oPjff5Qa7rHTW/9hYT+SIv31CJqWqv4cH23EI6T2M2I=;
        b=oUlICc/9QkARCLrpKPYbdssJlxZsW+2iuHJszhugFrnaq12oi6KvtOd5rmvB9Cxh1V
         8Lk6gIjctCZ+SZKlNdghOlnJbDLZx8/50u8qLP+Mwq/A5gA0mTt9JPKrmSWPxp8jFsf7
         Vo/Z/wYhRB8m4DW6BKt4lGp4sycOR6KwLf34C+NxKYpRYjK2Bq10LEIBDpWcTJqzPvxV
         b8Gv3R04ydMhlw/2h39MqPpyKIJH5jYqsCrKTlRdlsZ2I3advBtM/NX9V6ohQ7fSWrGa
         KHAQ4v2Qtzyc2P3siILv4sLzWUiBtJole+7QOXzWedifsThRXkvuwJlW5qYLAUMnYv5i
         ifqA==
X-Gm-Message-State: AOAM530J+RGamyNZbPP56Q+z/5UMCzTS1zE7M4y1gacDP8cNG/wRXEdE
        2Zq5QqphvYR0/9Hn2GSKTF/nuc9i10HWdQ==
X-Google-Smtp-Source: ABdhPJw1yNNagmpsxMgnWN7Lnw1e93udmkCVC/LX8cN72YTyFh+lL3sbUlGrMADbPwwg/mLouho9Yw==
X-Received: by 2002:aa7:cd87:0:b0:427:f800:220d with SMTP id x7-20020aa7cd87000000b00427f800220dmr4665994edv.112.1652956774831;
        Thu, 19 May 2022 03:39:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d12-20020a056402000c00b0042617ba637bsm2567740edu.5.2022.05.19.03.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:39:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrdZ6-0023yp-P5;
        Thu, 19 May 2022 12:39:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [PATCH v2 0/9] Incremental po/git.pot update and new l10n workflow
Date:   Thu, 19 May 2022 12:28:05 +0200
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <20220519081548.3380-1-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220519081548.3380-1-worldhello.net@gmail.com>
Message-ID: <220519.864k1l6c2j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> A workflow change for translators are being proposed.
>
> Changes since v1:
>
> * Patch 4/9: When running "make check-pot", do not update "po/git.pot".
> * Patch 6/9: reword: the removal of "po/git.pot" is in preceding commit.
> * Patch 7/9 and 8/9: Add new funciton "check_po_file_envvar" for reuse in both
>   po-update and po-init targets.

Thanks a lot for picking this up. I left some detailed comments on
individual commits.

My own latest WIP version of an approximation of this topic was
https://github.com/avar/git/tree/avar/Makefile-incremental-po-git-pot-rule,
which is what I used for some of the range-diffs.

(I think the first E-Mail I sent had a range-diff against the latest
version I found in your fork, but I found that was probably the v1
version, but I think those comments applied to your v2 (which I read
on-list))

Aside from differences already noted I spotted that your "make pot" ends
up with a po/git.pot that has a header, but I omitted it in
mine. Perhaps that explains some of the headers in 8/9? I.e. we don't
need the header on po/git.pot, perhaps that explains the difference
noted in my comment in 8/9?

Also: shouldn't "make clean" remove the generated po/git.pot and
po/git-core.pot? I see you added it to "distclean", maybe that's better
(or maybe that's from a version of mine...).

Just from some last minute testing I think you want this squashed in
(and move that "sed" to the "init" and/or "update" of the individual
po/XX.po files):
	
	diff --git a/Makefile b/Makefile
	index 65a7558261a..57db37db556 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -2778,14 +2778,7 @@ $(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
	 	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
	 		-o$@ $(XGETTEXT_FLAGS_PERL) $<
	 
	-.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
	-	$(call mkdir_p_parent_template)
	-	$(QUIET_XGETTEXT)$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
	-		-o - /dev/null | \
	-	sed -e 's|charset=CHARSET|charset=UTF-8|g' >$@ && \
	-	echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
	-
	-po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO)
	+po/git.pot: $(LOCALIZED_ALL_GEN_PO)
	 	$(QUIET_GEN)$(MSGCAT) $(MSGCAT_FLAGS) $^ >$@
	 
	 .PHONY: pot

I.e. we can just msgcat po/git.pot without the header. For both
"po-init" and "po-update" that seems to do the right thing for me...

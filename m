Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF1C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 01:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiKHB0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 20:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKHB0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 20:26:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69C20BDD
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 17:26:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so12865950pli.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 17:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XonapqJpM7yvaCyJe75gMK4hbgTaJjSwWgUYH1Q3RBM=;
        b=IFAZpIO/lwKubsjEFTL8BX1jRNVwrCYCmh7VU28q+J6mndywS7Ohi9AisIUNJ6b3CZ
         84pMS3wy4sqhJNnGfWKaZwYGaDlR8sYI1asjrc4OSbHqQ4sC7DJcLg1z9eBl+hewbaOw
         pZCvq+sEsOoTK6h0IS2WodjRNP9h3THtkYazkEOrgBPM6tdnU4HUb0gA/apj1l9ZPUHf
         bQ076D/ILMNWnkadKXD4dzalMQDssjWfOkvkoVI4pNBMjgtn4SFs7id6rWB65lxpmkIk
         NYWJ8x2qM3RSvqCcVJEc/M4yc3hHWv5dCJ1Yqu6iUgn5geRZPnDJZHT5ZaN3+lAaVSRu
         /NEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XonapqJpM7yvaCyJe75gMK4hbgTaJjSwWgUYH1Q3RBM=;
        b=nD5fMK0SMofNVteJYgH7nJuBoUWJiOf7cG0GpL6xg7W3SdmJ9iWTLams9+yVrGgcxg
         LgnupYASb29VLLvXfcyBk0mt3jkokyNCrvux82LxNucWA7MchTk/V9EYX8KCQowhYLa2
         2YFBL95kqkwdSmGwkhahRtS6Q1mxVxUufsxORfMu/Dq3zK4+YbKqVmZmMWHrMuPr3KLP
         O+lD0lHUXxpRe0EX7tEn+uRLlsg/jeSmpyA1rnN6EfmgHSYgCLYSFb9un0BA6ytQtxp7
         9i7QnbKx9Vxaah6ieCnYDP9y5DRUPv0hoO1TjsEv61F6wSVJyehdeuVo8xJSOaao6olE
         2pkA==
X-Gm-Message-State: ACrzQf2S5ndDlYuB61meg5ceNZ/yJPRN6jLqKMDJ/SY1Il6uO0fT0g0t
        e3hBHXgTDshjj904JBMeuNU=
X-Google-Smtp-Source: AMsMyM4Lle1ulY6EYmIx1TsW6QnxLHjvnuBdKtPJztAZCBlAt+hg4Y2BJr9BctZNLOIVsdM8+ARBvA==
X-Received: by 2002:a17:902:e80a:b0:187:1f2d:b1a8 with SMTP id u10-20020a170902e80a00b001871f2db1a8mr45754873plg.124.1667870778407;
        Mon, 07 Nov 2022 17:26:18 -0800 (PST)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id me6-20020a17090b17c600b00213a9e1ec44sm6789724pjb.52.2022.11.07.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 17:26:17 -0800 (PST)
Date:   Tue, 8 Nov 2022 08:26:15 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 05/13] bisect run: keep some of the post-v2.30.0 output
Message-ID: <Y2mwN3bpaiN/7vJh@danh.dev>
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <5ba3bafdd48b47320624d0db06f379bc0a4b8d4e.1667667460.git.congdanhqx@gmail.com>
 <221107.86k046tp8p.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86k046tp8p.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-07 22:40:33+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Sun, Nov 06 2022, Đoàn Trần Công Danh wrote:
> 
> > From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >
> > Preceding commits fixed output and behavior regressions in
> > d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
> > in C, 2021-09-13), which did not claim to be changing the output of
> > "git bisect run".
> >
> > But some of the output it emitted was subjectively better, so once
> > we've asserted that we're back on v2.29.0 behavior, let's change some
> > of it back:
> >
> > - We now quote the arguments again, but omit the first " " when
> >   printing the "running" line.
> > - Ditto for other cases where we emitted the argument
> > - We say "found first bad commit" again, not just "run success"
> 
> So, something you refactored here was that there's now a
> do_bisect_run(), and:
> 
> > -static int do_bisect_run(const char *command, int argc, const char **argv)
> > +static int do_bisect_run(const char *command, int argc UNUSED, const char **argv UNUSED)
> >  {
> >  	struct child_process cmd = CHILD_PROCESS_INIT;
> > -	struct strbuf buf = STRBUF_INIT;
> > +	const char *trimed = command;
> >  
> > -	strbuf_join_argv(&buf, argc, argv, ' ');
> > -	printf(_("running %s\n"), buf.buf);
> > -	strbuf_release(&buf);
> > +	while (*trimed && isspace(*trimed))
> > +		trimed++;
> > +	printf(_("running %s\n"), trimed);
> >  	cmd.use_shell = 1;
> >  	strvec_push(&cmd.args, command);
> >  	return run_command(&cmd);
> 
> Instead of trimming with strbuf_ltrim() we're now using this loop, but
> in any case, this has had the effect that you're only fixing one of many
> of the output changes. We're still adding this leading whitespace to the
> other messages we emit.

Sorry, I can't follow, we're fixing in do_bisect_run, which meant we
fixed all of the output changes for leading whitespace, no?

'do_bisect_run' will be called from normal 'git bisect run' iteration
and also after receiving code 126/127 for the very first run.

Which is the other cases you're talking about?

> 
> As note din the preceding commit you've carried here in 03/13 I didn't
> have time to come up with tests for those.

-- 
Danh

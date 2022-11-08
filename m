Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AA4C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 15:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiKHPBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 10:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiKHPA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 10:00:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F60B10B7D
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 07:00:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk15so21349438wrb.13
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 07:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPyJG5B90QccEuTz27i9/O5C46IbcgHzEekki9pIN0k=;
        b=NDQE4WVHJ2SveSf/3N0aO6pRPG5VlmD5JiPjbkAjQVgb9NVPyYDkVs/K7Z3EfDHINm
         m/nb5Dd+krpwPVyVlVucQN9bfcGIcF4Lk6VC0Rv7495NO/Tr81Jiw+aqEVjDnTuQtlb7
         MvrSPuP0b/dCty7QmSsEN/Shs7RM3NwwfYeFutXdsb8saZLvBOwmyM6KhkOprQPwZP5l
         C4bxV2Jdr0+UTfOTkUuMUefXB82MZqBsVNvxhLXwIt6B6KsPcMKyOFO1M6x3W+1YIxXa
         n7vXwquZmysabJuFnKeds/diZtwA4rbnQJjZKGIR5Hdq2DcvDPId4pMX57ajL17EjRnX
         cstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPyJG5B90QccEuTz27i9/O5C46IbcgHzEekki9pIN0k=;
        b=oUVPTIdwlONbiKtW08p+4DYcO5ifhGBAITN7WgV679Exmhy03d6gyByzYtRJV9zaWO
         0pMuyn//jCqsJjmB1CpK12qwv1ThCFU4wgcDssZfBUe+xTNUsCfMPTwSB0BaxBheCSh9
         /xghH7YqFg2YALjCd+nM/vUm19dWgDoO0sNROyGuWho7Vxb4rdQYEXKMqUn8YEIixG8s
         3XypHbtdKrWCJmvijaIMSQxkPrlK/n5a3ptZCyXtnKuv/y7YbR6y7oeHA1KzL+D4MYmg
         tmZpy9lP4ldr/ya+zbltWHouRsO207Lv7ceeORQ3kl9+xY8I6A3Wm21Aj3zQ68uInX0u
         3TMw==
X-Gm-Message-State: ANoB5pnUdOulZgDtkSnhiEgbn4Db7ae8PLfca/2BPZ6RR1VgZTuhWULN
        UD1953JyGZCWBlPJLslL8xe1Z2mO2yM=
X-Google-Smtp-Source: AA0mqf7pPk20A6dUa7G6LNcl2ZgG09yxZvDAKPUG6J7Hs2DlCyZbmnMGeHCpZ6HvUZf9cpdEPfXSww==
X-Received: by 2002:adf:ef0d:0:b0:23a:aa41:8651 with SMTP id e13-20020adfef0d000000b0023aaa418651mr15883369wro.54.1667919657120;
        Tue, 08 Nov 2022 07:00:57 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id bp4-20020a5d5a84000000b0023677081f3asm10585199wrb.42.2022.11.08.07.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 07:00:56 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <66835bfb-2815-4321-9d06-52f85a0c72f9@dunelm.org.uk>
Date:   Tue, 8 Nov 2022 15:00:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/17] sequencer.c: fix "opts->strategy" leak in
 read_strategy_opts()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
 <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
In-Reply-To: <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11/2022 14:50, Phillip Wood wrote:
> On 03/11/2022 17:06, Ævar Arnfjörð Bjarmason wrote:
>> When "read_strategy_opts()" is called we may have populated the
>> "opts->strategy" before, so we'll need to free() it to avoid leaking
>> memory. 
> 
> Where is the previous value coming from? I guess it may be the config 
> but otherwise I'm confused.

Having looked a bit more at this I think this is the wrong fix. The 
reason we're overwriting the existing value is that we're reading some 
of the state files twice. I think the only way to get to this point is 
to go through a code path that calls rebase.c:read_basic_state() which 
already populates these options via a later call to 
rebase.c:get_replay_opts(). I think the correct fixes looks something 
like the diff below.

I have also looked at the cherry-pick/revert case and I think that we're 
leaking opts->strategy (and probably some others) when running

	git cherry-pick --continue

after

	git -c pull.twohead=recursive cherry-pick -s ort <some commits>

I'm not sure what your strategy has been with the fixes in this series 
but we're never going to have 100% coverage of all the option 
combinations for rebase & cherry-pick so I think it is helpful to treat 
these LSAN reports as a starting point for looking into why the leak is 
occurring and also look for similar leaks.

Best Wishes

Phillip

--- >8 ---
  sequencer.c | 46 ----------------------------------------------
  1 file changed, 46 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e658df7e8f..ece34dce9f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2889,55 +2889,12 @@ void parse_strategy_opts(struct replay_opts 
*opts, char *raw_opts)
         }
  }

-static void read_strategy_opts(struct replay_opts *opts, struct strbuf 
*buf)
-{
-       strbuf_reset(buf);
-       if (!read_oneliner(buf, rebase_path_strategy(), 0))
-               return;
-       opts->strategy = strbuf_detach(buf, NULL);
-       if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
-               return;
-
-       parse_strategy_opts(opts, buf->buf);
-}
-
  static int read_populate_opts(struct replay_opts *opts)
  {
         if (is_rebase_i(opts)) {
                 struct strbuf buf = STRBUF_INIT;
                 int ret = 0;

-               if (read_oneliner(&buf, rebase_path_gpg_sign_opt(),
-                                 READ_ONELINER_SKIP_IF_EMPTY)) {
-                       if (!starts_with(buf.buf, "-S"))
-                               strbuf_reset(&buf);
-                       else {
-                               free(opts->gpg_sign);
-                               opts->gpg_sign = xstrdup(buf.buf + 2);
-                       }
-                       strbuf_reset(&buf);
-               }
-
-               if (read_oneliner(&buf, 
rebase_path_allow_rerere_autoupdate(),
-                                 READ_ONELINER_SKIP_IF_EMPTY)) {
-                       if (!strcmp(buf.buf, "--rerere-autoupdate"))
-                               opts->allow_rerere_auto = RERERE_AUTOUPDATE;
-                       else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
-                               opts->allow_rerere_auto = 
RERERE_NOAUTOUPDATE;
-                       strbuf_reset(&buf);
-               }
-
-               if (file_exists(rebase_path_verbose()))
-                       opts->verbose = 1;
-
-               if (file_exists(rebase_path_quiet()))
-                       opts->quiet = 1;
-
-               if (file_exists(rebase_path_signoff())) {
-                       opts->allow_ff = 0;
-                       opts->signoff = 1;
-               }
-
                 if (file_exists(rebase_path_cdate_is_adate())) {
                         opts->allow_ff = 0;
                         opts->committer_date_is_author_date = 1;
@@ -2959,9 +2916,6 @@ static int read_populate_opts(struct replay_opts 
*opts)
                 if (file_exists(rebase_path_keep_redundant_commits()))
                         opts->keep_redundant_commits = 1;

-               read_strategy_opts(opts, &buf);
-               strbuf_reset(&buf);
-
                 if (read_oneliner(&opts->current_fixups,
                                   rebase_path_current_fixups(),
                                   READ_ONELINER_SKIP_IF_EMPTY)) {

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82731FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933141AbeAKVdW (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 16:33:22 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:46182 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeAKVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 16:33:19 -0500
Received: by mail-wr0-f174.google.com with SMTP id g21so3521813wrb.13
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 13:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=YXHiW78qle210jlAUEYXVZZE1rCqtxm6XRvt/Gm28+E=;
        b=A7dmkDkTEszfkgwCzj8fPwWW1fBBfD4xCLbAxAJHikBPsktpZWdLcP6j02gzGfBJo0
         iha98VvOixRZEMSjfZhu3lYbjYZqOKvGvwavpYDQi4G2k3WPYQzC3rPsnmJJopg+yQ2M
         ZJ/7t+jqw7p836yvfmVjtG2HjvDiOCcUk/N88NK1JAXKOs6ElN/uTg62j2BlW+eYF1UE
         aN25RvJsCz8NHpSwP6txl4KIm8fhsKeKX7bM+GLB5r7Es/ZWiHGYVM0bgYbCLleRmaCD
         tDjlGSIYNMNtOh1TTQQI8KiyZffo4KYWFGTvTTrOOG3OEYcX+0326qCfBMUNTt9ZzZtL
         v/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=YXHiW78qle210jlAUEYXVZZE1rCqtxm6XRvt/Gm28+E=;
        b=DBPaR5r73rMXrCv1+dP0pvFbhh/Z31WKT5757FdgdCtRS13YiBRLNGt2MGHxhDfuw2
         aRm7AV/0KfxIabFPX72yFr2eaDvtljYObug2wStK9trFI1zfIQuugx32RA5QxMTmjUdx
         F936gERhVTSrWXeaOb1oqNvmoldSKbuZQi2M11U1ybdK8F17u0fkdEBbofdUE4mpw+pz
         SuWB7A1yQSg8PTYBtu31DRSE4YBImOqvIKrAQLYAe/MB3ampDkmBeV/VTc3U50/GPypw
         SoZXnVgeyTNvUo1hVMf2h4E/11gfKyb1bhAH2o1UTBR127PrLQFw9Z+7KOqUr1ILTcfu
         tv5g==
X-Gm-Message-State: AKGB3mKhLLId51FJzZpQP6QRzNPzux0aLg+Erx3LVywuVJyGEmiZlaPI
        0dM13vx+X2Zly4trycNKgJrVe8N8
X-Google-Smtp-Source: ACJfBotLdakE64GEKJ+lDACkLVby4CNN5yDF3s3ZkQrSLNdRXox4V7bHXJY5MOBpKcNe91EhNurgwQ==
X-Received: by 10.223.198.20 with SMTP id n20mr21014410wrg.191.1515706398101;
        Thu, 11 Jan 2018 13:33:18 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id t138sm1802564wme.16.2018.01.11.13.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jan 2018 13:33:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Christian Couder <christian.couder@gmail.com>
Subject: git gc --auto yelling at users where a repo legitimately has >6700 loose objects
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
Date:   Thu, 11 Jan 2018 22:33:15 +0100
Message-ID: <87inc89j38.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently disabled gc.auto=0 and my nightly aggressive repack script on
our big monorepo across our infra, relying instead on git gc --auto in
the background to just do its thing.

I didn't want users to wait for git-gc, and I'd written this nightly
cronjob before git-gc learned to detach to the background.

But now I have git-gc on some servers yelling at users on every pull
command:

    warning: There are too many unreachable loose objects; run 'git prune' to remove them.

The reason is that I have all the values at git's default settings, and
there legitimately are >~6700 loose objects that were created in the
last 2 weeks.

For those rusty on git-gc's defaults, this is what it looks like in this
scenario:

 1. User runs "git pull"
 2. git gc --auto is called, there are >6700 loose objects
 3. it forks into the background, tries to prune and repack, objects
    older than gc.pruneExpire (2.weeks.ago) are pruned.
 4. At the end of all this, we check *again* if we have >6700 objects,
    if we do we print "run 'git prune'" to .git/gc.log, and will just
    emit that error for the next day before trying again, at which point
    we unlink the gc.log and retry, see gc.logExpiry.

Right now I've just worked around this by setting gc.pruneExpire to a
lower value (4.days.ago). But there's a larger issue to be addressed
here, and I'm not sure how.

When the warning was added in [1] it didn't know to detach to the
background yet, that came in [2], shortly after came gc.log in [3].

We could add another gc.auto-like limit, which could be set at some
higher value than gc.auto. "Hey if I have more than 6700 loose objects,
prune the <2wks old ones, but if at the end there's still >6700 I don't
want to hear about it unless there's >6700*N".

I thought I'd just add that, but the details of how to pass that message
around get nasty. With that solution we *also* don't want git gc to
start churning in the background once we reach >6700 objects, so we need
something like gc.logExpiry which defers the gc until the next day. We
might need to create .git/gc-waitabit.marker, ew.

More generally, these hard limits seem contrary to what the user cares
about. E.g. I suspect that most of these loose objects come from
branches since deleted in upstream, whose objects could have a different
retention policy.

Or we could say "I want 2 weeks of objects, but if that runs against the
6700 limit just keep the latest 6700/2".

1. a087cc9819 ("git-gc --auto: protect ourselves from accumulated
   cruft", 2007-09-17)
2. 9f673f9477 ("gc: config option for running --auto in background",
   2014-02-08)
3. 329e6e8794 ("gc: save log from daemonized gc --auto and print it next
   time", 2015-09-19)

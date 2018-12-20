Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920E81F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeLTQmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:42:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50286 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730668AbeLTQmB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:42:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so2740556wmd.0
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2s2Id5GrJKnYx0iBVm7d0pinKIWJu++qzVZpF/y/8yI=;
        b=phuz3cfJ43dYHu6LZXHr8q8sxfJUkUomw7spo5+fapqMTt32TeVBLRIzkDPpsKrwcm
         PDWt6rQkD1MHGqLrc8IFow+p+qPjUkdK5djo7pCL0X+s7yJMnLch3LQsCsFJS1ZHv9v4
         tjJNwiu2U9CnooBFX70WUVfdHBGsFy669mXtTaTt6s81c+ZNmYBvHb1ssMwWWtEDiX5C
         rutXKt1ZEnHvaXmDVhundGQEsC/p8sEhm8bnFIuCkvCsOy9JbC57aNPhoAuHjt9Rp4qo
         Oc5AJ6XJfr2v//KpBrwk6iCD07eP6V+9Ih9FS0j6RL98DoAWS3bMaNw7Y35k/C88LOOt
         F49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2s2Id5GrJKnYx0iBVm7d0pinKIWJu++qzVZpF/y/8yI=;
        b=A8BXoVi84oShL7S5Ycz6r+0dPR+Obnj6p7KhzxUJsQlvD8yZn/X7LWzPglOiLLUl9y
         7XHSVATzrmwi37clOnO0vOeLjjxSHdYLob2MkEvKAMtV18n4qrpNtEh7nC2TUsbxBHlX
         SOFZndNp0BJF3GXqdkaT3XeL9EumbTC+sd8jg77tc1mvkM2YtpgZP9yysq39dr1NoG+K
         lCpoI8GOGm4ghXs+rGJ05Re3YEvP6coYZHJT+99RjOXTa30oni29/Ipyq8NlxS8y19OH
         7jeXOCrYf4G59VdABsnyhPOe3hHkhE1781Cx6mBsMiGxcc1NIbnQj8q9hJ8GW7uP2YZV
         inaQ==
X-Gm-Message-State: AA+aEWaKegIbm4qxcU7XRg1coU57skD57kU9ljtsRdIlBQeuod6n9eJf
        G+ktmJQ4urOJjzvl2N3XiKbR5CJ35aA=
X-Google-Smtp-Source: AFSGD/UmCwVvoN9aEgoCbq+FAaS8FjbYQZrUFaFAuyyIbJ1pd/HbpuQ3xMECnKKMWpHvgBa5aLTgCA==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr12494854wmc.113.1545324118457;
        Thu, 20 Dec 2018 08:41:58 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id r64sm10692684wmg.5.2018.12.20.08.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 08:41:57 -0800 (PST)
Date:   Thu, 20 Dec 2018 16:41:50 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>, szeder.dev@gmail.com,
        Jan Palus <jpalus@fastmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t5570: drop racy test
Message-ID: <20181220164150.GB25639@hank.intra.tgummerer.com>
References: <9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de>
 <20181125220138.GK4883@hank.intra.tgummerer.com>
 <20181126164252.GA27711@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181126164252.GA27711@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26, Jeff King wrote:
> On Sun, Nov 25, 2018 at 10:01:38PM +0000, Thomas Gummerer wrote:
> 
> > On 11/25, Torsten Bögershausen wrote:
> > > After running the  "Git 2.20-rc1" testsuite here on a raspi,
> > > the only TC that failed was t5570.
> > > When the "grep" was run on daemon.log, the file was empty (?).
> > > When inspecting it later, it was filled, and grep would have found
> > > the "extended.attribute" it was looking for.
> > 
> > I believe this has been reported before in
> > https://public-inbox.org/git/1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com/,
> > but it seems like the thread never ended with actually fixing it.
> > Reading the first reply Peff seemed to be fine with just removing the
> > test completely, which would be the easiest solution ;)  Adding him to
> > Cc: here.
> 
> Yes, I don't think there is a way to make this race-proof without
> somehow convincing "cat" to flush (and let us know when it has). Which
> really implies killing the daemon, and wait()ing on cat to process the
> EOF and exit.  And that makes the tests a lot more expensive if we have
> to start the daemon for each snippet.
> 
> So I'm still fine with just dropping this test.

Alright since this has come up twice on the mailing list now (and I've
seen this racyness as well), and nobody found the time to write a
patch yet, below is a patch to just remove the test.

> > > diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> > > index 7466aad111..e259fee0ed 100755
> > > --- a/t/t5570-git-daemon.sh
> > > +++ b/t/t5570-git-daemon.sh
> > > @@ -192,6 +192,7 @@ test_expect_success 'daemon log records all attributes' '
> > >  	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
> > >  		git -c protocol.version=1 \
> > >  			ls-remote "$GIT_DAEMON_URL/interp.git" &&
> > > +	sleep 1 &&
> > >  	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
> > >  	test_cmp expect actual
> > >  '
> > > ----------------
> > > A slightly better approach may be to use a "sleep on demand":
> > > 
> > > +	( grep -i -q extended.attribute daemon.log || sleep 1 ) &&
> 
> That doesn't really fix it, but just broadens the race window. I dunno.
> Maybe that is enough in practice. We could do something like:
> 
>   repeat_with_timeout () {
> 	local i=0
> 	while test $i -lt 10
> 	do
> 		"$@" && return 0
> 		sleep 1
> 	done
> 	# no success even after 10 seconds
> 	return 1
>   }
> 
>   repeat_with_timeout grep -i extended.attribute daemon.log
> 
> to make the pattern a bit more obvious (and make it easy to extend the
> window arbitrarily; surely 10s is enough?).

I gave this a try, with below patch to lib-git-daemon.sh that you
proposed in the previous thread about this racyness.  That shows
another problem though, namely when truncating 'daemon.log' before
running 'git ls-remote' in this test, we're not sure all 'git deamon'
has flushed everything from previous invocations.  That may be an even
rarer problem in practice, but still something to keep in mind.

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index edbea2d986..3c7fea169b 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -62,6 +62,7 @@ start_git_daemon() {
 		(
 			while read -r line <&7
 			do
+				sleep 1
 				printf "%s\n" "$line"
 				printf >&4 "%s\n" "$line"
 			done

Dscho also mentioned on #git-devel a while ago that he may have a look
at actually making this test race-proof, but I guess he's been busy
with the 2.20 release.  I'm also not sure it's worth spending a lot of
time trying to fix this test, but I'd definitely be happy if someone
proposes a different solution.

> -Peff

--- >8 ---
Subject: [PATCH] t5570: drop racy test

t5570 being racy has been reported twice separately on the mailing
list [*1*, *2*].

To make the test race proof, we'd either have to introduce another
fifo the test snippet is waiting on, or somehow convincing "cat" to
flush (and let us know when it has).  Which really implies killing the
daemon, and wait()ing on cat to process the EOF and exit.  And that
makes the tests a lot more expensive if we have to start the daemon
for each snippet.

As this is a test for a relatively minor fix (according to the author)
in 19136be3f8 ("daemon: fix off-by-one in logging extended
attributes", 2018-01-24), drop it to avoid this racyness.  It doesn't
seem worth making the test code much more complex, or slowing down all
tests just to keep this one.

*1*: 1522783990.964448.1325338528.0D49CC15@webmail.messagingengine.com/
*2*: 9d4e5224-9ff4-f3f8-519d-7b2a6f1ea7cd@web.de

Reported-by: Jan Palus <jpalus@fastmail.com>
Reported-by: Torsten Bögershausen <tboegi@web.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t5570-git-daemon.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7466aad111..58ee787685 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -183,19 +183,6 @@ test_expect_success 'hostname cannot break out of directory' '
 		git ls-remote "$GIT_DAEMON_URL/escape.git"
 '
 
-test_expect_success 'daemon log records all attributes' '
-	cat >expect <<-\EOF &&
-	Extended attribute "host": localhost
-	Extended attribute "protocol": version=1
-	EOF
-	>daemon.log &&
-	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
-		git -c protocol.version=1 \
-			ls-remote "$GIT_DAEMON_URL/interp.git" &&
-	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
-	test_cmp expect actual
-'
-
 test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	{
 		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
-- 
2.20.1.415.g653613c723


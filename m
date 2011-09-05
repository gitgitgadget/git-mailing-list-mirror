From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Mon, 05 Sep 2011 11:23:03 +0200
Message-ID: <4E6494F7.7010101@drmicha.warpmail.net>
References: <20110903105723.GA16304@tin.tmux.org> <1315067656-2846-1-git-send-email-drizzd@aon.at> <1315067656-2846-4-git-send-email-drizzd@aon.at> <7v62l7crpg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	tobiasu@tmux.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 11:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0VOc-0005Da-4Y
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 11:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab1IEJXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 05:23:10 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:47617 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab1IEJXH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2011 05:23:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ED4D52027E;
	Mon,  5 Sep 2011 05:23:05 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 05 Sep 2011 05:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=sYpOMg7UtAPDc643adi3xz
	TVvkw=; b=ZmYszBGzyxCTdHHXooMKz0efwynUZhdVAPOCWqVWlSyUXtFUT+Cu18
	oO/nuBNZCYSfpOZquSid75pRGDv6WS159UOogtopXDEn9vQU6qXOUrwjkCoJ3y7c
	dpVNqMGIm6bQG+FZnr2/WAImdVXWr9PYwDTcFqRQRCvVxfaCrOp3U=
X-Sasl-enc: ApQpTrN7w8HFpsobI9oBVH+EGWBJZ/VJ/tu2iso4Q64D 1315214585
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29B048207A1;
	Mon,  5 Sep 2011 05:23:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7v62l7crpg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180732>

Junio C Hamano venit, vidit, dixit 05.09.2011 10:35:
> Hmm, with this whole series merged to 'pu', I somehow am getting this
> error:
> 
> $ make -j8 \
>     DEFAULT_TEST_TARGET=prove \
>     GIT_PROVE_OPTS=-j8 \
>     T=t5541-http-push.sh test
> *** prove ***
> t5541-http-push.sh .. All 1 subtests passed 
> 
> Test Summary Report
> -------------------
> t5541-http-push.sh (Wstat: 0 Tests: 1 Failed: 0)
>   Parse errors: No plan found in TAP output
> Files=1, Tests=1,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.06 cusr  0.01 csys =  0.09 CPU)
> Result: FAIL
> make[1]: *** [prove] Error 1
> make[1]: Leaving directory `/srv/project/git/git.git/t'
> make: *** [test] Error 2
> 
> Without prove (drop "DEFAULT_TEST_TARGET=prove" from the command line),
> I do not see the breakage.
> 
> *** t5541-http-push.sh ***
> ok 1 - set up terminal for tests
> # passed all 1 test(s)
> 1..1 # SKIP Network testing disabled (define GIT_TEST_HTTPD to enable)
> make aggregate-results
> make[3]: Entering directory `/srv/project/git/git.git/t'
> for f in test-results/t*-*.counts; do \
>                 echo "$f"; \
>         done | '/bin/sh' ./aggregate-results.sh
> fixed   0
> success 1
> failed  0
> broken  0
> total   1
> 

Being cc'ed makes me feel guilty but I don't know what for... Anyway, in
case you need more test points, with pu at v1.7.7-rc0-315-g55af6ac  and
prove I get:

*** prove ***
t5541-http-push.sh .. skipped: Network testing disabled (define
GIT_TEST_HTTPD to enable)
Files=1, Tests=0,  0 wallclock secs ( 0.04 usr  0.01 sys +  0.00 cusr
0.02 csys =  0.07 CPU)
Result: NOTESTS

Patch 3/3 does not apply (am) to pu but leaves neither changes nor
conflicts in my wt. -3 gives a conflict which I don't know how to
resolve without digging further, see below.

Michael

The conflict in send-pack.c is simple, but what about:

diff --cc builtin/receive-pack.c
index 0b42e21,06c481a..0000000
--- i/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@@ -29,9 -29,9 +29,10 @@@ static int receive_fsck_objects
  static int receive_unpack_limit = -1;
  static int transfer_unpack_limit = -1;
  static int unpack_limit = 100;
 +static unsigned long limit_pack_size, limit_commit_count,
limit_object_count;
  static int report_status;
  static int use_sideband;
+ static int quiet;
  static int prefer_ofs_delta = 1;
  static int auto_update_server_info;
  static int auto_gc = 1;
@@@ -144,8 -113,10 +145,15 @@@ static int show_ref(const char *path, c
        if (sent_capabilities)
                packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
        else
++<<<<<<< HEAD
 +              packet_write(1, "%s %s%c%s\n",
 +                           sha1_to_hex(sha1), path, 0, capabilities());
++=======
+               packet_write(1, "%s %s%c%s%s\n",
+                            sha1_to_hex(sha1), path, 0,
+                            " report-status delete-refs side-band-64k
quiet",
+                            prefer_ofs_delta ? " ofs-delta" : "");
++>>>>>>> push: old receive-pack does not understand --quiet
        sent_capabilities = 1;
        return 0;
  }

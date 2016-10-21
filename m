Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23BDD20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755113AbcJUM0U (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:61546 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932750AbcJUM0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:18 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MTO3f-1cOtSF2ZGB-00SNWe; Fri, 21 Oct 2016 14:25:56
 +0200
Date:   Fri, 21 Oct 2016 14:25:41 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 19/27] sequencer: stop releasing the strbuf in
 write_message()
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <c89508366501c17e7363a7d5c631fce9b3750cd2.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l37DkSyTMf/wmz8qicfXxWz9+qv6mFhxpwS2BsQVUpsDgPKXHHV
 /k5ThdeVQ0eWKm/Sk7Ft4IsfGHQbCgzhEvv7MfI8V107jYOg8Olhn53S28VrK/nzzO1mHrj
 RMeucZv7gOqbDSB2iOfej44wfhaGbFYvDbeEFane3Rzrv6yEicXyQJH0ghdmsgGeeZ47F2S
 iNSv3Dwc16HCh3W8K0Nxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5a2cE+qP7RQ=:zgTMQSkn+gDSbbJfElLaop
 Rhs4C1IFznkch41ox9tJwqCpcSKsSN+tsG4Y29UZo1ANTwcnzVr44OVeSQ+4U/6MUHCwAf20T
 1aPUVo9yyXH0bV6yQkGZf5ernaSAu5b830mpzelv40cbBgYezwBNbyc8GWzCOqkMYZ16tyLCR
 W8fEbhrNULFx9y4yU4g8uEWH0BxEpra6OtFOk68IP/4Zgm4Q4oxyY82TuNsxBhlpXteQBsZBh
 eGmurOW50is20y0zFvLpi7QjPZxwVTu89IaRBO2FmYVSbPTgicjD3L3Nj3uwT1J1KwdBhf4Sh
 b5QwghgZlpbYz9K4gEeb+wip++HqkNMdbnQneQ/54fOPANrVzCcU5iOQvsP32PEdmq9ztysuv
 urTiReQgbv/yNpVLdEoQWdX7I4roRYf0rZCayeq6QfTKp2O/zBz2MVsTZH9DUJKoCOIVjan+H
 1NIPmJUeIDIh9uNndU4oR2uglRdZO2sRHTxuvi8JmgY5bfYj4wtA2t0zrBkMejn35VfbITj38
 SIDPD0hgEBfRbrivEFkAbLCnuJ7Ks1rywgGNljiQZ0564jBkmpnWxPMolTUPuJjT/XYrFOT/l
 DqJKhceT4FpGKT6+NPNk8lK6DW+kM3cBy2vbcwSkJ7iKedox2Q5lxSrWvLHXDqHUdpuGFo4+b
 K3LTxc6RxqZI84EfZDgL3nhCKk4FspBQgkqPfjY7ng6VCaZiIsDkEmIxvp+WICvBs7yU1mo1D
 aOAawglwDItr8YrUrIJ/kXaW5iO1ws1gE07pSvYEKqG+GdJa+ql9DW+/xHy3ORLgD7fUJFIRL
 6sqVzEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nothing in the name "write_message()" suggests that the function
releases the strbuf passed to it. So let's release the strbuf in the
caller instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index d74fdce..745c86f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -243,7 +243,6 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 		return error_errno(_("Could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
 		return error_errno(_("Could not write to %s"), filename);
-	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
 		return error(_("Error wrapping up %s."), filename);
 
@@ -759,6 +758,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		free_commit_list(common);
 		free_commit_list(remotes);
 	}
+	strbuf_release(&msgbuf);
 
 	/*
 	 * If the merge was clean or if it failed due to conflict, we write
-- 
2.10.1.583.g721a9e0



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A79720C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbdLHR3l (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:29:41 -0500
Received: from mout.web.de ([212.227.17.12]:57670 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdLHR3k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:29:40 -0500
Received: from [192.168.178.36] ([91.20.50.52]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5g0a-1fG9w51s08-00xcUl; Fri, 08
 Dec 2017 18:29:33 +0100
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
To:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <20171207212735.GD12850@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <e1daa2b6-004b-ad66-b84d-84fa70a44baf@web.de>
Date:   Fri, 8 Dec 2017 18:29:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171207212735.GD12850@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:bdmIRvaG75EzXJZjAJzU7VmaCHuHIp/h9yWgAHwbiCkn6QOj0kR
 qVwlk+8tKGy9WwvaMWyXk/OLoGerOCaz/RbVpFNGSl9ITVbgnljJ/2hYU8RUmo10jaZQNm6
 C1V9PltExYdBFUhYpDilKK3qEDPlJ0I2NohZykYsk5roH1i8yiWghCwCgOAxphTFpzfzDpE
 cEaVqIxy8/yx23wT8qqtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PBUWbUVwr2c=:8qlGUcpeOfybfKUzkODVCW
 XWkQ/GSk3w+MfSgYZ+D9ML4UPLzNhN5SWidFojETXhtRhA7i9XL1N6x6ZLY2mRZld5rhcRkB3
 0sg3Oe7BWQGPtPKFRDlOmSFjDYv8Lhfg3TUPQMLwAi62/AMsE1gRKVbD+95jtYBXDuPo3u48B
 hK1WHjlIdMxi0tOUXCujdC4oDTpgY52P+5O63g0a+9B8oAvVMomACWRMXav9MLvbqOKw92kFH
 +wuBO4GUYNkYpL+l1PuFr5Jj1IiUUNWsb0MBCO3VZm9Wj59wSczi6JuUYmqOG2IDmMS+2/J31
 KR0bU5XCFqHDdR3rs/xx4qH1CuzgTDASpyo9c4/1FiEaZKvCp2NXHRqCT++93WC54G0n+Mj+z
 EDzHg3nxwFaSuz8z61rPlpzJJyyI5M6f3QoVmuckNFnmky7ME3wsV3HlOig6xmJ6LvVO3e+EW
 ZcacGmLBgQk3BC1Fs5xECsno6tSTwaulYMLtXijX76C8jH8YTQAiO9Vd7OkfZU6oOwbzzEyeE
 KE1k0vKO9MDUUcMoNM6MULsiVLLY1gaRDgCJFyhiIlU+iAI/ZHrbmahQc5sUL63rF72gf9ePY
 1kJ0lz2FSQPyG78GXTEMHjjWOQAcZxGuo6B/8srSqb7k8IXk0y5zTsbBQDkp+RBcJlirE+xEA
 LjVZOvbqMEDCLx4uitqynolL4MKQvd1r0Xde5l0wL6ddpftPKkw0u46FQHxH7dgXN/CtCW3FO
 9+tK04+AkD4cSCfu4w5LCansqe/vvNRx/XKVIRsT1xg1/e2F0RjGRsV+p4ulCW7BiAbepLdvv
 5vu5lCXxHznhTMmZKo7f384F5lzAAiSE6+4g2UmPTHKOXAFGjk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.12.2017 um 22:27 schrieb Jeff King:
> Grepping for "list_append.*detach" shows a few other possible cases in
> transport-helper.c, which I think are leaks.

-- >8 --
Subject: [PATCH] transport-helper: plug strbuf and string_list leaks

Transfer ownership of detached strbufs to string_lists of the
duplicating variety by calling string_list_append_nodup() instead of
string_list_append() to avoid duplicating and then leaking the buffer.

While at it make sure to release the string_list when done;
push_refs_with_export() already does that.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 transport-helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index bf05a2dcf1..f682e7c534 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -882,7 +882,8 @@ static int push_refs_with_push(struct transport *transport,
 			struct strbuf cas = STRBUF_INIT;
 			strbuf_addf(&cas, "%s:%s",
 				    ref->name, oid_to_hex(&ref->old_oid_expect));
-			string_list_append(&cas_options, strbuf_detach(&cas, NULL));
+			string_list_append_nodup(&cas_options,
+						 strbuf_detach(&cas, NULL));
 		}
 	}
 	if (buf.len == 0) {
@@ -897,6 +898,7 @@ static int push_refs_with_push(struct transport *transport,
 	strbuf_addch(&buf, '\n');
 	sendline(data, &buf);
 	strbuf_release(&buf);
+	string_list_release(&cas_options, 0);
 
 	return push_update_refs_status(data, remote_refs, flags);
 }
@@ -930,7 +932,8 @@ static int push_refs_with_export(struct transport *transport,
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_oid(private, &oid)) {
 			strbuf_addf(&buf, "^%s", private);
-			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
+			string_list_append_nodup(&revlist_args,
+						 strbuf_detach(&buf, NULL));
 			oidcpy(&ref->old_oid, &oid);
 		}
 		free(private);
-- 
2.15.1

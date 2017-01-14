Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E948E20798
	for <e@80x24.org>; Sat, 14 Jan 2017 16:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdANQbq (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 11:31:46 -0500
Received: from mout.web.de ([212.227.17.11]:51778 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbdANQbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 11:31:45 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdVza-1csSNy1mSY-00ikYD; Sat, 14
 Jan 2017 17:31:40 +0100
Subject: Re: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of
 snprintf,
To:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
 <20170113175801.39468-2-gitter.spiros@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3165803b-6073-de97-bf33-71ad21108d6f@web.de>
Date:   Sat, 14 Jan 2017 17:31:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170113175801.39468-2-gitter.spiros@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9DVM/KWKDLiE8xjnh75PHi8HxM8hODalZ7zxo1TpvlePC6PMUhD
 67jWu89+7dqY27/WREpP1LISlFfZfgLB4sR2ujUqrZaUiBVveW4xv7FcVIOGF0MCNOtD8oZ
 BffXxz+yNLVuDb9U1wTVOKjPuTwrf+Rg+l2HgojFBWLSfxCUId1tyHG+S2B5WbqatMbjF0s
 hwVvkoGJ0sv8mL3B99rKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TZ1umpv9PCE=:rH9ntASI8MzY8eXiIhsTZs
 RC3vRi4Zb43rnXSQhbHzTxCfTbog9Cm9Pfcuoj0LFjvHKTs0ezjgtOE+tRcbNRrNupJijOxqu
 Nf2ycS9SmBEfyL1ROFxFf/X40HiPDlsPyxhSaku554/pI/nj0akbJxi+eRk9dinN9tnNWgrHr
 39LuxweyEiTLAbpM2hGftiLeilCcGVNgbeP1kR8gXYnwYnG0T5TS42rmVf+M+moqazdUDe9IV
 ZDZ52mK1tkMQZCw/zTR2CJDYH0C9Js/LxTvYTwqgq1WHY4k5elIoOw87yyiqOQ/i+v/6qYVK7
 XGOiWEo1a5VbLFJrwk/pQo16sq87DwPVM2Uynp6PMUnHIqxNEeYqJhLTit8tY8BsRxzxYauS4
 tiS6CyZA8imzI9sapcYi01mGMowRTVXcNj/DJ7r0qOE/t6cniaI2KBtaQrwRAC7Z5bxF/v/ul
 whrdXIRu3RrdfC+rpaBcKtiwpKcKMhgL1oH8mlgl/ovC0gGKUKdVSm54CsLxKAdCpaQR0Qe2o
 PPazItt+ordVVKGQuS49Zm1jmMtZPPDyn/aLjsBLOp7PFxZOQIXdoMFK8+zLjKUJBit2P+KUv
 eBiyPVRXwxQbWGZKPirW0WvorDrZ0al8H9vAcc4GVNYn7XASk+5nPmPDjjWhiX4e4Q/m9BvaD
 qEQnMKuhpU8OiPJaDL+Rly1TObblUeIzwF+O7MOrFYsqiOjYE4m610cT24P1OFLs6EOUGzs6C
 UQ8xLkl5iOSBcSrAWFJJ6bqimrk9G8u4RvEmMy+dZ+gtOw2+4fnwM7ROKbFertj+zYNNzJd9u
 sT5g/m/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.2017 um 18:58 schrieb Elia Pinto:
> In this patch, instead of using xnprintf instead of snprintf, which asserts
> that we don't truncate, we are switching to dynamic allocation with  xstrfmt(),
> , so we can avoid dealing with magic numbers in the code and reduce the cognitive burden from
> the programmers, because they no longer have to count bytes needed for static allocation.
> As a side effect of this patch we have also reduced the snprintf() calls, that may silently truncate 
> results if the programmer is not careful.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Jeff King <peff@peff.net> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the third  version of the patch.
> 
> Changes from the first version: I have split the original commit in two, as discussed here
> http://public-inbox.org/git/20161213132717.42965-1-gitter.spiros@gmail.com/.
> 
> Changes from the second version:
> - Changed the commit message to clarify the purpose of the patch (
> as suggested by Junio)
> https://public-inbox.org/git/xmqqtw95mfo3.fsf@gitster.mtv.corp.google.com/T/#m2e6405a8a78a8ca1ed770614c91398290574c4a1
> 
> 
> 
>  builtin/commit.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 09bcc0f13..37228330c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1526,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  static int run_rewrite_hook(const unsigned char *oldsha1,
>  			    const unsigned char *newsha1)
>  {
> -	/* oldsha1 SP newsha1 LF NUL */
> -	static char buf[2*40 + 3];
> +	char *buf;
>  	struct child_process proc = CHILD_PROCESS_INIT;
>  	const char *argv[3];
>  	int code;
> -	size_t n;
>  
>  	argv[0] = find_hook("post-rewrite");
>  	if (!argv[0])
> @@ -1547,11 +1545,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>  	code = start_command(&proc);
>  	if (code)
>  		return code;
> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
> -		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
> +	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>  	sigchain_push(SIGPIPE, SIG_IGN);
> -	write_in_full(proc.in, buf, n);
> +	write_in_full(proc.in, buf, strlen(buf));
>  	close(proc.in);
> +	free(buf);
>  	sigchain_pop(SIGPIPE);
>  	return finish_command(&proc);
>  }
> 

Perhaps I missed it from the discussion, but why not use strbuf?  It
would avoid counting the generated string's length.  That's probably
not going to make a measurable difference performance-wise, but it's
easy to avoid and doesn't even take up more lines:
---
 builtin/commit.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 711f96cc43..73bb72016f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1525,12 +1525,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 static int run_rewrite_hook(const unsigned char *oldsha1,
 			    const unsigned char *newsha1)
 {
-	/* oldsha1 SP newsha1 LF NUL */
-	static char buf[2*40 + 3];
+	struct strbuf sb = STRBUF_INIT;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	const char *argv[3];
 	int code;
-	size_t n;
 
 	argv[0] = find_hook("post-rewrite");
 	if (!argv[0])
@@ -1546,11 +1544,11 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 	code = start_command(&proc);
 	if (code)
 		return code;
-	n = snprintf(buf, sizeof(buf), "%s %s\n",
-		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	strbuf_addf(&sb, "%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
 	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, buf, n);
+	write_in_full(proc.in, sb.buf, sb.len);
 	close(proc.in);
+	strbuf_release(&sb);
 	sigchain_pop(SIGPIPE);
 	return finish_command(&proc);
 }
-- 
2.11.0


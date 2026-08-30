Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C492C0294
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122921; cv=none; b=s5Q+Vv+CEsZ/HL+a7CLbkQZ0LIixxruDab4A8SZknQ3n7FLqaVq99+9g49l2ZamyirKbgfFXLK9dkv1V3ADSZstfM4D9BnKQQdbHYJaki0NySFMZkbWOgPpsxRUcRPpG8+WyGqZP40IiBRj3ZfrDCdpGSQucKwpfH+sk8+jcU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122921; c=relaxed/simple;
	bh=C/6bvV3xbEAyRhwZCGxK/iIUe9kKzQyRyRyb+cSKwIM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGHL4fdOatzROadogsSCeY174VKsjkLf8IqcsWxRSoe1QMJDnv+kdBL5sSgyyCw/h5SWjLBQ7FIjsuUeyRtTmMsxLiZVPZmM18NcsZb9ljOaRcb7EeITZOimNpzhgjfKk+FgciS0FH+V0+Srpd/R6wiLIocCkYyVUluQ8i8CG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e6RaSklp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Map2Xmi5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e6RaSklp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Map2Xmi5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30C8A14000A9;
	Sun, 30 Aug 2026 16:48:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 16:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122918; x=
	1788209318; bh=MYek03ZCs14bk2awhmk73XshEkKZDz1uvK2uSltNs4A=; b=e
	6RaSklpqZ2QAbiQpCzpAnmDvwio/ctPaFWYPrNxK/9otPAdMN92r9h/98ewPaRyo
	CDL6nGk1Rkx/o5AiEwvEHWrfgN7FYZzaqYw0DscNpd3Pfp434sUWW0POQiMdDchp
	qnYKJmrgcAeWPeHSsSy9K5Wn6QXNcjKp5sil60U5wxctiKY9g7WUja1aYw9U6twh
	gYmOr/8uYIbzCPqp/hPSK3aHYilX9WaI5ybtiUdBO6hfl2uezxRvu91ytwXXnEhR
	E1kwhv8NN1PvGNQO7ykRMQuiQmMPDSSzCp4iGVvFusKtOmPNMHvaNe8B2RawBOa/
	jzg7+TBg7q9NvNMFvFaWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122918; x=1788209318; bh=MYek03ZCs14bk2awhmk73XshEkKZ
	Dz1uvK2uSltNs4A=; b=Map2Xmi5cZULn5hQ19Z9YALpJm46HfMDuwria5Rt/8bX
	gyFcdTyqB/Gemcpbv7xf3LWZiv+mCf7AER9tB+OZNsGlLC6FFTW+XUZQU/oTVUQs
	6LRitAwkMTNxyY8spFkaCg1t07jqRX3tn4x+VFStTMSz5Oo8qST4Due4OTapAR6A
	WhUvGNUV0XdNqAhtwl1kQSIBUxFegt+ngbzenHSMs8EfLDuCSEgSX/+kpFyMjTFM
	HTTzT8lTvwaffYUuD90UMHLh9rGTED2IhzmkqUHwAS29Lgs4mi2eTq6SsYB7GTVx
	WNT4/l7Ne9BObfyP1mh2kqhvtsX+O6hGCtb2z+2qGA==
X-ME-Sender: <xms:JpeUai_JF8Y3xJsooArC6ujPQ8TlL64yuoiwUmQJvdKAsPachE37eg>
    <xme:JpeUaouCyMghaDC9m1v6nBjva7OyhnU8mVpaupX1MbQJ4kgzjRw_9T3G6ZJJfbzHM
    qpz0f-OzX7RQnweTezaij3cPNSeIAyh6KsXiyjSHGbSSu4945Y3Dg>
X-ME-Received: <xmr:JpeUalptFbnTVCSfevyLNbATUNl4F5-PZgaHMDixfjmZ25aQkGJeTF1I6xZmyUuLJ7Iwgu0QlehuJob_rz2zj4LdqkVCD-rkUw>
X-ME-Proxy-Cause: dmFkZTGpxBreKong0VtR4qC+o1j65EClxmMKtlNb51ZMOKkI04uXcAfuEsFsLLc+HbJj8e
    0uh5su56pJDxkDNagV0UC6S6uMVhaFZ5jIBZtwvmdengJmUhCxcdsNjG/XEMam3+verCk7
    H+yUAW193Pbb3PboqDdPE/X+dfwuUuh2WZmN90YifjKjFoJ/OdNwHqTxOnRMHKgE6nqZwD
    pOQh6dMLhuJEriX8QtN7iSSj4zlM3sswf6gW+Yby+7EWb/cJnyEE9EV6EcsgdIp0VBsK2F
    PlRVcO5jVI2l+wZNp7rE7xBEphaLUgejJ5SSXParYGKyF4xabIUgL1OXOhxq+EnrXoy+hi
    rHkYlLxa6SGkLqVF43sgxG9C+r2Dl4IoipfWLX52HtF9h/bRZF0GNrRb7guOsSyalY08mP
    3lII08XTY4X+e5bc47Zvp9w/lgrfmw3F+PaKnFVBjgRQeXCAB54j3ryy555shZPt2Zqelw
    /5ARRghf+M6utplEl8dfgVTcs2s+8Ph0m3prm0Okb0b0z8+Mkf2KYl9WLJf7aywxlB44PF
    /30rAwSRISNrHpVjaevaxfvwwQU5a2B31xRv+mTw5l/mpKrVzr5W3wosj0SdW+CnHin37X
    VAvuS6DmnpFpmZhj/5TupT0F6hhwDZYQ18mpwN7xeIzoAksWI0pfGg6WvrWg
X-ME-Proxy: <xmx:JpeUalm0MBGd71whNWQS_YAezHqQvNtHGm3vHQ8DuzG93cLXYfspiQ>
    <xmx:JpeUapw9l20OPb-g79tu6qHozoQmp55Ii7JPmlMWN-nWYdNHIXCycA>
    <xmx:JpeUatlOJzwdGlrfy8EfKqleq2ql5IMzfsLyI4IOrLVEBKsrAeV7HQ>
    <xmx:JpeUaic7NKfpF7Ax5nyrvV29orwPfYNKHEkYRrJtGfXI5LWJNzZz1Q>
    <xmx:JpeUauUajKpAdeqKuLMnXgs9oqbVqcrp2ra_bpkkXLY4u14TKD2EaQiY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/8] checkout: pass cb_option explicitly to branch name parsers
Date: Sun, 30 Aug 2026 13:48:28 -0700
Message-ID: <20260830204835.1040408-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file-scope static variable 'cb_option' is used to record whether
a new branch is being created via '-b' (in 'git checkout') or '-c'
(in 'git switch'), primarily for error reporting and advice messages
in parse_remote_branch().

Global mutable state makes the code harder to reason about and refactor.

Pass 'cb_option' explicitly as a parameter to parse_remote_branch()
and parse_branchname_arg(), removing the file-scope static variable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..774e4fd5b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1346,7 +1346,7 @@ enum checkout_command {
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
-				 enum checkout_command which_command)
+				 char cb_option)
 {
 	int num_matches = 0;
 	char *remote = unique_tracking_name(arg, rev, &num_matches);
@@ -1361,16 +1361,15 @@ static char *parse_remote_branch(const char *arg,
 	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
 		    const char *cmdname;
 
-		    switch (which_command) {
-		    case CHECKOUT_CHECKOUT:
+		    switch (cb_option) {
+		    case 'b':
 			    cmdname = "checkout";
 			    break;
-		    case CHECKOUT_SWITCH:
+		    case 'c':
 			    cmdname = "switch";
 			    break;
 		    default:
-			    BUG("command <%d> should not reach parse_remote_branch",
-				which_command);
+			    BUG("unexpected cb_option '%c'", cb_option);
 			    break;
 		    }
 
@@ -1394,7 +1393,7 @@ static char *parse_remote_branch(const char *arg,
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
-				enum checkout_command which_command,
+				char cb_option,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
 				struct object_id *rev)
@@ -1505,7 +1504,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		if (recover_with_dwim) {
 			remote = parse_remote_branch(arg, rev,
 						     could_be_checkout_paths,
-						     which_command);
+						     cb_option);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1832,9 +1831,6 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-/* create-branch option (either b or c) */
-static char cb_option = 'b';
-
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
 			 enum checkout_command which_command)
@@ -1842,6 +1838,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	int parseopt_flags = 0;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
+	char cb_option = (which_command == CHECKOUT_SWITCH) ? 'c' : 'b';
 
 	static const char * const checkout_usage[] = {
 		N_("git checkout [<options>] <branch>"),
@@ -1997,7 +1994,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
+		int n = parse_branchname_arg(argc, argv, dwim_ok, cb_option,
 					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
@@ -2174,8 +2171,6 @@ int cmd_switch(int argc,
 	options = add_common_options(&opts, options);
 	options = add_common_switch_branch_options(&opts, options);
 
-	cb_option = 'c';
-
 	return checkout_main(argc, argv, prefix, &opts, options,
 			     CHECKOUT_SWITCH);
 }
-- 
2.55.0-884-g76cf8659c2


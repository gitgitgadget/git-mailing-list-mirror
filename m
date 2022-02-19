Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FACC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 06:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiBSGZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 01:25:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiBSGZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 01:25:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C29DD55
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:25:03 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p9so19866832ejd.6
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 22:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3uMNPncFtVhowRNL8Nk2BrBwpY9tlImsIT/ablxoy0I=;
        b=aeii2l41yDDulcCQXqEQfVtlq3L5hR98NsY8RBwGZnQcxDrQaXaIakua/1ZqakldHV
         B59yGWZwwV4cFkR2jsoOCHEawDOG58qyd4RZ8ZTbmL/M+STuDvnEdkhyLnPgkwLHTbCj
         Gb8iV+HV4eEqDwnewHc93PZ3jAdcUpJPUV0oeeMa2QK4wAv2RonmcE+52/YxFPJd9k3+
         KZ+G4iwl1VVWIwjmKTubQsLsHEAvkXAGA+47ffMSRMSCqskZpiruAECxoDREUb/TN2om
         AXWsAj/HuoxX/wPLQBCqWKOGSZb0b4oIJd8Y/o3tV7pdOSdx2LRfniFDjbQzCO5IcTSE
         l2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3uMNPncFtVhowRNL8Nk2BrBwpY9tlImsIT/ablxoy0I=;
        b=PuTZdC5XTcUqf79Ue9qLP4lClYZK8Nvv8UD0J6d8yLIi0MrOuftM8n8EEmDBo2Tw4o
         LMLi4NhtyVzQsiGjoSIV+2AsnkoxPhueVcFNBYVLnk6kqNUSJ8si+VoHwrQmVbFesGU3
         I/6tx7pllVrzG1lYYkyR8P79ILQ4sR920/73iYryHvZdB5fBEhSVQgPxx0YksJ5hu0mb
         01fAHyR2SwaOVmTfLdnfWH+2LXlr0H/G1t/oaNlWgyiM86tRfbgZ2BTBFGt3pWrZXDPu
         a1x9YhKW40nc9y0O7d38kRQPBVHmWLPjNq36poQesvJO2vQyT9Ymi1Mjwia1YUO1KhRg
         RkqA==
X-Gm-Message-State: AOAM533FFHMZNorVRzGl6Y6xm4nUO9EUBe46VyBXS1rqtDFAyqoG+KGz
        1+S8iF6Z9Xvd48Yc3s+2IwI=
X-Google-Smtp-Source: ABdhPJzOn3QIAz1ZbCLTkx8m1lSP4O1rPttoSyQtSnSgqh6Y9aN/7pV0paSoD/u1aAU/J6kOeDd+Lw==
X-Received: by 2002:a17:906:2695:b0:6ce:b94d:9f07 with SMTP id t21-20020a170906269500b006ceb94d9f07mr9233905ejc.297.1645251901799;
        Fri, 18 Feb 2022 22:25:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z7sm3002658ejl.98.2022.02.18.22.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 22:25:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLJAy-004pMA-FY;
        Sat, 19 Feb 2022 07:25:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Teng Long <dyronetengb@gmail.com>
Subject: Re: [PATCH v11 06/13] ls-tree: simplify nesting if/else logic in
 "show_tree()"
Date:   Sat, 19 Feb 2022 07:06:51 +0100
References: <cover.1644319434.git.dyroneteng@gmail.com>
 <3816a65fe62b1039c396eb38d27bf2c22e8d84de.1644319434.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3816a65fe62b1039c396eb38d27bf2c22e8d84de.1644319434.git.dyroneteng@gmail.com>
Message-ID: <220219.86ee3ze5kz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 08 2022, Teng Long wrote:

> This commit use "object_type()" to get the type, then remove
> some of the nested if to let the codes here become more cleaner.
>
> Signed-off-by: Teng Long <dyronetengb@gmail.com>
> ---
>  builtin/ls-tree.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index ef8c414f61..9c57a36c8c 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -66,19 +66,13 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  {
>  	int recurse = 0;
>  	size_t baselen;
> -	enum object_type type = OBJ_BLOB;
> +	enum object_type type = object_type(mode);
>  
> -	if (S_ISGITLINK(mode)) {
> -		type = OBJ_COMMIT;
> -	} else if (S_ISDIR(mode)) {
> -		if (show_recursive(base->buf, base->len, pathname)) {
> -			recurse = READ_TREE_RECURSIVE;
> -			if (!(ls_options & LS_SHOW_TREES))
> -				return recurse;
> -		}
> -		type = OBJ_TREE;
> -	}
> -	else if (ls_options & LS_TREE_ONLY)
> +	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
> +		recurse = READ_TREE_RECURSIVE;
> +	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
> +		return recurse;
> +	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
>  		return 0;
>  
>  	if (!(ls_options & LS_NAME_ONLY)) {

I think the use of object_type() here is good, but in any case I think
doing a minimal change first for the "type" and then this proposed
refactoring would be easier to look at, and to independently decide on
the two.

I find this much easier to read, both as a diff and as end-state:

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef8c414f61a..0af09e94a03 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,20 +66,18 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int recurse = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
+	enum object_type type = object_type(mode);
 
-	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
-	} else if (S_ISDIR(mode)) {
+	if (type == OBJ_BLOB) {
+		if (ls_options & LS_TREE_ONLY)
+			return 0;
+	} else if (type == OBJ_TREE) { 
 		if (show_recursive(base->buf, base->len, pathname)) {
 			recurse = READ_TREE_RECURSIVE;
 			if (!(ls_options & LS_SHOW_TREES))
 				return recurse;
 		}
-		type = OBJ_TREE;
 	}
-	else if (ls_options & LS_TREE_ONLY)
-		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {

Unrolling this from a logical if/else if to an if/if/if I think also
doesn't make sense. At the cost of a slightly larger diff (could be done
on top) we get rid of the show_recursive() branch too:

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef8c414f61a..d4be71bad24 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,20 +66,17 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int recurse = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
+	enum object_type type = object_type(mode);
 
-	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
-	} else if (S_ISDIR(mode)) {
-		if (show_recursive(base->buf, base->len, pathname)) {
-			recurse = READ_TREE_RECURSIVE;
-			if (!(ls_options & LS_SHOW_TREES))
-				return recurse;
-		}
-		type = OBJ_TREE;
+	if (type == OBJ_BLOB) {
+		if (ls_options & LS_TREE_ONLY)
+			return 0;
+	} else if (type == OBJ_TREE &&
+		   show_recursive(base->buf, base->len, pathname)) {
+		recurse = READ_TREE_RECURSIVE;
+		if (!(ls_options & LS_SHOW_TREES))
+			return recurse;
 	}
-	else if (ls_options & LS_TREE_ONLY)
-		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
 		if (ls_options & LS_SHOW_SIZE) {

Which, I think is also nicer to read, we're not checking "is it a
tree?", setting "recursive", and then using that "recursive" as a
boolean for no reason. Let's just continue on that "else if" chain we're
already in instead...

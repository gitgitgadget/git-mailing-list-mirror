Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 837BC201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756425AbdEKWqo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:46:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35464 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756388AbdEKWqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:46:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so5151029pgd.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZEM6qMByycyTxq87qIrumZy2lCaqi8LSmGYwukTPSQ=;
        b=TNgTRfRF86DAS6B29QXoTbYrs4dxFzDeD9q5dIfRJr/b1CglqPNUnUDawhpd9TKcdQ
         t6/WisjXZLYxlEcRBPSpd1ULDz/zBOQVzd1bgl7G5ZOv7koDbM8f6h5jErYw5bQlY1Po
         S7H0H2sTmPNZDNWXQc9murVa0EhBbkBTlScX6hKpMR+8R1M5iNjaxh9R28F3tAAGSO4V
         ULSlt/sUHlHUkQby70k0znAfu8TDGTYhR4/67KwgT7Ln53VZNh2/0eg/MyIGC+9IfRaT
         nq49HNB2mw07ToN9s7P8nkEVD5OibtUTpkW3KvppGlEjK3KiMH3jyfo1MZBP1UId0DfL
         YgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZEM6qMByycyTxq87qIrumZy2lCaqi8LSmGYwukTPSQ=;
        b=N8+kMAfIFB+QGJWtfejS6c4Kfm7dFzpa5dEwtP2pLz4pN8ugCbp18bc7o7Vj0oqb4c
         ZRoYmS1dJjVdbIDPoOv+ZshAEFNGucj7qvH15ktF1j7FGDbFrN/jNmGBUU5grAB5creS
         Kb4vbW/jNgym3GnaASDoKBHxMbaHxUV642Kw0gTkb7fnK9osrItkOztmFcI1Rc+lnvPR
         LUdlTq8/WmAP8na0jL0rHJRUled7mli11lg0ulxdPINKTvFi+MvegkOPEQZxqzYnVH9P
         EnyR42HYlojjbLlkjsfKbs5kI49gdho95xsFlEZSIntrZ+VOLff0x+KOMJThhohsJStx
         s3sA==
X-Gm-Message-State: AODbwcBuh3+/Oa6D5b4Gg2DR+WZtm6dYNBplAlcXflOLnzP4ClCo0T10
        FfKLCNXZWLSwJg==
X-Received: by 10.99.113.6 with SMTP id m6mr901464pgc.188.1494542802314;
        Thu, 11 May 2017 15:46:42 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id r90sm1929019pfl.82.2017.05.11.15.46.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:46:41 -0700 (PDT)
Date:   Thu, 11 May 2017 15:46:39 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511224639.GC21723@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511223054.25239-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170511223054.25239-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -15,6 +15,7 @@
>  #include "version.h"
>  #include "prio-queue.h"
>  #include "sha1-array.h"
> +#include "oidset.h"
>  
>  static int transfer_unpack_limit = -1;
>  static int fetch_unpack_limit = -1;
> @@ -592,13 +593,32 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
>  	}
>  }
>  
> +static void add_refs_to_oidset(struct oidset *oids, struct ref *refs)
> +{
> +	for (; refs; refs = refs->next)
> +		oidset_insert(oids, &refs->old_oid);
> +}
> +
> +static int tip_oids_contain(struct oidset *tip_oids,
> +			    struct ref *unmatched, struct ref *newlist,
> +			    const struct object_id *id)
> +{
> +	if (!tip_oids->map.cmpfn) {

This feels like a layering violation.  Could it be e.g. a static inline
function oidset_is_initialized in oidset.h?

> +		add_refs_to_oidset(tip_oids, unmatched);
> +		add_refs_to_oidset(tip_oids, newlist);
> +	}
> +	return oidset_contains(tip_oids, id);
> +}

The rest looks good.

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patient work.

diff --git i/fetch-pack.c w/fetch-pack.c
index 9dd430a65a..0394580434 100644
--- i/fetch-pack.c
+++ w/fetch-pack.c
@@ -603,7 +603,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
 			    struct ref *unmatched, struct ref *newlist,
 			    const struct object_id *id)
 {
-	if (!tip_oids->map.cmpfn) {
+	if (!oidset_initialized(tip_oids)) {
 		add_refs_to_oidset(tip_oids, unmatched);
 		add_refs_to_oidset(tip_oids, newlist);
 	}
diff --git i/oidset.c w/oidset.c
index ac169f05d3..f2a6753b8a 100644
--- i/oidset.c
+++ w/oidset.c
@@ -18,7 +18,7 @@ int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
 	struct hashmap_entry key;
 
-	if (!set->map.cmpfn)
+	if (!oidset_initialized(set))
 		return 0;
 
 	hashmap_entry_init(&key, sha1hash(oid->hash));
@@ -29,7 +29,7 @@ int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
 	struct oidset_entry *entry;
 
-	if (!set->map.cmpfn)
+	if (!oidset_initialized(set))
 		hashmap_init(&set->map, oidset_hashcmp, 0);
 
 	if (oidset_contains(set, oid))
diff --git i/oidset.h w/oidset.h
index b7eaab5b88..2e7d889770 100644
--- i/oidset.h
+++ w/oidset.h
@@ -22,6 +22,16 @@ struct oidset {
 
 #define OIDSET_INIT { { NULL } }
 
+/**
+ * Returns true iff "set" has been initialized (for example by inserting
+ * an entry). An oidset is considered uninitialized if it hasn't had any
+ * oids inserted since it was last cleared.
+ */
+static inline int oidset_initialized(const struct oidset *set)
+{
+	return set->map.cmpfn ? 1 : 0;
+}
+
 /**
  * Returns true iff `set` contains `oid`.
  */

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B823751
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="t/aLGkWU"
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F869AD
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:49:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4180f5c51f8so20427071cf.1
        for <git@vger.kernel.org>; Fri, 13 Oct 2023 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697226596; x=1697831396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWntybEDA82HpS3Iu/Dazvc0MTocHv2y6i0TdOe1UyY=;
        b=t/aLGkWUiBEfyr3RlCgkqlqSL7Q28WaLgvbGwDl+HRPWYQZUH1Cr1XQhY7x5z0ZxcV
         q+2znUbgzXuMJ2SZi04G27oP1R/BjruTexGGeSnw4mFLOyP3nb5Im94mV1tf2EK2KmLY
         YD9JOAmrHn74gU9vEoweOOM19ffGCf0jgA1nBthiw8jTZ5Wu2us1AS/iWq/y0gEAVyKF
         qieVPwdSpUe+/qR+SdM0q2BN+VvUfVygNZl6ezkAb0Q8Ikp8D+lnrgbhkumDOAkYQQrs
         eN90BaU3vkH8HfF+HQSoexaV3BOJO8f409S56xC9J2liMAU4APRNuDR2Mb9pdLR1PBOl
         B9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697226596; x=1697831396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWntybEDA82HpS3Iu/Dazvc0MTocHv2y6i0TdOe1UyY=;
        b=AocZYlgNEszNh+RHLs9V/T+yEQ5LbKnx3E2exQRohJANgL2qWL+nk7ZFgpPC692heG
         oD4JHNx4lBDUVwGkcPFnxDcMzoQ5hEgQztS7++NfX3i60S2Y+bNnoSKUyp+jIY3rOI4W
         aolYZUOmrXjqjpgUnFc9XO8yYz4uqYrRxW6oORgVimmbJmtK8z9EIf1XanA0yJsd3WU2
         dgVIy/Axpcrfe9dxF9yTFOc0vgq/Bj4Bc05RnSVxog5mzEIKOee3PM3rx4nz85vRp1qn
         tpEVa2tGaWfb6vPdYncFMEM7KI5dhj1AAMwm8rYI4XHWs99T0M7zWXlGbjoBDCg43bEd
         7MqQ==
X-Gm-Message-State: AOJu0YzxqK1IJuBbcFixe+J/VgX15Zr/qy9XkbiU1sESyL7hjm1vvSM2
	3scPH6GxjLIY3JdzdS6yuBJP8SEZQ2WvEQDRfNc7Jg==
X-Google-Smtp-Source: AGHT+IHR3SOp4pnFsgLhgotZ/dPKGIjyVx1ck3Y6lBYIkZvX+0Zvfqa04IBWUkTqLTfv1smWkRle+w==
X-Received: by 2002:a05:622a:353:b0:403:abf5:6865 with SMTP id r19-20020a05622a035300b00403abf56865mr1448710qtw.18.1697226596152;
        Fri, 13 Oct 2023 12:49:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k13-20020ac8478d000000b0041991642c62sm843335qtq.73.2023.10.13.12.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:49:55 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:49:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] commit-graph: read `BIDX` chunk with
 `pair_chunk_expect()`
Message-ID: <ZSmfYtkOjqwqtbzz@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <cover.1697225110.git.me@ttaylorr.com>
 <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 03:25:30PM -0400, Taylor Blau wrote:
> Perform an identical conversion as in previous commits to read the BIDX
> chunk.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Oops. This fails t4216 because it changes the warning() message, which I
thought I excluded from this patch :-<.

Here is a replacement that passes the test. I can reroll the entire
"series" if we decide that this is a worthwhile direction to go in:

--- 8< ---

Subject: [PATCH] commit-graph: read `BIDX` chunk with `pair_chunk_expect()`

Perform an identical conversion as in previous commits to read the BIDX
chunk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0fab99f5dd..66c2e628d8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -330,18 +330,6 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }

-static int graph_read_bloom_index(const unsigned char *chunk_start,
-				  size_t chunk_size, void *data)
-{
-	struct commit_graph *g = data;
-	if (chunk_size != g->num_commits * 4) {
-		warning("commit-graph changed-path index chunk is too small");
-		return -1;
-	}
-	g->chunk_bloom_indexes = chunk_start;
-	return 0;
-}
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -461,8 +449,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}

 	if (s->commit_graph_read_changed_paths) {
-		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
-			   graph_read_bloom_index, graph);
+		if (pair_chunk_expect(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+				      &graph->chunk_bloom_indexes,
+				      st_mult(graph->num_commits, 4)) == -1)
+			warning(_("commit-graph changed-path index chunk is too small"));
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
 			   graph_read_bloom_data, graph);
 	}
--
2.38.0.16.g393fd4c6db


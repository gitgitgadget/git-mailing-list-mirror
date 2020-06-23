Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598AEC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203E720774
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SihqTQ6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgFWRzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733082AbgFWRzt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:55:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D732C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:55:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i16so16073917qtr.7
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SmkgLYbvL/0zYnQocyiJbWUY43uBGvFWFrt9CrGCeRo=;
        b=SihqTQ6LO57Fz2jlCGhgTmkmWRNF59n55SJX3xFSd0aKNjd0FTw1JGI5BFS2zhCLqM
         7QuN3XkVxmOxymZYTnkRX5UIfgr7XFXhkNwpkNpMpdteYU624wwvQLLlSVxjLGSbS11E
         D/qwYIkaLypaBoSkWmcBGaigMgvB9lwLiydjGavj+JrSpl2M2ZN9kjVp8M0vv1HxUnfI
         rXzrwzRP9vFxBnwGUoPSYuRYncvIm7xK1z1rdtQDM0XVm0Co2MctD2HzsWIDQn5zgD1a
         ICa0uKUUZ21IcCLNFYh/+a7S0CpvlJn3ORsOv3scF+kmdWohgS08AFATgZ+nSwn1n4Ew
         8kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SmkgLYbvL/0zYnQocyiJbWUY43uBGvFWFrt9CrGCeRo=;
        b=J+BGyzfJ7TOtrFSeQjtRy6zFRSCxz1yG1HJ+p4zCgk1rXAgkLJf6B/9fr50GBGtvLE
         TKIBvXhAVx8yoGemeJl19xOTIDZ+tC4YhZ3TYhAyMtS21n1bC6JOnHoqT0WZimUBnyGZ
         7t+UKCqgv9Hbit+5JeJCplCFf9dbiWUpaFfsbn94bv6sedVds3uyhnYLNinchZNNTIop
         ymow7c6VBTuYdRfHKCJP2WBIS1q7vPI8uUAK4cQbhueGBWK3XHowBCNEnPwcLTVr6fpW
         qdcYFpfkWJEuuoE7ZvcJ6JwNHBBkmTLaFl9ym2H9IMeax1eSOMSXeitFMsI1k8gXRHJQ
         sQow==
X-Gm-Message-State: AOAM530wBF0+CQIdkjcyD7lp6ti5LP61zdzO4QJcswAySRZ3j4kc8e06
        0WeBvLMvlLrKOdp+xK/dkUnwEPliXUs=
X-Google-Smtp-Source: ABdhPJw1jMnNSgR3rVQHj7dXEfXdZpyo/dpOA1jJxkzJ8S/cJvW1nlXUXrP4DEtLEO16fW2UGrLniQ==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr11161787qtu.206.1592934947422;
        Tue, 23 Jun 2020 10:55:47 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id l2sm1380920qtc.80.2020.06.23.10.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:55:46 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] pkt-line: war on magical `4` literal
Date:   Tue, 23 Jun 2020 13:55:31 -0400
Message-Id: <cover.1592934880.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.307.g7979e895e7
In-Reply-To: <cover.1592119902.git.liu.denton@gmail.com>
References: <cover.1592119902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are many instances of the literal `4` in packet line-related code.
This series replaces these instances with either functions that can
generate the number or an appropriately-named constant.

Changes since v1:

* Introduce patch 1-2 so that the string length is used to generate the
  `4` where appropriate

Changes since v2:

* Replace some a couple of inline functions with macros that ensure they
  are string constants

* Use strlen() in one more instance over the PACKET_HEADER_SIZE

Denton Liu (3):
  remote-curl: use strlen() instead of magic numbers
  pkt-line: use string versions of functions
  pkt-line: extract out PACKET_HEADER_SIZE

 pkt-line.c    | 68 ++++++++++++++++++++++++++++++---------------------
 pkt-line.h    |  6 +++--
 remote-curl.c | 35 +++++++++++++-------------
 3 files changed, 62 insertions(+), 47 deletions(-)

Range-diff against v2:
1:  d2aaf15aa8 ! 1:  cb8683837c remote-curl: use strlen() instead of magic numbers
    @@ Metadata
      ## Commit message ##
         remote-curl: use strlen() instead of magic numbers
     
    -    When we are memcpy()ing the length header, we use the magic literal `4`,
    -    representing the length of "0000" and "0001", the packet line length
    -    headers. Use `strlen("000x")` so that we do not have to use the magic
    -    literal.
    +    When we are dealing with a packet-line length header, we use the magic
    +    literal `4`, representing the length of "0000" and "0001", the packet
    +    line length headers. Use `strlen("000x")` so that we do not have to use
    +    the magic literal.
     
      ## remote-curl.c ##
     @@ remote-curl.c: static int rpc_read_from_out(struct rpc_state *rpc, int options,
    @@ remote-curl.c: static int rpc_read_from_out(struct rpc_state *rpc, int options,
      			break;
      		case PACKET_READ_RESPONSE_END:
      			die(_("remote server sent stateless separator"));
    +@@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
    + 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
    + 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
    + 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
    +-	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
    ++	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, strlen("0000"));
    + 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
    + 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
    + 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
2:  8cab5078b1 ! 2:  d283a1b514 pkt-line: use string versions of functions
    @@ Commit message
         replaced with constants at compile-time so this should not result in any
         performance penalty.
     
    +
    + ## Notes ##
    +    Junio, you mentioned in an earlier email[0] that write_str_in_full() and
    +    strbuf_addstr() each count the string length at runtime. However, I
    +    don't think that's true since they're both inline functions and
    +    strbuf_addstr() has the following comment:
    +
    +    	/**
    +    	 * Add a NUL-terminated string to the buffer.
    +    	 *
    +    	 * NOTE: This function will *always* be implemented as an inline or a macro
    +    	 * using strlen, meaning that this is efficient to write things like:
    +    	 *
    +    	 *     strbuf_addstr(sb, "immediate string");
    +    	 *
    +    	 */
    +
    +    so I believe that the lengths should be determined at compile-time.
    +
    +    [0]: https://lore.kernel.org/git/xmqqeeqhxred.fsf@gitster.c.googlers.com/
    +
      ## pkt-line.c ##
     @@ pkt-line.c: static void packet_trace(const char *buf, unsigned int len, int write)
      	strbuf_release(&out);
    @@ pkt-line.c: static void packet_trace(const char *buf, unsigned int len, int writ
     +	packet_trace(buf, strlen(buf), write);
     +}
     +
    -+static inline void control_packet_write(int fd, const char *s, const char *type)
    -+{
    -+	packet_trace_str(s, 1);
    -+	if (write_str_in_full(fd, s) < 0)
    -+		die_errno(_("unable to write %s packet"), type);
    -+}
    ++#define control_packet_write(fd, s, errstr) \
    ++	do { \
    ++		(void)s"is a string constant"; \
    ++		packet_trace_str(s, 1); \
    ++		if (write_str_in_full((fd), s) < 0) \
    ++			die_errno((errstr)); \
    ++	} while (0)
     +
      /*
       * If we buffered things up above (we don't, but we should),
    @@ pkt-line.c: static void packet_trace(const char *buf, unsigned int len, int writ
     -	packet_trace("0000", 4, 1);
     -	if (write_in_full(fd, "0000", 4) < 0)
     -		die_errno(_("unable to write flush packet"));
    -+	control_packet_write(fd, "0000", "flush");
    ++	control_packet_write(fd, "0000", _("unable to write flush packet"));
      }
      
      void packet_delim(int fd)
    @@ pkt-line.c: static void packet_trace(const char *buf, unsigned int len, int writ
     -	packet_trace("0001", 4, 1);
     -	if (write_in_full(fd, "0001", 4) < 0)
     -		die_errno(_("unable to write delim packet"));
    -+	control_packet_write(fd, "0001", "delim");
    ++	control_packet_write(fd, "0001", _("unable to write delim packet"));
      }
      
      void packet_response_end(int fd)
    @@ pkt-line.c: static void packet_trace(const char *buf, unsigned int len, int writ
     -	packet_trace("0002", 4, 1);
     -	if (write_in_full(fd, "0002", 4) < 0)
     -		die_errno(_("unable to write stateless separator packet"));
    -+	control_packet_write(fd, "0002", "stateless separator");
    ++	control_packet_write(fd, "0002", _("unable to write stateless separator packet"));
      }
      
      int packet_flush_gently(int fd)
    @@ pkt-line.c: static void packet_trace(const char *buf, unsigned int len, int writ
      	return 0;
      }
      
    -+static inline void control_packet_buf_write(struct strbuf *buf, const char *s)
    -+{
    -+	packet_trace_str(s, 1);
    -+	strbuf_addstr(buf, s);
    -+}
    ++#define control_packet_buf_write(buf, s) \
    ++	do { \
    ++		(void)s"is a string constant"; \
    ++		packet_trace_str(s, 1); \
    ++		strbuf_addstr((buf), s); \
    ++	} while (0)
     +
      void packet_buf_flush(struct strbuf *buf)
      {
3:  585d8892c3 ! 3:  00c19983fd pkt-line: extract out PACKET_HEADER_SIZE
    @@ remote-curl.c: static void check_pktline(struct check_pktline_state *state, cons
      				}
      				state->len_filled = 0;
      			}
    -@@ remote-curl.c: static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
    - 	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
    - 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
    - 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
    --	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
    -+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, PACKET_HEADER_SIZE);
    - 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
    - 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
    - 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
     @@ remote-curl.c: int cmd_main(int argc, const char **argv)
      			parse_fetch(&buf);
      
-- 
2.27.0.307.g7979e895e7


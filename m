Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2937820958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935238AbdCWPjC (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:39:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35171 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934412AbdCWPjA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:39:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so31736868wrb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7OLvol4CoJ+776ptyzP+yBjc7Lx8z4WiOtUBWeiEqM=;
        b=n0WzWMvsn0Hz2/cr4WmR5jVdXOGv0isLKj6Ze4/B+XYrP6Zf+2zncXbnH71lR29cGa
         qEpd27508dXK2uribCKtzNl7obuU41Y+r8Fdu7SBzp3KOrjhALtgwsN919Vc0AAvq+Or
         r9T095EE3+0JCUHlYBvRdSWa2+amqS2D+DpCSAxYeV+MWeBdThgjUT0Cg72wj8SNEFTk
         AyFWveNn3veoUiVsWN+5MMWsrTG/ANDg0oC+FF4MeJfnd6KUII6WG2XT7WjmsUVEwo/R
         ankOdDhR1YFM/MBUCOR+3Fej8akWqeT4XTvOjRtmEkdOOTfkHtTB9iGvUQq7wQ+RMTjb
         ooEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7OLvol4CoJ+776ptyzP+yBjc7Lx8z4WiOtUBWeiEqM=;
        b=jPpzEwEmJIN4mgtrDsSJ7TXTNSqVDzGQx6+FKMPB9oBeO5arck0XypLuvlM6FlfVQP
         wMmB2T69h6w01A5R9B/Z15GXLDcKiIfJpPuDAZWlHxVZgEqutS+nmmct+wxRpXKVfKv1
         HdAV3LEobFasaHgIOaerfJpXEIq0zRyKTIAokqtSUKQCzrdTrDHcwEessQI4CKzxDs2N
         Wo4i0K/MHkbbXg5FR+P5CUSHQtFj3p6BLdUMX8XLEvTbWeJ0ILOLyjGi3+SfD1BQbmDj
         9S/RIkfYOROZQJpPJ9/viH7BhKd7AkiAmZLqfs+3pMLgSsep26zVZnUBnw7/qIDI5qrn
         3thQ==
X-Gm-Message-State: AFeK/H2DVkJ2oA+KKUH8Bia8BDWtVNfgrLmtvb/RKD317CJ4Qxgtf22dfc+fCUkEYZuCHA==
X-Received: by 10.223.144.8 with SMTP id h8mr3039775wrh.45.1490283528694;
        Thu, 23 Mar 2017 08:38:48 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id b13sm4793766wmf.6.2017.03.23.08.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:38:48 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] completion: offer ctags symbol names for 'git log -S', '-G' and '-L:'
Date:   Thu, 23 Mar 2017 16:38:39 +0100
Message-Id: <20170323153839.24283-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323153839.24283-1-szeder.dev@gmail.com>
References: <20170323153839.24283-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like in the case of search patterns for 'git grep', see 29eec71f2
(completion: match ctags symbol names in grep patterns, 2011-10-21)),
a common thing to look for using 'git log -S', '-G' and '-L:' is the
name of a symbol.

Teach the completion for 'git log' to offer ctags symbol names after
these options, both in stuck and in unstuck forms.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e38178022..48690ad1a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1687,6 +1687,19 @@ _git_log ()
 	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
 		merge="--merge"
 	fi
+	case "$prev,$cur" in
+	-L,:*:*)
+		return	# fall back to Bash filename completion
+		;;
+	-L,:*)
+		__git_complete_symbol --cur="${cur#:}" --sfx=":"
+		return
+		;;
+	-G,*|-S,*)
+		__git_complete_symbol
+		return
+		;;
+	esac
 	case "$cur" in
 	--pretty=*|--format=*)
 		__gitcomp "$__git_log_pretty_formats $(__git_pretty_aliases)
@@ -1732,6 +1745,21 @@ _git_log ()
 			"
 		return
 		;;
+	-L:*:*)
+		return	# fall back to Bash filename completion
+		;;
+	-L:*)
+		__git_complete_symbol --cur="${cur#-L:}" --sfx=":"
+		return
+		;;
+	-G*)
+		__git_complete_symbol --pfx="-G" --cur="${cur#-G}"
+		return
+		;;
+	-S*)
+		__git_complete_symbol --pfx="-S" --cur="${cur#-S}"
+		return
+		;;
 	esac
 	__git_complete_revlist
 }
-- 
2.12.1.498.gded7ead47


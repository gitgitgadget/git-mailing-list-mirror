Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF9A20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbcJUMZr (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:53122 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932708AbcJUMZo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:44 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLvGW-1c0sHc2t1I-007oZP; Fri, 21 Oct 2016 14:25:36
 +0200
Date:   Fri, 21 Oct 2016 14:25:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 18/27] sequencer: left-trim lines read from the script
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <a63b65b1191a5147d0924d72759bf355b0a91323.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+Vm9kejFpox1dnNq46ZxKNi8TVquutS0zLPZ9i0ZMHxVPkyBh02
 h9hf7cEwsY/3CIV7w+nF2D8gjb1d5lnsPiewCCR8PZ0ohp6Z42cAbIJqUyveBcrSkVuXPCe
 2GdpifipAdbFsMPC6tIDakX1Pck9QTikADswuRJloEclXoZPj5pZmX/d1GAslBaf7Pi2aKk
 QVfgxx6RxVcE0RLJ7T5AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ceAaiPTehyw=:O/z9IrYuMq4M70TySX6JVu
 x2Iu4JrAumWfmXhBYukE10FnJ9DPPrkg664PhDyO90A8ZNj4y7o8gRzaeve1/1HvDiKqjojYq
 onKQOXhCXK5ufJrDAcmzeQAX15Rp+V6OmWdMPIG4LMKHGK7lMZnHitGU/54JrETvxL4CWyNAS
 +ClVummD+nVed0N5f6xXYTnAKKifs6lKLI5laphh9Kfk/z2WqvWaBPvGXrLvV4JmC8h6M7uuu
 kw1rrT1SC+Y0R9/cuOWG49zK0eSaiS2QVtdOZi1ZxCXff5CHvJiR8gH26rH8MzkHSqvlFkH0l
 EUrygxkHT9tZoOuxPg5xKXyboUsyYRwzWpUqHb+/WLZuTLqbnyKADsnignYMkBGA2dXiP2ND7
 JVU4PEliMuRcD+qoBwi0KPnYL1a7kSmjeaC8wd2Su3iY5Lyp9E11D75/cCIObnptl4QRcfxz9
 27dnJMnQ54zo/KikvQW0Vw7kqeM2P6boQgYgLUYn2m0qX9kYCbyqdJnqOMihWKCy8nOxNadWx
 tocB5JdCsdNE/2cZ/SbYfR70TaDZ0lGHvQXcxk+E2cFDNwy5Jn887vSFvTckj5vMrH9zFdW61
 CuqX8CGWYZzIn5mHYRoDv9jISfNeB96tbBi7A/BMNe5yV5x8Pd3DX9QsWXV0OaGx68C9Kbo2h
 1wFeqWUxeyUyfGgA/3fShEEOD4PfYYh40HzgEECuTLAgY/VSBDJLdY8iaAdlqD0EdonIhN0dq
 HniwOsaAPv2eRVH/rxAq++4S1iqPQMnUVYXSClUAlnA4jXTD/gUQf7d+cTmzedsRb0Ag5Bf9U
 uJr13Vb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebase's scripts may be indented; we need to handle this
case, too, now that we prepare the sequencer to process interactive
rebases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 8646ca5..d74fdce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -874,6 +874,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
+	/* left-trim */
+	bol += strspn(bol, " \t");
+
 	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
 		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
 			item->command = i;
-- 
2.10.1.583.g721a9e0



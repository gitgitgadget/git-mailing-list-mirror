Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EEB1F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 12:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfJMMts (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 08:49:48 -0400
Received: from mout.web.de ([212.227.17.12]:35373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfJMMts (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 08:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570970982;
        bh=XZpFvCIqU/OBVgzBjG43dg2+NDTEoNXcdC3C1l5uXHQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=LRidhVIXoFaaHGTICzlpK1r1Y/ejt+4zZfosSvNa8h79Mhj7J9ApB1MGBQXKX9AEY
         yqthRSQtDBKprPt1Eb6ePMYK8we4ra2RObM1npVfW/Ozrabjg2L+rF73Sk9ShWtFd/
         qIR8CcyyuaYC03Urbsl+4R6qG34YqQIfcKtGjLX4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSaZk-1iTdB43GPk-00RVzD; Sun, 13
 Oct 2019 14:49:42 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] http-push: simplify deleting a list item
Message-ID: <3739b392-ee45-98c2-c5fa-e4c36e585166@web.de>
Date:   Sun, 13 Oct 2019 14:49:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0sLogKY5CarveVwwiIsE6cFIXM/FQ/HPBDOuJAnni5ZccFKylKi
 SMAQujqyaqG15davOpa5MnDKftIFoq23Wbsm9PjXk8rnvDFvJvOkN+vg0t0tyBTY/4DZras
 mggeNoMHpeQU330O6fBJjsakINfG5/ZnNhXW2Mt2UN07vaSr8IZJ+TmXR/Ai38+x/uGLP+V
 K5ZoyumNztueCejPR5kwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gL8wu/df+6g=:q1rlDTWKH1x6oanHPNilUP
 G6G04DJtsoBOILIi8c3oYx6+VkJQPVujBZIheFj2A3jOBTw8ie1MSnh2H+IgJw++BnTmA/cxw
 KsopJQvLPxmWZ1kxndz83jWxzK5e9bjBWje/zDjVuenNOg1wXsq8xk7yWbVsuSt+u+y6E9K2Q
 yu4cy6TZWDffQHKg5wjeoYvJbAExvCiUom4E7sU202bkRBEOasNehS7Ah/zE6wgD7dL5Yt0ie
 Hzrq+cpSqU93xqFvyAiOq79yGG25tZnkvjmcr43Cru2/aaVz2whMOpPXHFgCGx0D2jY6BiH3D
 /YCrnQuEimaq4nqxaHUF+5wxmrLLrvAuLo9MLIUwSjPa7pVyX+PrQhzefBNuY6wUqiGszvuoD
 vNbF+1+vZzvJAlUqeA8xPM0/jXCG/fdpBh+cTX9f2eb6n+ZvW0PoeC8b2ydgWe5cOPKpF//i5
 oo04tfTFgHpP6LNwUVh0u3v5SHpiRYAR19sinG+oZIC6X3P0DwcwSbmadkyD/6VWfVXx1fwUG
 lHkA54V+I6I6TjxV4tQNolAuW/qSdgdvOHwK28+R0EwnUJQIFXMhCyeGP/7qa7vE7VZJx7j7Z
 PzwUrTOkHPUhcVbrlClArSXTjLfxdzZVpEBeC0QtWbldR7dZ5oVH9BT/Mwg7203vu2N0u5O6z
 G9GS7srs85vd/fEj5QlVjWRVNp60+UTFnvK/fEzd4gayeZfC6xpBBrr0oa3vo2H5/ryt0HCg+
 wPCD26bnIOVZV6BzqWJ+wESMdC/NmGlfPOzEphAEDqhu0kMvvLd4SR2NjV0LrqPc8NjwnjBre
 pi17xZnubG+qY9hi4uLkOO7DQOgm4ndf9ZIt28IKDQYysZlLsYE3XiN/sj8lxj7lgxf+fxOX0
 Ry1KDTi6dZrF4b8EgQPfLJx/N+yw0r+BblxDoZTnsC4JEk061GBrNYM26r02JTrNzt7tlnLCa
 yg+h0vT+2e1NUB0OS6w3Iv5fda99vT+iYBVz3FXqfrMVNKPllH4cHKsxqx3xC7RrL9sFWXXxe
 fCfAJ+sKcooTFkZL5ogRW2n9uM/Is67iVc7QkuN6Wnv8PGQidbHiScBwjeKIG2lAcWll2+mab
 uw9kJSngnF3nzkN1WCkRzX6r8Z9TMVQ4nWcVngzRWMTVmgY5bU1eBwfyl/2P2fBUvN6ENIaqo
 4c7SoZuuW3mzZIaX/N9RGivWMv+vmWO5DfnWfjG9EiUtQKmHaDt+BTSfCbZSia28AiyasO6Cs
 HKIY3M7uwn274AdYf/RNCrRmIzboYrfMt1Nugkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first step for deleting an item from a linked list is to locate the
item preceding it.  Be more careful in release_request() and handle an
empty list.  This only has consequences for invalid delete requests
(removing the same item twice, or deleting an item that was never added
to the list), but simplifies the loop condition as well as the check
after the loop.

Once we found the item's predecessor in the list, update its next
pointer to skip over the item, which removes it from the list.  In other
words: Make the item's successor the successor of its predecessor.
(At this point entry->next =3D=3D request and prev->next =3D=3D lock,
respectively.)  This is a bit simpler and saves a pointer dereference.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 http-push.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/http-push.c b/http-push.c
index 0353f9f514..822f326599 100644
=2D-- a/http-push.c
+++ b/http-push.c
@@ -501,10 +501,10 @@ static void release_request(struct transfer_request =
*request)
 	if (request =3D=3D request_queue_head) {
 		request_queue_head =3D request->next;
 	} else {
-		while (entry->next !=3D NULL && entry->next !=3D request)
+		while (entry && entry->next !=3D request)
 			entry =3D entry->next;
-		if (entry->next =3D=3D request)
-			entry->next =3D entry->next->next;
+		if (entry)
+			entry->next =3D request->next;
 	}

 	free(request->url);
@@ -981,7 +981,7 @@ static int unlock_remote(struct remote_lock *lock)
 		while (prev && prev->next !=3D lock)
 			prev =3D prev->next;
 		if (prev)
-			prev->next =3D prev->next->next;
+			prev->next =3D lock->next;
 	}

 	free(lock->owner);
=2D-
2.23.0

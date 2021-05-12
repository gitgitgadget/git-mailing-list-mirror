Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D4C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38376121F
	for <git@archiver.kernel.org>; Wed, 12 May 2021 03:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhELDT7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 23:19:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33083 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230002AbhELDT6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 May 2021 23:19:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF3E95C018A;
        Tue, 11 May 2021 23:18:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 May 2021 23:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm3; bh=03xEK805Gh390KotxaDRYZEMVByqjvtRyEYw6anFlrM=; b=QWI7n
        tnP0YnG2muqGLwXe6nWWT/PV71eBdU3megn+tniZAybH0bjDzse3eEmvSLdtTika
        C55fVkJrZ86Nt+2j/Rmxw2VTo/cXugxX4MMLsjGLBrtTSNJl5JBd8Z6YU3CA5WzY
        FgG8/8lPz6GPAamHqeR9R0/gO350ujqrFzvzK2uTqp/LpUV4uTMFg0OuaO8I1rjJ
        DyjlgSFZVOzNkuLDUncIL7gUuO4baqiFqyoiVqhemCft3GAeKiqT6rgTTNfaR4Z3
        QqfjMYPF3VhCMdRSutrnzczULyvVpJuKNU9m9Rg+oryD7XwomEIBYPzPtTkmcGIE
        4MJ06i4y/hMP9MMNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=03xEK805Gh390KotxaDRYZEMVByqjvtRyEYw6anFlrM=; b=kcZQflZs
        KRgca3wFv1mC7FIoGOtBSz/yNWH2yGGF0tdEo1D3AECK60PgxHnv5VFc4IxOxIPl
        Fo+JY7nOQ6DJQ6TFNo/z0ckBRlsJgPHqxY9zJvA3qxLOC4rFZcssQAMGdt0Ikxfw
        +ItFilM/W54+yPKZTYLXpgy569xCwFvHY0LFYbFJl6KYOVBqCrNf2efLRiOnQFnh
        n9bhX6kygQluHxHEenAGLjOl+o+mmCjJN+oDAGqmUeE29pOzgwq7JzhSa4OhvYTs
        Vrmda7zQYwleZyY1sLXAKu5WRPtV0sYORTZC56jsD+/azMhZFu14sAV/CzB/dQ5b
        m3lHLa7pCa2EUw==
X-ME-Sender: <xms:GkmbYMktldaw5TTBKKLxHY5BM4ug2Xu9UoPqddoFa4raeAIGzJrfNQ>
    <xme:GkmbYL0w6S8LTW7n6i7yXpm3fhR7k9zJUNgskXtctVWjByrkQE_cLW8zyPIEvU3ep
    QFErmBJNRr4KzYV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepffgrvhgvucfjuhhsvggshicuoegufihhsehlihhnuhigphhr
    ohhgrhgrmhhmvghrrdhorhhgqeenucggtffrrghtthgvrhhnpeejheegiefhhfdukeeite
    fgvdevieeigffgfefhleejvdefheekfeehffdvgfdvhfenucfkphepudejgedrhedvrddu
    hedrfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epugifhheslhhinhhugihprhhoghhrrghmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:GkmbYKrmr7P99_eC8WnqnVG_czzPmRuqXI78Z8p__k_K6Dsh-T9MNA>
    <xmx:GkmbYIleveCYM8zTotPfCvKoHpiqL3Vq3l178Nadndli3dhh__PWbw>
    <xmx:GkmbYK0aIAR2VQ3HB4Mdw-jrVSnB4MAYYX4VOxABDQGzkhqs-2scLA>
    <xmx:GkmbYP9RRHIAbUAyeeb8dKHCZuUqXT7hOWuYHED_MMeu_F1CHQKVow>
Received: from linuxprogrammer.org (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 11 May 2021 23:18:49 -0400 (EDT)
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de
Subject: [PATCH v2] Writing down mail list etiquette.
Date:   Tue, 11 May 2021 20:18:21 -0700
Message-Id: <20210512031821.6498-2-dwh@linuxprogrammer.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512031821.6498-1-dwh@linuxprogrammer.org>
References: <20210512025447.6068-1-dwh@linuxprogrammer.org>
 <20210512031821.6498-1-dwh@linuxprogrammer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After violating a few unspoken etiquette rules that were spotted by
Christian Couder <christian.couder@gmail.com>, Filipe Contreras
<felipe.contreras@gmail.com> suggested that somebody write a guide.
Since I was the latest cause of this perenial discussion, I took it upon
myself to learn from my mistakes and document the fixes.

Thanks to Junio <gitster@pobox.com> for providing links to similar
discussions in the past and Stefan Moch <stefanmoch@mail.de> for
pointing out where the related documentation already existed in the
tree.

Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>
---
 Documentation/MailingListEtiquette.txt | 125 +++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 Documentation/MailingListEtiquette.txt

diff --git a/Documentation/MailingListEtiquette.txt b/Documentation/MailingListEtiquette.txt
new file mode 100644
index 0000000000..9da2d490aa
--- /dev/null
+++ b/Documentation/MailingListEtiquette.txt
@@ -0,0 +1,125 @@
+Mailing List Etiquette
+======================
+
+[[introduction]]
+== Introduction
+
+Open source, community projects such as Git use a mailing list and email to
+coordinate development and to submit patches for review. This article documents
+the unspoken rules and etiquette for the proper way to send email to the
+mailing list. What follows are considered best practices to follow.
+
+If you are looking for details on how to submit a patch, that is documented
+elsewhere in:
+
+- `Documentation/SubmittingPatches`
+- `Documentation/MyFirstContribution.txt`
+
+[[proper-use-of-to-and-cc]]
+== Proper Use of To and Cc
+
+When starting a new email thread that is not directed at any specific person,
+put the mailing list address in the "To:" field, otherwise address it to the
+person and put the mailing list address in the "Cc:" field.
+
+When replying to an email on the mailing list, put the person you are replying
+to in the "To:" field and all other people in the thread in the "Cc:" field,
+including the mailing list address.
+
+Make sure to keep everyone involved in the "Cc:" field so that they do not have
+to be subscribed to the mailing list to receive replies.
+
+[[do-not-use-mail-followup-to]]
+== Do Not Use Mail-Followup-To
+
+When posting to the mailing list, your email client might add a
+"Mail-Followup-To:" field which contains all of the recipients, including the
+mailing list address, but not the sender's email address. This is intended to
+prevent the sender from receiving replies twice, once from the replying person
+and again from the mailing list.
+
+This goes directly against the desired "To:" and "Cc:" etiquette (see "Proper
+Use of To and Cc" above). Most users want to use "group reply" or "Reply to
+all" in their mail client and create a reply email that is sent directly to
+author of the email they are replying to with all other recipients, as well as
+the mailing list address, in the "Cc:" field.
+
+The proper thing to do is to never use the "Mail-Followup-To:" field as well as
+disable honoring any "Mail-Followup-To:" fields in any emails you reply to.
+Some email clients come with both enabled by default. Mutt is like this (see
+Disable Mail-Followup-To in the Mutt section below).
+
+[[enable-plain-text-mode]]
+== Enable Plain Text Mode
+
+Most email clients automatically reject mailing list email if it is not a
+text/plain formatted email. For that reason, it is important that your email
+client is set to create text/plain emails instead of text/enriched or
+text/html email.
+
+[[patches-that-receive-no-response]]
+
+From Junio's notes from the maintainer:
+
+> If you sent a patch and you did not hear any response from anybody for
+> several days, it could be that your patch was totally uninteresting,
+> but it also is possible that it was simply lost in the noise.  Please
+> do not hesitate to send a reminder message in such a case.  Messages
+> getting lost in the noise may be a sign that those who can evaluate
+> your patch don't have enough mental/time bandwidth to process them
+> right at the moment, and it often helps to wait until the list traffic
+> becomes calmer before sending such a reminder.
+
+[[send-merge-ready-patches-to-the-maintainer]]
+== Send Merge-Ready Patches to the Maintainer
+
+Once a patch has achieved consensus and all stakeholders are staisfied and
+everything is ready for merging, then you send it to the maintainer: "To:
+gitster@pobox.com".
+
+[[mutt-config]]
+== Mutt Config
+
+This section has suggestions for how to set up Mutt to be polite.
+
+[[known-mailing-lists]]
+=== Known Mailing Lists
+
+Mutt has the ability to change its behavior when replying to a mailing list. For
+Mutt to know when an address is a mailing list, use the `subscribe` keyword in
+your Mutt configuration:
+
+**~/.muttrc:**
+```
+# tell Mutt about the Git mailing list
+subscribe git@vger.kernel.org
+```
+
+[[reply-properly]]
+=== Reply Properly
+
+By default, Mutt uses the 'g' and 'L' hotkeys to execute a "group reply" or
+"list reply" respectively. A "group reply" creates an email addressed to the
+sender with all other recipients in the "Cc". A "list reply" starts an email
+addressed only to the mailing list without anybody else as "Cc".
+
+Per rule X, Y, and Z above, using "group reply" in Mutt is what you want to do.
+
+[[disable-mail-followup-to]]
+=== Disable Mail-Followup-To
+
+By default, when replying to mailing lists, Mutt will automatically generate
+"Mail-Followup-To" headers. To fix this, disable the generation of the header
+in your Mutt configuration. It is also a good idea to disable honoring any
+"Mail-Followup-To" headers so that any "group reply" operations are correctly
+addressed.
+
+**~/.muttrc:**
+```
+# disable Mail-Followup-To header
+unset followup_to
+
+# disable honoring Mail-Followup-To header
+unset honor_followup_to
+```
+
-- 
2.20.1


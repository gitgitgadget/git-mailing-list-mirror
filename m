Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32E3C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 08:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjC2IGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjC2IG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 04:06:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B535A7
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 01:06:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so19087490lfj.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 01:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680077183;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab/9xo5xcCVwNd7fYIpt30u9GD5F12B2HmtU/JCDQ4s=;
        b=XRCyM5u8ESFZyk47YmsttZVg1VMXS07Fx5GA7G1O70VF3GUOK59GwgANU6M69EnjYS
         0pzWDPiQ6aBdj6N/mRAUTEKo3go8YrOqur7+nlEBb9TBxrFLDL9fvkqG6N3ontRbFIl3
         fy/yNwMD2VbqgcVCy7JGGa18k51D55A/gceNOFlSejZS8W71q458e2cH0uah5GLGHZQT
         NxNO3DWmJcrHkUuuXumeByrqjfOLlM4BC3PnkNRmBg4uMYjNPuTeAzaWyWlYV91G6awJ
         mGTCQxwGh5lZEAJ/SM0+xxTwt4TES5qJ6hdNL210QBPtxFQXAwxoSLGa/QLknx8vnaIs
         6vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680077183;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab/9xo5xcCVwNd7fYIpt30u9GD5F12B2HmtU/JCDQ4s=;
        b=53ExkLnVLpHe+x/uppQ8YSlsRJvOdfR/Z/SH4PhWOaJwzJtSPaB8TuJIyyQ74ObDwY
         QUYUS29Wv3dHn0YvFbM2p7xRGxFtyBjyDW+1TnPaPhMww90ag6YRPoWgMmue8ZmqHzyA
         zU27LElDKBsq9+K5EkJc5+AB8mmjDHr63iuF1DCPkeS8y4OtcthliOZkYg7YE26rJzo4
         eaI7gRovd6y6aRaXPAQDRdMYkRSrZn6QTkhaFy5UULwgveLmEFWFT5d2zw8028UpEKaE
         la9pLsqEU3t228sqlJWFA5MXm0Kt3PmnL8DQkKmhWGBeAwZE7e4ifgVOQ50njBfRbBT2
         wuUQ==
X-Gm-Message-State: AAQBX9cuNNVUmBf03o7m510ak97l5WG1yhlaxEdO20sgzreDDlN8xlXa
        J4b7PGc26tDaIhoUnxPGTTU33aLmmNo=
X-Google-Smtp-Source: AKy350bo3CDNcu4UG6ajLZgXLLY/q8yS3mGQVhctnOm1JAfVJ0OjBXyojv9wSVFkpKa+IcW2JW2gnA==
X-Received: by 2002:ac2:4a71:0:b0:4d8:4fed:fa0c with SMTP id q17-20020ac24a71000000b004d84fedfa0cmr5889886lfp.9.1680077183152;
        Wed, 29 Mar 2023 01:06:23 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e3008000000b002a4bb086610sm1804850ljw.123.2023.03.29.01.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:06:22 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
        <874jquxc67.fsf@osv.gnss.ru>
        <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg5vgvc.fsf@osv.gnss.ru> <xmqqjzzo46tv.fsf@gitster.g>
        <874jqj31gv.fsf@osv.gnss.ru> <xmqq8rfugbuy.fsf@gitster.g>
        <87y1nk6aa5.fsf@osv.gnss.ru>
Date:   Wed, 29 Mar 2023 11:06:21 +0300
In-Reply-To: <87y1nk6aa5.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        25 Mar 2023 19:55:14 +0300")
Message-ID: <87mt3w0yo2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

[...]

> [As a side-note, current behavior of implied -p, explicit -p, -s, and
> --raw with respect to each other that I figured by experiment looks
> suspect to me. E.g., once explicit -p is given, and then canceled by -s,
> I can't get bare --raw output anymore]

Specifically, this test unexpectedly fails:

modified   t/t4013-diff-various.sh
@@ -457,6 +457,16 @@ diff-tree --stat --compact-summary initial mode
 diff-tree -R --stat --compact-summary initial mode
 EOF
 
+# This should succeed, but --patch --no-patch does something hidden
+# that breaks --raw.
+test_expect_success '--no-patch only cancels --patch' '
+	git log --raw master >result &&
+	process_diffs result >expected &&
+	git log --patch --no-patch --raw >result &&
+	process_diffs result >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log -m matches pure log' '
 	git log master >result &&
 	process_diffs result >expected &&


Thanks,
-- Sergey Organov

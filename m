Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13E72022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbdBWUOq (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:14:46 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34208 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbdBWUOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:14:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so201630pgb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 12:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=lGLxQNPaxpzYYG7Teu8vQCrMUxe0FeCTyp73PlxyEKP1cLzGeFfgRUtXaaa+1JkwBa
         B24/+FVBa2c4OJIJNwf1alOpgSFu6rK9iMO5xFiV8zy9FO/Ib6L67QIuU1osJKpeYhW/
         MMo0sJU09pQseGbygDNi7nCcHUHLG/crKPEltD+XWonFTq/+r8yxH4nhwp97QP6qXs4j
         1LHdDHHS2sXBb0Dga6kqMZB+bXFiuofeGdrRgNXU4/7nukBR0BujAyeKRgeoRYOGJpXK
         +auQqO1653ZJabPaj/F7Li8USUYOQ/1pVROHg+tih82HQbmlbNV7C0rs6YxLVMcOHc2N
         ZLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B7d8ySsjr4QTi1Xl0oTp13tAc0DvFi67hqDNlHpCELI=;
        b=cq9TX+3NGEd/Hj5R8Imd+70SPe0ToVJhdsRjFsSkkMStk/0wtXF8PqUc0dhfxboCWb
         J1e728JRaOpcTr7/pUMr74VB9+HKjq20gjJvtTP/7xDF3QADRnunWHTH6OGt9E1XUAwr
         6C2sJTTjyk1dhVHXTzZ/NyZxv3zu2SRLodjwpg0rGLr6yOk29mnn2W6W6KoSAIs8/Bdi
         msLbydDiYn7x82+y87dCIKttTa884KuKUi0JVg/RvfQmbqM7oKmtWG0pVjB/oAPVsccP
         JF+zuRWtx1pRZM1STg5kBbhOHpcQ/cUUO2V3mPLUOvfxwaipPGL4xW7AePqg44P9VrGG
         iuOw==
X-Gm-Message-State: AMke39mzXvjargjA2Su7R2eyn2EUqZD0o7iMICQg4L2Pi1WG1RRCAnxNlxtEeFcBog9RPQ==
X-Received: by 10.84.140.131 with SMTP id 3mr54828120plt.151.1487880885199;
        Thu, 23 Feb 2017 12:14:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id x15sm11357434pgo.56.2017.02.23.12.14.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 12:14:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: report "not our ref" to client
References: <xmqqo9xtajcu.fsf@gitster.mtv.corp.google.com>
        <20170223184303.26530-1-jonathantanmy@google.com>
Date:   Thu, 23 Feb 2017 12:14:43 -0800
In-Reply-To: <20170223184303.26530-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 23 Feb 2017 10:43:03 -0800")
Message-ID: <xmqqshn47jgs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C7B1FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbdEIDPz (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:15:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36358 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdEIDPy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:15:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id 64so5599249pgb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i8Hq6N80G13ZBYsxLdEIrllQRUolUkHP70yNgnPX3RE=;
        b=i5Qd4lWrO+SX2JAezEiTY+4ocQZ06o43x0duRnBipzuJce2rFkHP33fwVrE54CopDP
         n+71z/OUnxoXdFE0+/Yh7TB9twTg8pCbEoxG2F0BqSfx+JRVh5/t45/360rpqUf9OV2i
         gwEa1poONahNbTr+vKVYYp7uSO8GAQKaJ73vC98nbMrAPiG4sHAzlATWsgCgd+umMNov
         sgLmgRkXfeFggUlZBgSgwu7lbBE11zybAdH290HToihZbLgIP5UoFi6Toe/h0AtkdcOX
         b3adH1ssrdh4+Fyjtbxvu27/n4zlAIy5kw/yS3Z2vlIQU5L6Ieloybey1u+o9r3oBUU7
         TnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i8Hq6N80G13ZBYsxLdEIrllQRUolUkHP70yNgnPX3RE=;
        b=ZjtgjOCihJ7PmjKbNNIqNQUYmwhlaOYdTow1yWP4KKK9r3yj0SuzGAm7hY346QChVq
         /N9tLKASwcG9OP3nPQTtEGkb5E/rAg496lKNHn/IJ5ZCh/gqbOl2I2sxe006nRVBjqkN
         aAJgcRxSTJBYteFbo8p+nxq3jB3xV9864QDr8fCluz0sfKtGgsmbg3RVd8GbArvWKuq1
         3giOLcxiLKLCECN089YDL6ZR5APtmhk9/UIejLRo6WK5ZTyhC2GOmcUXbBHeX3DNfUp9
         7739QrPN3dmMfB/502v9VQmqmpZLYjNHkVxtXGmx+ZaWDmeeda0ggBcpTpa7JmJLirbI
         82pw==
X-Gm-Message-State: AN3rC/6phPwOnp7Pheq0ByX6F2md/SZ+dR7r72L/QxEDCilnfoRE4atd
        BT/E8xY6xrO3Fr+VRLz5cQ==
X-Received: by 10.84.143.195 with SMTP id 61mr88452252plz.158.1494299753629;
        Mon, 08 May 2017 20:15:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id p16sm29908195pgc.4.2017.05.08.20.15.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 20:15:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 2/2] receive-pack: verify push options in cert
References: <cover.1494279020.git.jonathantanmy@google.com>
        <cover.1494027001.git.jonathantanmy@google.com>
        <cover.1494279020.git.jonathantanmy@google.com>
        <cc21a5566dcf10e4683465ac253c76370b7b6a7f.1494279020.git.jonathantanmy@google.com>
Date:   Tue, 09 May 2017 12:15:51 +0900
In-Reply-To: <cc21a5566dcf10e4683465ac253c76370b7b6a7f.1494279020.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 8 May 2017 14:33:51 -0700")
Message-ID: <xmqqlgq64t5k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Teach receive-pack, in the case that push options are provided for a
> signed push, to verify that the push options both within the cert and
> outside the cert are consistent.

Thanks.  The idea was that the certificate should record how the
push was made fully, hence we need two copies.  The one outside the
certificate is meant to be actually used, but obviously we need to
make sure that matches what is recorded in the certificate.

In retrospect, we could have required the receiver who groks signed
pushes to only look inside the certificate for options etc. so that
the sender can omit the "extra" copies outside the certificate, but
that is not how the current protocol is structured, hence ...

> This sets in stone the requirement that send-pack redundantly send its
> push options in 2 places,...

... this requirement.

Thanks.

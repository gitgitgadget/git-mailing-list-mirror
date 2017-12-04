Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1258B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbdLDRMc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:12:32 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43468 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdLDRMb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:12:31 -0500
Received: by mail-qt0-f195.google.com with SMTP id w10so22585210qtb.10
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dHb3qmVcPNiB0NruzoUSOHYhC8vaxWN6xLvxS9hDni4=;
        b=oJduaVZx6wR1vUaQMmh6yykHbggIV0foD3ISVwdNFFOD2V6ARdozOFYCrJcQDHSlI5
         GAlFpgH5bKcM+VD/WePTX0dqAnIqc112St4ApuI4eUVbcdQJWYovLzobYPERINMNXoBG
         Ypqks92fWt+AfirjhIxiSEtpHJutwJxxVdOELzxaon1nxAevP/4nJMttlgMRp3WOtMb0
         Rw85yqoEWiLr0jcONegjNYVi7vfIYfXiMEdLN/QclivrUTgLple84KBY199QNnI1wf7X
         coRdfvqZYnDpbpRdJPbJ7cAyslV8GL1I2Vl68XkUDfmpJBFhBmVVgwhXl2iWxGMeJmL3
         C/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dHb3qmVcPNiB0NruzoUSOHYhC8vaxWN6xLvxS9hDni4=;
        b=B54CRhNezbCcHzgxEsaWzL4k47JBHIIwaN4x5hhu61WhdD76mQo2kbhSFgPcrZhgXA
         AtExqBvElXZjrq4DRevsU1e0vNGPxL88JSB563vtQTBxJlV/UczY62biZgsOQka8ga04
         X8YplqNNhF1Gejh5dztEJNxwb0gaU4PD6YuqwXqI6bxJUcmGcBXr424dn2mjV2tzkgiF
         IAcNiv6GxUFSXNiDc7+6JLUPpGIr7RRevqQ2Tf/ZHrGociHm6M/4SYQCCXjlo7KDq7bm
         G/LzCXr7c3Gcvt/jAilQStaYf9wDxAGoO10XKVyZwXvObvdETOuihn7VoW1YRBvv/hcD
         24Mw==
X-Gm-Message-State: AKGB3mL+qtgwXFJ16qTP1yQNH2PB+/FnVbMNqkjAJ2K1pkWx3v+otq4Q
        naeS4Kl55ersKWxRTcmx+AY=
X-Google-Smtp-Source: AGs4zMbWCy6VoFVPiXG74XZDZ+RcmB2vOif+GJXJjO6up/A0KOXnkMwF3e9X4tahU7p4ec5ieVAVHQ==
X-Received: by 10.237.37.162 with SMTP id x31mr22425668qtc.58.1512407551048;
        Mon, 04 Dec 2017 09:12:31 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:1::7cc])
        by smtp.gmail.com with ESMTPSA id c1sm5503695qta.52.2017.12.04.09.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 09:12:30 -0800 (PST)
Subject: Re: [PATCH v2] sha1_file: use strbuf_add() instead of strbuf_addf()
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
References: <20171201223945.GB17334@sigill.intra.peff.net>
 <20171204140603.180079-1-dstolee@microsoft.com>
 <20171204165652.GA12701@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f539b5e3-6bb2-4970-4205-242a2a3cc6ce@gmail.com>
Date:   Mon, 4 Dec 2017 12:12:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171204165652.GA12701@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2017 11:56 AM, Jeff King wrote:
> When you put your cover letter first, you need to use "scissors" like:
> -- >8 --
>
> to separate it from the commit message. Using three-dashes means "git
> am" will include your cover letter as the commit message, and omit your
> real commit message entirely.

Thanks. I updated our internal best-practices accordingly.

-Stolee

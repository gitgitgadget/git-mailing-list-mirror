Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5AD1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 11:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeFDLcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 07:32:55 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45610 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeFDLcx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 07:32:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id i18-v6so29356261qtp.12
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pOKv55h2g83E9rdvMfCbbcii8wAyAjnWdGM8euL6DF8=;
        b=esUsv/OgOXPrs1DkpnOqzJGUOixpr/dZl+C9MU1AhU2tnf4rYT8O8rzNg1YAJ45Pep
         twaUq56KzeV+tu/qTAMqqaeccVETAKNaQ+BOw2DpgKO4ZvyGNoklYquG9TSzfn5sreN8
         NXu+CJBwK1ZSl3JnJ/B+IceALq2iBWggt9ObEp8TywHFe1YL2ARbgWFAMsSZL9vzmLNb
         Iwm5BNdW9M9zN0MzKjangLYh/yzgn4bj3QCjCcr88VZgkEDqXcPD0bRnflhi4S+njN+L
         Cw7I/tD7uCmUKmTPL4qdD9Fp0Tcu/ggcZCk+YTCfLUsjlhh2EJHesyFvtiuSRI8BptBo
         WN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pOKv55h2g83E9rdvMfCbbcii8wAyAjnWdGM8euL6DF8=;
        b=Qz8Ahpxxdhvt5qk2ibWWBJTfiKh4ireNAWAYXzxAawabP+gTMaZ4dhbOBWqugIp9GA
         JlxprSpRy3vhgM9PKuX6t+bxjcbMgQpTnGzCxRfXzqvhRuPl1WSw4duQwcMYinTHpBtR
         aD/WGw0fVfrbwkja3yT6d5DZtctCZmvBRjQ6ijDk1E/VTL0Wb0+4P3+Zdm9ZkXCZtLO+
         jQZlLYLaerDiCtzYH+Hf9QvpA7txsDlx5akKy0izvwxA/ukcXNe3UzTN7kSVwDMVi7W9
         yZN3vYMrEHSCItwwm3ZdMtUTcYZ6DW03ryS4OERfYFnX7LQLuItjxM91kd8J1IlT4eG/
         qLgQ==
X-Gm-Message-State: APt69E1IvuB+xcjubXJy111XNMTWbwNZwGiDx+Ho+lJEUbzJUjm0r9T9
        Mf9W2IUEbrc1rTVRWcwcwHY=
X-Google-Smtp-Source: ADUXVKIlo6ecaaTrAKjxo1oBtAOGGUstxAFSqZr7j+hP0x+YqbTz0GEBAuFFlwgb+vt6+6FGcLhTdQ==
X-Received: by 2002:aed:3cba:: with SMTP id d55-v6mr21032848qtf.210.1528111973095;
        Mon, 04 Jun 2018 04:32:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2d1c:9d08:485:87f2? ([2001:4898:8010:0:1652:9d08:485:87f2])
        by smtp.gmail.com with ESMTPSA id z135-v6sm6793867qkz.82.2018.06.04.04.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 04:32:52 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] commit-graph: verify corrupt OID fanout and
 lookup
To:     Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-10-dstolee@microsoft.com>
 <CACsJy8A8NofWCo0MbMxCe=xKTrnAqmM5D+FHSJXC-wO-DPnXwg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <86d82fe4-3dcc-48a1-6800-70d49e30af8c@gmail.com>
Date:   Mon, 4 Jun 2018 07:32:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8A8NofWCo0MbMxCe=xKTrnAqmM5D+FHSJXC-wO-DPnXwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 12:38 AM, Duy Nguyen wrote:
> On Thu, May 24, 2018 at 6:25 PM, Derrick Stolee <dstolee@microsoft.com> wrote:
>> +               if (i && oidcmp(&prev_oid, &cur_oid) >= 0)
>> +                       graph_report("commit-graph has incorrect OID order: %s then %s",
>> +                                    oid_to_hex(&prev_oid),
>> +                                    oid_to_hex(&cur_oid));
> Should these strings be marked for translation with _()?
I've been asking myself "Is this message helpful to anyone other than a 
Git developer?" and for this series the only one that is helpful to an 
end-user is the message about the final hash. If the hash is correct, 
but these other messages appear, then there is a bug in the code that 
wrote the file. Otherwise, file corruption is more likely and the 
correct course of action is to delete and rebuild.

Thanks for being diligent in checking.

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976A22047F
	for <e@80x24.org>; Wed, 27 Sep 2017 17:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdI0ReN (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 13:34:13 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:43076 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdI0ReM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 13:34:12 -0400
Received: by mail-pg0-f47.google.com with SMTP id u18so8157536pgo.0
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H1FTmeP+dwEGPMEVV6aE88Cn52o0/UObSVw7lDWn2bw=;
        b=R3RXfESVEWOqi2yQw+20L1aO7dPbAOR3pOXtwKxXK8ZehesS6n9BfcR3F55hZtgQz0
         o3CkT7xeOt0Lan57jNkAcxkTUooaPgiua1HllB+mIQV0Sti+5WpY2wSugjTn4ltPiGWq
         Hrgi03kI9gxCxdZs2embNA5Tr9Sg/8Du+9/9IHrefM5c/37AnmFbx2gqLO72ZImQ6/ly
         d42OOpWa3G4HTFpp4xooDNueme7bCBJPOT5xBqCV8og43mVFdozfihgVl2vvDWHCencj
         Tg6GHKgDxcNwoVBvt3mrvvnfu9v7ygAz1MXktXgWaoSLSca7KKuAskPZZyrVq389CYVk
         /spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H1FTmeP+dwEGPMEVV6aE88Cn52o0/UObSVw7lDWn2bw=;
        b=OUyKgmIEHLCLbAEYcn/smEwRF7n/RDWDJ5YFxTCzVtLBndCN/BttIqvkPkyzVEmND5
         dtFb1o796zpSV24a/BOnfOLVYKWckCYbIqnLmzL66BafoYYlOKLt754S0mFOBq38g3Ry
         zOiqKz2Y0TeNga2BPYlk15j5Qs2c6YOCK9QDXAgAxK1q2LaDVLbEATB4Wv/rPm59nKUZ
         +itWXHCUvqQzdydT4CIsxusFUDnNp4ReNG7CKJCcR31NMVn4569T2rXhEEU3rZt6RrRJ
         /uvqSPBySBry/G8Lbrp/3pjbpHGGZC5nrkXws0pmPwfZzivvxA6DSaKnay5L4jFaebYs
         tsgA==
X-Gm-Message-State: AHPjjUgxiqiykBnH8F0M7fiChFZyyYCHnxYg4K0jV0WzvHXP1zzKxXf3
        Xex5GQbOZIS1Sqb13rhH2NOIbQ==
X-Google-Smtp-Source: AOwi7QArtfChYzobpMP/RH1Rg+V1yheoLeO/x4ZCqwv0pTtVfG+vdmv2Kb2PrxiVJI2h3ZStH6W0PQ==
X-Received: by 10.84.224.141 with SMTP id s13mr1823262plj.409.1506533651800;
        Wed, 27 Sep 2017 10:34:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f4af:3f36:535a:c7e6])
        by smtp.gmail.com with ESMTPSA id x81sm19119334pfk.40.2017.09.27.10.34.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 10:34:10 -0700 (PDT)
Date:   Wed, 27 Sep 2017 10:34:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 6/9] connect: teach client to recognize v1 server
 response
Message-ID: <20170927173409.GA161070@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-7-bmwill@google.com>
 <xmqqh8vp7xv4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8vp7xv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
> > +static int process_protocol_version(void)
> > +{
> > +	switch (determine_protocol_version_client(packet_buffer)) {
> > +		case protocol_v1:
> > +			return 1;
> > +		case protocol_v0:
> > +			return 0;
> > +		default:
> > +			die("server is speaking an unknown protocol");
> > +	}
> > +}
> 
> checkpatch.pl yells at me:
> 
>     ERROR: switch and case should be at the same indent
> 
> and we would probably want to teach "make style" the same, if we
> already don't.

'make style' actually already understands this, I just forgot it run it
on this change :)

-- 
Brandon Williams

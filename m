Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65C31F404
	for <e@80x24.org>; Wed,  4 Apr 2018 17:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeDDRBe (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 13:01:34 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:36793 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeDDRBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 13:01:33 -0400
Received: by mail-pl0-f52.google.com with SMTP id 91-v6so14895643pld.3
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 10:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ywHUGO64jj0iOjSPc8K8bxdiqVz6Jk6y0fFLT8K40qU=;
        b=rA772o5TdJE88dMaQUlYwjxTMisJLlvJeHt5z75H20Ngshbp45lcldSu7ZpOuGyV0l
         xQuX9C9bJnG3ex/LIcKNg6bQRWi968wdICGSxgAIRdC3sT1FcQmJ67mEGdtuTxcBtmCH
         r656hgIbTco+hKluow4gc99IiAjZtzViB4ogV1F1G+lCoIu4w96zRz5kX0N9JAClGQOQ
         rnbPU7+ZyizE5StZAhb8HB58qo1AHrjtqKMvrHeA2lQzBSwUmSxrGLf6vklrMIxKFPKD
         3q1RzzYYKoMBJtsnZtGjGuGMi7gXPpTHaQm1HphMcnwyT9nqH+UfkCloZDTjhee2v4b6
         M3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ywHUGO64jj0iOjSPc8K8bxdiqVz6Jk6y0fFLT8K40qU=;
        b=GWhCY52WUHL9n892xAPfUI/8a3CWKjBQl1Vvg5lUiJTa1PbUwxxx4WOIiwPr3kWwSK
         8m8663iqUqy0ooIalHrvjfwiyGkYhmMdw8RLIrcZ9PzvAj6RmalxDreUgXyjMVdSdjYA
         ym7LrDFHB054tWE+aYjVIaVDuFNa/ftRl7vQD2b5TTQRkGC/bvhwNMTiEhkUjF4vppOU
         WK/rFCg+pmKUONWo8IrgY5ZzjKCAo85SoxrdaTCj5331HPaQwBA1E9VeovwDO3onhewQ
         45aSul1+ON9Yyxzm7O0SifO0zxPOtZMXN8mH968UBJiyPh7L0kt9lpqJAn+1DW12ld7y
         hppQ==
X-Gm-Message-State: AElRT7EBLkzP+Uy/uV2x0q0TNlCzAXaSQRdzdiAslYJHPnmbEoKR8Tzh
        uZMw8/l7XkioNfvnI5tBUAismYE4AYw=
X-Google-Smtp-Source: AIpwx4/NLzZ2DAgcdM/yT7/31KfOI0W6W0YttiRyav75kjWyQf4ELekT0J2ng8g2KsyqPhD/7cgZqQ==
X-Received: by 2002:a17:902:32a2:: with SMTP id z31-v6mr19902410plb.41.1522861293179;
        Wed, 04 Apr 2018 10:01:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id b184sm3835460pfg.110.2018.04.04.10.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Apr 2018 10:01:32 -0700 (PDT)
Date:   Wed, 4 Apr 2018 10:01:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        peff@peff.net, avarab@gmail.com, sbeller@gmail.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH 8/6] commit: use generation numbers for in_merge_bases()
Message-ID: <20180404170131.GD100220@google.com>
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404154554.140716-2-dstolee@microsoft.com>
 <14e4e1d3-5c77-dc7c-10d5-e9406b992f0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e4e1d3-5c77-dc7c-10d5-e9406b992f0e@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/04, Derrick Stolee wrote:
> On 4/4/2018 11:45 AM, Derrick Stolee wrote:
> > The containment algorithm for 'git branch --contains' is different
> > from that for 'git tag --contains' in that it uses is_descendant_of()
> > instead of contains_tag_algo(). The expensive portion of the branch
> > algorithm is computing merge bases.
> > 
> > When a commit-graph file exists with generation numbers computed,
> > we can avoid this merge-base calculation when the target commit has
> > a larger generation number than the target commits.
> > 
> > Performance tests were run on a copy of the Linux repository where
> > HEAD is contained in v4.13 but no earlier tag. Also, all tags were
> > copied to branches and 'git branch --contains' was tested:
> > 
> > Before: 60.0s
> > After:   0.4s
> > Rel %: -99.3%

Now that is an impressive speedup.

-- 
Brandon Williams

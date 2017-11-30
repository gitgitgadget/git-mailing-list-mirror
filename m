Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FE620C11
	for <e@80x24.org>; Thu, 30 Nov 2017 23:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdK3X0J (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 18:26:09 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:44929 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750923AbdK3X0I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 18:26:08 -0500
Received: by mail-io0-f171.google.com with SMTP id w127so9353069iow.11
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 15:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WDuE+IEkMupvyuP1PRmbbaNeqdRcUNnTKsrMg7jDiw=;
        b=DnGYCpbnWIjRySFp5HPr0xJ4tphnD9QXtRAmtfdpVJ/pqjNn6KS8U/6XlLU4SNYgtb
         ellj5YYHr6CXnfcazcnw3Y6OV6PhJO9KmJBNmnxlU9PUyX5theFMfRHoEeWfLsP1i3pg
         Ol5+kvA8a+IbTR+Af2vWuTmxLB0AwQIzwasYrc6OvnVEbnPLnI+0yOZWOvOMOphjRuAA
         fZZEw7DL30HrqaK5POL14HO4vg9FDkDHqrpOxNLM1xxT2zoEvv1HzZO2MWcLKYH7792O
         pyl8pQUnGS1qcc2ShLXBdZkNJF2gnIpNzke+bacYRZfepf+2I6ZTH39KYhtLvUQAfyqz
         bOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WDuE+IEkMupvyuP1PRmbbaNeqdRcUNnTKsrMg7jDiw=;
        b=k3+KEy2//kHA1sNkkvOVePvIdt2ZTuycPM2UqO7tRGpxWVKtOWwSgKDhduxbauCi8B
         aZRguq9MsR8vf6k0qQmaPDlYvFgc+s5YYaipXV3NYDlH4A4y4QC7FbD4K74UD1CNd4Bc
         KRW/oZF0SbaZOmACeyHug33I5yVHQ+It+rKaEbee5zaaFXEMqFngY1kaQErPsk3NMASI
         inzIeiXcEe6BGn8uLcFP69UnYyzAlolreSssSnzg83yLipO1PNzK7ceoDBPHnx0jW7mS
         ARA1+XduZg3NxZJFn8uGVB/SD70HMPkno1lcEHK/FxQ9oZpih1ijFzvB8KZJxQOMXiCF
         ZtQA==
X-Gm-Message-State: AJaThX41C1pgtK5B5K5aDVnUHM5WmOej6FHlPGOA4gzYTjPCHtC3w3vc
        laPRP+pRroH4PjZX3cp04pZA8f1R7yI=
X-Google-Smtp-Source: AGs4zMa277E+baudvgwf0U5LZ1OygbTtgozcV7UdE4vX50xflljpF/JqtA0Vn0Uo9unmwSmm7BH2Cg==
X-Received: by 10.107.43.16 with SMTP id r16mr9870855ior.172.1512084368074;
        Thu, 30 Nov 2017 15:26:08 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:f9d7:5b9e:50b:554])
        by smtp.gmail.com with ESMTPSA id 85sm2476932ioi.83.2017.11.30.15.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 15:26:07 -0800 (PST)
Date:   Thu, 30 Nov 2017 15:26:05 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitster@pobox.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3] diff: support anchoring line(s)
Message-Id: <20171130152605.1b775e9cc2ddd7f917424448@google.com>
In-Reply-To: <alpine.DEB.2.21.1.1711300134560.6482@virtualbox>
References: <xmqq1skj9o7r.fsf@gitster.mtv.corp.google.com>
        <20171128184703.155931-1-jonathantanmy@google.com>
        <alpine.DEB.2.21.1.1711300134560.6482@virtualbox>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 30 Nov 2017 01:36:37 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Jonathan,
> 
> On Tue, 28 Nov 2017, Jonathan Tan wrote:
> 
> > @@ -4607,7 +4627,14 @@ int diff_opt_parse(struct diff_options *options,
> >  		DIFF_XDL_CLR(options, NEED_MINIMAL);
> >  		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
> >  		options->xdl_opts |= value;
> > +		if (value == XDF_PATIENCE_DIFF)
> > +			clear_patience_anchors(options);
> >  		return argcount;
> > +	} else if (skip_prefix(arg, "--anchored=", &arg)) {
> > +		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
> > +		ALLOC_GROW(options->anchors, options->anchors_nr + 1,
> > +			   options->anchors_alloc);
> > +		options->anchors[options->anchors_nr++] = xstrdup(arg);
> 
> I looked and failed to find the code that releases this array after the
> diff is done... did I miss anything?

You didn't miss anything. As far as I can tell, occurrences of struct
diff_options live throughout the lifetime of an invocation of Git and
are not freed. (Even if the struct itself is allocated on the stack, its
pathspec has some elements allocated on the heap.)

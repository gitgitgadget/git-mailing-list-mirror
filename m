Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1E0D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 23:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeKNJES (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 04:04:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33696 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeKNJES (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 04:04:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so3775476pgu.0
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 15:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T1wTYIXrzQwvA7uVSij/cuQUnQEuNv5x0qEGPzkBY+4=;
        b=Tu65rpfOCcphUX6ONGyb6pvaxeqk01nMGYJ3iafD7bzcRPGuCZrBNZp0dkTGVJ0Jx2
         H5CEu4r/7UI9M76B6KdipDDnYNQLUJR/bnH4qGG9e3EhiDby9LndS2xTdII6Gsq3/Em0
         tu5Tndf/04wcbtDB/u9oR+I8tw7L+oY7ikwHjW9aj7wBTT3jL7V9Rj5rWrsRRswX1wyx
         /eiMGHYoK4YqwiG7IA4USw+SWLqpDjj0T5NCkwqRX/onhUFeapz2V9ZmPGXAHDTxNpNa
         A/2Uu70cd0it8vd3xLBCXnKli5aJ3bPTIwJNkJ7+dIS6yX8/v+74y8BvL/tlTQTSpsX1
         ucbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=T1wTYIXrzQwvA7uVSij/cuQUnQEuNv5x0qEGPzkBY+4=;
        b=MnvjlF0NMHmwGFbJFszMryFbZFyrWmkiUDGqrhG7oReLofO2ulaRDz8mtHTDVAjvMN
         vw5PMiuEoTe7VjhyAeftn4TDhP5bIZKHNV0K/gC+gzH2GWmd7H8jp/RCoFtzveQ4W/zi
         OqG10le/pevQnLYMbVJWbAdiQPBJpFulCkchxuJUIXkRS6u0OHs1iJjvcX3WOcO5MHVK
         X+JjjNUvA9N8QqJqO/4NVootblA2UKMoF8uJYeFE8GeKVfL7mN5Xp6PAVPtO58/j3YxT
         uMGXZcYjIRvyIareehvTTadacLku5CCLV2Uqz9fY3SLb8BTiNk66JS8xXKPaIPvJnCA8
         TVjw==
X-Gm-Message-State: AGRZ1gLxic5oOKnA7E4mi5I2SxRzgL3tT91q0nT8oLvIz7aOPDKovmTV
        S7o6cQ9lhW466ZHHi2KGvRQr5w==
X-Google-Smtp-Source: AJdET5cjiP1ShmZ9LMuFb9Y1ZBrT7xB9acVCncPQCUlhLBN5ik28UshdjN2epoRxYwiDcZhOtNsFJQ==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr6605265pgn.112.1542150233759;
        Tue, 13 Nov 2018 15:03:53 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id k75-v6sm56975994pfb.119.2018.11.13.15.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 15:03:52 -0800 (PST)
Date:   Tue, 13 Nov 2018 15:03:47 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
Message-ID: <20181113230347.GH126896@google.com>
Mail-Followup-To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        gitster@pobox.com
References: <cover.1539305180.git.steadmon@google.com>
 <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <20181113182802.GG30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181113182802.GG30222@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.13 19:28, SZEDER Gábor wrote:
> On Mon, Nov 12, 2018 at 01:49:05PM -0800, steadmon@google.com wrote:
> 
> > diff --git a/protocol.c b/protocol.c
> > index 5e636785d1..54d2ab991b 100644
> > --- a/protocol.c
> > +++ b/protocol.c
> 
> > +void get_client_protocol_version_advertisement(struct strbuf *advert)
> > +{
> > +	int tmp_nr = nr_allowed_versions;
> > +	enum protocol_version *tmp_allowed_versions, config_version;
> > +	strbuf_reset(advert);
> > +
> > +	have_advertised_versions_already = 1;
> > +
> > +	config_version = get_protocol_version_config();
> > +	if (config_version == protocol_v0) {
> > +		strbuf_addstr(advert, "version=0");
> > +		return;
> > +	}
> > +
> > +	if (tmp_nr > 0) {
> > +		ALLOC_ARRAY(tmp_allowed_versions, tmp_nr);
> > +		copy_array(tmp_allowed_versions, allowed_versions, tmp_nr,
> > +			   sizeof(enum protocol_version));
> > +	} else {
> > +		ALLOC_ARRAY(tmp_allowed_versions, 1);
> > +		tmp_nr = 1;
> > +		tmp_allowed_versions[0] = config_version;
> > +	}
> > +
> > +	if (tmp_allowed_versions[0] != config_version)
> > +		for (int i = 1; i < nr_allowed_versions; i++)
> 
> We don't do C99 yet, thus the declaration of a loop variable like this
> is not allowed and triggers compiler errors.
> 
> > +			if (tmp_allowed_versions[i] == config_version) {
> > +				enum protocol_version swap =
> > +					tmp_allowed_versions[0];
> > +				tmp_allowed_versions[0] =
> > +					tmp_allowed_versions[i];
> > +				tmp_allowed_versions[i] = swap;
> > +			}
> > +
> > +	strbuf_addf(advert, "version=%s",
> > +		    format_protocol_version(tmp_allowed_versions[0]));
> > +	for (int i = 1; i < tmp_nr; i++)
> 
> Likewise.
> 
> > +		strbuf_addf(advert, ":version=%s",
> > +			    format_protocol_version(tmp_allowed_versions[i]));
> > +}

Sorry about that. Will fix in v4. Out of curiousity, do you have a
config.mak snippet that will make these into errors? I played around
with adding combinations of -ansi, -std=c89, and -pedantic to CFLAGS,
but I couldn't get anything that detect the problem without also
breaking on other parts of the build.

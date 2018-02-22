Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BEC21F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeBVS0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:26:51 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:39180 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933521AbeBVS0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:26:49 -0500
Received: by mail-pl0-f41.google.com with SMTP id s13so3340697plq.6
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gsEDpm0wTAtWVPWjlQwaKn8RtI2uOOiRgWrjVVNEHYw=;
        b=b8BcDNADaEZq/qu5EfCSngKpjAAd6f8BeC5Z/kbVlTMELdRbfX5qfona7o+fMc06t+
         rT7o1lZN0RktL4+3WXNyRm1n2C+hptpXYncpx/W0XaePkeFuCv5j1nN/Mh3U3LOgkOLW
         Ys8CXMgGrUim7teyA6Ktd6qD8k7k7uNazQOEJrgAnwDyBL8Cb4kiP7WRV4MDr88zmyoA
         fNkjhHideJJdRSeQYodnbqYA6daBOd4hRgHhF2yhPRH9j4zyEkz1Eo1gBLC3ikndF7Q8
         W8/igDXcSnmHeX5jvYCaaiyI5+ElZfjV3H3uZ/ui2VTV5HTNxtyBFtsEltnssdkvw6pR
         A7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gsEDpm0wTAtWVPWjlQwaKn8RtI2uOOiRgWrjVVNEHYw=;
        b=HJCb7SweA4zVthzX4NiV+1YjGav3AbRMiPWS2IX1CERsbIzQz3Kztvv/QgaPVm9k0B
         Qn6xEjfv+OCvtY3VcWTqiqCiJpQKNqOe03ohfdLOJiSGruCuQxYfn5+92EBAlokn5JWb
         frFRWdCfaq/3Zj9qwF5T1deSz5x/z2dPNl7jCmKtWglqY4cSzpdDSh95jvIT4MUjhc8W
         utQPCC4bheJBredIZpG5qPdeDQceFKQG6z02TwHBmvj4na+B7/uIAgb3lxaTtCDXCRF5
         gJYtgSh3fgDP8ITYpULzREfePOCbOr7clLX/HkdlsTqdUoSZgx5zWy0fsdv9mrzEmbu1
         MJuA==
X-Gm-Message-State: APf1xPCY+gRlatYRClYfuAQAEGfZnKewTpccdpOTbSzMWI/8ya72HdRB
        zKF5uK84U6YgJqv1vbJTawXPoqmmYQY=
X-Google-Smtp-Source: AH8x224Hk+LHKRxErilbzX/jdVYrhZPRpQd60eVtyVS7QI3vOo2vk6STfWbNUWOjy2FsvH6Svzj4RQ==
X-Received: by 2002:a17:902:47:: with SMTP id 65-v6mr7289223pla.194.1519324009227;
        Thu, 22 Feb 2018 10:26:49 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r62sm1728144pfi.52.2018.02.22.10.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:26:48 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:26:47 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 16/35] transport: convert transport_get_remote_refs to
 take a list of ref patterns
Message-ID: <20180222182647.GF185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-17-bmwill@google.com>
 <20180221145804.f483fb21559f71618812404d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221145804.f483fb21559f71618812404d@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:53 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > -const struct ref *transport_get_remote_refs(struct transport *transport)
> > +const struct ref *transport_get_remote_refs(struct transport *transport,
> > +					    const struct argv_array *ref_patterns)
> >  {
> >  	if (!transport->got_remote_refs) {
> > -		transport->remote_refs = transport->vtable->get_refs_list(transport, 0, NULL);
> > +		transport->remote_refs =
> > +			transport->vtable->get_refs_list(transport, 0,
> > +							 ref_patterns);
> >  		transport->got_remote_refs = 1;
> >  	}
> 
> Should we do our own client-side filtering if the server side cannot do
> it for us (because it doesn't support protocol v2)? Either way, this
> decision should be mentioned in the commit message.

If someone wants to add this in the future they can, but that is outside
the scope of this series.

-- 
Brandon Williams

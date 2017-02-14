Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0EF1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbdBNSYq (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:24:46 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33280 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbdBNSY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:24:28 -0500
Received: by mail-ot0-f196.google.com with SMTP id t47so3058983ota.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mGIEB+8+KHwSGwtOIBO4S8IyV53pAuXe0t5xFnQ8gjg=;
        b=o0DUEdDfmKNYnGsrIqK94t0hWH3/vjky+MKUQcz1mm2hv6wgNMT/ptYArGrLB7dr+E
         St6rzW7dq2HHmlRpxrlD1dB3H6Cc4rRu0F8PbHP0eCi10QnvJP881FVTr+ZoUwR7TPzt
         Y8xzZzudmRz2n4QT+TPpYTIajtr7/qaDyifrXWJGs16diBQyRDMvoYX4rn4JHxV5ReYa
         GZDapu2rVb58EzZVcWfMJ7PhToPcqyOYcUoRct+FRFzqUDAnalOgPFakNVn0tRPHMNZJ
         LhtKsatZ2lDgU1O++sAOyM2zyNd5H7GEct1/bscOOPfPz+YbqxDNn/yRPZRq+ssYntLa
         ll5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mGIEB+8+KHwSGwtOIBO4S8IyV53pAuXe0t5xFnQ8gjg=;
        b=ueOeVmnTT9ENUvxKZfV4AtuIIrlPSs+Xd4Vov4SGURBnKsHekV9K7UguiMMv61RtZU
         JWv0pTck03eJSmJxgTgBUqLodZCfY4iDvMs7mBhJfTq+02VWqZz125qMr/HdoGw/7g1l
         +UXhazqgIu7NdLTvIwAKlMrskNlN2u04JErkGyaPGsJG/5QojvzvSLl8nNrOLPRUBv56
         P1LjOJXMqgX9r6VBM16ks4IRWtchsJOcxocqc0j/vuhCD6nVLpCanYi3JStXvuydro8y
         VO40LJ2ki6YeOoKp3AAKdeBdMhHvgJ+7Kdji1X8MIpxKrOj90OrzuGA1idWDmSQhEvlE
         Y40A==
X-Gm-Message-State: AMke39k+7Lx3305nt29jRUFRc6R3LlQnzEkKasVPPvZMgg35qsL1CX2pGZByZtbzAaA7tA==
X-Received: by 10.98.59.204 with SMTP id w73mr33329272pfj.73.1487096662277;
        Tue, 14 Feb 2017 10:24:22 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id e13sm2621485pgn.38.2017.02.14.10.24.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:24:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH 11/11] refs: split and make get_*_ref_store() public API
References: <20170213152011.12050-1-pclouds@gmail.com>
        <20170213152011.12050-12-pclouds@gmail.com>
        <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com>
        <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com>
Date:   Tue, 14 Feb 2017 10:24:20 -0800
In-Reply-To: <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 14 Feb 2017 17:04:06 +0700")
Message-ID: <xmqq8tp8aawb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Direct call sites are just middle men though, e.g.
> for_each_ref_submodule(). I'll attempt to clean this up at some point
> in future (probably at the same time I attempt to kill *_submodule ref
> api). But I think for now I'll just put a TODO or FIXME comment here.

So we'd have get_*_ref_store() for various cases and then will have
a unifying for_each_ref_in_refstore() that takes a ref-store, which
supersedes all the ad-hoc iterators like for_each_ref_submodule(),
for_each_namespaced_ref(), etc?

That's a very sensible longer-term goal, methinks.

I am wondering what we should do to for_each_{tag,branch,...}_ref().  
Would that become

	ref_store = get_ref_main_store();
	tag_ref_store = filter_ref_store(ref_store, "refs/tags/");
	for_each_ref_in_refstore(tag_ref_store, ...);

or do you plan to have some other pattern?

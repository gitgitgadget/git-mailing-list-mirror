Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B392013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdBOAoq (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:44:46 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36153 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdBOAop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:44:45 -0500
Received: by mail-oi0-f54.google.com with SMTP id u143so79601509oif.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yPJ/9rx5ZJPbTrn40m2T/Kn11PGaeR1Grb1XvVBTrAs=;
        b=tPC9wQvaezVx8nZkVYxrGxnLcp/Ap+dCY6ITxUNY8RfgUG/kSMbXqZQCcuwT6ycNlF
         fJskD0EKtgtKOYnPnqx1ftMm0oQ6JCEpkrkT8ZSlkPKtyoH9v4/GFlEgY57vK/MwJ7Tq
         HUdKsei9GiJW0rKXCJwbb/dTs7nCyzuRGO+epx7Jxl6khfnVFhLA8bSGF1E3JMp1MUcR
         wVxRcQSfNA/4H0DFYytDELbmi+k2Tbb+kekmxrCxiWhndu/1kThrRfRA5/5mWe2VCxxY
         jKYtmEI9crgI/7I8cXNo7duPkdNVF4w1q8ecfVcdKJr+32bhusxxAjASFFv+N5QqpgZx
         HNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yPJ/9rx5ZJPbTrn40m2T/Kn11PGaeR1Grb1XvVBTrAs=;
        b=by2tZQyqq1W+I1Q4bp2FFtFjqYaZhJksFUootDhwdlDBxcKxFya1kKteDyJdS96D20
         p+9Iqf2O/Hrk69jREzTD9tTEnFHD88htb4MK+pk2VlDBV7OC09UozBxBeceMMZjS7M9q
         n/fOgZMW2Jf2sxNoGGAgmLwMGMgGfuMBHbR/t4qKnk1DGv1nJ2raL00t8G2QL9hjnbbv
         mUZr6OKLoe8cwths61MqP6D/0CsHYu7EpuWCwdaSonOx6fOCGx+YXH0IvXxXOGex68uz
         VO3Qgu7bFQ2jxfvpav0X7LWb6Owfi8dVWgE1quaOrwTiPelOwZDC7lHVAGxYEbzcM48w
         Rv3g==
X-Gm-Message-State: AMke39njRYM+Z5uesOLnl4uZPKi8Ed08n1Zj9PgPo/WU2wbXXgiZJ4LdqouQfs7mqzrNSN5BunpmgvMTjAqEdA==
X-Received: by 10.202.78.214 with SMTP id c205mr18056383oib.65.1487119484998;
 Tue, 14 Feb 2017 16:44:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 16:44:14 -0800 (PST)
In-Reply-To: <xmqq8tp8aawb.fsf@gitster.mtv.corp.google.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-12-pclouds@gmail.com>
 <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com>
 <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com> <xmqq8tp8aawb.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Feb 2017 07:44:14 +0700
Message-ID: <CACsJy8AfwGK_Y8vH-mF4NXWts_4_CPZamO0L_rWD-1WR3=36Yg@mail.gmail.com>
Subject: Re: [PATCH 11/11] refs: split and make get_*_ref_store() public API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Direct call sites are just middle men though, e.g.
>> for_each_ref_submodule(). I'll attempt to clean this up at some point
>> in future (probably at the same time I attempt to kill *_submodule ref
>> api). But I think for now I'll just put a TODO or FIXME comment here.
>
> So we'd have get_*_ref_store() for various cases and then will have
> a unifying for_each_ref_in_refstore() that takes a ref-store, which
> supersedes all the ad-hoc iterators like for_each_ref_submodule(),
> for_each_namespaced_ref(), etc?
>
> That's a very sensible longer-term goal, methinks.

Ah I forgot about ref namespace. I'll need to try something out in that area.

> I am wondering what we should do to for_each_{tag,branch,...}_ref().
> Would that become
>
>         ref_store = get_ref_main_store();
>         tag_ref_store = filter_ref_store(ref_store, "refs/tags/");
>         for_each_ref_in_refstore(tag_ref_store, ...);
>
> or do you plan to have some other pattern?

Long term, I think that's what Mike wants. Though the filter_ref_store
might return an (opaque) iterator instead of a ref store and
for_each_refstore() becomes a thin wrapper around the iterator
interface.
-- 
Duy

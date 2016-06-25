Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6611FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbcFYQ2T (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:28:19 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36566 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcFYQ2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2016 12:28:18 -0400
Received: by mail-it0-f46.google.com with SMTP id a5so37357213ita.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 09:28:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9gyOSRObQmN4Adcq22SA+Nd3XE1GkgEpyRhQUaGAjak=;
        b=KrVjpxJQJSyKgg6hfvUU68JiTZTwRTArcFrZiOB9dD4GHCslAzDgcPWa9kzA0CB7Cf
         vTKO3LP4X8UITNe8koJeGdfmg2jCNVdioZJ+3BekgPhByjHDQNolxjsDYnapDG91YiMN
         ZKAwczMngD3gQs646NcN6qRz647BisPsWRAQbLaWTIM4eE/8OQ/6Ybq6mps3Ca2m0qFD
         pSaB2okUi0EBlNEYlnRdjmMTalZ3m79LEgunYkPYMjdifuEmX8n49H9n+GcrG+Jm3IVA
         HtFlEITDPrAZgipbCsHQ8xut6Xo5B0xHGTlYIois/CEZTsPLdN7kaPI41CEA5uLYNwD5
         iE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9gyOSRObQmN4Adcq22SA+Nd3XE1GkgEpyRhQUaGAjak=;
        b=lSlJ7VZ/tkQ8iNFcmaGoaMjIhbfblC5ji8zSovSv6Z+DW975zw0Hnb+EHsIqn8JAse
         hjnTJ6G9PnlhAZ4sTqw2GhDtR6jWUVWrUsRKoqlJNW+CF64H4/kjMv1E0Iuutr4C6SkR
         ChvDgrPPvsMgMxJqsZthA62lDb+MzjoV1N2paDF7KKvp8nYvjMnzBrdQF8RSWsk8jA/M
         WkTPouT5JXRMuIFnCJoiuZ2nCLuPLgMf+YRyhH59V2ethakk8qwEF5jCzKElmaN9IL/I
         EQC7MuA2ktw49elqvW0iQLau/uyFaNZJwv2P1g7c1Qzy20P13dNRw91HYJzuUR4gYuvb
         7rtQ==
X-Gm-Message-State: ALyK8tJY01KvqWfHoPxgJ2m1ho8bIQkmR/iOI6yoMm6TDJAEoTkcJxKQv12MhiR8mjvU926cLQ6fhAHz/j67Mw==
X-Received: by 10.36.130.130 with SMTP id t124mr2833821itd.42.1466872098231;
 Sat, 25 Jun 2016 09:28:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 09:27:48 -0700 (PDT)
In-Reply-To: <1463694357-6503-12-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-12-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 18:27:48 +0200
Message-ID: <CACsJy8DYTcF_W+5K9uAHuqqBFu8J=xj7VRx-aqM6Dtc2+GmS1Q@mail.gmail.com>
Subject: Re: [PATCH v12 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> From: Nguyễn Thái Ngọc Duy <pclouds@g
> +"poke <path>":

The new format is "poke <pid> <capabilities>".

> +       Like "poke", but replies with "OK".  If the index has the
> +       watchman extension, index-helper queries watchman, then
> +       prepares a shared memory object with the watchman index
> +       extension before replying.
> +
-- 
Duy

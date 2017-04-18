Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841B81FE90
	for <e@80x24.org>; Tue, 18 Apr 2017 07:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755598AbdDRHoA (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 03:44:00 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33284 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbdDRHm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 03:42:28 -0400
Received: by mail-lf0-f46.google.com with SMTP id 88so29240188lfr.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xCJi7ftklYLzjXaV0oeOGNjeTg3k23sF/7AHvd+QPxE=;
        b=bjBRMqy0cdtMIktLyAT3MC7XQOUYGPIQAtlQWvFkTEsxFvZsvIth00N7450sdQ4iyO
         wwpzJQcvV7qpS/McTtZzwJWCdHeH5Dy6B45UUOJ4JmpBWiEQUDPjML2BPYAqfFGvwJfs
         aO2fIFMK6PAMwRRDTES7LeYfNCgCgVk1PlqaNFGsl78zYDHBwSL7RHyfPrcsRf9+VdnB
         vmu6uAvOU0OrX0KzaZQKtTXL478EuxgQm13JS14upaefnBoofHppkwDf3fjBXALNG8QD
         eXSP4F8x1T6eZnwJI5YGAr85oEGFR5iuf5dbTEay+hF978iN+Rz4+2UwbxEj2T0w7Grh
         pl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xCJi7ftklYLzjXaV0oeOGNjeTg3k23sF/7AHvd+QPxE=;
        b=EZtWFfYaqHAFoeCZRquia8GCaZjRw5G1iybBiW5jhJImEmNCj2NkemP09r3h0AwQVX
         3d90xrQxn3FQgKlTaToqVBtHJJSRWeLkSqNJttRIyWDbEhKg0eYsi6f+/7AwI1gdi9aa
         A5eizzFJ3aOLBEvonEUOn1ZAIB9zuX/b400JnDQiBuYqS20oIc8xdUo0VaZh3lzORLsR
         EbQdxF9qQB1yjWvdORcLVBoXr13dxzExCtvLQNdaPJAa7nYD/4ZqZc5Vt8BbB1SIXETv
         xs8vY+qQWbEo1grdp2fzBfAQbvB3B2X9BQL9aGFtZsYxipxzhMCkHDVTZ/Z1GU58f/pC
         Xepg==
X-Gm-Message-State: AN3rC/573mpipuZM6it4RLigLBvdXbNbk0ZdSCVSY2bP4FRbdHsUULmn
        7WL1bO1ENc9xXkvgSF33OFCUcDNcxA==
X-Received: by 10.25.153.137 with SMTP id b131mr3377912lfe.114.1492501341482;
 Tue, 18 Apr 2017 00:42:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Tue, 18 Apr 2017 00:42:00 -0700 (PDT)
In-Reply-To: <xmqqk26ih3qf.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413171224.3537-2-jacob.e.keller@intel.com>
 <xmqqk26ih3qf.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 18 Apr 2017 00:42:00 -0700
Message-ID: <CA+P7+xoSszSrHCijG4gDE6r_Eo-AeAk2zsecwpAW_KEdBiLWuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: fix path used when recursing into submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 7:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Don't assume that the current working directory is the root of the
>> repository. Correctly generate the path for the recursing child
>> processes by building it from the work_tree() root instead. Otherwise if
>> we run ls-files using --git-dir or --work-tree it will not work
>> correctly as it attempts to change directory into a potentially invalid
>> location. Best case, it doesn't exist and we produce an error. Worst
>> case we cd into the wrong location and unknown behavior occurs.
>>
>> Add a new test which highlights this possibility.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> I'm not sure that I'm convinced by this method of solving the problem as
>> I suspect it has some corner cases (what about when run inside a
>> subdirectory? It seems to work for me but I'm not sure...) Additionally,
>> it felt weird that there's no helper function for creating a toplevel
>> relative path.
>
> Is this a similar issue as discussed in a nearby thread e.g.
>
>   <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>
>
> I do think it is a bug that sometimes we do not go to the root of
> the working tree when we know the repository is not a bare one.

Yes and no. I think that this would be a problem in both a bare and
non-bare repo ? I think the correct thing to do here is really to do
what we proposed, and properly lookup the full file name.

I do think it makes the most sense conceptually to always cd into the
top level directory of a non-bare repo though.

Thanks,
Jake

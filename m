Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C7E1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbcHCWab (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:30:31 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36197 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932380AbcHCWaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 18:30:30 -0400
Received: by mail-io0-f173.google.com with SMTP id b62so256874860iod.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 15:30:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xPcP6xSidbfPtumEf+P6tNpjMt+LbIWM+eR7TOQok6U=;
        b=BtmG1hU19uV17S0698rALES2yI6AbLadSHmiljjCGmndPtb+hl33r7Rfiuf8vWE4Uk
         Gh/FhtIbMVD20dEgh5GG2ax2gdrZbojJrQ7cm+CFxBYIu/0MW1VQGsTk6PrILENhuOEk
         Sx6DwfmVbxatO4gfx3SPZ5Oc+pqXYj5WQkegoHd9i2DpREu/QJaPzGp7JWbix5bLQ2rY
         BzFEEp4ScmqoAkmWoYHBq2uHBnrNNq+mbhEBC8wZlcwILfM+fb2OoUo2kKQZXiV6PlfF
         4AuMq+GjnqT1em7bpV1RGRKJ8VIQm/mvQh2Z/Jn61kPQ0nQ63O5OWXI85dd5WE8lJlph
         mdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xPcP6xSidbfPtumEf+P6tNpjMt+LbIWM+eR7TOQok6U=;
        b=E9koDl05sZ/ex8dIZSZcmr/YJlus2BoTxaqEYAohUE995YgcxVzrI5fAwrjAO0comM
         sZHvRCFwJkmLk8pKvAlAG6biOhC168d/mzgqpQkUFxFxyaG1FE4H6N/7oU2QUBEFzb3/
         nWaeL8nePJkhsTjEjKqKqjlN+S/CPT6vrW+FWADkp93em3PR3D17T2/uNbcP3xflte4w
         TzyJUZ6DAK2LfA9QbWZt6sPqjFN+xioMTZI5lK4iAK2eV3EFOGv87GpCq0SC1F9lUeR4
         bgtdbeIk7O5Z5DVZ2rmedxcsrB+ZrtqBNGDCU5alZ4RGHZQq9iFkWM1psdfXHDS1x0bQ
         qmQQ==
X-Gm-Message-State: AEkoouuMHXzmUQ2lMa8uNVmY4ZoQwLQn98l4MeLl5Lpi6dCMJlFemHpFvZH7KCsNzwUxz13e9La6nk5Gw9/a6C3h
X-Received: by 10.107.131.38 with SMTP id f38mr73224304iod.173.1470263429225;
 Wed, 03 Aug 2016 15:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 15:30:28 -0700 (PDT)
In-Reply-To: <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 15:30:28 -0700
Message-ID: <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 3:00 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> +        return 10 * score - bonus;

Would it make sense to define-ify the 10 as well
as this is the only hardcoded number in the
scoring function?

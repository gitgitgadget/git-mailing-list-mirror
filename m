Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A06120209
	for <e@80x24.org>; Wed, 28 Jun 2017 03:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753585AbdF1DmD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 23:42:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36363 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdF1DmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 23:42:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so7216766pfk.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 20:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/dxqzKexv3BnLGVHW06G0S0oGsaJOmmGe7IPWTxc2FU=;
        b=Vmz+ZQSO9cI7mpMS+fbOKMrU/DrOPrqZM1pP1sOD0vkPuhQDGKDVptVa8TSyKOjuQ6
         1Vhm/9OVhNPe2QGnz+VbDXWsz37CdPbiL9bHDJw9ZwmGL0lWeSTQ8IpNnDWeo60SqS1x
         H410eMzcTnOL3rZ+iMTh0cdkU6hA3zSyIAGUIXiCIdfBXv1JoAr5n1PO4YObvoy4NrIy
         8O3LunrqUpcpmPHRtgd2Prd2OQWp3NJa2fG9JW4brjPQD6f4KmWCHWA6cPmkFneVxxBN
         infisZyEO/+1p5yALDuzAEQS2Fxi0UaZ3d2YZtUCgcqiGOg6JqQ6NjEmHuNaDF4WUmbg
         FBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/dxqzKexv3BnLGVHW06G0S0oGsaJOmmGe7IPWTxc2FU=;
        b=Xm92E+0Ms6ThhS1FBvFUuNKg89FB0LmQIpfH2ouvedsiDviQmVMNME33MZEak9UYmu
         SYkULQOwhIb3pOWJnoMaVX+AJN26LIrAu4/R+D36rIds2WR5qwA076qQmFL7x4xTSjLR
         J5lzzR9F4laNHXWdLyNv8LlBxDkcfG3Gi8yRKhaNmqboDN3CSGdte8RDWgJeCmDzG1d5
         WYryjvOemxd8PSgMBb/EOjpEQJE9Go7KL4qh8YBeXVBTn3O4x0amdSkche+aP/UgO2l3
         i5/MTU9y5zRFXedcr66V1mBph9pIi1HYZiIFycs6QRzUbMiETdjC3AGR4vFh8kvLQWUH
         h9ZA==
X-Gm-Message-State: AKS2vOzKO+y2nZfRzJ9Pvn+LxJNooS+E4CGfxp0t103WwEq017oc+nlR
        JqmhTbjL/+ZAPQ==
X-Received: by 10.84.253.1 with SMTP id z1mr9667608pll.114.1498621321028;
        Tue, 27 Jun 2017 20:42:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id t23sm1122250pgb.25.2017.06.27.20.42.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 20:42:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net
Subject: Re: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
References: <20170628005651.8110-1-sbeller@google.com>
        <20170628005651.8110-7-sbeller@google.com>
Date:   Tue, 27 Jun 2017 20:41:59 -0700
In-Reply-To: <20170628005651.8110-7-sbeller@google.com> (Stefan Beller's
        message of "Tue, 27 Jun 2017 17:56:51 -0700")
Message-ID: <xmqqshikye0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Reuse the compare function from the hash map instead of calling the
> compare function directly. Then we pick the correct compare function
> when told to compare ignoring white space.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c                     |  3 +--
>  t/t4015-diff-whitespace.sh | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 1d93e98e3a..4bcf938e3a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -903,8 +903,7 @@ static void mark_color_as_moved(struct diff_options *o,
>  			struct moved_entry *p = pmb[i];
>  			struct moved_entry *pnext = (p && p->next_line) ?
>  					p->next_line : NULL;
> -			if (pnext &&
> -			    !emitted_symbol_cmp(pnext->es, l, o)) {
> +			if (pnext && !hm->cmpfn(pnext, match, NULL)) {
>  				pmb[i] = p->next_line;
>  			} else {
>  				pmb[i] = NULL;

I presume that this makes the use of emitted_symbol_cmp() vs
emitted_symbol_cmp_no_ws() consistent with the remainder of the
file.

Looking at the implementation of get_ws_cleaned_string() that is the
workhorse of emitted_symbol_cmp_no_ws(), it seems to be doing wrong
things for various "ignore whitespace" options (i.e. there is only
one implementation, while "git diff" family takes things like
"ignore space change", "ignore all whitespace", etc.), though.


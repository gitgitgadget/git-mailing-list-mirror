Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7B81F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeBUVsk (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:48:40 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42743 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBUVsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:48:39 -0500
Received: by mail-pg0-f65.google.com with SMTP id y8so1179558pgr.9
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=45N5C9nBtoTXVtXEyQI59XvD/7rkjymwaZ4JKwrk07I=;
        b=eZvo/I3uLkemByj/qk3kp0FrLMR6dhbYNF1vRAjPYJZaI8izy9yxS7Ci7huL5CSPqx
         8LUDiLT6RbfKxrgogclrXC+FkIcy/hcEnWb2NWvbcI6ECflXyGHgXKGhWbQPbjrXEGGY
         HGwfGyo4ZKyd16rj8A6xoKpuFyeoF427GKJjc+2fAYe/9Zp1u5eVNE0+N19hNezEfxLA
         QSsuEH7T5aOHOkYeyGAIls+qQ/RpO/uYI54tAownRcXa01iOJapLaC9Zoef/X0RoeeRi
         UB2+CnjKzdwZ+sE+2ZYXciyIHKU+c++qgPmVuiKLK14c7AyB2VkInrgBArypmDxzw2K4
         dlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=45N5C9nBtoTXVtXEyQI59XvD/7rkjymwaZ4JKwrk07I=;
        b=rhsBM2Yq1bzOqiMNw32CSJlCA1PM13jq8p6ssqrkUH5d5CricSu2hsURPrW2DAHUjP
         TrYA0/IPXsZI/RiNvmHOSKm8VgKdVF+s5YQ15Z9nf0oJBv6lE5SiFEoZZVjbM57NbLH2
         LwUqaYDPr5ZIFC9XueNFeWos6vybJXp8AuHCBeSQp2eqi65UzOkUM6zMg4ucueoFtXQ0
         zYT8Zr6Yz3LD3z0JG7sHwNzxpoVw6COAghU2xgrL0GBQKzswy8ZrH0v2USjA2PvcWeLz
         NAALdMo81qwoGpdqgmt1/0ddHnvfGSmJADjTN95L/8g1C2PvkrRUTtPq1fshrwljq8kO
         eeag==
X-Gm-Message-State: APf1xPB7JAZZhJ9ob2MYY1RhGNC9q5vTgPeQbxqtuC9C21Xm3o1qyt2J
        M4m+cbgEXxLgVcVWAYH5zxsP1psB
X-Google-Smtp-Source: AH8x227ZUjdjRaDXOWvMyCGIISz4i9zT43w8eQND51WUwXqi0fkR7ZVakQxnc2NIxXg5+iOVrqpbiw==
X-Received: by 10.99.60.8 with SMTP id j8mr3822877pga.209.1519249719092;
        Wed, 21 Feb 2018 13:48:39 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f190sm46075360pfb.158.2018.02.21.13.48.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 13:48:37 -0800 (PST)
Date:   Wed, 21 Feb 2018 13:47:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH 04/26] upload-pack: convert to a builtin
Message-ID: <20180221214755.GA10327@aiede.svl.corp.google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-5-bmwill@google.com>
 <CAGZ79kb2=uU0_K8wr27gNdNX-T+P+7gVdgc5EBdYc3zBobsR8w@mail.gmail.com>
 <20180103203956.GA44365@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103203956.GA44365@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 01/03, Stefan Beller wrote:
> > On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:

>>> In order to allow for code sharing with the server-side of fetch in
>>> protocol-v2 convert upload-pack to be a builtin.
>>
>> What is the security aspect of this patch?
>>
>> By making upload-pack builtin, it gains additional abilities,
>> such as answers to '-h' or '--help' (which would start a pager).
>> Is there an easy way to sooth my concerns? (best put into the
>> commit message)
>
> receive-pack is already a builtin, so theres that.

*nod*

Since v2.4.12~1^2 (shell: disallow repo names beginning with dash,
2017-04-29), git-shell refuses to pass --help to upload-pack, limiting
the security impact in configurations that use git-shell (e.g.
gitolite installations).

If you're not using git-shell, then hopefully you have some other form
of filtering preventing arbitrary options being passed to
git-upload-pack.  If you don't, then you're in trouble, for the
reasons described in that commit.

Since some installations may be allowing access to git-upload-pack
(for read-only access) without allowing access to git-receive-pack,
this does increase the chance of attack.  On the other hand, I suspect
the maintainability benefit is worth it.

For defense in depth, it would be comforting if the git wrapper had
some understanding of "don't support --help in handle_builtin when
invoked as a dashed command".  That is, I don't expect that anyone has
been relying on

	git-add --help

acting like

	git help add

instead of printing the usage message from

	git add -h

It's a little fussy because today we rewrite "git add --help" to
"git-add --help" before rewriting it to "git help add"; we'd have to
skip that middle hop for this to work.

I don't think that has to block this patch or series, though --- it's
just a separate thought about hardening.

Cc-ing Sitaram Chamarty since he tends to be wiser about this kind of
thing than I am.

What do you think?

Thanks,
Jonathan

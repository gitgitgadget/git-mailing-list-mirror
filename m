Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CB620954
	for <e@80x24.org>; Tue, 28 Nov 2017 17:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbdK1RQh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 12:16:37 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:43186 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbdK1RQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 12:16:35 -0500
Received: by mail-pf0-f174.google.com with SMTP id e3so201569pfi.10
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 09:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=i6Noh2iv1TOo+fqVpJZIJsZrLRkPl4SQ0pNgw6XEUKA=;
        b=Wc50lblzpEKqyeNLf70Aq1/xg0FYWVmbyHluEzePdWNrsaZr3S5bFxMNXe6+BwuAV9
         kQKb62/d9ChWJxC0eL8Pxi1JOisaPVrjOdVslsX1f6+bEv9Qd9MddrHPwNVrkU+cu/f9
         5xO2BxD+96FqrheS887Fp+fCW7P5SCZwcuDaMS1lSgygvTBm9GJ5RSdoSeuI3rUMdiIQ
         bejmu7nqIx5Y1xAdmz54sqf67Qb010+qvh8Isj96y24Gc5MFpF/jYb7Wrn+0WhuAfdF+
         dahCNwS12KlVMNip+zltKfzpYWs2n3LroeMLKm5gMK4wTtzDyEnGtf2IKdziigUzz52L
         efJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=i6Noh2iv1TOo+fqVpJZIJsZrLRkPl4SQ0pNgw6XEUKA=;
        b=KE43Qs3treAfmVMhmASJUwuErokIKrKOVZjq5519Uf3qXGJurWvk2NQzviACduWCVe
         28eaMHNmryNcHHx2ZIHDgBekrOBSA9sm4a2GPjTdhsj2v5hkn+HINdlePXaRktQr/vAz
         RFy3f3N6mhLq8BZ23DcTn6Chw8Tjv3dNKB74DyEX5+KKIZV8i5nuDcnrwvQMeJWh6KnJ
         tzOIday3rTmcnYQ/YBlO3F2tiA+NPHWP4TTbuy6wQWuaStYO7FxT3n5enjmi04T7l4I9
         etC7cGq0imrAlupxogLka0XY/zpgdLKdLtBpx6rUVS7a/kBs6MuBo3RXY5XTW/ObuYQm
         qLtg==
X-Gm-Message-State: AJaThX71gHGdbVgSBVfS8RFfqfqrt9oFavLCDK9G7sXTf5zbCtcDZHV1
        xJQktlO5szenRXsBINLMZKmyAE5AAGw=
X-Google-Smtp-Source: AGs4zMaz6nfzOGUxwqKeq2laHCiQRDsXIzz6XlCnB0hXefHIBmYqVT0NCwFS+nhe/HFfxWX75NNFEQ==
X-Received: by 10.101.101.143 with SMTP id u15mr35136537pgv.106.1511889394814;
        Tue, 28 Nov 2017 09:16:34 -0800 (PST)
Received: from unique-pc ([2405:204:7344:993e:9a3:d467:14f5:495b])
        by smtp.gmail.com with ESMTPSA id b187sm20497225pfg.109.2017.11.28.09.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Nov 2017 09:16:33 -0800 (PST)
Message-ID: <1511885730.10193.8.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] rebase: rebasing can also be done when HEAD is
 detached
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
In-Reply-To: <xmqqlgir8770.fsf@gitster.mtv.corp.google.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
         <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
         <20171127172104.5796-4-kaartic.sivaraam@gmail.com>
         <xmqqlgir8770.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 28 Nov 2017 21:45:30 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2017-11-28 at 11:31 +0900, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
> > +		if test "$branch_or_commit" = "HEAD" &&
> > +			 !(git symbolic-ref -q HEAD)
> 
> Did you need a subshell here? 

No. That's a consequence of me not remembering that I would span a sub-
shell with a simple '()' when I was doing that part. (partial
transition from C to shell)


>  Now with a proper test with
> "symbolic-ref -q HEAD", I wonder if you'd need to check if the
> original was named HEAD in the first place (I do not feel strongly
> enough to say that checking is wrong, at least not yet, but the
> above does make me wonder), and instead something like
> 
> 	if ! git symbolic-ref -q HEAD
> 	then
> 		...
> 
> might be sufficient.  I dunno.
> 

It does  seem you're right. The only thing we would be losing is the
short-circuiting when $branch_or_commit is not HEAD (which I suspect to
be the case most of the time). So, I'm not sure if I should remove the
check (of course, I'll change the check to avoid spawning a sub-shell).


Thanks, 
Kaartic

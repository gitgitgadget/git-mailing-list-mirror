Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2062018A
	for <e@80x24.org>; Tue, 28 Jun 2016 19:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcF1TB0 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 15:01:26 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:36464 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbcF1TBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 15:01:25 -0400
Received: by mail-it0-f49.google.com with SMTP id a5so100457408ita.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 12:01:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OE9MQa0YM7/dFXgtceo8n1gmhgEdxM5Ut5iLmN7v2Hc=;
        b=ni5czs+Q3RXAnhD6v2OPnS9E54A9VaNwO2H1GKVGAxwKMgRnmo6lREZSABxJlUTD0M
         OQ+krpFuqGuegoYgq4YR4KSLwgopqxFm94CRM3dYZL0Fm7m91uyh4YSxWK0bpfb38YNB
         WEYPtG/PHpU9f8v3SUFInJ1PJtrGw1gPI3uPSe6jooNNEXQFjxMfzDjmSfj7IXlKrew2
         95XXPoSTXUnZ46hA/ooOmVGyIEecXDrfnfTtgA2mSQd2AkEE47drBqQpmn0lLvuwk7/K
         N3FG0aYyLPBcZEWRaUMNcNWKefgwzdB+pJtNfBsdr2/BKXaNRxz4awgiMqQp1EdR5V7J
         1/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OE9MQa0YM7/dFXgtceo8n1gmhgEdxM5Ut5iLmN7v2Hc=;
        b=EKD+rnHEcngzZGUdYT7L/Ive83asDGlsJu2qEsLivWUrWJEpX71PclLT1qRIverRPU
         VgV9otT8EE/ZBNFu6PUHv4xPLT9rHCU+ZlrLX69FP2mtMs13WhUvjHUOPlVoqwqxA7Cd
         ul+Ox3tBqH+b9jtxOhHn38gd4pF253z4S1aWZdDqMmK3WB4K2OYmz1vH2J2s1SO1IKZT
         VtM+7JCqx8diLTFMpCzp4rtd0bweY1HlHhV1F1EnieGU+GGj2DhtK1FMMlcht4mUsw9k
         CXtpmUszjxfjn1dn0RScStaMDKKw4DNOvAdbYTZid8ndoqNx59ml7WYOPqgvfZBVYaot
         yCGA==
X-Gm-Message-State: ALyK8tJC1R6TpgC8kdImjLvSBXvKEUgXTDEud8v8e7MDIWb0vA62TA2wLLzTV7bwBjwVSEciRFStnTN/qGxLBw==
X-Received: by 10.36.55.138 with SMTP id r132mr16685872itr.73.1467140471887;
 Tue, 28 Jun 2016 12:01:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Tue, 28 Jun 2016 12:01:11 -0700 (PDT)
In-Reply-To: <xmqqtwgd8ab0.fsf@gitster.mtv.corp.google.com>
References: <20160626111635.6809-1-pclouds@gmail.com> <20160627193322.GB10877@sigill.intra.peff.net>
 <vpqwpl9yal3.fsf@anie.imag.fr> <xmqqtwgd8ab0.fsf@gitster.mtv.corp.google.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 28 Jun 2016 15:01:11 -0400
X-Google-Sender-Auth: oxAnl8nn2iM6UiqR944L5c9ReNI
Message-ID: <CAPig+cRtmk_yukPGOTOn7CR7U_FY=ThbaMEc632L=yYz98zhVw@mail.gmail.com>
Subject: Re: [PATCH] connect: read $GIT_SSH_COMMAND from config file
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Let's then squash this in.
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -444,11 +444,11 @@ This is useful for excluding servers inside a firewall from
>  core.sshCommand::
> -       If this variable is set then 'git fetch' and 'git push' will
> -       use the specified command instead of 'ssh' when they need to
> +       If this variable is set, `git fetch` and `git push` will
> +       use the specified command instead of `ssh` when they need to
>         connect to a remote system. The command is in the same form as
> -       'GIT_SSH_COMMAND' environment variable and is overriden when
> -       the environment variable is set.
> +       the `GIT_SSH_COMMAND` environment variable and is overriden

s/overriden/overridden/

> +       when the environment variable is set.

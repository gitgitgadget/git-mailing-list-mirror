Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12AE8211B5
	for <e@80x24.org>; Tue, 29 Jan 2019 23:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfA2XMF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:12:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40860 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfA2XME (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:12:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so24015149wrt.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8/1WBLSuGA7QF2FR48ECDeboe8CFVvg20J9SXAZXMCs=;
        b=vg55bAmpnnuOgiJuMTSQaIFI/+B9ne65RENYTbyrMgs9lhbvReVAzn5zgB5vdFxrLl
         TgQCeZHGLQpi08ZxGuKSZzJBzaxpNvAI9tLqxi3ol6F4oSAn25PuuM+OhWE2VMu1AWPP
         Zebxpr9WbGunsBjLlZK0ylBxYbPS9khL3d7GFDD4J50220hqSHnFuD7vFz9cQuq9J0Q3
         JPqVpaa7wYb1EGb9ZO470+CLqsuTpMv2ToOGgzWD0B9TLxLsVHkHVmglFcMSFpSP2R8h
         A5yrHmg2sA6LsDYwWMF6Z77QDl556lEU9eTNRE7Z6zB4n4fDX2ZPuKGoq48/wg9S+qRK
         p8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8/1WBLSuGA7QF2FR48ECDeboe8CFVvg20J9SXAZXMCs=;
        b=MoYH/wQc0iDiEXMNb6qhNI/LMFCbgsniVedR2gNtlhtNCP7bp4ZpvEbIy0NJ495Q5D
         wscQK+FTw28c39NwwNfr2TAddsaitgvVpD95QR8aPtuDHTbtmq7GCEjC2XGh5dSVzsMV
         vibI056nWE9+lFKsOtYy9QRPpBNWgh08jpK5p4E2G3oD/zLzylP/bk5j2ZTZcNYqeUlc
         FInwHCv/BNKa+JyVB4iMvEX6fVs+fb/SNMuB/dLoznVcx2g7bWJGlwmndXkv7Nv0MdGG
         ZYDXYFPbVhaPdbtkR2UsEFaHztt6Zde98WeUtJjv4+7eGI6ZBa8xKlUKYcQVQ8mKbCsF
         aYRg==
X-Gm-Message-State: AJcUukdPO8doGLEPsHVYNASgoZDdWyBmAYv0ezu3SQmLJ32k4SBMGEmx
        UITS8HuDPj6CeAO5hgAPdUU=
X-Google-Smtp-Source: ALg8bN6FMOy0ejpG0Up9z/Dq85jzrfb66JZ6CklzVbVA2/WVHh87nNj61umU3wc2XNeD0ue3nyk0gg==
X-Received: by 2002:adf:82f1:: with SMTP id 104mr28932496wrc.131.1548803522634;
        Tue, 29 Jan 2019 15:12:02 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g129sm144030wmf.39.2019.01.29.15.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:12:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, peff@peff.net, Matt Wright <mww@apple.com>,
        Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: Re: [PATCH (Apple Git) 11/13] Fix problem found from running the test suite.
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-12-jeremyhu@apple.com>
Date:   Tue, 29 Jan 2019 15:12:01 -0800
In-Reply-To: <20190129193818.8645-12-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Tue, 29 Jan 2019 11:38:17 -0800")
Message-ID: <xmqqk1in5a9q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc: just forwarding to the area expert]

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> From: Matt Wright <mww@apple.com>
>
> Signed-off-by: Matt Wright <mww@apple.com>
> ---
>  git-svn.perl | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 050f2a36f4..d29730be3b 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1815,6 +1815,36 @@ sub complete_url_ls_init {
>  
>  sub verify_ref {
>  	my ($ref) = @_;
> +
> +	if ($ref =~ /^(.*)\^0$/) {
> +		my $baseref = $1;
> +		my $p = "$ENV{GIT_DIR}/$baseref";
> +		$p = "$ENV{GIT_DIR}/refs/remotes/$baseref" unless -e $p;
> +		$p = "$ENV{GIT_DIR}/refs/$baseref" unless -e $p;
> +		$p = "$ENV{GIT_DIR}/refs/heads/$baseref" unless -e $p;
> +
> +		my $resolved = undef;
> +		if (-e $p) {
> +			open FH, $p;
> +			$resolved = <FH>;
> +			chomp $resolved;
> +			close FH;
> +		} elsif (-e "$ENV{GIT_DIR}/packed-refs") {
> +			open FH, "$ENV{GIT_DIR}/packed-refs";
> +			while (<FH>) {
> +				if ($_ =~ /^([0-9a-fA-F]+) ((refs\/)?(remotes\/|heads\/|\/)?$baseref)$/) {
> +					$resolved = $1;
> +					last;
> +				}
> +			}
> +		}
> +
> +		if (defined($resolved)) {
> +			return verify_ref("$1^0") if $resolved =~ /^ref: (.*)$/;
> +			return $resolved
> +		}
> +	}
> +
>  	eval { command_oneline([ 'rev-parse', '--verify', $ref ],
>  	                       { STDERR => 0 }); };
>  }

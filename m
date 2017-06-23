Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C34020282
	for <e@80x24.org>; Fri, 23 Jun 2017 18:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754851AbdFWSz3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 14:55:29 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35028 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdFWSz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 14:55:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id w12so6417172qta.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 11:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qNRgHWrp6karh8hWnUglLzHlUcCwi1+kY7umvTEOkPU=;
        b=KgdV2cBKgB9QhIOJXF8x3zNaq4i9yVfaD4ZeUQZUPgvKaEDEQB15q7j3L6O8OS3f/X
         K8oVIGYZ4N226RuOXXMIJq7obDRTogNdpcxrB5Btmel/Q8+2ICwOROMbVLwqxEmJ90+S
         6mSjTyTj8iIohbHQV+e5OyGYXxKD6CP3gQZAZzN8sq0Ugn5FmjkDB6OTKRpjmsBV9/it
         cxvJ32nP2HUKCOazCHeTEor8nO5CoTu4tVAnejEhxTczhQc6TNQI8d1Ccb5blXAIK+mR
         8tweQpoFyZXKrKp3nbewTMLG5tmKTkqmwu+3gsCmB/lcPnib91rIYzt95QDTRZZSpzQ3
         m8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qNRgHWrp6karh8hWnUglLzHlUcCwi1+kY7umvTEOkPU=;
        b=S5SMbgM6c6h1/UyGWczzsCnV0/Ar9f63hLJL7Kh2IrcSeKETUoA+M7/7PFLZtLvwZr
         W2a7xM4H8J+TjUaLVLXGjdONDdTbxnRNXc20CbhHHc6JMdu71SPe2J3Nqa+F5FlCaM07
         6meHQTjD7T6m8jBVfoTSGo3J+uRIuxlJgNiE7KELEy0izchWwqZ5ydF/Gorv7/9PRU5Z
         9ufoKt/WtrhLW9pFD2RN925vCSFQPo1H7dc1NUY/EYdE++ND6TW75asfAmrNCg5O95J8
         lkfy0Pxf5xHwggwyjGevX7nnYmPgymcB15Yx/jOzOgrP0GbruRjRQCqWl00kynynrBQP
         3AiQ==
X-Gm-Message-State: AKS2vOw9Sstus/Oz3Wih3B8voBwJ4JFhfeFeXFVwYelNVhb8iZqvsvP9
        Hc/Dq6AO+10yKA==
X-Received: by 10.200.47.176 with SMTP id l45mr11135724qta.153.1498244126916;
        Fri, 23 Jun 2017 11:55:26 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s6sm3794542qki.44.2017.06.23.11.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 11:55:25 -0700 (PDT)
Subject: Re: [RFC/PATCH v4 07/49] Git/Packet.pm: add packet_initialize()
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
 <20170620075523.26961-8-chriscool@tuxfamily.org>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a2adc8ab-a1a2-082d-8588-fb683acaadaf@gmail.com>
Date:   Fri, 23 Jun 2017 14:55:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170620075523.26961-8-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I like where this ends but it seems to me that patches 6, 7 and 8 should 
just get merged into patch 4 and 5.

On 6/20/2017 3:54 AM, Christian Couder wrote:
> Add a function to initialize the communication. And use this
> function in 't/t0021/rot13-filter.pl'.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   perl/Git/Packet.pm      | 13 +++++++++++++
>   t/t0021/rot13-filter.pl |  8 +-------
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
> index 2ad6b00d6c..b0233caf37 100644
> --- a/perl/Git/Packet.pm
> +++ b/perl/Git/Packet.pm
> @@ -19,6 +19,7 @@ our @EXPORT = qw(
>   			packet_bin_write
>   			packet_txt_write
>   			packet_flush
> +			packet_initialize
>   		);
>   our @EXPORT_OK = @EXPORT;
>   
> @@ -70,3 +71,15 @@ sub packet_flush {
>   	print STDOUT sprintf( "%04x", 0 );
>   	STDOUT->flush();
>   }
> +
> +sub packet_initialize {
> +	my ($name, $version) = @_;
> +
> +	( packet_txt_read() eq ( 0, $name . "-client" ) )	|| die "bad initialize";
> +	( packet_txt_read() eq ( 0, "version=" . $version ) )	|| die "bad version";
> +	( packet_bin_read() eq ( 1, "" ) )			|| die "bad version end";
> +
> +	packet_txt_write( $name . "-server" );
> +	packet_txt_write( "version=" . $version );
> +	packet_flush();
> +}
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index 36a9eb3608..5b05518640 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -40,13 +40,7 @@ sub rot13 {
>   print $debug "START\n";
>   $debug->flush();
>   
> -( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
> -( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
> -( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
> -
> -packet_txt_write("git-filter-server");
> -packet_txt_write("version=2");
> -packet_flush();
> +packet_initialize("git-filter", 2);
>   
>   ( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
>   ( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
> 

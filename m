Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8BD2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdBWSxn (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:53:43 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33090 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBWSxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:53:42 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so5424865pgj.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tL4f6sbFCoH5mQR9LT2FUvVbZEdMG78CBanJcbfNmJM=;
        b=M4chqYVfmGIwb1CoFhad1tIXosDVD6myZ0A1x7IA0LLdRjoN7SAh208JkqWEEHIpin
         Tru71KCI82f0hiXu7QVSL1NP5+Wb+JBYGhUa2d0Z92V4pgRFmy5iKqMFJoDN2tE8M1pa
         W8WsPXR2EBhGqAsaH+jO9dToUe2a6rfL+6z5RlgwG7vTLYnZlR0LBCdehYdGRgC2ZP0A
         C1Tj7MJKh/A3s6LvT2tgDHysOt/NenFbwRdl3EDz/YS5Okt1yWY20Z0/4i/Y5MjOBBHB
         coTzfrOhgMbwo0xxALpyS8Xmo5GBFzlysu23yuZC+L1Juf41wb3rNAV0j0Q3IZq9qTeV
         dozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tL4f6sbFCoH5mQR9LT2FUvVbZEdMG78CBanJcbfNmJM=;
        b=leD33CgS9RDO9B2/1w8n+0NFMYStbc/8ndaACVaam/wJhaQ799AOet0ofNub9sMgxs
         95bVbXZ6bSibf+jTtJUknNNky7Rga/WdB+SDu+ztvWD+gG8QE5ZWLHSSb9ma8UPiliia
         K57NVHGwzYppfPXC/zZG65mYS7rKeulX3ksxzIuLiSP8xIorxhT2ZdYKbkdeyghV5bfX
         h7Lnpk2T8u3zcxuIFUhW7W451dxrgjk2xD788xlWzBEANo44fYR5BsNCNvOKWFqYU4+C
         pqL0Qdky5khAjrqf8ASRCd2FBahhDD/Fq8eksxge3qjdWBTZY/wj4tgwiMwGCiu5CSKB
         IulQ==
X-Gm-Message-State: AMke39lbG9sgAUHzKYnBm23Wl3Q9FIMNI/TRK+X1+/r6KRME7sg7dtpXn8KLwHQuIHT/Fg==
X-Received: by 10.84.172.1 with SMTP id m1mr56495485plb.5.1487876021428;
        Thu, 23 Feb 2017 10:53:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id v69sm11214323pgd.18.2017.02.23.10.53.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 10:53:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Johan Hovold <johan@kernel.org>, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>,
        Larry Finger <Larry.Finger@lwfinger.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] send-email: only allow one address per body tag
References: <xmqqbmu0pgg6.fsf@gitster.mtv.corp.google.com>
        <20170220114406.19436-1-johan@kernel.org>
        <vpqo9xxkqqo.fsf@anie.imag.fr>
Date:   Thu, 23 Feb 2017 10:53:39 -0800
In-Reply-To: <vpqo9xxkqqo.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
        20 Feb 2017 13:10:07 +0100")
Message-ID: <xmqqfuj491sc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Johan Hovold <johan@kernel.org> writes:
>
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1563,7 +1563,7 @@ foreach my $t (@files) {
>>  	# Now parse the message body
>>  	while(<$fh>) {
>>  		$message .=  $_;
>> -		if (/^(Signed-off-by|Cc): (.*)$/i) {
>> +		if (/^(Signed-off-by|Cc): ([^>]*>?)/i) {
>
> I think this is acceptable, but this doesn't work with trailers like
>
> Cc: "Some > Body" <Some.Body@example.com>
>
> A proper management of this kind of weird address should be doable by
> reusing the regexp parsing "..." in parse_mailbox:
>
> 	my $re_quote = qr/"(?:[^\"\\]|\\.)*"/;
>
> So the final regex would look like
>
> if (/^(Signed-off-by|Cc): (([^>]*|"(?:[^\"\\]|\\.)*")>?)/i) {
>
> I don't think that should block the patch inclusion, but it may be worth
> considering.
>
> Anyway, thanks for the patch!

Somehow this fell off the radar.  So your reviewed-by: and then
we'll cook this in 'next' for a while?

Thanks.

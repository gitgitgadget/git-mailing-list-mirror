Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438F91F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeCEVuh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:50:37 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54328 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeCEVuf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:50:35 -0500
Received: by mail-wm0-f46.google.com with SMTP id z81so18863885wmb.4
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BMAsrMEZbQ6elTzLbc8P1AWKKuGnpnTevdD4FZCzIzo=;
        b=ekCj6huPaVk9Ox1+or8D9QIcxQTF4uLXbBTZiTqsl9Z9OGpgWpbk9/mhts6y8enbzU
         2AW1MRBgGo68JwrHrFx/qXacl9wlv/xnpGvH0QThxTKrYz+gcCJJ62JLrClYeOjU3rU4
         v9GLKPjTIuVPWUcpRaRhQ0S7uezBYk3HDxvRNosLOLkYgRPfetATpn5W6SsIqXHNrd1V
         A0w95w2ZpyVPzXHbLFF9iAcd5Tx78eiA8DdNLeyEjLKYBaAGNFQdOcKw6yRbYJElHzU5
         ub+VFzePtJrKEgMis8SvtruWkxV2Tk1OpRAENety6UAMuG4Ojh6V3H2VNiPspb46LVKB
         Rp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BMAsrMEZbQ6elTzLbc8P1AWKKuGnpnTevdD4FZCzIzo=;
        b=FKN05/1ALiLraI5mWvj/eDIT9lT6Egbq4flL4THCd5FgTXHAtW+KXRwq92Q9BV45r7
         PzIbL0mWHFTDNbwoYZNKd1GEJ9xT/6XzN+hKhuWsBNnhpi++nCZgFfyRFXfELId/F9sA
         9cw6o4ieHAsnPMbCegwBlTdfqMv/fLiEgO9Tix+wdw24jGZ+lJhmb0fveILM174itssc
         yOOTUtu6UR0bKFmMQ2BHGqTHLeOkNQerMl0DnOD/Gh8IK5XhKYnLm3FGUdjP83qtpdbu
         yvtuaJVzReLs6yweKGlL2zljz9jKb7D8enOsESxhjP9G0EGPGIsn1as70S3/1pUunJ0C
         GPpA==
X-Gm-Message-State: AElRT7H4aN1AQkiclMUeGAsUVsnfNZGpJKxsyBHQUud5DiVa4StpZZ8x
        B7C7wnYivST49wNmMBfxYDM=
X-Google-Smtp-Source: AG47ELs5QQnp25QPVWXra9fsvFtcV2kdcgTSg9q9WlfTeEvgHRqvbn1k+WGRl/Vozc+SreeoxNxabQ==
X-Received: by 10.28.106.18 with SMTP id f18mr9490182wmc.51.1520286633905;
        Mon, 05 Mar 2018 13:50:33 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w29sm13609411wra.84.2018.03.05.13.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:50:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v9 6/8] convert: check for detectable errors in UTF encodings
References: <20180304201418.60958-1-lars.schneider@autodesk.com>
        <20180304201418.60958-7-lars.schneider@autodesk.com>
Date:   Mon, 05 Mar 2018 13:50:32 -0800
In-Reply-To: <20180304201418.60958-7-lars.schneider@autodesk.com> (lars
        schneider's message of "Sun, 4 Mar 2018 21:14:16 +0100")
Message-ID: <xmqqfu5e8a53.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lars.schneider@autodesk.com writes:

> +static int validate_encoding(const char *path, const char *enc,
> +		      const char *data, size_t len, int die_on_error)
> +{
> +	if (!memcmp("UTF-", enc, 4)) {

Does the caller already know that enc is sufficiently long that
using memcmp is safe?

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 09/21] strbuf: give strbuf_getline() to the "most text
 friendly" variant
Date: Thu, 14 Jan 2016 20:46:47 -0500
Message-ID: <CAPig+cSAO-bJTvkOO-h=R-FKE90pfiJAaW-n-9Gi-omEr7aMCQ@mail.gmail.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 02:46:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJtTY-0002UA-QT
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 02:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbcAOBqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 20:46:49 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34900 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbcAOBqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 20:46:48 -0500
Received: by mail-vk0-f65.google.com with SMTP id i129so9090347vkb.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=K2GCVEtKm3IwhaiIx4PLeDOHf3SFW/3bUC7bYmG6TF0=;
        b=zgrMLhF9mwR2L6mwB5uUmSKKrCh4zY8yEss0NEN9JnwzQfyB8thH5RPllSZscrg0Nd
         pgq8Yr0nmNizBoAa0gx+FjOQc4nx+9yPupKjbaAVDdjZOe+OHg+v2l3zjwwHkSM0yLMO
         Hy9yEcHgh8SdYNUlOqnX+w35fWh1B06PCtls33C4RKvmj8PCPHPAfJ4pUZuz9snawxo8
         aMz1FaWhJhWvQp/ZS7PXEWeHcJ3sZcBXIaJsWpnM5sB/DP80OkvHexY8bcS5y6wFXT6X
         GNKHkokK9yE9gsBdcK6Ur30KwoJ1XZ74YrGnud2PpYc0Y7offZvUC2NO4VXS7yLc/+up
         i5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K2GCVEtKm3IwhaiIx4PLeDOHf3SFW/3bUC7bYmG6TF0=;
        b=FOQMSJk9mlroQUeK5faU63BNhdKY6sZ++N6JPtQgrKRpDJi1SrvekAEF/1JEfDJ+X7
         FddGpa/6u/HBIWxQdw/wnb4r1rj2nVsSJObrYFFuqEmJiLtYHXnN+VFa2uqeE91U3Wjw
         jonlsniT2z7Z0PmJ8PQgcAh0+sIpJkTfRIqUvbowLTUu9v6LUeNk8Cow9Be2x8mnUdBY
         /1YmbZSbCFTEJ8RtRKZThOqy+UvONRfypFm9uBoburKB78rFz7lviWLuaq7F1X4xbunV
         CuWgzsfRikOJlBp+enFpMbjV3rAJ8XKe4du1Yjs0p6tPI5VDqtTnQKuMl6zmQejLHP2d
         TQOA==
X-Gm-Message-State: ALoCoQmSVRcAiRtfzSr1JKY2hDoyPESSiK+xxLHz6ediHQu7qdhGqX9jUVhik4pV+W3CKPpGg/pGvXgM/XqdmxPtWMd5UI0b2w==
X-Received: by 10.31.47.130 with SMTP id v124mr5760413vkv.117.1452822407281;
 Thu, 14 Jan 2016 17:46:47 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 14 Jan 2016 17:46:47 -0800 (PST)
In-Reply-To: <1452815916-6447-10-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: Cr4-Yl82K5MfPXztliWVUC2_Q74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284131>

On Thu, Jan 14, 2016 at 6:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Now there is no direct caller to strbuf_getline(), we can demote it
> to file-scope static private to strbuf.c implementation and rename
> it to strbuf_getdelim().  Rename strbuf_getline_crlf(), which is
> designed to be the most "text friendly" variant, and allow it to
> take over this simplest name, strbuf_getline(), so we can add more
> uses of it without having to type _crlf over and over again in the
> coming steps.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/strbuf.h b/strbuf.h
> @@ -380,26 +380,29 @@ extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
>
>  /**
>   * Read a line from a FILE *, overwriting the existing contents
> - * of the strbuf. The second argument specifies the line
> - * terminator character, typically `'\n'`.
> + * of the strbuf.  There are three public functions with this
> + * function signature, with different line termination convention.

s/public// perhaps?

Also, is it worth worrying that the comment may become outdated due to
the mentioned "three"? Perhaps s/three/several/? Or:

    The family of strbuf_getline*() functions share the same
    signature, but have different line termination conventions.

>   * Reading stops after the terminator or at EOF.  The terminator
>   * is removed from the buffer before returning.  Returns 0 unless
>   * there was nothing left before EOF, in which case it returns `EOF`.
>   */
> -extern int strbuf_getline(struct strbuf *, FILE *, int);
> -
>
>  typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
>
> +/* Uses LF as the line terminator */
>  extern int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
> +
> +/* Uses NUL as the line terminator */
>  extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);

This documentation could have been included in patch 3/21.

> -/*
> - * Similar to strbuf_getline(), but uses '\n' as the terminator,
> - * and additionally treats a '\r' that comes immediately before '\n'
> - * as part of the terminator.
> +/**
> + * Similar to strbuf_getline_lf(), but additionally treats
> + * a '\r' that comes immediately before '\n' as part of the
> + * terminator.  This is the most friendly version to be used
> + * to read "text" files that can come from platforms whose
> + * native text format is CRLF terminated.
>   */
> -extern int strbuf_getline_crlf(struct strbuf *, FILE *);
> +extern int strbuf_getline(struct strbuf *, FILE *);

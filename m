From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 14:03:28 -0500
Message-ID: <20160210190328.GA2376@flurp.local>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sschuberth@gmail.com, peff@peff.net
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 10 20:03:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTa3B-0000jb-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 20:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbcBJTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 14:03:37 -0500
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34889 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbcBJTDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 14:03:37 -0500
Received: by mail-ig0-f194.google.com with SMTP id mw1so2418915igb.2
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 11:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ceodP2qGqFx1Sm3SZ2XQyndJL2w00gugU2iBvzs/78s=;
        b=kmofGNC7MdZbR2aIzH4LhcfxxJUPAjphaye7qwgbCmDEJaWHdZWTBPYnP0i5UOUtoc
         bhpXLFthkzbnJ1pnpEVgpRNzG8eZ59KO9S4aY8KEtHcVnD2tfcWtvHNLhUMvFKQWwGZj
         7MklAbtV66oG02B40JmvFQlCmiNIblWfzPAOpZOqZK4ebqIYaZ/ABdHFIB6JD7rjYCI1
         /kIobaUW/UTYXV1yWN5c60Ih90NmvVUC1M7wtlnZL3jA6GDJjqbtIkeZq3nyR0NHB9wj
         2hSvM2vu/LorJefPma2PBz2RBVFijKw6NJCwcdOw2T5NS6gOlRCjTdbvjKhx+UNFD+5D
         3cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ceodP2qGqFx1Sm3SZ2XQyndJL2w00gugU2iBvzs/78s=;
        b=KjdNLs3XGRH6LBuHcS8pVdqDnyaIqA/W3W0jy+nCgQEcaKbeq4WD7DxFGiTX9HQLMJ
         YxefaimxS7sN6Ko4SJr9QsVWpgDYnJKmzztyDb69X/izSv/jzJICXgaQS2jjARsV5Rxq
         xQfcLT281a5ccUWbdNnN274FWLU2h2s7lhdPqc0cUqQTMNaMhp4fFBklADfQOupz2Wa3
         GagiVWMh+rQZQu2w9VavGLUuxhf4Qgypd3CS2qgLCtxjiVaVY0SB1K1LjQHXQsLI3n2h
         KevSNrkrxurXJh5UWpO2tfNLEHNK/nED3CzFp7dvVUPNjDPdKqJWmjquazUsNxEdNzjS
         rsiw==
X-Gm-Message-State: AG10YOQe1MHMwiGU5eFFBWGlcoSWn4oFEcELIXW4XNsmm/XiNP8Dh2Zx8LPjKK7L61dybQ==
X-Received: by 10.50.72.48 with SMTP id a16mr11093115igv.73.1455131016177;
        Wed, 10 Feb 2016 11:03:36 -0800 (PST)
Received: from flurp.local (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id s19sm2336509ign.4.2016.02.10.11.03.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 11:03:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285922>

On Wed, Feb 10, 2016 at 11:13:18AM +0100, larsxschneider@gmail.com wrote:
> If config values are queried using 'git config' (e.g. via '--list' flag
> or the '--get*' flags) then it is sometimes hard to find the
> configuration file where the values were defined.
> 
> Teach 'git config' the '--sources' option to print the source
> configuration file for every printed value.
> 
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -91,8 +94,58 @@ static void check_argc(int argc, int min, int max) {
> +/* output to either fp or buf; only one should be non-NULL */
> +static void show_config_source(struct strbuf *buf, FILE *fp)
> +{
> +	char term = '\t';
> +	char *prefix;
> +	const char *fn = current_config_filename();
> +
> +	if (end_null)
> +		term = '\0';
> +
> +	if (fn) {
> +		if (given_config_source.use_stdin)
> +			prefix = "stdin";
> +		else if (given_config_source.blob)
> +			prefix = "blob";
> +		else
> +			prefix = "file";
> +	} else {
> +		fn = "";
> +		prefix = "cmd";
> +	}
> +
> +	if (fp)
> +		fprintf(fp, "%s", prefix);
> +	else {
> +		strbuf_addstr(buf, prefix);
> +	}

Style: drop unnecessary braces

> +
> +	if (fp)
> +		fputc(term, fp);
> +	else
> +		strbuf_addch(buf, term);

Why not combine this 'if' with the preceding one?

> +
> +	if (!end_null)
> +		quote_c_style(fn, buf, fp, 0);
> +	else {
> +		if (fp)
> +			fprintf(fp, "%s", fn);
> +		else
> +			strbuf_addstr(buf, fn);
> +	}
> +
> +	if (fp)
> +		fputc(term, fp);
> +	else
> +		strbuf_addch(buf, term);
> +}

Overall, due to its duality (outputting to FILE* or strbuf), this
function is more difficult to read than it probably ought to be. Have
you considered simplifying it by making it single-purpose. Something
like this, for instance:

    static void get_config_source(const char **name, const char **prefix)
    {
        *name = current_config_filename();
        if (!*name) {
            *name = "";
            *prefix = "cmd";
        } else if (given_config_source.use_stdin)
            *prefix = "stdin";
        else if (given_config_source.blob)
            *prefix = "blob";
        else
            *prefix = "file";
    }

    static void show_config_source(struct strbuf *buf)
    {
        char term = end_null ? '\0' : '\t';
        char *prefix;
        const char *name;

        get_config_source(&name, &prefix);
        strbuf_addstr(buf, prefix);
        strbuf_addch(buf, term);
        if (end_null)
            strbuf_addstr(buf, name);
        else
            quote_c_style(name, buf, NULL, 0);
        strbuf_addch(buf, term);
    }

    static int show_all_config(...)
    {
        if (show_sources) {
            struct strbuf buf = STRBUF_INIT;
            show_config_source(&buf);
            fputs(buf.buf, stdout);
            strbuf_release(&buf);
        }
        ...
    }

    static int format_config(...)
    {
        if (show_sources)
            show_config_source(buf);
        ...
    }

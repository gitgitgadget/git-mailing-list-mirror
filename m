Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC0C433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2162761354
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJTMEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMEF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:04:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A31BC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:01:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id a25so25004652edx.8
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ef3bGGAEjlNbscXVvF+pu+LEiLkUswn75C7kPgpbuFw=;
        b=VgcGOV04bas6c00dwyPwD5wChgAJgoF5pZFu1Le7ZK9foeyNY+5pPB8Eik9Fpy93K2
         B6eSbCRhoc2OPHCBQOKvZiPJ45Uuft0m5Rcz3sWZxNDKQMId0UQxF5e98QZMFfV3laEb
         HolVc1rtf0p0NIf8DopKZxq1aRV3Gv2yU+dvAEutwahKZyYhPiKDrqeletHoccuPhFDA
         nsikewKGatoNY0VXvChSBIJ9jN47I8maouaN8018JKC7/wadJlWrMJEOA/0b9bZurXb0
         6MUVAn3KXlKIR9+r23DvzBZqG6VOFj6zReYmdCo91Y6XjlThGusOySZ7HN/0EbpAU72d
         RRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ef3bGGAEjlNbscXVvF+pu+LEiLkUswn75C7kPgpbuFw=;
        b=5sJrHurxcRdHYW1MiMlDfnaUJhBiEkr1Q/NeR96U2roqEL1VNFIGB0ZDe0HjMWg6es
         XNl5yq32YSsFxYeb3X6n/kUo+ZFRSJs0Y9ncCl2Ju066vH3arROJUD9ck/g0X3Zkz4Mk
         KSjfNI2e4qaor6v+U8lqGjs+B4pt164LVYulMEE/tJY9bVt+5ClO95fhxoyLTvUoM0GZ
         H8a0LeqwNWv25cRJalvTJSOlFe6ChpaaiHfHRB95/qWORFjEcasVeip2RJC3FC0M6/Jc
         Lvy0c88r/2BhxSpiWntF/Xgz224wMURBekTOjXCcTAHHq2HCGtmiUdHJPMvXQ7e+PmWK
         H/sg==
X-Gm-Message-State: AOAM53136kpDLDyGIJ5I9dFjNTArXEHxrl5CX+DCAxp23NhgAh6Oyz+e
        YGcEbVVmRLtpwTkdTN/IgoBniQy5m2Te9w==
X-Google-Smtp-Source: ABdhPJzMeIxLik+q4qAY5yuYIJipPPo+XOM6LOBikkAjIahphXX3GMe46jJSFf3A+VLJCGMMYUJ2mA==
X-Received: by 2002:a17:906:fb19:: with SMTP id lz25mr47380145ejb.406.1634731301457;
        Wed, 20 Oct 2021 05:01:41 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v15sm1073249edi.89.2021.10.20.05.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:01:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdAHs-000hEK-2Q;
        Wed, 20 Oct 2021 14:01:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH v3] fetch-pack: redact packfile urls in traces
Date:   Wed, 20 Oct 2021 13:41:57 +0200
References: <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com>
 <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
Message-ID: <211020.868rynoqfv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 19 2021, Ivan Frade via GitGitGadget wrote:

> From: Ivan Frade <ifrade@google.com>
>
> In some setups, packfile uris act as bearer token. It is not
> recommended to expose them plainly in logs, although in special
> circunstances (e.g. debug) it makes sense to write them.
>
> Redact the packfile URL paths by default, unless the GIT_TRACE_REDACT
> variable is set to false. This mimics the redacting of the Authorization
> header in HTTP.
>
> Signed-off-by: Ivan Frade <ifrade@google.com>
> ---
>     fetch-pack: redact packfile urls in traces
>     
>     Changes since v1:

Just context for other reviewers:

s/Changes since v1/Changes since v2/ I see, from the context of
https://lore.kernel.org/git/pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com/

>      * Redact only the path of the URL
>      * Test are now strict, validating the exact line expected in the log

And this was changed in v2...

>     Changes since v1:
>     
>      * Removed non-POSIX flags in tests
>      * More accurate regex for the non-encrypted packfile line

[...]

>      * Dropped documentation change
>      * Dropped redacting the die message in http-fetch

Since both of those were done I think in response to my feedback I just
want to clarify (if needed):

 * That the documentation change is still good to have, although I had
   feedback on fixing that more generally in the protocol v2 docs. It
   would be great if you could still pursue it (and that I didn't
   discourage you from doing so).

 * I think having this redaction in die() could still be valuable,
   e.g. your packfile-uri's start failing, and now users are
   copy/pasting "private" URLs that contain their passwords or whatever
   to try to get help, that would be bad.   

   But perhaps if you don't have private URLs redacting them
   unconditionally would slow down debugging for some, i.e. you have 10x
   pasted URLs, and all the errors are from one set of servers (although
   your current redaction includes the hostname, which I think would
   address most cases of say one CDN node failing).

   It was really just a comment that your v1's commit message didn't
   mention or justify it, but just having it make a mention of it would
   also be an OK solution, or fold that into another patch or
   whatever...

>  {
> +	int saved_options;
>  	process_section_header(reader, "packfile-uris", 0);
> +	/*
> +	 * In some setups, packfile-uris act as bearer tokens,
> +	 * redact them by default.
> +	 */
> +	saved_options = reader->options;

nit: no need to pre-declare "int saved_options" here, just move this &
the comment above "process_section_header" (in this case I'd say a
comment isn't even needed, obvious from context...), or it should be at
the definition of PACKET_READ_REDACT_URL_PATH... (more below)

> +	if (git_env_bool("GIT_TRACE_REDACT", 1))

If we're going to use GIT_TRACE_REDACT for this the documentation needs updating:

Documentation/git.txt:`GIT_TRACE_REDACT`::
Documentation/git.txt-  By default, when tracing is activated, Git redacts the values of
Documentation/git.txt-  cookies, the "Authorization:" header, and the "Proxy-Authorization:"
Documentation/git.txt-  header. Set this variable to `0` to prevent this redaction.

> +		reader->options |= PACKET_READ_REDACT_URL_PATH;

(continued)... but that was from a really narrow reading of the code, I
think this whole flip-flopping of options back and forth isn't needed at
all, and you should just assign this flag at the top of
do_fetch_pack_v2(), no?  The setting of it also looks like it belongs
with the reading of "GIT_TEST_SIDEBAND_ALL".

I.e. nothing else uses PACKET_READ_REDACT_URL_PATH, why do we need to be
flipping it back & forth? Keeping these flags in the "reader" is what
that member is for, isn't it? Maybe I'm missing something.

> +static int find_url_path_start(const char* buffer)
> +{
> +	const char *URL_MARK = "://";
> +	char *p = strstr(buffer, URL_MARK);
> +	if (!p) {
> +		return -1;
> +	}
> +
> +	p += strlen(URL_MARK);
> +	while (*p && *p != '/')
> +		p++;
> +
> +	// Position after '/'
> +	if (*p && *(p + 1))
> +		return (p + 1) - buffer;
> +
> +	return -1;
> +}

I think that packfile URI only supports http:// and https://, not
file:// or whatever, so I wonder if either curl or we have a helper
function for this that we can use....(more below)

>  enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>  						size_t *src_len, char *buffer,
>  						unsigned size, int *pktlen,
> @@ -393,6 +412,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>  {
>  	int len;
>  	char linelen[4];
> +	int url_path_start;
>  
>  	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
>  		*pktlen = -1;
> @@ -443,7 +463,18 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
>  		len--;
>  
>  	buffer[len] = 0;
> -	packet_trace(buffer, len, 0);
> +	if (options & PACKET_READ_REDACT_URL_PATH &&
> +	    (url_path_start = find_url_path_start(buffer)) != -1) {
> +		const char *redacted = "<redacted>";
> +		struct strbuf tracebuf = STRBUF_INIT;
> +		strbuf_insert(&tracebuf, 0, buffer, len);
> +		strbuf_splice(&tracebuf, url_path_start,
> +			      len - url_path_start, redacted, strlen(redacted));
> +		packet_trace(tracebuf.buf, tracebuf.len, 0);
> +		strbuf_release(&tracebuf);
> +	} else {
> +		packet_trace(buffer, len, 0);
> +	}

...If we're redacting the URL isn't (and this might be less code with a
helper function) saying:

    failed to get 'https' url from 'somehost.example.com' (full URL redacted due to XYZ setting)

Friendlier than something like (which this function sets up):

    failed to get 'https://somehost.example.com/<redacted>' url

I.e. it allows us to use a get_schema_from_url() and get_host_from_url()
functions (I don't know if/where we have those, but seems likelier than
"find path url boundary" (or maybe I'm wrong and we always feed those
as-is to curl et al).

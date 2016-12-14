Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787A01FF6D
	for <e@80x24.org>; Wed, 14 Dec 2016 20:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756662AbcLNUh4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 15:37:56 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36344 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbcLNUhz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 15:37:55 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so5131831pfz.3
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wPj/VARD/5Ed88/2ga7A62y5E5UJ2SaBvxgrjfjsihY=;
        b=EQbLumhKSgd8a8sFl76nmKSPTs50Q8Sgv76ehZOgEx5YuBShK74QHtFZ0yeN88T9RP
         r/NydU26obDeOJyb4ETDL15eA6+Lb1L1oeoeUjy2iJDnj0yTW5umei7Lg+q7qr0yrhku
         Sy0sWqaiHYW2pP4VBHvlYihLv831YKGxOZRBIoimMK+YLa8TjQtG9fWkKgDzeB0QwBaE
         zdLenZY7UJqmSxKchykV8dbdlBPSC2mI6vCelnPaWefvcpkOcfLV4arUdXpxYhJcoZhr
         EnpkrvhRsVVYrmDq6hWtCBwPPI9+E/Y96t795lOEKYeX11jGwNHwc0OQyvc/WseUXKph
         2/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wPj/VARD/5Ed88/2ga7A62y5E5UJ2SaBvxgrjfjsihY=;
        b=fyKwDlZORu6Z50cLTGyPlxPy7rO1khFn5LkRjDxNnh2TsXcBTifCL63e/q64yFkl6g
         VLA4dO58KS+HQCkFrWPelV5s3iqlIj291ry3xHbkDoP2CTEzsdRJPQPDQWy9PM13imCL
         3Q+JU4mxMnVX14jvzc8gaT50Zxt2higE6TrPM1zVkFAuJw1gKeTZ7zdS+3y9243P3WLY
         UMPyg8CZPxTLIq6ZUrMQaRSWIYhzdq4+lU1Pc6NlusETO9D+3QbRHmhojibMhKTSW3L1
         hmO2Vz+medRDpN0BG/4LZanU/FJicrsrVjeoIuQboGt1VQ6UGkpBCc7JUYJWI5/TXli8
         MEfg==
X-Gm-Message-State: AKaTC00xpQCWBZH9FF4Ba3TEHWGIb8Ik9hsZ8j/EUzT+rUIoYbrshegBtvv32Ng1voiWr6Yn
X-Received: by 10.84.193.101 with SMTP id e92mr209944458pld.12.1481747874719;
        Wed, 14 Dec 2016 12:37:54 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a0bd:b7d6:4331:46ad])
        by smtp.gmail.com with ESMTPSA id r21sm89243109pfd.44.2016.12.14.12.37.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 12:37:53 -0800 (PST)
Date:   Wed, 14 Dec 2016 12:37:52 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214203752.GD20063@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214201323.GC20063@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14, Brandon Williams wrote:
> On 12/14, Jeff King wrote:
> > On Tue, Dec 13, 2016 at 05:40:37PM -0800, Brandon Williams wrote:
> > 
> > > Add the from_user parameter to the 'is_transport_allowed' function.
> > > This allows callers to query if a transport protocol is allowed, given
> > > that the caller knows that the protocol is coming from the user (1) or
> > > not from the user (0) such as redirects in libcurl.  If unknown a -1
> > > should be provided which falls back to reading `GIT_PROTOCOL_FROM_USER`
> > > to determine if the protocol came from the user.
> > 
> > I think your commit message is upside-down with respect to the purpose
> > of the patch. The end goal we want is for http to distinguish between
> > protocol restrictions for redirects versus initial requests. The rest is
> > an implementation detail. It's definitely still worth discussing that
> > implementation detail (though I think your in-code comments may be
> > sufficient), but I don't see the rationale discussed here at all.
> 
> I'll fix the commit message to better discuss the reasoning behind the
> change.
> 
> > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > > ---
> > >  http.c      | 14 +++++++-------
> > >  transport.c |  8 +++++---
> > >  transport.h | 13 ++++++++++---
> > >  3 files changed, 22 insertions(+), 13 deletions(-)
> > 
> > I'm trying to think of a way to test this. I guess the case we are
> > covering here is when a server redirects, but the protocol is only
> > allowed from the user. So:
> > 
> > diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
> > index 044cc152f..d911afd24 100755
> > --- a/t/t5812-proto-disable-http.sh
> > +++ b/t/t5812-proto-disable-http.sh
> > @@ -30,5 +30,12 @@ test_expect_success 'curl limits redirects' '
> >  	test_must_fail git clone "$HTTPD_URL/loop-redir/smart/repo.git"
> >  '
> >  
> > +test_expect_success 'http can be limited to from-user' '
> > +	git -c protocol.http.allow=user \
> > +		clone "$HTTPD_URL/smart/repo.git" plain.git &&
> > +	test_must_fail git -c protocol.http.allow=user \
> > +		clone "$HTTPD_URL/smart-redir-perm/repo.git" redir.git
> > +'
> > +
> >  stop_httpd
> >  test_done
> > 
> > It's an oddball configuration, and you'd probably just set
> > http.followRedirects=false in practice, but it does correctly check this
> > case.
> 
> K I'll add this in as a test.
> 
> > > @@ -588,9 +588,9 @@ static CURL *get_curl_handle(void)
> > >  #endif
> > >  #if LIBCURL_VERSION_NUM >= 0x071304
> > >  	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> > > -			 get_curl_allowed_protocols());
> > > +			 get_curl_allowed_protocols(0));
> > >  	curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> > > -			 get_curl_allowed_protocols());
> > > +			 get_curl_allowed_protocols(-1));
> > 
> > This covers internal redirects done by libcurl, but not the dumb-walker
> > http-alternates nonsense. We have to feed the URL from http-alternates
> > back to curl ourselves, so it uses CURLOPT_PROTOCOLS even though it
> > should count as "not from the user".
> > 
> > To fix that, I think we'd need something like:
> > 
> >   - get_curl_handle() stops setting these options, as it is done only
> >     once when the curl handle is initialized. Instead, the protocol
> >     restrictions should go into get_active_slot(), which is called for
> >     each request.  The values set would remain the same, and be the
> >     baseline.
> > 
> >   - the http-walker.c code would need to know when it's requesting from
> >     the base URL, and when it's an alternate. I think this would depend
> >     on the position of the "alt" in in the linked list it keeps.
> > 
> >   - when requesting from an alternate, http-walker would set
> >     CURLOPT_PROTOCOLS with get_curl_allowed_protocols(0)
> > 
> > I have to admit that it sounds like a fair bit of work for a pretty
> > obscure case. You'd have to:
> > 
> >   1. Turn http.allowRedirects to "true", to allow redirects even for
> >      non-initial contact.
> > 
> >   2. Turn one of protocol.{http,https,ftp,ftps}.allow to "user" to
> >      restrict it from being used in a redirect.
> > 
> > I'm tempted to punt on it and just do:
> > 
> >   if (http_follow_config == HTTP_FOLLOW_ALWAYS &&
> >       get_curl_allowed_protocols(0) != get_curl_allowed_protocols(-1))
> > 	die("user-only protocol restrictions not implemented for http-alternates");
> > 
> > which errs on the safe side. We could even shove that down into the case
> > where we actually see some alternates, like:
> > 
> > diff --git a/http-walker.c b/http-walker.c
> > index c2f81cd6a..5bcc850b1 100644
> > --- a/http-walker.c
> > +++ b/http-walker.c
> > @@ -160,6 +160,12 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
> >  #endif
> >  }
> >  
> > +static void check_alternates_protocol_restrictions(void)
> > +{
> > +	if (get_curl_allowed_protocols(0) != get_curl_allowed_protocol(-1))
> > +		die("user-only protocol restrictions not implemented for http alternates");
> > +}
> > +
> >  static void process_alternates_response(void *callback_data)
> >  {
> >  	struct alternates_request *alt_req =
> > @@ -272,6 +278,7 @@ static void process_alternates_response(void *callback_data)
> >  			/* skip "objects\n" at end */
> >  			if (okay) {
> >  				struct strbuf target = STRBUF_INIT;
> > +				check_alternates_protocol_restrictions();
> >  				strbuf_add(&target, base, serverlen);
> >  				strbuf_add(&target, data + i, posn - i - 7);
> >  				warning("adding alternate object store: %s",
> > 
> > I find it unlikely that anybody would ever care, but at least we'd do
> > the safe thing. I dunno. Maybe I am just being lazy.
> 
> Well, that's unfortunate!  It does sound like a more full-proof solution
> to these dumb http alternates could be involved.  I don't think your
> simple "lazy" solution may be enough to not just die by default.
> 
> By default ftp/ftps will have a policy of "user only" which means they
> will be set by the call to get_curl_allowed_protocol(-1) but not set by
> get_curl_allowed_protocol(0).  This would result in the call to
> check_alternates_protocol_restrictions failing all the time unless the
> user explicitly sets ftp/ftps to "always" or "never".  If that is the
> desired behavior then your proposed solution would be fine, otherwise we
> may have to do the more involved approach.

Naively looking at the code (and your longer suggestion), is there a
reason why we couldn't simply have http-walker set CURLOPT_PROTOCOLS
with get_curl_allowed_protocols(0) in the fetch_alternates() function?
That way we just override the CURLOPT_PROTOCOLS value when alternates
are involved.
Like so:

diff --git a/http-walker.c b/http-walker.c
index c2f81cd..b284cec 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -339,6 +339,8 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url.buf);
+	curl_easy_setopt(slot->curl, CURLOPT_PROTOCOLS,
+			 get_curl_allowed_protocols(0));
 
 	alt_req.base = base;
 	alt_req.url = &url;

-- 
Brandon Williams

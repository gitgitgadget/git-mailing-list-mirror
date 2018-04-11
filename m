Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732E81F404
	for <e@80x24.org>; Wed, 11 Apr 2018 01:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752403AbeDKBdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 21:33:13 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:43952 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeDKBdM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 21:33:12 -0400
Received: by mail-pl0-f44.google.com with SMTP id a39-v6so162447pla.10
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uec3B/Mvn8+pzfBTDNcn6V9qDc+C8vKyebn8ugTx7EU=;
        b=G9eN82pITykdEluzQLSPWN+gP9ely/6bNH4QdWUOe6k4hISt2V46dmLZH7ZI4u3TB6
         PlXgTnivz/nA7UldP99kFhKCdiUFessYsVZvYoHHhZxoFkf/FRvQwkzDMGaiKH0wkdmv
         AK0GfyIbv5Gp9tCqD3b22KD38gIrKTVodscxk+0zZf0f4n7RQDa/oKmwhxI3bN+jYNpR
         aauoiiX3ndliUQeOOW8T4IGemrJ9cgW08zgK6CKs0/uhrXYfLOFgQH6HKxr5I2AI9/w/
         mTdmagBVmNqbFv/Rp0Qa79cwtOuYG3Htjt7tqtip1Gbw/Hq9y9wP7GKVk6hUbc+ntAej
         ddtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uec3B/Mvn8+pzfBTDNcn6V9qDc+C8vKyebn8ugTx7EU=;
        b=qWZHxUvATcDu9i6VBw5UvDb0m1+2BPpnZodeQeQ1uzHlbclQrWV/1rrxSmnct/mkj1
         c3/O6TM1sDF4RLk2RHeHgaL09hT2AV1anNfOMvJUMlYBCAddYMo0PHEuk/OFmZDW2vEy
         hZCCMowEgCGQHdh07VvkprBIvvgyDJ6luHpKIPUvFhk7NYlBk6sHiE+tgB1uBmUvTLtG
         0luyt+Af3JF2jMB59CA8Y+NRV/ZmDy+5JXFfqHc+5S/bg2vrlZQNFzKXh+lS3Sj8PXGN
         4T+Ty+erLWYFsdRC0VoHSAtwccNVDrEK5Gcq7xlqCJUjNUu/D85ZNUZLjUAbmph08GVp
         WS+g==
X-Gm-Message-State: ALQs6tAH7PwEhuoRcDzudEi0wXYb9dBkFUcbNN2GDQ7ev35PwSdu4qdG
        PsgTyNAPnxNnaFpGimkCdAkK6w==
X-Google-Smtp-Source: AIpwx4/w3KGU83hEEXGnVnYhu5f53qMWzMDmR9O3dJm1trdtqBBvL8/GAjQXdZBLv7TeWMN7CFH7/A==
X-Received: by 2002:a17:902:5902:: with SMTP id o2-v6mr2832190pli.81.1523410391529;
        Tue, 10 Apr 2018 18:33:11 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d0e:5efd:b490:f1b1])
        by smtp.gmail.com with ESMTPSA id t25sm37256pfk.69.2018.04.10.18.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 18:33:09 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 10 Apr 2018 18:33:09 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, peff@peff.net
Subject: Re: [PATCH v8 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180411013309.GA36066@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180411010654.GA28561@syl.local>
 <xmqqtvsizg9u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtvsizg9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 11, 2018 at 10:24:45AM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Attached is the eighth re-roll of my series to add `--type=<type>` as
> > the preferred alternative for `--<type>`.
> >
> > The main changes since v7 concern handling degenerate cases, such as:
> >
> >   * git config --type=int --type=bool
> >   * git config --type=int --int
> >
> > We have previously had discussion about whether we should (1) retain the
> > error in previous versions when confronted with multiple, conflicting
> > type specifiers, (2) ignore the error, in favor of making --<type> and
> > --type=<type> true synonyms, or (3) some combination of the two.
> >
> > I have thought some more about my argument that it would be favorable to
> > make "--type=int" and "--int" behave in the same way, and I am no
> > longer convinced that my argument makes sense. It's based on the premise
> > that "--type=<type>" must _necessarily_ allow multiple invocations, such
> > as '--type=int --type=bool', and therefore "--int --bool" should be
> > updated to behave the same way.
> >
> > We are not constrained to this behavior, so in v8, I have taught Git the
> > following:
> >
> >   1. Allow multiple non-conflicting types, such as '--int --int',
> >      '--type=int --int', and '--int --type=int'.
> >
> >   2. Disallow multiple conflicting types, such as '--int --bool',
> >      '--type=int --bool', and '--int --type=bool'.
> >
> >   3. Allow conflicting types following --no-type, such as '--int
> >      --no-type --bool', '--type=int --no-type --bool', and '--int
> >      --no-type --type=bool'. Note that this does _not_ introduce options
> >      such as '--no-int' and whatnot.
> >
> > This is accomplished by a new locally defined macro called
> > OPT_CALLBACK_VALUE, which allows us to reuse option_parse_type() to
> > handle --int as well, by sending it through as opt->defval.
> >
> > I think that the above is the best-of-all-worlds choice, but I am
> > curious to hear everyone else's thoughts. Thanks in advance for your
> > review.
>
> I too am curious.  Personally I do not think your "last one wins"
> was necessarily bad--in fact it internally was consistent--I just
> thought that the log message did not justify the choice well.  And I
> do not think the semantics defined by this one, "once you choose,
> stick to it, or explicitly clear the previous choice", is bad,
> either.

:-). If nothing else, I like that we retain more, stricter behavior from
previous versions.

> > diff --git a/builtin/config.c b/builtin/config.c
> > index 5c8952a17c..7184c09582 100644
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -61,28 +61,53 @@ static int show_origin;
> >  #define TYPE_PATH		4
> >  #define TYPE_EXPIRY_DATE	5
> >
> > +#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
> > +	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
> > +	PARSE_OPT_NONEG, (f), (i) }
> > +
> > +static struct option builtin_config_options[];
>
> OK.  I am not sure if OPT_CALLBACK_VALUE() needs to take 'f', as you
> always pass the option_parse_type function to it.

That's fair. I left this in as an indication that something like this
_might_ want to make its way into parse-options.h as a general-purpose
utility, but was not yet ready to do so. Thus, I defined it inside
builtin/config.c.

> >  static int option_parse_type(const struct option *opt, const char *arg,
> >  			     int unset)
> >  {
> > -	int *type = opt->value;
> > -
> >  	if (unset) {
> > -		*type = 0;
> > +		type = 0;
> >  		return 0;
> >  	}
> >
> > -	if (!strcmp(arg, "bool"))
> > -		*type = TYPE_BOOL;
> > -	else if (!strcmp(arg, "int"))
> > -		*type = TYPE_INT;
> > -	else if (!strcmp(arg, "bool-or-int"))
> > -		*type = TYPE_BOOL_OR_INT;
> > -	else if (!strcmp(arg, "path"))
> > -		*type = TYPE_PATH;
> > -	else if (!strcmp(arg, "expiry-date"))
> > -		*type = TYPE_EXPIRY_DATE;
> > -	else
> > -		die(_("unrecognized --type argument, %s"), arg);
> > +	/*
> > +	 * To support '--<type>' style flags, begin with new_type equal to
> > +	 * opt->defval.
> > +	 */
> > +	int new_type = opt->defval;
> > +	if (!new_type) {
> > +		if (!strcmp(arg, "bool"))
> > +			new_type = TYPE_BOOL;
> > +		else if (!strcmp(arg, "int"))
> > +			new_type = TYPE_INT;
> > +		else if (!strcmp(arg, "bool-or-int"))
> > +			new_type = TYPE_BOOL_OR_INT;
> > +		else if (!strcmp(arg, "path"))
> > +			new_type = TYPE_PATH;
> > +		else if (!strcmp(arg, "expiry-date"))
> > +			new_type = TYPE_EXPIRY_DATE;
> > +		else
> > +			die(_("unrecognized --type argument, %s"), arg);
> > +	}
> > +
> > +	if (type != 0 && type != new_type) {
> > +		/*
> > +		 * Complain when there is a new type not equal to the old type.
> > +		 * This allows for combinations like '--int --type=int' and
> > +		 * '--type=int --type=int', but disallows ones like '--type=bool
> > +		 * --int' and '--type=bool
> > +		 * --type=int'.
> > +		 */
> > +		error("only one type at a time.");
> > +		usage_with_options(builtin_config_usage,
> > +			builtin_config_options);
> > +	}
> > +	type = new_type;
>
> Does this rely on a file-scope global variable (type)?

I don't think it does. I think I had conflated the difference between
opt->value and opt->defval while amending this patch. What do you think of the
following (which removes reaching outside the function for "type")?

diff --git a/builtin/config.c b/builtin/config.c
index 7184c09582..53755ca461 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,8 +61,8 @@ static int show_origin;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5

-#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
-	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
+#define OPT_CALLBACK_VALUE(s, l, v, h, f, i) \
+	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
 	PARSE_OPT_NONEG, (f), (i) }

 static struct option builtin_config_options[];
@@ -71,7 +71,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
 	if (unset) {
-		type = 0;
+		*((int *) opt->value) = 0;
 		return 0;
 	}

@@ -95,7 +95,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			die(_("unrecognized --type argument, %s"), arg);
 	}

-	if (type != 0 && type != new_type) {
+	int *to_type = opt->value;
+	if (*to_type && *to_type != new_type) {
 		/*
 		 * Complain when there is a new type not equal to the old type.
 		 * This allows for combinations like '--int --type=int' and
@@ -107,7 +108,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
-	type = new_type;
+	*to_type = new_type;

 	return 0;
 }
@@ -135,12 +136,12 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", NULL, "", N_("value is given this type"), option_parse_type),
-	OPT_CALLBACK_VALUE(0, "bool", N_("value is \"true\" or \"false\""), option_parse_type, TYPE_BOOL),
-	OPT_CALLBACK_VALUE(0, "int", N_("value is decimal number"), option_parse_type, TYPE_INT),
-	OPT_CALLBACK_VALUE(0, "bool-or-int", N_("value is --bool or --int"), option_parse_type, TYPE_BOOL_OR_INT),
-	OPT_CALLBACK_VALUE(0, "path", N_("value is a path (file or directory name)"), option_parse_type, TYPE_PATH),
-	OPT_CALLBACK_VALUE(0, "expiry-date", N_("value is an expiry date"), option_parse_type, TYPE_EXPIRY_DATE),
+	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), option_parse_type, TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), option_parse_type, TYPE_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), option_parse_type, TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), option_parse_type, TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), option_parse_type, TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),


Thanks,
Taylor

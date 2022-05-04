Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8871C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 10:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbiEDKLv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiEDKLt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 06:11:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3098724948
        for <git@vger.kernel.org>; Wed,  4 May 2022 03:08:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k1so999875pll.4
        for <git@vger.kernel.org>; Wed, 04 May 2022 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+QUPRqaoUo6Qer57SQ7wCjYeKuSlE9Anflp19gdP5s=;
        b=GNfq4A/F8MaT13pqbS33vJLe8fpgLcreUTbp8V5sDQ1QoDm+sh6+th4zr7MvDxvCBZ
         yMfNEbQtu50Be7FoIti+dbRa83Q3NisrFRznOZp/zPtTKgK/d6O3zGvkUB8oNjoBnbxc
         RN2HHxEPDC1SMofe6ICiQgrDZBkcvM6eW3t5kB2Z4bXsZ9hFtzxdEglPZMl7b1ZUzpU5
         4uhaIe+2mPLAlvXgFjZ+K+Y+6RPrWmyZGKXGFI0awHMBX1LbZkWIhMduXWvEbEEprr/W
         BWlbre3KAUMrBlcv++btc9nxpGQ+LAVPDDqFJJlJaE1I8Nmf8WWTpRv2YdA1gtFJkM1W
         JeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+QUPRqaoUo6Qer57SQ7wCjYeKuSlE9Anflp19gdP5s=;
        b=oc53EB0R24CP+CHb3k5YJpHaf/gup5C66MWo8sOuMf1EgipXB337aG1BJeRl79kRlM
         kg6hSjq6WjZ1mtNBXPkdPEHAmVyb55yda2/jEHm5VXvau0BL69YMbUWZNbMCsQXqy2sE
         m+a8HgwikaYOJIvYCUtbqFTCfcn95Y/f9mFzWCVvRIONYgNQZ7j32YFctQ//sNGOF7kd
         0NPkhK1Q+Cf+0Cn1XOCGOSYt4WhwZmh6pN1N/Yhwh6d4P10Or0dLBG+9AA36V4NK3POl
         E8Re+AvUbd6JlsP39yxq6aiLWA8nXyBXBrU33Mny2nw8hPfkyODtxIpOIZVrP2Fa/lLE
         dj7w==
X-Gm-Message-State: AOAM530gWfmhK1n6kl50mxT61055fFp3Rn+7A5+UiXIXFvJfCY4o/6Yl
        z4ChIy7dnMyfGuEC8F54LxReo/EEyY1qPSjwjvk=
X-Google-Smtp-Source: ABdhPJwBDIWFaS/h7mj2hbD8GftEppefevIgveHiB6R4Vo6Xjx5+PqbnbXc3k2i9glqeq8kXYKqOOLvD99AEjDCorEk=
X-Received: by 2002:a17:902:ce8b:b0:15e:c249:1bf0 with SMTP id
 f11-20020a170902ce8b00b0015ec2491bf0mr3412261plg.125.1651658891463; Wed, 04
 May 2022 03:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220502083639.610279-1-chriscool@tuxfamily.org> <xmqqfslrycvp.fsf@gitster.g>
In-Reply-To: <xmqqfslrycvp.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 4 May 2022 12:07:59 +0200
Message-ID: <CAP8UFD0hWUudP6pZVGS5yOVCjbBCm1LdK_EbrsQp9KiVPPMCyA@mail.gmail.com>
Subject: Re: [PATCH] http: add custom hostname to IP address resolves
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jacob Vosmaer <jacob@gitlab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 2, 2022 at 9:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Subject: Re: [PATCH] http: add custom hostname to IP address resolves
>
> I can guess what you means, but I am not able to quite parse the
> above.  I guess the phrase that makes me hiccup when I read is
> "resolve" used as a noun.

Ok, I will use "http: add custom hostname to IP address resolutions"
in the next version then.

> > Libcurl has a CURLOPT_RESOLVE easy option that allows
> > hostname resolve information in the following form to
>
> The same here, "... allows the result of hostname resolution in the
> following format ...", perhaps?

Ok, I will use your suggestion.

> > be passed:
> >
> >       [+]HOST:PORT:ADDRESS[,ADDRESS]
> >
> > This way, redirects and everything operating against the
> > HOST+PORT will use the provided ADDRESS(s).
> >
> > The following form is also allowed to stop using these
> > resolves:
> >
> >       -HOST:PORT
>
> The above is a reasonable summary of CURLOPT_RESOLVE documentation
> that is appropriate to have here for those of us who are not
> familiar with it.  For those of us who may want to learn more, it
> would help to have an URL to the canonical documentation page, e.g.
> https://curl.se/libcurl/c/CURLOPT_RESOLVE.html but it is not
> required.  People should be able to find it easily.

Yeah, I also thought that it wasn't required, but I will add it
anyway, as I agree it could be useful and hopefully it doesn't change
very often.

> > Let's add a corresponding "http.hostResolve" config
> > option that takes advantage of CURLOPT_RESOLVE.
>
> CURLOPT_RESOLVE allows us to feed cURL a list of these <host,port>
> -> <address> mappings, so we use that mechansim to feed the values
> listed on the multi-valued configuration variable (spell it out as
> such, by the way, instead of saying "config option", which may give
> a false impression that it is a last-one-wins single string with
> many such mapping entries on it).
>
> OK.
>
> > Each value configured for the "http.hostResolve" key
> > is passed "as is" to curl through CURLOPT_RESOLVE, so it
> > should be in one of the above 2 forms. This keeps the
> > implementation simple and makes us consistent with
> > libcurl's CURLOPT_RESOLVE, and with curl's corresponding
> > `--resolve` command line option.
>
> OK.
>
> > I am not sure if some tests could/should be added. Ideas about how to
> > test this are welcome.
>
> It should.  Perhaps invent a totally bogus domain name, map that to
> localhost ::1, run a test server locally, and try to clone from that
> bogus domain?

Ok, I will add a simple test like this.

> > +http.hostResolve::
>
> Is "host" a good prefix for it?
>
> In the context of HTTP(s), if there is no other thing than host that
> we resolve, "http.resolve" may be sufficient.  For those who are
> looking for CURLOPT_RESOLVE equivalent, "http.curloptResolve" may
> make it easier to find.

I am Ok with just "http.resolve". I think using "curlopt" is perhaps
going into too many details about the implementation of the feature,
which could theoretically change if we ever decided to use something
other than curl.

> > +     Hostname resolve information that will be used first when sending
> > +     HTTP requests.  This information should be in one of the following
> > +     forms:
> > +
> > +     - [+]HOST:PORT:ADDRESS[,ADDRESS]
> > +     - -HOST:PORT
> > +
> > ++
> > +The first form redirects all requests to the given `HOST:PORT`
> > +to the provided `ADDRESS`(s). The second form clears all previous
> > +config values for that `HOST:PORT` combination.  To allow easy
> > +overriding of all the settings inherited from the system config,
> > +an empty value will reset all resolve information to the empty
> > +list.
>
> If I understand your use case correctly, this is not something you
> would want to hardcode in your configuration files for long term, is
> it?

Right, but I wonder if there are other use cases where people would
like to hardcode it, for example on a private network where IP
addresses rarely change. Also a config option makes it more consistent
with "http.extraHeaders" and other such options.

> I am wondering if we want to mention the expected use case here
> as well, something like
>
>     This is designed to be used primarily from the command line
>     configuration variable override, e.g.
>
>         $ git -c http.resolve=example.com:443:127.0.0.1 \
>             clone https://example.com/user/project.git
>
> perhaps?  Not a suggestion, but soliciting thoughts.

I am also interested in others' thoughts about this. If no one thinks
that a config option could be useful, I am Ok with making it a
"--resolve" command line option that can be passed to any Git command
similar to "-c <name>=<value>":

git --resolve=... <command> [<args>]

> > diff --git a/http.c b/http.c
> > index 229da4d148..e9cc46ee52 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -128,6 +128,9 @@ static struct curl_slist *pragma_header;
> >  static struct curl_slist *no_pragma_header;
> >  static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
> >
> > +static struct curl_slist *host_resolves;
> > +static struct string_list http_host_resolve = STRING_LIST_INIT_DUP;
> > +
> >  static struct active_request_slot *active_queue_head;
> >
> >  static char *cached_accept_language;
> > @@ -393,6 +396,17 @@ static int http_options(const char *var, const char *value, void *cb)
> >               return 0;
> >       }
> >
> > +     if (!strcmp("http.hostresolve", var)) {
> > +             if (!value) {
> > +                     return config_error_nonbool(var);
> > +             } else if (!*value) {
> > +                     string_list_clear(&http_host_resolve, 0);
>
> OK, this is a way to "clear" the list of entries accumulated on this
> multi-valued configuration variable so far.  And it is documented in
> the above, too.  Good.
>
> > +             } else {
> > +                     string_list_append(&http_host_resolve, value);
> > +             }
> > +             return 0;
> > +     }
> > +
> >       if (!strcmp("http.followredirects", var)) {
> >               if (value && !strcmp(value, "initial"))
> >                       http_follow_config = HTTP_FOLLOW_INITIAL;
> > @@ -985,6 +999,17 @@ static void set_from_env(const char **var, const char *envname)
> >               *var = val;
> >  }
> >
> > +static struct curl_slist *http_copy_host_resolve(void)
> > +{
> > +     struct curl_slist *hosts = NULL;
> > +     const struct string_list_item *item;
> > +
> > +     for_each_string_list_item(item, &http_host_resolve)
> > +             hosts = curl_slist_append(hosts, item->string);
> > +
> > +     return hosts;
> > +}
> > +
> >  void http_init(struct remote *remote, const char *url, int proactive_auth)
> >  {
> >       char *low_speed_limit;
> > @@ -1048,6 +1073,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
> >       no_pragma_header = curl_slist_append(http_copy_default_headers(),
> >               "Pragma:");
> >
> > +     host_resolves = http_copy_host_resolve();
>
> This is curious.  I imagined that the reason why you keep the
> original in a string_list and copy it to a curl_slist was perhaps
> because you'll lose the latter every time you make a curl request,
> but it does not appear to be the case.  You http_init() just once
> and then the same CURL *curl instance will be reused until you clear
> it with http_cleanup().  So I do not see offhand the need to have
> the string_list at all.

Ok, I will remove it.

> Does it work equally well if you used curl_slist_append() in
> http_options() and maintain ONLY the curl_slist version of the
> host_resolve list?  That would make it unnecessary to keep
> http_host_resolve and add http_copy_host_resolve() function, no?

Yeah, right. I will remove http_host_resolve and http_copy_host_resolve().

Thanks!

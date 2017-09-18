Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 144762047F
	for <e@80x24.org>; Mon, 18 Sep 2017 16:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932970AbdIRQ4S (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 12:56:18 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:57324 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbdIRQ4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 12:56:17 -0400
Received: by mail-pg0-f52.google.com with SMTP id 7so439273pgd.13
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNngMGi81j70QXlqQT9+v+rmmYJPJFd/k9B9Orl0rxk=;
        b=Ioy4ul0HwB5nGZ8AXiCoRzxffyiaJXdDG6CpbDsknvBXyb0fm/DyBJfsLgpBVbYjf1
         0epHVbIJ4BVunZIJ9fp2Wz3q8qvn+pkiB6G/a9nkrBQkO3aCV97osh5C41FGkNsmcsnS
         AN6on1x52uk6YjLyVssm2UbFHbCv+VSTCGNFAkWKtBZwmDNS3/YOVbmFgBQEqdVDD2Nr
         ZP8Yu0jpqLdkDHOv4qGwvZpcMvwLVvbKvZHWYZpZKoGsF6f7fWliyMueYozlnoW+aQqW
         gOnDG1WBg2r8LANo0N+E7IZ4BKqWSjA+4HCTy19JK62JB33pfj2dApx52OB74CM/B36B
         dRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNngMGi81j70QXlqQT9+v+rmmYJPJFd/k9B9Orl0rxk=;
        b=iTqlD5LnwtaAZT7mY4nNXaXKE8Tj9kboVuGuUAkXCdTVt6jDE1yRpKiG2MJbV0Jl3S
         dX5fRQISA3tMDP8oQv+jQVu5QLaV6WtCSFvVJLC5sw0VZMupT2jyZ3O9HIVP8/vxrcuQ
         JK1nEX824pHc5RuJyOQsxfK6/AEI5ZgLOivS6ZHSer81wMgH80Wzhgfnx0zBLV0ODpzV
         59HNmygzPH0oEe/l3qyAD641Kqu5ZDJT044c2jJCxVD4zET0d6Nd1xpwQnFZOb53ovIg
         2O6eq264MenkIxCgatlSQ5AeR88nQ8yYmENKWHxv0+qfexozLOj++w5Fobu5eI5vfWnV
         i6eg==
X-Gm-Message-State: AHPjjUjQTDQz4Dx3V7DcN7h4MCTtMbE/GnAh7/GZYDBLBV76DqkA5Gew
        5XPAz9I7jSF51ZAK
X-Google-Smtp-Source: AOwi7QDAjwRENObB4YcVJ/11JynBk6kVrplcnOiF5sW9cVpptL8w5nEjtrpODH//FBkLMz7dYLcZfw==
X-Received: by 10.98.192.18 with SMTP id x18mr8050218pff.2.1505753777164;
        Mon, 18 Sep 2017 09:56:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c140:486c:cfb0:5862])
        by smtp.gmail.com with ESMTPSA id y83sm16332224pff.167.2017.09.18.09.56.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 09:56:16 -0700 (PDT)
Date:   Mon, 18 Sep 2017 09:56:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, bturner@atlassian.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/8] daemon: recognize hidden request arguments
Message-ID: <20170918165615.GE144331@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170913215448.84674-4-bmwill@google.com>
 <CAGZ79kZkGfM=2Nek66gvZnbMAu2HLUkbd4D4S5Rij1D_t5DYKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZkGfM=2Nek66gvZnbMAu2HLUkbd4D4S5Rij1D_t5DYKg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/13, Stefan Beller wrote:
> On Wed, Sep 13, 2017 at 2:54 PM, Brandon Williams <bmwill@google.com> wrote:
> > A normal request to git-daemon is structured as
> > "command path/to/repo\0host=..\0" and due to a bug in an old version of
> > git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> > command, 2009-06-04) we aren't able to place any extra args (separated
> > by NULs) besides the host.
> >
> > In order to get around this limitation teach git-daemon to recognize
> > additional request arguments hidden behind a second NUL byte.  Requests
> > can then be structured like:
> > "command path/to/repo\0host=..\0\0version=1\0key=value\0".  git-daemon
> > can then parse out the extra arguments and set 'GIT_PROTOCOL'
> > accordingly.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  daemon.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 61 insertions(+), 10 deletions(-)
> >
> > diff --git a/daemon.c b/daemon.c
> > index 30747075f..250dbf82c 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -282,7 +282,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
> >         return NULL;            /* Fallthrough. Deny by default */
> >  }
> >
> > -typedef int (*daemon_service_fn)(void);
> > +typedef int (*daemon_service_fn)(const struct argv_array *env);
> >  struct daemon_service {
> >         const char *name;
> >         const char *config_name;
> > @@ -363,7 +363,7 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
> >  }
> >
> >  static int run_service(const char *dir, struct daemon_service *service,
> > -                      struct hostinfo *hi)
> > +                      struct hostinfo *hi, const struct argv_array *env)
> >  {
> >         const char *path;
> >         int enabled = service->enabled;
> > @@ -422,7 +422,7 @@ static int run_service(const char *dir, struct daemon_service *service,
> >          */
> >         signal(SIGTERM, SIG_IGN);
> >
> > -       return service->fn();
> > +       return service->fn(env);
> >  }
> >
> >  static void copy_to_log(int fd)
> > @@ -462,25 +462,34 @@ static int run_service_command(struct child_process *cld)
> >         return finish_command(cld);
> >  }
> >
> > -static int upload_pack(void)
> > +static int upload_pack(const struct argv_array *env)
> >  {
> >         struct child_process cld = CHILD_PROCESS_INIT;
> >         argv_array_pushl(&cld.args, "upload-pack", "--strict", NULL);
> >         argv_array_pushf(&cld.args, "--timeout=%u", timeout);
> > +
> > +       argv_array_pushv(&cld.env_array, env->argv);
> > +
> >         return run_service_command(&cld);
> >  }
> >
> > -static int upload_archive(void)
> > +static int upload_archive(const struct argv_array *env)
> >  {
> >         struct child_process cld = CHILD_PROCESS_INIT;
> >         argv_array_push(&cld.args, "upload-archive");
> > +
> > +       argv_array_pushv(&cld.env_array, env->argv);
> > +
> >         return run_service_command(&cld);
> >  }
> >
> > -static int receive_pack(void)
> > +static int receive_pack(const struct argv_array *env)
> >  {
> >         struct child_process cld = CHILD_PROCESS_INIT;
> >         argv_array_push(&cld.args, "receive-pack");
> > +
> > +       argv_array_pushv(&cld.env_array, env->argv);
> > +
> >         return run_service_command(&cld);
> >  }
> >
> > @@ -574,7 +583,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
> >  /*
> >   * Read the host as supplied by the client connection.
> >   */
> > -static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> > +static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> >  {
> >         char *val;
> >         int vallen;
> > @@ -602,6 +611,39 @@ static void parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
> >                 if (extra_args < end && *extra_args)
> >                         die("Invalid request");
> >         }
> > +
> > +       return extra_args;
> > +}
> > +
> > +static void parse_extra_args(struct argv_array *env, const char *extra_args,
> > +                            int buflen)
> > +{
> > +       const char *end = extra_args + buflen;
> > +       struct strbuf git_protocol = STRBUF_INIT;
> > +
> > +       for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
> > +               const char *arg = extra_args;
> > +
> > +               /*
> > +                * Parse the extra arguments, adding most to 'git_protocol'
> > +                * which will be used to set the 'GIT_PROTOCOL' envvar in the
> > +                * service that will be run.
> > +                *
> > +                * If there ends up being a particular arg in the future that
> > +                * git-daemon needs to parse specificly (like the 'host' arg)
> > +                * then it can be parsed here and not added to 'git_protocol'.
> > +                */
> > +               if (*arg) {
> > +                       if (git_protocol.len > 0)
> > +                               strbuf_addch(&git_protocol, ':');
> > +                       strbuf_addstr(&git_protocol, arg);
> > +               }
> > +       }
> > +
> > +       if (git_protocol.len > 0)
> > +               argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> > +                                git_protocol.buf);
> > +       strbuf_release(&git_protocol);
> >  }
> 
> I wonder if this could be written as
> 
>   begin = extra_args;
>   p = extra_args;
>   end = extra_args + buflen;
> 
>   while (p < end) {
>     if (!*p)
>         *p = ':';
>     p++;
>   }
>   argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s", begin);
> 
> to ease the load on the server side, as then we do not
> have to copy the partial strings into strbufs and then
> count the length individually? (maybe performance is no big deal here?)

I'm sure something like that could work, and I don't know how
performance sensitive this bit is.  That and depending on if we need the
unmodified string for anything at a later point maybe its best to not
modify it in place?  I don't know :)

> 
> 
> >
> >  /*
> > @@ -695,6 +737,7 @@ static int execute(void)
> >         int pktlen, len, i;
> >         char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
> >         struct hostinfo hi;
> > +       struct argv_array env = ARGV_ARRAY_INIT;
> >
> >         hostinfo_init(&hi);
> >
> > @@ -716,8 +759,14 @@ static int execute(void)
> >                 pktlen--;
> >         }
> >
> > -       if (len != pktlen)
> > -               parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
> > +       if (len != pktlen) {
> > +               const char *extra_args;
> > +               /* retrieve host */
> > +               extra_args = parse_host_arg(&hi, line + len + 1, pktlen - len - 1);
> > +
> > +               /* parse additional args hidden behind a second NUL byte */
> > +               parse_extra_args(&env, extra_args + 1, pktlen - (extra_args - line) - 1);
> > +       }
> >
> >         for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
> >                 struct daemon_service *s = &(daemon_service[i]);
> > @@ -730,13 +779,15 @@ static int execute(void)
> >                          * Note: The directory here is probably context sensitive,
> >                          * and might depend on the actual service being performed.
> >                          */
> > -                       int rc = run_service(arg, s, &hi);
> > +                       int rc = run_service(arg, s, &hi, &env);
> >                         hostinfo_clear(&hi);
> > +                       argv_array_clear(&env);
> >                         return rc;
> >                 }
> >         }
> >
> >         hostinfo_clear(&hi);
> > +       argv_array_clear(&env);
> >         logerror("Protocol error: '%s'", line);
> >         return -1;
> >  }
> > --
> > 2.14.1.690.gbb1197296e-goog
> >

-- 
Brandon Williams

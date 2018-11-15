Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6B41F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 20:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbeKPGqa (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 01:46:30 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:39140 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKPGqa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 01:46:30 -0500
Received: by mail-ed1-f41.google.com with SMTP id b14so15309222edt.6
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHH3IE4C+mTgXIWgXnfBBk6mfaltTVY+byFtXiAChDg=;
        b=Gs86NYrkoVGey/h8MsbDLwxHnltcmQvRUmbt8ZWIzhMt8n1vMysY/mlUc9L8I8n+RM
         OZcWjz9hsSx5OsSLNbxdgOABZTr57SYFWa4+hkwWflhNTFT5ilj7Qb9jK84FEqGH+Qam
         lL1P0/AKSRwmZMO1KDOCTfXyUlAtaC4FWmgcbzs5KGCqkRk9DwkI4ZE7MCinW2GWUsR1
         YN0ANoxe9aaRemekAwfNo8wmIbNRDHo4xKU4xTonFFQHI9Uq7rY3BmhLk9sIljtueEu0
         Vn7/xLODsH81uvop3TyAVBAoGDhJ2yuP/dH/h6DXI/V7oEEZc6j3hz+zFOszSseQgjTh
         jvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHH3IE4C+mTgXIWgXnfBBk6mfaltTVY+byFtXiAChDg=;
        b=CCgRzQ6agcmi/5MUSstqtAjeLS1dNT4kmBqHpuHIYjNU8gHCLs+eKYJ2AfaRqVkcug
         sO6iU96HlVHsk4R38PyBI+nMrejcz4cPENTw7JIMUXWy5wTTaX/0j1b8pNmsqYC74nu7
         HOgKHJ8kH68WaMV5bzEDVClPGYCkHRomI9wBGDDaW2ocxq1V8/7elMIlPhjnDUIfSxrb
         HfpSGc79C6nfVCQvE3uEH1mj5Ei3oeolSgVbHfSfAmB4N7nDCjCYQ+Khhe48Q6nbO/o+
         0aIc+OUN3YwoBIZ8DAPrs5rVgiO1lXGQ4ZZZNTL8Q77PBqgBukVgUX9vPADFfIEZcQ7u
         hVyw==
X-Gm-Message-State: AGRZ1gJR3f5QOt3WjTx7yx+TmEkqfGpJhgOyMs5/8QIRk8h8f1U6xKrA
        zQ+dawgSDoFYpxqtCefchAeZox6zKof76O5LnHgAUQ==
X-Google-Smtp-Source: AJdET5exNs4joZrXNCRtGVMtpi27g91Y3xSjFvWk3ZZoAMzrD8Fyb/zmx3vnNJvr6Lnl63biIvx0VdJpIaBdisC94rU=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr6438815eji.67.1542314227768;
 Thu, 15 Nov 2018 12:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20181114001306.138053-19-sbeller@google.com> <20181115195416.21890-1-jonathantanmy@google.com>
In-Reply-To: <20181115195416.21890-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Nov 2018 12:36:56 -0800
Message-ID: <CAGZ79kZ72eQPiQ_KW1QkiRqMFUAUpCQCHZdk3RSMVK7TGPE2aw@mail.gmail.com>
Subject: Re: [PATCH 18/23] submodule: use submodule repos for object lookup
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 11:54 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +/*
> > + * Initialize 'out' based on the provided submodule path.
> > + *
> > + * Unlike repo_submodule_init, this tolerates submodules not present
> > + * in .gitmodules. This function exists only to preserve historical behavior,
> > + *
> > + * Returns 0 on success, -1 when the submodule is not present.
> >   */
> > -static void show_submodule_header(struct diff_options *o, const char *path,
> > +static struct repository *open_submodule(const char *path)
>
> The function documentation needs to be reworded - there's no "out", and
> the return value is now a possibly NULL pointer to struct repository.

Noted.

>
> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +     struct repository *out = xmalloc(sizeof(*out));
> > +
> > +     if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> > +             strbuf_release(&sb);
> > +             free(out);
> > +             return NULL;
> > +     }
> > +
> > +     out->submodule_prefix = xstrdup(path);
>
> I've discussed this submodule_prefix line before [1] - do we really need
> this? Tests pass even if I remove this line.

We might not need it yet as the tests indicate, but it's the right thing to do:
/*
 * Path from the root of the top-level superproject down to this
 * repository.  This is only non-NULL if the repository is initialized
 * as a submodule of another repository.
 */

We're not (yet) using this string in our error reporting, but
I anticipate that we'll do eventually.

> Other than that, this patch looks good.

Thanks,
Stefan

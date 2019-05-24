Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE291F462
	for <e@80x24.org>; Fri, 24 May 2019 08:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfEXIGA (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 04:06:00 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34766 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388959AbfEXIF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 04:05:59 -0400
Received: by mail-ed1-f46.google.com with SMTP id p27so13181090eda.1
        for <git@vger.kernel.org>; Fri, 24 May 2019 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KTP8xo8bXt3EqCAo6ry32/b5+DzTsRWcd2joGB1ntSU=;
        b=GTg9NKXI/h5kqekLgssorVwVnMk4c4XGv+/SZVb8+bTyLUVoC1DV7r4G0KQvCt3yCS
         xEICklUEK45OCyB1LulbqJ3zv3DhX6S0npe82noNDXTq8CEZW55hNrfBVSnu101J82sm
         J89QjADZn6TxdYJrPHQBMnePv3xtNuWj3kJam8iXGsStXAIBZ3pMdV9daHVih7LSCXeg
         FZzDdeo2WbDGDQimvaCmBx7PwUzhqCN6D19TNHuNrX66NneZ7g712qeRS3RyiZ7NZMmh
         hhUyTq3IvSwW6+6pG4DZokXsJHBGoiJRNOxJPr8vv3Y8PSqEVVLNIMaUMJfeiXO1aaDT
         CujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KTP8xo8bXt3EqCAo6ry32/b5+DzTsRWcd2joGB1ntSU=;
        b=qaciEvfVgr8Ahi4EfH2vOECYg1EhUTfKEoEgPZMd0eRiqGiilFmx2b8sTe+Y9FD881
         czNFgXbOQozbkyWt1xv/bR9pllpEXKpOgscLObljRgKkMywVy8sqAwgagOmLgVyYT+fO
         Fk3R+HwFbrOvDZYKqmuh3CN5at5V+bZrQ2fjlDhah8OnIuTCPw3pb8CPndlW2FCAaBKo
         TbRFV+Hr6U23oV+VVvvh9fTPj9QGgtavSw2eEujwAie1bNHzfDNm6f6zpv5XJV2DnYUz
         LsMo/eRi64b2JGqmnQ7je6Y37tAig7xFi2XvYax21o70aed4jML5CzhpzEFTeapGCZMz
         eZxg==
X-Gm-Message-State: APjAAAV12AVYnfQcSI2ffVm2g5B9GYkbx23GZoFTSbLa3TzuVtVCxgR/
        LxDia34BmNKlx/UIxLgLTnoERVGHaGnjA7uu0hKQC9/v3s4=
X-Google-Smtp-Source: APXvYqxXMJUzRfTSU4muFUhzugP4fGDs3F+hk9215Soea6lbGBcAkYid1sbKLKEQc1DklbsSnG0jWmiE856XDquZEKU=
X-Received: by 2002:a50:ec87:: with SMTP id e7mr102309962edr.126.1558685157835;
 Fri, 24 May 2019 01:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181108050755.GA32158@sigill.intra.peff.net> <79b06312-75ca-5a50-c337-dc6715305edb@jeffhostetler.com>
 <20181122173931.GA22123@sigill.intra.peff.net>
In-Reply-To: <20181122173931.GA22123@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 24 May 2019 10:05:45 +0200
Message-ID: <CAP8UFD0XbOUj70pt4X=HDvGBoLaG9qBv9SWGnM6N8FG3t-57rg@mail.gmail.com>
Subject: Re: how does "clone --filter=sparse:path" work?
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Matthew DeVore <matvore@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Sorry for the late reply to this.)

On Sat, Nov 24, 2018 at 8:07 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Nov 08, 2018 at 01:57:52PM -0500, Jeff Hostetler wrote:
>
> > > Should we simply be disallowing sparse:path filters over upload-pack?

I agree that it should either be disallowed or heavily restricted.

> > The option to allow an absolute path over the wire probably needs more
> > thought as you suggest.
> >
> > Having it in the traverse code was useful for local testing in the
> > client.
> >
> > But mainly I was thinking of a use case on the client of the form:
> >
> >     git rev-list
> >         --objects
> >         --filter=spec:path=.git/sparse-checkout

Do you mean "sparse:path" instead of "spec:path"?

> >         --missing=print
> >         <commit>
> >
> > and get a list of the blobs that you don't have and would need before
> > you could checkout <commit> using the current sparse-checkout definition.
> > You could then have a pre-checkout hook that would bulk
> > fetch them before starting the actual checkout.  Since that would be
> > more efficient than demand-loading blobs individually during the
> > checkout.  There's more work to do in this area, but that was the idea.
> >
> > But back to your point, yes, I think we should restrict this over the
> > wire.
>
> Thanks for your thorough response, and sorry for the slow reply. I had
> meant to reply with a patch adding in the restriction, but I haven't
> quite gotten to it. :)

The way I see it could be restricted is by adding a config option on
the server, maybe called "uploadpack.sparsePathFilter", to tell which
filenames can be accessed using "--filter=sparse:path=".

For example with uploadpack.sparsePathFilter set to
"/home/user/git/sparse/*" and "--filter=sparse:path=foo" then
"/home/user/git/sparse/foo" on the server would be used if it exists.
(Of course care should be taken that things like
"--filter=sparse:path=bar/../../foo" are rejected.)

If uploadpack.sparsePathFilter is unset or set to "false", then
"--filter=sparse:path=<stuff>" would always error out.

Is this what you had in mind?

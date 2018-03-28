Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3E01F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeC1Sp4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:45:56 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:33296 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeC1Spz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:45:55 -0400
Received: by mail-ot0-f179.google.com with SMTP id 23-v6so3787208otj.0
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73mV0vwTsDtl3o3LCco+Oq3/7xPyVKueEY1dNI3dX7c=;
        b=Dtzn2ObcuTM3PPAbbWGU4utJUAkpXJDZx8lHsFezgt29rSFfF1OMUplxmhxcPOcuy0
         HEuoXYuH4wQRpzi3Usuj/P/lSAWdHh8PJWrbBU2srhfmUad0jgTlrUWE5axtaVuJZ0tv
         VssM790nAjuELDq7EvHcKnMLu4apQbl/E8TaA1bsKxWe2/dQW43cASZJVKrhHvQuIkBS
         mxXJGu/B/qQrF/OhDyCXRiXvWFgACIm+juQCYuCeW5vSLrz28PUehmkTeySnlm0IgqX3
         LpR587ZM4O/ptF3xxqlW1ACIp/3heh532Rtu0AcQykgyJ7LFtUdZeEKx7yBK6Rt3eZpX
         ubsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73mV0vwTsDtl3o3LCco+Oq3/7xPyVKueEY1dNI3dX7c=;
        b=feLrwr0rHyMBBPQsfAdlzFDlMQKTK1pN+6AhaYBUEhyjfWuOxouLAHrazHFyRABC8M
         F4e4hV7w3ymPPW7ajUL6prXXqVp0rO07uDEBTaOQkL5pMdU46DGd668QhrMPSp81Y74f
         Y0fXI3LyY6zfYnzIUpUJrao4VgW18AMhAfqfzhg0DkK9ajRgAcvW9cP+mqiq/5xZWVMw
         9qsxJeaJvn+GbLedqYnnuyGtQ3adBsvaDMoG/Q1z8wah7EcMTaiO2aFHjFWbKUfAqmZ1
         tiY7JXkR3Pp7YDp//YO+ig22Wq9RBXFCJQtMyWlTUczD4khkFxT7I54c44FCYCXAJ4Gd
         Zl/Q==
X-Gm-Message-State: ALQs6tB92D+NXlIYt3fk03ZZtz89t/Yw09K2JnIPtmZ+p21ODb50UL+K
        edxrTriPqAQ+iCDYEroi+nHyHU/+as02469juFs=
X-Google-Smtp-Source: AIpwx48KQcpIRsWAjuFu6SzOMrThbaquu/JdOwWSf8udnAz2O548WMZPe0qeFEJyI9nWCg+7pwGTLq9iBeJGc0xGL9A=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr3135370ota.152.1522262754410;
 Wed, 28 Mar 2018 11:45:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Wed, 28 Mar 2018 11:45:23 -0700 (PDT)
In-Reply-To: <20180328183011.GA16931@sigill.intra.peff.net>
References: <20180328094733.GA1523@sigill.intra.peff.net> <20180328175537.17450-1-pclouds@gmail.com>
 <20180328175537.17450-7-pclouds@gmail.com> <20180328183011.GA16931@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Mar 2018 20:45:23 +0200
Message-ID: <CACsJy8COj-usWbJzb_CRF95an94QhpTcc+uv-VDxmPbDfH+o6g@mail.gmail.com>
Subject: Re: [PATCH 6/8] environment.c: adjust env containing relpath when
 $CWD is moved
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 8:30 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 28, 2018 at 07:55:35PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> From: Duy Nguyen <pclouds@gmail.com>
>>
>> As noted in the previous patch, when $CWD is moved, we recognize the
>> problem with relative paths and update $GIT_WORK_TREE and $GIT_DIR
>> with new ones.
>>
>> We have plenty more environment variables that can contain paths
>> though. If they are read and cached before setup_work_tree() is
>> called, nobody will update them and they become bad paths.
>
> Hmm, yeah, I missed these. It would be interesting to know if there are
> easy-to-run test cases that show off these bugs, or if they're
> hypothetical. (Even if they are hypothetical, I'm not opposed to fixing
> them in the name of maintainability).

It's kinda hard to show off these. But the GIT_ALTERNATE_OBJ..
variable could be one example in favor of this fix. Before, we lazily
read the env var which is most likely after setup_work_tree() has run.
After a bunch of code reorganization and stuff, GIT_ALTERNATE_OBJ is
now read very early, which should be safe (why not?) but it actually
breaks. Alternate db is only queried as the last resort if I'm not
mistaken, so 90% of time you just hit an object in odb and never find
out that your GIT_ALTERNATE_OBJ... points to nowhere.

>> diff --git a/environment.c b/environment.c
>> index 39b3d906c8..f9dcc1b99e 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -128,6 +128,20 @@ const char * const local_repo_env[] =3D {
>>       NULL
>>  };
>>
>> +/* A subset of local_repo_env[] that contains path */
>> +const char * const local_repo_path_env[] =3D {
>> +     ALTERNATE_DB_ENVIRONMENT,
>> +     CONFIG_ENVIRONMENT,
>> +     DB_ENVIRONMENT,
>> +     GIT_COMMON_DIR_ENVIRONMENT,
>> +     GIT_DIR_ENVIRONMENT,
>> +     GIT_SHALLOW_FILE_ENVIRONMENT,
>> +     GIT_WORK_TREE_ENVIRONMENT,
>> +     GRAFT_ENVIRONMENT,
>> +     INDEX_ENVIRONMENT,
>> +     NULL
>> +};
>
> It might be nice to fold this list into local_repo_env automatically. I
> think you'd have to do it with a macro.

Aha! I did not like the split either and wanted to turn
local_repo_env[] to an array of struct so we can add attributes to
each variable, but the way local_repo_env[] is being used, that's
impossible without more surgery.

> OTOH, it's possible that there could be a path-related environment
> variable that _isn't_ actually part of local_repo_env. E.g., I think
> GIT_CONFIG might classify there (though I don't know if it's worth
> worrying about).

I'd rather fix it now and forget about it than trying to troubleshoot
a problem related to bad relative $GIT_CONFIG (even if the chance of
that happening is probably 1%)

>> +static void update_path_envs(const char *old_cwd, const char *new_cwd,
>> +                          void *cb)
>> +{
>> +     int i;
>> +
>> +     /*
>> +      * FIXME: special treatment needed for
>> +      * GIT_ALTERNATE_OBJECT_DIRECTORIES because it can contain
>> +      * multiple paths.
>> +      */
>
> Yuck. It just keeps getting more complicated. :(
>
> I do wonder if relative paths in variables like this are worth worrying
> about. AFAIK, it's always been a "well, it kind of works" situation, but

Yeah. 99% of time $GIT_DIR is $GIT_WORK_TREE/.git and no path
adjustment is needed.

> not something we've tried to actively support. I think with the current
> code you'd potentially get inconsistent results between a command which
> sets up the work tree and one which doesn't. So this would be fixing
> that, but at the same time, I'm not sure how much we want to promise
> here.

I would be just as happy to die() when we find out we have relative
paths that takes too much work to reparent. It keeps the amount of
work down and will not bite us later (and will let us know if any user
needs it because they would have to report back after hitting the said
die()).
--=20
Duy

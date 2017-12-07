Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F07F20954
	for <e@80x24.org>; Thu,  7 Dec 2017 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbdLGSkd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 13:40:33 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:38860 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdLGSkM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 13:40:12 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so16612094itr.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9i++w+5QjmUsNOdtEtcht//YT4vocc1ohT0SVh4VFQ=;
        b=fUePEYlfJvAnjqBOPcdZslF1XQM/YLtSnFxO18Lb1cdT4DaDVhjFIwl6EFaY6O/u2+
         GLkMXvTtXSOHHKAPwdhw5htc0ePBiGv9bLob5kcbcMHGhlB5mQWgbomLdAq0q7Vs7Tfr
         ltnVVy+O232rHFWj9x9F9fad4Ry+V/yfmQ/oOz3segBU7Z528VyWEmn19AY68Ijwh3xF
         j83IuMRAtOiIPC6FcQ0oUJNtl+PVZM9Gip38FHEqTgv5+o4LCBAAZEFZ7r3X09tTO2Qk
         vCUz8O5qZ3hVP3ZVfewNAi/5GI5r5MJe3h3AzAS7sV8bAiR3fN3KPQNPlt9g5R6PHiZP
         FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9i++w+5QjmUsNOdtEtcht//YT4vocc1ohT0SVh4VFQ=;
        b=k2wYMaEQBR+d/SaIbrgTus/0+sFGRTTMt4i+DomSDiyxD/9FnPXm+8fpcs+swW7By5
         DHCFdjo3LdEX20Pt+XRyN0MxmHEMGMfW39xVgRolW/Zv9RokfXHbJybODznEmnE6YK9p
         nfF4JaNhJhRQm5DBdIxL+O6dPsHVErN2b6V0h+LoHtGU3y/oEZM7WO8g9PJVO9qY6YFt
         i1GLt1ppokhy40QuDtCi3UIUy8n/wH28+G64Y2IzIlEDrkOGrPSzKBx12HuKaYoQmPZ/
         7/UKitbccWqvkDV0b0niQ2v01wn/FGGzKGVPXpoKCAW91b1WnpaMmVX+zO8DJ3JbxJfa
         rVRg==
X-Gm-Message-State: AKGB3mLB0mmRDMb2aqRpgB9YGKRSNqkHzm49Lc5ydX4+aOkPVZtWJcKd
        rSm7dZ4x7B2RnhZ7s8Ne0+PTKQ==
X-Google-Smtp-Source: AGs4zMazA4Oqz/EP30HiDmfSEcPigkfYBME43v33tM9rnVzsbFdsibxXt7v1W7M5VYYVwBDIaMFSSg==
X-Received: by 10.36.47.210 with SMTP id j201mr2351437itj.127.1512672011528;
        Thu, 07 Dec 2017 10:40:11 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id s4sm3003425ita.12.2017.12.07.10.40.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 10:40:10 -0800 (PST)
Date:   Thu, 7 Dec 2017 10:40:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 06/15] transport: use get_refs_via_connect to get refs
Message-ID: <20171207184009.GA152943@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-7-bmwill@google.com>
 <xmqqmv2vfqxh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv2vfqxh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Remove code duplication and use the existing 'get_refs_via_connect()'
> > function to retrieve a remote's heads in 'fetch_refs_via_pack()' and
> > 'git_transport_push()'.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  transport.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> >
> > diff --git a/transport.c b/transport.c
> > index d75ff0514..7c969f285 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -230,12 +230,8 @@ static int fetch_refs_via_pack(struct transport *transport,
> >  	args.cloning = transport->cloning;
> >  	args.update_shallow = data->options.update_shallow;
> >  
> > -	if (!data->got_remote_heads) {
> > -		connect_setup(transport, 0);
> > -		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
> > -				 NULL, &data->shallow);
> > -		data->got_remote_heads = 1;
> > -	}
> > +	if (!data->got_remote_heads)
> > +		refs_tmp = get_refs_via_connect(transport, 0);
> 
> The updated version is equivalent to the original as long as
> transport->data->extra_have is empty at this point.  Were we
> deliberately sending NULL, instead of &data->extra_have, in the
> original, or is it a mere oversight?
> 
> The same comment applies to the other hunk of this patch.

extra_have is only ever used by the push logic, so they're shouldn't be
any harm is passing it through on the fetch side, especially since
upload-pack doesn't send .have lines.

The push side is what uses the .have lines.  From a quick look through
the code it seems like get_refs_via_connect is always called before
git_transport_push, so the extra check to make sure ref's have been
retrieved doesn't get executed.  But if it ever did get executed, we
would silently ignore a server's .have lines.

-- 
Brandon Williams

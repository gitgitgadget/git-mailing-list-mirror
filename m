Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8776C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 20:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCQU32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCQU3W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 16:29:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60D0CA7BA
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:28:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id ce7so3832645pfb.9
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679084930;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZzkVGyeXhDVnuRBlr0jgZHkz3MYwBadfasY2VTqwA4=;
        b=oGgBcMPu8uIWA2PmXDFNJ+X3Gz6YJlEbaOy/czi9qF92NBHSEdIRF7XvPmOXTqsj+c
         qBMi0IvGsII+Huh8G4+FfR6jE7FLwd9AGzEW+h8pomMTChERKrN7KmxqKEG5Jl/vWkTX
         T5OyT5KWbq4H8TlF4GaR+H0m8wzasO0VukkOXDlO7Yu0Q+ETXx6B8RWreWKTz6D/jGdY
         JZlqoQOwuwEwL7/4YjFHs4BYpeI334hrRd41ishqJceTCB+MvD7YmOB5GjMmWYnCJK7V
         u4LueEKu1TDqXvQ+PS97Jrde64yWCBp/N8KhxYtag1pYVHqNirHFDZbe9NimnggklUFg
         dN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084930;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZzkVGyeXhDVnuRBlr0jgZHkz3MYwBadfasY2VTqwA4=;
        b=SxiFKvs4KwWnDCpDB7LHMRuxtimd88Y6SHxctU/RrL9EfmLTReP+ZuQS0vEjyvxo55
         J60ccR3dWIuQ2qtARhOPN8wQKUDr6xt6QkEraRgePYFOKc7Qb+Q6S83aHU9jXv18tSSh
         a1ua84FIpf+NsF55MFAsiCSB/cM1UEPoCBiyXVdX0s1nnBmUifZ08qX+tzi270SL5Bw4
         QAOoRQ+4V3Qx+rpVYAoprx2AcnS4stlOXddWv/sMoM1dHDb3iRVgD3fCFyjg18OxbT80
         gBLcqsnFYoH6wZ7eG4nNkVR77BUQ+yPFMjNG4fbJrDC01UZr2Qnjt7JH7pEI0lXk3ExD
         P1Cg==
X-Gm-Message-State: AO0yUKXYFh0iPQodL6tniLiQtuO/dH+JxO2Ak4K7YsIDYRMRObVthDUh
        BLtas9CSNxxpSHLDx8dyYiDG8Ru458g=
X-Google-Smtp-Source: AK7set/1ioD4brmYE7qgBONIcqglOyWwpj1/XwgRO7TylSIsaIRuXslb7/VUniV9LwZsX9Xe+pgLTg==
X-Received: by 2002:a62:cf04:0:b0:5a8:a0df:a624 with SMTP id b4-20020a62cf04000000b005a8a0dfa624mr6612318pfg.22.1679084929673;
        Fri, 17 Mar 2023 13:28:49 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005907716bf8bsm1961386pfo.60.2023.03.17.13.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 13:28:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] transport: mark unused parameters in
 fetch_refs_from_bundle()
References: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
        <ZBS8vt97YJj3wMxn@coredump.intra.peff.net>
Date:   Fri, 17 Mar 2023 13:28:48 -0700
In-Reply-To: <ZBS8vt97YJj3wMxn@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 17 Mar 2023 15:17:18 -0400")
Message-ID: <xmqq7cvfgm0v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We don't look at the "to_fetch" or "nr_heads" parameters at all. At
> first glance this seems like a bug (or at least pessimisation), because
> it means we fetch more objects from the bundle than we actually need.
> But the bundle does not have any way of computing the set of reachable
> objects itself (we'd have to pull all of the objects out to walk them).
> And anyway, we've probably already paid most of the cost of grabbing the
> objects, since we must copy the bundle locally before accessing it.
>
> So it's perfectly reasonable for the bundle code to just pull everything
> into the local object store. Unneeded objects can be dropped later via
> gc, etc.
>
> But we should mark these unused parameters as such to avoid the wrath of
> -Wunused-parameter.

Very well described, and I agree with the reasoning.

Will queue all four.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  transport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/transport.c b/transport.c
> index 81950bf755f..c5abf26f31e 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -167,7 +167,8 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
>  }
>  
>  static int fetch_refs_from_bundle(struct transport *transport,
> -			       int nr_heads, struct ref **to_fetch)
> +				  int nr_heads UNUSED,
> +				  struct ref **to_fetch UNUSED)
>  {
>  	struct bundle_transport_data *data = transport->data;
>  	struct strvec extra_index_pack_args = STRVEC_INIT;

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 636C81F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeJKIoQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:44:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44096 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKIoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:44:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so7706491wra.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B63sM4TomtM820M+xZsWFZ+W4pqAOBN9jKWWu/pKiHE=;
        b=HLZBgnf04b/FSry5fjk2h+Ki9p5c5jbS6H2INfdhRll8BrOABSpBU5k5G60MMoBFXB
         2CyqtnCc4vSjoK20i7Gzwmx2Unv16BQa2Ssl6HwgbkpLvOk6mu4HQPNjUu9kEC0SMFUW
         PsD0vqtXdgzbHdwR/RgxxHjvXl7B8B9GQpwQcs5l6V8mw4/JEC4oB+zVkLOw3lxJC2kc
         w9QHMPNvfY9Q2G85lHjjBXHhKPTb+qJux54Vg5wCbZTW1FifUi8LOMctpb28dPP1QeQc
         w7WUrXOO9PQCcGu3hOOR4aGrnYYlZSF4oUAQ2kmKSFYKKcclm7xNcshUtyQB5t3SIpZ/
         r+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B63sM4TomtM820M+xZsWFZ+W4pqAOBN9jKWWu/pKiHE=;
        b=MV1sShjl7PQ6kHtceNREgdF3G4EP0KVgVHWCXD4JxK7HRCymHD/RfjzL6gvI/6KctR
         sNWXtbQlHezNHNHYJWvkV2umGDb96HEPnTPyvxvxgsmvqTQ+FKBxKZBZCPgTw8TK6LOp
         dgUbnqO22OYZG8lnpNBC1fQn+C4PhtX7QZZe5msGZpJDiooPN/F6nmKFaLSg///mM+OP
         y12jPjAx8Jyf37J/IE5G8Ozxgvib72+InXMzrmgZqLdmENNsVUXOOq+D3wjXninzFIJD
         6IAyyLbsnjtrcVEh+/4odCtOkieDyEEt44bVdPuWD5y3tsLSEUULvjk4CH7ekRPflhCl
         qQ1A==
X-Gm-Message-State: ABuFfoivpwnfI1NhN8bAuHUNbEhA2TyNjPKG7b1mTSULQ/PCwT5YQB8H
        BpYAlsWHwTzw5dGNybUnVwo=
X-Google-Smtp-Source: ACcGV61ezk8qcIfjRBI1kPuYPI5fS7sQ3Ihq3Kbt2ytuXF6w7ipwbxbJQG50eOK4qQYkl5y0LgKcrQ==
X-Received: by 2002:a5d:540d:: with SMTP id g13-v6mr25267057wrv.4.1539220764819;
        Wed, 10 Oct 2018 18:19:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n11-v6sm30566992wra.26.2018.10.10.18.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:19:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] ref-filter: free item->value and item->value->s
References: <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
        <0102016657e7d087-be1f65a3-be3e-4b15-95f1-7570d258c70d-000000@eu-west-1.amazonses.com>
Date:   Thu, 11 Oct 2018 10:19:22 +0900
In-Reply-To: <0102016657e7d087-be1f65a3-be3e-4b15-95f1-7570d258c70d-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Tue, 9 Oct 2018 08:18:21 +0000")
Message-ID: <xmqqzhvli8kl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Release item->value.
> Initialize item->value->s dynamically and then release its resources.
> Release some local variables.

Again, "why" is lacking.

> @@ -1373,36 +1379,31 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  		}
>  	} else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
>  		if (stat_tracking_info(branch, &num_ours, &num_theirs,
> -				       NULL, AHEAD_BEHIND_FULL) < 0)
> +				       NULL, AHEAD_BEHIND_FULL) < 0) {
> +			*s = xstrdup("");
>  			return;

It is a bit sad that we need to sprinkle xstrdup() all over the
place, but I do not offhand think of a better alternative to ensure
that it is safe to blindly free the .s field.

> -		if (explicit)
> -			*s = xstrdup(remote);
> -		else
> -			*s = "";
> +		*s = explicit ? xstrdup(remote) : xstrdup("");

Next time, please avoid mixing this kind of unrelated changes with
the main theme (i.e. "the original had allocated and static pieces
of memory pointed by the same variable, which made it impossible to
blindly free it, so make sure everything is allocated").  It makes
it harder to let reviewers' eyes coast over the patch.

I say "Next time" because the change is already written this time,
and I already spent time to see it was an OK change.  By the way,

	*s = xstrdup(explicit ? remote : "");

is probably shorter.

> @@ -1562,10 +1566,11 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  				if (!refname)
>  					continue;
>  			}
> +			free((char *)v->s); // we will definitely re-init it on the next line

No // comment, please.

>  static void free_array_item(struct ref_array_item *item)
>  {
>  	free((char *)item->symref);
> +	if (item->value) {
> +		free((char *)item->value->s);
> +		free(item->value);
> +	}
>  	free(item);
>  }

OK.

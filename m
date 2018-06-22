Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C991A1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 20:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbeFVUrm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 16:47:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43477 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754345AbeFVUrl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 16:47:41 -0400
Received: by mail-wr0-f194.google.com with SMTP id d2-v6so7833291wrm.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8G5t46/zGajrnZaqa3EB3V06NVw/ad3v61d3S6U/0w=;
        b=BHYS57lCCOvUhIfPOuty39B3f1vabfwKPu6SixQeVDDkp0A/9GTA6jikQxYHV4rjWU
         lXRu8Dlw2n6H7XxyQgRaCbscBVVYx77xukDnHvWb4f5/CWZSAnHTULcDwQnvuY/fJlOA
         NNz8Ep9IfrbYkFBaLI6nAcM+cXBIV8TZx07MXnTqML2VBug7c/qSniPJ6buvTx3LcCOq
         uGFDrzT+D6BDxxzNkLfDoY6VyLNs6GnPSow/5ANxckBz2cM8sE/u8sPHPE/En/qHRKYg
         CUS1VNtoeikaP3UvTDP6k1qkqh0ftANKEVUIy0lEd+NZReI27/c+TomII7sWPxwhOafr
         TbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8G5t46/zGajrnZaqa3EB3V06NVw/ad3v61d3S6U/0w=;
        b=EBC4lkZZT2NdDE0/AIWt/Gcbu/6elAppNflo7EmhLG4XB8DawcolCRvyqarDKqLwER
         jycS5yX/kuTCLNwVDfi5bbCFo+5KfejBaqcJey0Q91GWkJamELo1rtbqW3f2vvzA8C6d
         MezMTiFddxBB4nbizS/x0waGAafHVt3cQxxSgizTlPzCSJK0vWVLSELa0QVXBrr1KIfk
         USasMG8E4yUiHmC8WdR2z0SMu7qqaca4jtLemXut+euETFHkr/HcFlLSfZQix6574+ld
         p8getWb1zsrudpCj0vGAbGuHMB4hSJ9Dk54Xoh8QvFSzCbbV/IP3Adsthnw5AxlcF47o
         LwCA==
X-Gm-Message-State: APt69E0bVtMCwmMA4g8oFjthoTa6eZD2qrZTS8I25eMvOypWaFV1txge
        ii8iVkgWW7LZNRho+/C3ACo=
X-Google-Smtp-Source: ADUXVKJ+BdCb9Ng6NBpDF741ljGHNo8XqbcbugNqGEVCL9Okx9GxoAuMwktgfxADB+iIn/nhtYh16A==
X-Received: by 2002:adf:8650:: with SMTP id 16-v6mr2917162wrw.73.1529700460349;
        Fri, 22 Jun 2018 13:47:40 -0700 (PDT)
Received: from andromeda.localnet (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.gmail.com with ESMTPSA id w3-v6sm7958099wrr.88.2018.06.22.13.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 13:47:39 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add a new function to silence a command, except if it fails.
Date:   Fri, 22 Jun 2018 22:47:32 +0200
Message-ID: <6634943.MY9lBgqpaT@andromeda>
In-Reply-To: <xmqqk1qrre4w.fsf@gitster-ct.c.googlers.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com> <20180621141732.19952-2-alban.gruin@gmail.com> <xmqqk1qrre4w.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 22/06/2018 =C3=A0 00:03, Junio C Hamano a =C3=A9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> > This adds a new function, run_command_silent_on_success(), to
> > redirect the stdout and stderr of a command to a strbuf, and then to run
> > that command. This strbuf is printed only if the command fails. It is
> > functionnaly similar to output() from git-rebase.sh.
> >=20
> > run_git_commit() is then refactored to use of
> > run_command_silent_on_success().
>=20
> It might be just a difference in viewpoint, but I think it is more
> customary in this project (hence it will be easier to understand and
> accept by readers of the patch) if a change like this is explained
> NOT as "introducing a new function and then rewrite an existing code
> to use it", and instead as "extract a helper function from an
> existing code so that future callers can reuse it."
>=20

I like your wording.  It=E2=80=99s not a difference of point of view, I=E2=
=80=99m just bad at=20
writing commit messages ;)

> > +static int run_command_silent_on_success(struct child_process *cmd)
> > +{
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	int rc;
> > +
> > +	cmd->stdout_to_stderr =3D 1;
> > +	rc =3D pipe_command(cmd,
> > +			  NULL, 0,
> > +			  /* stdout is already redirected */
>=20
> I can see that this comment was inherited from the original place
> this code was lifted from (and that is why I say this is not "adding
> a new helper and rewriting an existing piece of code to use it" but
> is "extracting this function out of an existing code for future
> reuse"), but does it still make sense in the new context to keep the
> same comment?
>=20
> The original in run_git_commit() made the .stdout_to_stderr=3D1
> assignment many lines before it called pipe_command(), and it made
> sense to remind readers why we are passing NULL to the out buffer
> and only passing the err buffer here.  But in the context of this
> new helper function, the redirection that may make such a reminder
> necessary sits immediately before the pipe_command() call for
> everybody to see.
>=20

Yeah, you=E2=80=99re right.

> > @@ -861,20 +872,8 @@ static int run_git_commit(const char *defmsg, stru=
ct
> > replay_opts *opts,>=20
> >  	if (opts->allow_empty_message)
> >  =09
> >  		argv_array_push(&cmd.args, "--allow-empty-message");
> >=20
> > -	if (cmd.err =3D=3D -1) {
> > -		/* hide stderr on success */
> > -		struct strbuf buf =3D STRBUF_INIT;
> > -		int rc =3D pipe_command(&cmd,
> > -				      NULL, 0,
> > -				      /* stdout is already redirected */
> > -				      NULL, 0,
> > -				      &buf, 0);
> > -		if (rc)
> > -			fputs(buf.buf, stderr);
> > -		strbuf_release(&buf);
> > -		return rc;
> > -	}
> > -
> > +	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
> > +		return run_command_silent_on_success(&cmd);
> >=20
> >  	return run_command(&cmd);
> > =20
> >  }
>=20
> It probably is easier to understand the code if you added
> an "else" after, to highlight the fact that this is choosing one out
> of two possible ways to run "cmd", i.e.
>=20
> 	if (is_rebase_i(opts) && !(flags & EDIT_MSG))
> 		return run_command_silent_on_success(&cmd);
> 	else
> 		return run_command(&cmd);

Okay.

Cheers,
Alban





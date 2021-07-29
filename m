Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0294C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF8660F46
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhG2TJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhG2TJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:09:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58853C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:09:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso17201112pjb.1
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WQobYXgkD/xxoWRHAnVdLolMEJm//RjcnesDDFMAqa4=;
        b=sW156+Rh3tp/OSJRq0sif8pq0Tu9JE8T9NDuAM5UwqL4zVGIearbvmEBPFi5BlFDXo
         Fz2x2mADGYxggP3l/+tGpdzvAvToCNhm99Qkvh4VX1ysbbpGelzOzrdyUqNQcmfChtS8
         kJ5z+0wBJLszIcSYmOqBkoTchUmwVKz2EzLyCeHFgWlOj33o3Gz8433Ij1GtsaLB2ur0
         RaDfpvx9qoICbCa2WJfkTy/M4q7fMR2B0mxoBzrFt3v4MYJ2I6NtFkQST5KUKza31wgK
         4x1eHrMXwI/wbiS1rzEEthUDa5bW6MfOq0XbYJOzyZlEK24R8NCRE0mZK7/QUzfz+gYf
         Gozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WQobYXgkD/xxoWRHAnVdLolMEJm//RjcnesDDFMAqa4=;
        b=ar9Kkjeuszuq+vX7Ee4VkuKsVvigc2fGkaFNSAYwFvsX2wt2ECoLp1NII198gCLmOQ
         qrfnVMAOhgDLR2wukwLKHWtu0B1pcEuxbJu7IXocoMRxA7YbSY1YJyApNYgA7FrStTaY
         51B/HX4ep0nff2YI7lut9JF/ETheg6dEXjyfMIesJF7Cbat/AnRu8jP/lexXtzk7PMsJ
         r846GKYnNrXqnQhDSZp3F6EiYf7dBpW8e6xDS2B8+v6sx0K1m+PLkW5CLdrccgO1d0z2
         z0NFKL2Q8OKyH+v8vgdMNrGy6qUEPCBkohm4W3l4QC93jtkW+SRi4mqdJqrOuUHtJLrG
         XExA==
X-Gm-Message-State: AOAM5304uw4R4aIPP9+sgJftMbKcVaSINq7edq10A9S53ADR1CEL961B
        s0BvFNA9/XpP7j+EZZpg/xoV/FfJCB4QbQ==
X-Google-Smtp-Source: ABdhPJxXijZvYvHKf1P2/+u4JBQ24O+qYc5niqkorYztISlqMwcypotMpvznVtOt/Rv/UOvNC6jIqQ==
X-Received: by 2002:aa7:8812:0:b029:32d:8252:fd0 with SMTP id c18-20020aa788120000b029032d82520fd0mr6569812pfo.48.1627585748577;
        Thu, 29 Jul 2021 12:09:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:12b4:7532:e087:f8ab])
        by smtp.gmail.com with ESMTPSA id f10sm4652431pfa.17.2021.07.29.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 12:09:07 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:09:00 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
Subject: Re: [PATCH v6 2/9] ssh signing: add ssh signature format and signing
 using ssh keys
Message-ID: <YQL8zAHe8CkW1U6j@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>
References: <pull.1041.v5.git.git.1627391744.gitgitgadget@gmail.com>
 <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f05bab16096c080891ee8f7e179eecce7f32e839.1627501009.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for this series, it sounds like a great idea. I have a few
comments, inline below.

On 2021.07.28 19:36, Fabian Stelzer via GitGitGadget wrote:
[snip]
> +static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
> +			   const char *signing_key)
> +{
> +	struct child_process signer = CHILD_PROCESS_INIT;
> +	int ret = -1;
> +	size_t bottom, keylen;
> +	struct strbuf signer_stderr = STRBUF_INIT;
> +	struct tempfile *key_file = NULL, *buffer_file = NULL;
> +	char *ssh_signing_key_file = NULL;
> +	struct strbuf ssh_signature_filename = STRBUF_INIT;
> +
> +	if (!signing_key || signing_key[0] == '\0')
> +		return error(
> +			_("user.signingkey needs to be set for ssh signing"));
> +
> +	if (starts_with(signing_key, "ssh-")) {
> +		/* A literal ssh key */
> +		key_file = mks_tempfile_t(".git_signing_key_tmpXXXXXX");
> +		if (!key_file)
> +			return error_errno(
> +				_("could not create temporary file"));
> +		keylen = strlen(signing_key);
> +		if (write_in_full(key_file->fd, signing_key, keylen) < 0 ||
> +		    close_tempfile_gently(key_file) < 0) {
> +			error_errno(_("failed writing ssh signing key to '%s'"),
> +				    key_file->filename.buf);
> +			goto out;
> +		}
> +		ssh_signing_key_file = key_file->filename.buf;

You probably want to call strbuf_detach() here, because...

> +	} else {
> +		/* We assume a file */
> +		ssh_signing_key_file = expand_user_path(signing_key, 1);
> +	}

... you need to free the memory returned by expand_user_path(). If you
detach the strbuf above, you can unconditionally
free(ssh_signing_key_file) at the end of this function.

> +
> +	buffer_file = mks_tempfile_t(".git_signing_buffer_tmpXXXXXX");
> +	if (!buffer_file) {
> +		error_errno(_("could not create temporary file"));
> +		goto out;
> +	}
> +
> +	if (write_in_full(buffer_file->fd, buffer->buf, buffer->len) < 0 ||
> +	    close_tempfile_gently(buffer_file) < 0) {
> +		error_errno(_("failed writing ssh signing key buffer to '%s'"),
> +			    buffer_file->filename.buf);
> +		goto out;
> +	}
> +
> +	strvec_pushl(&signer.args, use_format->program,
> +		     "-Y", "sign",
> +		     "-n", "git",
> +		     "-f", ssh_signing_key_file,
> +		     buffer_file->filename.buf,
> +		     NULL);
> +
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +	ret = pipe_command(&signer, NULL, 0, NULL, 0, &signer_stderr, 0);
> +	sigchain_pop(SIGPIPE);
> +
> +	if (ret) {
> +		if (strstr(signer_stderr.buf, "usage:"))
> +			error(_("ssh-keygen -Y sign is needed for ssh signing (available in openssh version 8.2p1+)"));

I share Jonathan Tan's concern about checking for "usage:" in the stderr
output here. I think in patch 6 the tests rely on a specific return code
to check that "-Y sign" is working as expected; can that be used here
instead?

> +
> +		error("%s", signer_stderr.buf);
> +		goto out;
> +	}
> +
> +	bottom = signature->len;
> +
> +	strbuf_addbuf(&ssh_signature_filename, &buffer_file->filename);
> +	strbuf_addstr(&ssh_signature_filename, ".sig");
> +	if (strbuf_read_file(signature, ssh_signature_filename.buf, 0) < 0) {
> +		error_errno(
> +			_("failed reading ssh signing data buffer from '%s'"),
> +			ssh_signature_filename.buf);
> +	}
> +	unlink_or_warn(ssh_signature_filename.buf);
> +
> +	/* Strip CR from the line endings, in case we are on Windows. */
> +	remove_cr_after(signature, bottom);
> +
> +out:
> +	if (key_file)
> +		delete_tempfile(&key_file);
> +	if (buffer_file)
> +		delete_tempfile(&buffer_file);
> +	strbuf_release(&signer_stderr);
> +	strbuf_release(&ssh_signature_filename);
> +	return ret;
> +}
> -- 
> gitgitgadget
> 

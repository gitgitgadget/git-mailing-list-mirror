Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C631F98D
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568957; cv=none; b=PbcfgtLgz9EV1qYYb+ODao8d5ao5xWo8dV8e6pyZ7q64oJabJIORkFTMi2Q9mzT2T1pI1gZiaE9NVDda0C47o6HTcdtHpsl/KWDby1RUxJzkwj2y2uY+h4tTfRQ6x0oGIydgcGeogMtJFT2FgQkoI36D6JJ5h6LJ48Rxpddd6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568957; c=relaxed/simple;
	bh=pbfRTQQwH4Mhs/NE0zAifoojUGbI8nOzX1FVf2TrVdU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELveMm8/xBtOBIsDfKNMS5vv6OLXxhluIq+yLqZEgnwiBVJ0V4JuL7PV0mr+iQ1heC3de6AnJ1Xo30w6IXH/rKpJjbwQxnd/cCbVfoIYLDo1ZrpkWfaEvSWyssHq+uKdue4rpwtC4MNMyaulyx7edWUckV+vqwe9MeHtDxDUFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V7ZX0lLB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdT/T1lm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V7ZX0lLB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdT/T1lm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E2FA7A00C9;
	Wed,  8 Jul 2026 23:49:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 23:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783568955; x=1783655355; bh=v1pyOh7v8X
	hopaQRaWCdEPRgVafb4jsFYyTXlz282Vw=; b=V7ZX0lLBCHfZR1LsXiVnvUybzY
	biXXmSsh66LW9Mmq9ianKI38DeRD/iVVXVqUQW2nZCrDV8fDJ9TeSuRGb6SXWOXy
	9juZ1a8RVcJmNLr+0UANcmrE/orRAnAjcSqbP1/Fpl1yNmZvWM4GMszG4GZED3Fp
	Jb0c83mbjALceDgDbt+0N/drsmiFSXc4POLUZiFsFiXFP8lWH+JjkVjp3Enu6EnE
	+FACjy51DQv9UjD426cu9xEkfhwvoihosLiYgjlKv40HhAbdjJyYH/RB2NpyWZsU
	c7iTDvNLHG9o2iMFaZdbRnj5qw2q8KYG381edCMB+lITN/G275dO4eOhAyGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783568955; x=1783655355; bh=v1pyOh7v8XhopaQRaWCdEPRgVafb4jsFYyT
	Xlz282Vw=; b=EdT/T1lm+vgDdDZ/yUujtmpF2/nTK2SO/LQpa2/9D7En7Bgdh8u
	960Agq5RUMU+98fiJqIbO2iaFTZaHHSn1+arQlqnQTrY2vcHXYj4vO2grjZ0TYfg
	Gox4cExXHX9hqfkXI0PhsMAthRWCzkGgzUbsPXo/vhKwQOVHXXcn8BBMjpdyPphl
	f6oMF8pys1qqBq3OTJZ02b1l/L36ylO+eokgZmWFkB0jMh7C3ZRvLJRTw0H/SCno
	VdrPOu8K4ov42T7ofhOC6+K55DMjr4huHPz6HoyrCUCbcWhceiqx9C24isWdP0Tg
	N5EriTOc27NhcqffBWA/87mjOW6JCyxJRSA==
X-ME-Sender: <xms:OxpPalL5FyS2tcCV__J1H3oA8HU8Lh8chdjZJ-1hr_SoHKR02olotQ>
    <xme:OxpPaoKU-z5kbaKIPrjnDMtvnYz5Aq8_5wHW8q7mJD7grhLwK35WDo3uKhxn5C1nz
    Wl7YXSmBvBcjcZ_WJoY-4x01g1WB7JXChJmk_goa7Irp6Q64P1bKg>
X-ME-Received: <xmr:OxpPaisVTepG7NGgxxAW2P82D5dDVY-BwfVEo1tYFX0DxtE3H4mjUIE1SlOrPoeNthjPkzOsFwXvtCj2GvQeZBMN2IPREn-LBzJJmas>
X-ME-Proxy-Cause: dmFkZTFFOxp+TUcinvAhIMiMSRKnusR01ZtRjx3gwRYm3oQZkyI3rjZYpM/DMdv2f3S0Dz
    naWEHR6zRkwXgvSAxSfN1LSCwRkR+W/3Y7MDE/iyGYAWYoQE9hcoYgpLcGPkxAbwAkk7OX
    aF6h3yBPSM7bUB6sbIXhgmsyMg6jWnn2K3prqtqKe4Z5IDI66YInZVsEu0fLD12zFRbd9z
    UmNc7CA9ZZdp36oM0WoYjBiwwkymyUe+Smv9ID2ShAO2sB4Twc+Hm7wzLn0PrdOBCXCLhA
    scGUrXk//SHdWqaEi186nOduatF6luBJLyboCkrqx/JGKJD4c1zPD4gQQbdHhFiiRpYBb2
    /+N3aO3A7TDbNLf3UsRqvmey7keXkQO2FHfN3K2q7wr0wylIT3yqNcnKtMb4RXlPMRvOXx
    02x2cDocagUqQy7Co93diRXU4Y5+ktArtmJJaB/F6blthMxmufrA+oJgGc6zLxVkhAQ3HU
    pZgFZJ8oMrhy8nAXdbAIyflqg4WfYGpvPh774Ug8DugkIPzKAxwdYepa64SexdeRGyMSbG
    qzgC5wy/UX0Zf3hOULybpmqa5jeyC0f3ra3PGs9ixpKRnD8JACULBm5pJtNmlRLuBYvBg4
    Bo57x/8NPv6u6Pm3OiSeZ3V6hY92cEDqEGwamAJcVkMsvWyQz0wRC6B7gjqw
X-ME-Proxy: <xmx:OxpPalSzmqpmFd61s-nd0RpDcsh-doxpgqvVKf3jXjowbyHz6uQd-A>
    <xmx:OxpPaoMIrXf6QHvkaW4AWjD8aXJVchs6RIgMtEEorGpSg0rdRmpHZg>
    <xmx:OxpPaqafrCv7DaAbcS2qOFqVrkfnHNecW3rYNYuspuLWP_T9x3P3kw>
    <xmx:OxpPaiwx4lhI3H7eWDPhDfxogIoEXG2bxbiOwrMK6xTFjAaJziCSiQ>
    <xmx:OxpPaiM_I3qia7TaNVW6_AQxOXTZMEZNcK98U_q4wgLpGsnSFfJw4Mwq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 23:49:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 11/11] builtin/receive-pack: stage incoming objects
 via ODB transactions
In-Reply-To: <20260708235925.3992097-12-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 8 Jul 2026 18:59:25 -0500")
References: <20260708041412.1157499-1-jltobler@gmail.com>
	<20260708235925.3992097-1-jltobler@gmail.com>
	<20260708235925.3992097-12-jltobler@gmail.com>
Date: Wed, 08 Jul 2026 20:49:13 -0700
Message-ID: <xmqq33xsrfeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> @@ -2027,6 +2031,7 @@ static void execute_commands_atomic(struct command *commands,
>  static void execute_commands(struct command *commands,
>  			     const char *unpacker_error,
>  			     struct shallow_info *si,
> +			     struct odb_transaction *transaction,
>  			     const struct string_list *push_options)
>  {
>  	struct check_connected_options opt = CHECK_CONNECTED_INIT;
> ...

Hidden in the context early in this function is an error return.
When unpacker_error string is non NULL, we mark all the commands in
the linked commands list as failed, and return early from this
function.

> @@ -2105,14 +2115,13 @@ static void execute_commands(struct command *commands,
>  	 * Now we'll start writing out refs, which means the objects need
>  	 * to be in their final positions so that other processes can see them.
>  	 */
> -	if (tmp_objdir_migrate(tmp_objdir) < 0) {
> +	if (odb_transaction_commit(transaction)) {
>  		for (cmd = commands; cmd; cmd = cmd->next) {
>  			if (!cmd->error_string)
>  				cmd->error_string = "unable to migrate objects to permanent storage";
>  		}
>  		return;
>  	}
> -	tmp_objdir = NULL;
>  
>  	check_aliased_updates(commands);

In the "happy case", execute_commands() would commit the transaction
before going on to do the execute_commands_{atomic,nonatomic}() that
appears later in it.

> @@ -2706,11 +2705,14 @@ int cmd_receive_pack(int argc,
>  		if (!si.nr_ours && !si.nr_theirs)
>  			shallow_update = 0;
>  		if (!delete_only(commands)) {
> -			unpack_status = unpack_with_sideband(&si);
> +			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))

In the "main" program, we start a transaction here, and

> +				unpack_status = "unable to start object transaction";
> +			else
> +				unpack_status = unpack_with_sideband(&si, transaction);

then call unpack_with_sideband().  It may fail.

>  			update_shallow_info(commands, &si, &ref);
>  		}
>  		use_keepalive = KEEPALIVE_ALWAYS;
> -		execute_commands(commands, unpack_status, &si,
> +		execute_commands(commands, unpack_status, &si, transaction,
>  				 &push_options);

And in such a case, execute_commands() returns without committing
the transaction.  Is there a need to add and make an
odb_transaction_abort() call or something in such a case?
Everything should be cleaned up upon process exit, and on file based
backends, we probably let the tempfile/lockfile API do their thing
to clean up, but are there other things we may want to clean up?

>  		delete_tempfile(&pack_lockfile);
>  		sigchain_push(SIGPIPE, SIG_IGN);
> @@ -2719,7 +2721,7 @@ int cmd_receive_pack(int argc,
>  		else if (report_status)
>  			report(commands, unpack_status);
>  		sigchain_pop(SIGPIPE);
> -		run_receive_hook(commands, "post-receive", 1,
> +		run_receive_hook(commands, "post-receive", 1, NULL,
>  				 &push_options);
>  		run_update_post_hook(commands);
>  		free_commands(commands);

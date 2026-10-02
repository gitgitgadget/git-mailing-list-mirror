Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67E2D0C92
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962093; cv=none; b=X/krlWI6+rMnhBQb5K9bFT95wznT+CJ9xEuvA/1QnLIxPYYtxqV5YJxlIC/683BZigCZSzknyvzR6KygeQx5F0XRv4dM/1IChoVjmMz76blL5/67cW/ysvWTTe0oIZXECvH/AijDa/yOei3eqaan3FXC56vtI2UlKijdQlCS48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962093; c=relaxed/simple;
	bh=eq29R2op+benfrnLggkyx5TuEO//U7AiQ0sia3rvEQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WiFMhPxwj9i691gbwzCxsCYdM84rASwgoavcWkB6ruox7YShJ4zopsybd7hLmTB26IOjS9zyyXFBXJSEK1Fy32PbVcfdLOL8bD/0HQuUW4fUt2cogxKheSyPUo1QAB2lE/itZPerDTCsnJmXmf9JaO7w2dAGTZSZ/JotnHsjrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LikSL+X9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P68unhpk; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LikSL+X9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P68unhpk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3AC3F1D00078
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:28:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 13:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790962090; x=1791048490; bh=lTlL4LTWTC
	XFb+DtlHz1jJYbyESj8CdBJrk1vKURWCE=; b=LikSL+X9OQOeoF3HpU/HcKTtEg
	3fKBWo2APzCckAM7xW8zORr4uWrGATRNtHZMN4C6HlfUqEEP3zlTvnzUPKj4LGTp
	lXXGj7hE6JfRBm0Wsh81hK+NQ+CerB42RYCqdSyLgmGRcsOQ/eD9pfuoiEhvM24E
	fV+fw8yDBvVmFv9dlFFj/jy3CYIQpTsb5sOFDSzWv8J4GaIPss4ZXy6XIVZ4s0RO
	VEQHxIeFgob8HcXu3poYZIuhv5tw9FZkzIz/zx/5uh6p2VaiP8n3xIl1CYcE+EaP
	meuNRHWccRY3SuEg1Yo3bXJGtNUcqqcMwqf2XN2w8POdWM+hY8btMPNulJwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790962090; x=1791048490; bh=lTlL4LTWTCXFb+DtlHz1jJYbyESj8CdBJrk
	1vKURWCE=; b=P68unhpkstTu3PS8v1fzUJNb+eNwqwp47eosSl3ikjJpH9o74U8
	ge7+X2zTG5L9j8OAOdzF9HcFAFzYmZPYJ3lMtluMN79Viu0TC2wGgyKeDgoSFtlE
	494YRQgnRb6Yy7U61QVmfLGwNknGCCQnhliUbPNvAw8zVjKv96V/zy+QvEXiRQ6a
	8k10o5sdfQRVKV4MZk57CtuQshuWa5oNNZcCNo0Xmdj8FV5NRHwCl5c7ardTp/zu
	5PyFkBQ2ZJmLrCq7FWmAaaLQC9LUOz4UnOAs4zo4xQ4JYqq4OSb9E7+mHdZaHuNq
	9H0Z+6y6yhJZko+JKdD/gBTOi9aZ20W1gwg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790962090; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qK8qZmXsK3kzVHctcdOLX8v1k14o/TRJPo/b3mSbtOeoPeE
	ZEmHfzY/RtJRgA97DwMREIkwlYoAnWnVR9JMQlfeJtfuG4pJ0ogA3Avm/SRvrB70
	mIQCHB94jDuelQouo8u1yeGQ1agM7VJcFp90b7hhDIM7jr9S64hgfLaVCc174bQ8
	4wrzkzGbh+t5QjKKYYSUlJzxlLk8ZHsf2I6toW7Dr2+Mqf0rMKXpTi0NoJmC1Eta
	XJ0FjtvK8lcBWIaQ2G05QgPvBInGAgW1ZYDDF5v49+63mGBB8Kp+6JHKRv9fmXKd
	hIPmATANy7LTsKrwLuhbzdDmMmsRH50kC7tI8eg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:1et+jL9LHeZGuGrWgia5NeQ3CD4bjQy3vOiGIeKdVBo=:eq29R2op+benfrnLggkyx5TuEO//U7AiQ0sia3rvEQc=;
X-ME-Sender: <xms:qum_auW2ie0tPL_Rt78WXrfKb4g7R76z_4rk5HQOp177Wrcm1bhuNg>
    <xme:qum_aheEPSrB1I-xFkA4yYl5vZAmg5OJOKglKQLyOB-XpDhRMAAGWViTNxvBuBEta
    FXPLrw_tUl_Iv1LICe5QquE-Wndfvebcq6EvuzM_zax190uov8_sQ>
X-ME-Received: <xmr:qum_aqt6JJtkw7QXhJX33OpbQKUw6M9YLl6QxoSdkhxOEpL_3KieUdHFwKOgbN9_hW1SNwJ5vcEUeUhxWsHLHVjc3K1RYYNFQSZO>
X-ME-Proxy-Cause: dmFkZTGcd7e0qb5XglNUvX+97kd0AerjurVpdS+j21KerEmlQcZ6j1S+6FTI4tQxkWWSmM
    u+Ko+G1kmVesEq2hRtvbhsAgTmmJB3ah5IW0XxChbBgTTj+l36EhpINQO1TKP2gZicL4e8
    9FfsCX9pjI/JVasDTJUlnfgDBwp88MhCQawkbWIHI0gNEbfh8MY7s8LL7zJ1eRXetNVv+G
    aFWrfib+DGfjmYr5Q2IZX+jYtDY7YegO3uvu2YR1EhB7L3lrZqATcR22UPRZtfodBYSWEW
    toAzVk4KALOfUwvr6TJf/JH92SQje7UYqhPVRF0h2hhv4QN7cljnImfwmeHpKKQ3oF0ooj
    BsZOXI9/2wAO2YttSCdKPMXfNUFNhfizK/utxzhdvNcuMGX4TP3JFiGb396Td1RUU2Xx9F
    fUG+TnN5C7ScoejE8pas0Zx51lmGKDkdvtQi3SNRAxb7nO3+5cDayJdhOnZ8EeI5NomX82
    EqHH5Cq+F4G3wpaJwe2jJ28gQ8ugIbMVczolFU5ZrEZEwHa4TNQXv/tIUxMIHmUiBsFOjF
    xRDa0BF7noagg4vqt8/B5Lv2JsULCUvOxiAFfVnMVEWyyVuURJrUvuRXC3VKLjz3/rrPuX
    67ReCZC01YgUyG4X8ynfxHm0IJ92SEdSLR7Z2GPttQe98HZy/iOzI7rXbmzw
X-ME-Proxy: <xmx:qum_ag8HA7rKiOGOOxTN0qDnEwql1UKiLCV9yzDhOYhTWMFrHzUL5A>
    <xmx:qum_al04i6TT5--hfqcnRpD6U_zXbb03hbJrNYChhd4tkt3WNGyTdg>
    <xmx:qum_alDnosOfGVnKE-Wc0JBefdzKlz-jQWmzR4cXAfhYkMug3anSKg>
    <xmx:qum_ahelJ5yRVfG_VIqsIz9vqJS7ooybKEXCPA_kn2OOGlPiXstZ6A>
    <xmx:qum_agMyHMb0DtQEQJsswCGiJ1Tv8mGeiAlfRujhjw4r2Ikt_Ghwfc5f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 13:28:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  "D .
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 2/2] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <V3_format-patch_learn_--range-diff-notes.d3b@m5gid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 2 Oct 2026
	12:56:39 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
	<V3_format-patch_learn_--range-diff-notes.d3b@m5gid.xyz>
Date: Fri, 02 Oct 2026 10:28:09 -0700
Message-ID: <xmqqy0cgvwpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> git-format-patch(1) passes on the notes behavior that it is using for
> the patches to git-range-diff(1). In turn you get the same Git notes
> displayed in the range diff as the ones you used to generate the
> patches. And that makes sense in most cases.
>
> However, I often make notes between series versions that mostly prepend
> ...
> something like an alias set up with it. But why spend code closing
> that door? There is no usability upside to erroring out.

This is somewhat shared with the next step, but the commit message
includes a lengthy narrative of the author's thought process ("An
off/on switch is enough for this behavior...", "But now we are faced
with a problem...", "Well, we can't. Therefore we need...").

Can we strip out the conversational journey?  The log message should
be a concise, permanent technical reference explaining the problem
(range diff notes inherit patch notes, which may contain irrelevant
iteration changelogs) and the solution (the new options and the
.override flag).

> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index 191f64b77d1..5907f299a8d 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -378,6 +378,21 @@ case is to show comparison with an older iteration of the same
>  topic and the tool should find more correspondence between the two
>  sets of patches.
>  
> +`--range-diff-notes=<ref>`::
> +`--no-range-diff-notes`::
> +	Used with `--range-diff`, tweak what notes to display in the
> +	range diff.
> ++
> +The default behavior is to display the same notes in the range diff as
> +on the patches; see `--notes`. But you can use these options to use a
> +different list of notes. For example, say you have given three notes
> +refs to `--notes`. At this point those same three notes will be
> +displayed in the range diff. But then you pass
> +`--range-diff-notes=<ref>`. Now the range diff will only display
> +_<ref>_. You can of course pass more refs to this option, just like
> +`--notes`. And you can also turn off all range diff notes with
> +`--no-range-diff-notes`.

Very chatty and colloquial.  A technical reference manual should be
concise and direct.  Here is my attempt to condense it down to make
it more readable:

  By default, '--range-diff' displays the same notes as the patches
  (see '--notes').  Use '--range-diff-notes=<ref>' to specify a
  different notes ref for the range diff. This option can be given
  multiple times to show notes from multiple refs.  Use
  '--no-range-diff-notes' to disable notes in the range diff.

> diff --git a/builtin/log.c b/builtin/log.c
> index 560af00e2fd..d70101f0755 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1327,15 +1327,56 @@ static void prepare_cover_text(struct pretty_print_context *pp,
>  	strbuf_release(&subject_sb);
>  }
>  
> +struct rdiff_notes {
> +	/*
> +	 * True if we want to override the notes behavior
> +	 * of 'format-patch'
> +	 */
> +	bool override;
> +	struct string_list notes;
> +};
> +
> +static int rdiff_notes_cb(const struct option *option,
> +		       const char *arg,
> +		       int unset)
> +{
> +	struct rdiff_notes *rdiff_notes = option->value;
> +
> +	rdiff_notes->override = 1;
> +
> +	/*
> +	 * The rest is the same as
> +	 * parse-options-cb.c:parse_opt_string_list
> +	 */

Hmph, I wonder if it is more future-proof to wrap the string-list
callback like so ...

        static int rdiff_notes_cb(const struct option *option,
                               const char *arg,
                               int unset)
        {
                struct option opt = *option;
                struct rdiff_notes *rdiff_notes = opt.value;

                rdiff_notes->override = 1;
                opt.value = &rdiff_notes->notes;
                return parse_opt_string_list(&opt, arg, unset);
        }

... than copying and letting the code drift apart.

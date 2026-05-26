Received: from fout-c4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187A2765E2
	for <git@vger.kernel.org>; Tue, 26 May 2026 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760597; cv=none; b=ScjBZ3J+rHByrdgGUDkmXaBUNrxHy1fuEFjyZ87d9upxsqOljCdUb59tTdetQNP8zPV2I+LOfJFhBtNGcOpKn9yuCayyNG4r7ZVRpRcqB2T48XpFvD3rQlNFAispp+OoleQ6rKjysVbqspneSnk5vT8mdeuzhWSv2+3QnGF1Nwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760597; c=relaxed/simple;
	bh=Um5IUacPPPYOrsqrUS6m5RZMpNQ57EuzFgh5FRR5PAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gGkSLb4N6clsShxpqRedbTQwXwYXl7ej1Z33mkfCkNh45kZj6F6lm4ww07tGrrM726dpVPnMt9Sqc+bPbRggAqBJAOCvAgzQdWYReHfpzZzmeFJwpUiHsg8y2dLxdoY42IjEvp0s9325PfY5vAbO+yvpJabORcJzYpQtJ8rTzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qq7wlHw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKIcB7Pa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qq7wlHw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKIcB7Pa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A6F151D00108;
	Mon, 25 May 2026 21:56:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 25 May 2026 21:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779760594; x=1779846994; bh=fSpfX1mp49
	n246nUlDCI4FVevK5DQIC+y6ZPUuqgYek=; b=Qq7wlHw8p7PGmfxknydpwtWc6Q
	np/6O37CJvPG9FJIg+3SvKR1pm0/sm3E4welSZ9nj2+/067SAscp3tI2vO66ozB2
	8WYBXj2DKg6M1YifbGCKMfbwoXAS7KxVHpVpw3k/5okYuR3jB4+Qk3DxOWGN1BjD
	0aR6ZMTBRsnHDtbF+B5M7XfULj4oAnjZ3HFXkwtYUyW56p5QpY1qE15TGsAyKIgg
	ltWeFHmSlkQAjsexom1g6geVSx3e2jMuEUtfNWTuLB31yyAfT6aY0hFcaXEY8+JS
	swZ2XXy174b7PfDCLxgkyeYkPpxTgVdls5Gqu3flv0bQ2nJfF2nI1OvG1gAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779760594; x=1779846994; bh=fSpfX1mp49n246nUlDCI4FVevK5DQIC+y6Z
	PUuqgYek=; b=AKIcB7Pa4tOk9n3o72PofnidbxZPFJvUMD/SuU4A2l+d+jBoBkG
	FfnO4vT/LdNhsRRTllvLt2I2qzxBNcEb/VReeU9PMOQCxAEYFlA01iis/WGAmIpk
	iuT/SLPsJjkDY25Om2uyqdxV9fv78JNIxnla0j6bLjgTYTstBygDsiwRhY7u6Mmg
	Yf2oyRNKZNNRqLtmFFhQt3zNts38KKZ/X2pl7hKWQKBX2Kudxop6vz5fR82Z168C
	PToyfPo0oV4f1MoPwu/kBjFFlFEHjfNeYWpLSAmyHWc9eivQRJOv953Gb0B3Gf2/
	IYuDPWlFx675+VH/5eqh7GSRme2R/lFef4w==
X-ME-Sender: <xms:0v0Uat7Sq8zL2bCxu1_1doHSAlnlpbvXusF9_PhU1_vaDHYPrqzHmQ>
    <xme:0v0UaldKLtuiaqDy9kYu3LLPs5VXnZWtR8wwMMjxFVIQuP8WsQvBa2g3ViVlmKJVC
    nETocebYeoUbJiJACwcKnY9A00NSBdXGV8vBD4mjl94YsPGnyED2g>
X-ME-Received: <xmr:0v0UahDf07zETDLw4YnmepUMo-y0XrdMCUFky3tnWiYhIioSEH-KkOn1lafDw7MX51d9n6avyoI8nA9EnMJb_nUxhjmBsbJIaU1y>
X-ME-Proxy-Cause: dmFkZTGLsGk/Oa5wrOMKDoYmWUOfmtO9rG4KhoP/yItcLKmVySBIT6SrMEDQP3ATsA1e/d
    x295gZ4oxHzQYtZP1PUXwJDfdGqSu4hKh14R89ADB1Lf76j8JC1oNx3jW64jFHt4l7n7NB
    +q+oeh3YhAFjfLr+2ml6+vW4UDz4J72zCv1jT/BoA/rOcLJ/ZlDT3uHDWwUFBD7L1MPQPe
    BQfhgY4ADHhqNJCWICJ78yit5NJaM0fDf1rq3P1C6xRZGc1g8E9+ovZH+K8C4D/FYVpCZZ
    rbmFbb84ltjsOqcuJHxx8TERUgXZJ8MX/mnp1NOIC5fhF8A5sGocIfHhGxpVucDy9LU/Am
    Qv2MmxVmxGzoxnScVu3C6Kk+SeFa0RFmnzsoZ1GiZwgCfnMYw7YAi4pXL9QWXo6pfSK3Xh
    /LOqWe54uzL1zWGB4sr4XAsiXbhig9tu2tlViyihdPPjrrB6wOigVDEUchgxN2UWMkmgrg
    bygYB0cemh/Kta3xae9J2mQKdroP5fuLkCKaBw9tE49Rqxa1p57o9w1tvVYD+Y1YjKrOAn
    h02O5puBb9/CHD4fhnbTV81+sg8csjxKNTXLX7mK4GYXXa77B8wcBmqaLK9KxdpI46Vjml
    1OLjsTFzB3r6l0OU9wc2LycPp0MBpfB0S352xE36JcteVQRRaPqk9/FPTS5g
X-ME-Proxy: <xmx:0v0Uao-Pn_DU359TGxSda3L3Fj-R6qemItSLrnjggnetaPQ4P5nulw>
    <xmx:0v0UasLnVHet5ETOnWT8F6iHBHLxP-JbH-90fG3pPcQOKK22CyRVyg>
    <xmx:0v0UahgNIoL7MGfGnBbIvsuWF4KJwo96EVDeuGDGXWcvleJYhl4UZQ>
    <xmx:0v0Uas4JkP1gt0wTUf30_VZK2pNL4ivC4qH4ICkzhLsvvrI04alCkw>
    <xmx:0v0UatqA-qFCBguq7cBdCl50KCQRj8-X3OIcZmHvtqRTcclKvTkIes9h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 21:56:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 3/4] diff: add long-running diff process via
 diff.<driver>.process
In-Reply-To: <c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Mon, 25 May 2026
	18:29:57 +0000")
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 10:56:32 +0900
Message-ID: <xmqqpl2jlyr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct diff_subprocess {
> +	struct subprocess_entry subprocess;
> +	unsigned int supported_capabilities;
> +};
> +
> +static int subprocess_map_initialized;
> +static struct hashmap subprocess_map;

Can we avoid introducing new global variables like these?  Would
"struct userdiff_driver" or "struct diff_options" be a good place to
hang this hashmap, perhaps?

> +static int send_file_content(int fd, const char *buf, long size)
> +{
> +	int ret;
> +
> +	if (size > 0)
> +		ret = write_packetized_from_buf_no_flush(buf, size, fd);
> +	else
> +		ret = 0;

Shouldn't "size == -24" be flagged as an invalid input?

> +	if (ret)
> +		return ret;
> +	return packet_flush_gently(fd);
> +}

> +static int parse_hunk_line(const char *line, struct xdl_hunk *hunk)
> +{
> +...
> +}

This gives a silent error diagnosis, which is good for a lower level
helper.

> +int diff_process_get_hunks(struct userdiff_driver *drv,
> +			   const char *path,
> +			   const char *old_buf, long old_size,
> +			   const char *new_buf, long new_size,
> +			   struct xdl_hunk **hunks_out,
> +			   size_t *nr_hunks_out)
> +{
> +	struct diff_subprocess *backend;
> +	struct child_process *process;
> +	int fd_in, fd_out;
> +	struct strbuf status = STRBUF_INIT;
> +	struct xdl_hunk *hunks = NULL;
> +	struct xdl_hunk hunk;
> +	size_t nr_hunks = 0, alloc_hunks = 0;
> +	int len;
> +	char *line;
> +
> +	if (!drv || !drv->process)
> +		return -1;

A driver that does not define process is not an error; it is
perfectly normal in the current world order where nobody has such an
external process and even fi this patch lands, external processes
are optional.  So here "return -1" does not mean an error, and
silent return is perfectly fine.

> +	backend = find_or_start_process(drv->process);
> +	if (!backend)
> +		return -1;

This is probably an error; the user specified drv->process, we
either tried to find or start the process and failed.  Isn't it an
event that deserves to be reported in an error message?

> +	if (!(backend->supported_capabilities & CAP_HUNKS))
> +		return -1;

Backend started, but the "hunks" feature is not supported.  Perhaps
in a year or two, this external process protocol may have become so
popular that it gained more capabilities, possibly making get_hunks
obsolete.  We may be looking at such an external process that uses
other capabilities but not this one.  This is not an error, so
silent return is perfectly fine.

> +	process = subprocess_get_child_process(&backend->subprocess);
> +	fd_in = process->in;
> +	fd_out = process->out;
> +
> +	/* Send request */
> +	if (packet_write_fmt_gently(fd_in, "command=hunks\n") ||
> +	    packet_write_fmt_gently(fd_in, "pathname=%s\n", path) ||
> +	    packet_flush_gently(fd_in))
> +		goto error;
> +
> +	/* Send old file content */
> +	if (send_file_content(fd_in, old_buf, old_size))
> +		goto error;
> +
> +	/* Send new file content */
> +	if (send_file_content(fd_in, new_buf, new_size))
> +		goto error;
> +
> +	/* Read hunks until flush packet */
> +	while ((len = packet_read_line_gently(fd_out, NULL, &line)) >= 0 &&
> +	       line) {
> +		if (parse_hunk_line(line, &hunk) < 0)
> +			goto error;
> +		ALLOC_GROW(hunks, nr_hunks + 1, alloc_hunks);
> +		hunks[nr_hunks++] = hunk;
> +	}
> +	if (len < 0)
> +		goto error;
> +
> +	/* Read status */
> +	if (subprocess_read_status(fd_out, &status))
> +		goto error;
> +
> +	if (strcmp(status.buf, "success")) {
> +		if (!strcmp(status.buf, "abort"))
> +			backend->supported_capabilities &= ~CAP_HUNKS;
> +		goto error;
> +	}
> +
> +	*hunks_out = hunks;
> +	*nr_hunks_out = nr_hunks;
> +	strbuf_release(&status);
> +	return 0;
> +
> +error:

All exceptions that lead here look like events that should be
reported to the end-user.

> +	free(hunks);
> +	strbuf_release(&status);
> +	return -1;
> +}

> +/*
> + * Query a diff process for hunks describing the changes
> + * between old_buf and new_buf.
> + *
> + * The backend is a long-running subprocess configured via
> + * diff.<driver>.process.  It receives file content via
> + * pkt-line and returns hunks with 1-based line numbers.
> + *
> + * On success, sets *hunks_out and *nr_hunks_out to a newly allocated
> + * array (caller must free) and returns 0.
> + *
> + * On failure, returns -1.  The caller should fall back to the
> + * builtin diff algorithm.
> + */

I do not agree with this.  If it is a failure, the user should fix
the external process (or disable).  It shouldn't be hidden behind a
fallback.  As I left comments, in this round of implementation,
there are conditions that returns -1 for soemthing that is not an
error (i.e., not configured, or process not supporting the
particular capability) *and* in those cases the caller should fall
back as if nothing happened.  But some error cases, the caller
should't hide them.

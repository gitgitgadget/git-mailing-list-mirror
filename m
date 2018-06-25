Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213FF1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964775AbeFYRlB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 13:41:01 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:39927 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeFYRlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:00 -0400
Received: by mail-yb0-f202.google.com with SMTP id z186-v6so10981201ybf.6
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ke3/b799Oa4+kCfkB7q4URjxJ/zLRHHFg+LID7QKC4A=;
        b=gNSKk5UxTLDVbtCkjj7EZW4fNQv5b5/FFhJWJUjwCJVchh7ZClsrfuQVyMxPXezmW8
         JuRj0Wp17M3NK0Hvn7q+oH19+N5vkc57mTA+KapDCnV0Xc1qRwbOVkT7SBJEASAy4kaN
         y0xmn8FRoxq1NOW62aYpBZ9vOp0e6PDlvA/KF7t4Oo19afazLMo28sGQbHk9WccRZRlx
         +JzR2TnfHieHYM0dkRUkqfEh8Ti+hdWlKTOvdhf4ddhfNZW9CBpASJSBJprewLIUFN97
         0FGeX+6v3sI7Zx8h/kFZqy/r8PEcEK4Vv0kGsHGNBTMid/daYLzDiI3ljYodxcFJDz8E
         ww3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ke3/b799Oa4+kCfkB7q4URjxJ/zLRHHFg+LID7QKC4A=;
        b=HGvOu8m3Hvhh+WIxrjgnGRzY0NMzHV4hYCQNQbguCqdmVjlzgm80AQwqhp+Rq6gFUc
         ++2mY7lzmuQ03ISgwjG0LlxhzMWUIb6XViPtdhThDz6ocnBw02YfgQ5haWZGfQLkQgFY
         RsLWJJ7vtJlQLI6NGkcpwdSR4U7gQKWX+VXHH/NduKZ/0IqQS5iZfA/7c2n5M2YzFR4v
         oHEPYQ7H7sMGsP9PvXfzAR7W1zSjQ4R2sA/w6kRhkrIo4OP5FMiTw5FCi/qa8ToAGZAK
         EnILemp2Y0x3r0oxXQ7NVSmg87bq/dXsJUn8Yhda09v7skic83qi0gQnPiEmY2Cmi/Cx
         Cnlg==
X-Gm-Message-State: APt69E3sDF7cGvY3YJSzG1KtWNYVBR2cSzEEC1MRdsN0CpsuLvXYCmKX
        vmFR8P9FLMmkUrqMKFjdcFcDbDoc3rqCRXhoOukw
X-Google-Smtp-Source: ADUXVKJgBz/Rwu/vYunZ+j52cQtk4EZf0fj7V2Sj7CMQCLKkqROPPdphIAP80GHoxmyYDlNO3F+VR4tQ/cCY/HHJWX+3
MIME-Version: 1.0
X-Received: by 2002:a81:7305:: with SMTP id o5-v6mr3970353ywc.118.1529948459612;
 Mon, 25 Jun 2018 10:40:59 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:40:56 -0700
In-Reply-To: <20180620213235.10952-3-bmwill@google.com>
Message-Id: <20180625174056.53053-1-jonathantanmy@google.com>
References: <20180620213235.10952-3-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH v3 2/8] upload-pack: implement ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +    wanted-refs section
> +	* This section is only included if the client has requested a
> +	  ref using a 'want-ref' line and if a packfile section is also
> +	  included in the response.
> +
> +	* Always begins with the section header "wanted-refs"

Add a period at the end to be consistent with the others.

> +	* The server will send a ref listing ("<oid> <refname>") for
> +	  each reference requested using 'want-ref' lines.
> +
> +	* The server MUST NOT send any refs which were not requested
> +	  using 'want-ref' lines.

We might want tag following refs to be included here in the future, but
at that time, I think we can amend this to say that if include-tag-ref
is sent by the user, the server may send additional refs, otherwise the
server must not do so. So this is fine.

> +test_expect_success 'mix want and want-ref' '
> +	cat >expected_refs <<-EOF &&
> +	$(git rev-parse f) refs/heads/master
> +	EOF
> +	git rev-parse e f | sort >expected_commits &&
> +
> +	test-pkt-line pack >in <<-EOF &&
> +	command=fetch
> +	0001
> +	no-progress
> +	want-ref refs/heads/master
> +	want $(git rev-parse e)
> +	have $(git rev-parse a)
> +	done
> +	0000
> +	EOF
> +
> +	git serve --stateless-rpc >out <in &&
> +	check_output
> +'

Overall the tests look good, although I might be a bit biased since they
are based on what I wrote a while ago [1]. I was wondering about the
behavior when the client mixes "want" and "want-ref" (as will happen if
they fetch both a ref by name and an exact SHA-1), and this test indeed
shows the expected behavior.

[1] https://public-inbox.org/git/d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com/

> +test_expect_success 'want-ref with ref we already have commit for' '
> +	cat >expected_refs <<-EOF &&
> +	$(git rev-parse c) refs/heads/o/foo
> +	EOF
> +	>expected_commits &&
> +
> +	test-pkt-line pack >in <<-EOF &&
> +	command=fetch
> +	0001
> +	no-progress
> +	want-ref refs/heads/o/foo
> +	have $(git rev-parse c)
> +	done
> +	0000
> +	EOF
> +
> +	git serve --stateless-rpc >out <in &&
> +	check_output
> +'

Likewise for this test - the ref is still reported, but the packfile
does not contain the requested object.

>  struct upload_pack_data {
>  	struct object_array wants;
> +	struct string_list wanted_refs;

Document here that this is a map from ref names to owned struct
object_id instances.

> +static int parse_want_ref(const char *line, struct string_list *wanted_refs)
> +{
> +	const char *arg;
> +	if (skip_prefix(line, "want-ref ", &arg)) {
> +		struct object_id oid;
> +		struct string_list_item *item;
> +		struct object *o;
> +
> +		if (read_ref(arg, &oid))
> +			die("unknown ref %s", arg);
> +
> +		item = string_list_append(wanted_refs, arg);
> +		item->util = oiddup(&oid);
> +
> +		o = parse_object_or_die(&oid, arg);
> +		if (!(o->flags & WANTED)) {
> +			o->flags |= WANTED;
> +			add_object_array(o, NULL, &want_obj);
> +		}

Makes sense - besides adding it to wanted_refs, this adds the object to
want_obj, just like how the other code paths for "want" adds it.

> +static void send_wanted_ref_info(struct upload_pack_data *data)
> +{
> +	const struct string_list_item *item;
> +
> +	if (!data->wanted_refs.nr)
> +		return;
> +
> +	packet_write_fmt(1, "wanted-refs\n");
> +
> +	for_each_string_list_item(item, &data->wanted_refs) {
> +		packet_write_fmt(1, "%s %s\n",
> +				 oid_to_hex(item->util),
> +				 item->string);
> +	}
> +
> +	packet_delim(1);
> +}

The documentation states that the "wanted-refs" section is only sent if
there is at least one "want-ref" from the client, and each "want-ref"
causes one entry to be added to data->wanted_refs, so this is correct.

Thanks - besides adding the period in the documentation, this patch
looks good to me.

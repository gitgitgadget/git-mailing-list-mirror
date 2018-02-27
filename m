Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307291F404
	for <e@80x24.org>; Tue, 27 Feb 2018 19:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeB0Ta1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:30:27 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44742 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeB0Ta0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:30:26 -0500
Received: by mail-pg0-f49.google.com with SMTP id l4so7900254pgp.11
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QZDpSc7hVfLKtdp2mG92vWttp0GRekTNOoenfnfXEzk=;
        b=YrO/QoB5mdtpluDQQWSU2VCHWbZSUp3R/GzRqUhj0k3yGh8DdzjaC+VVwOgLXPT/ql
         6+wqCn3KjXFrTZcbRsxwL04yN3WXCyrnxhWlBnguYwpQ5SlQmhB0Pjc8JDlG0VLTpc6m
         S9iL2QUNRciOJ26afTd1wrRriVKlKjFo08SivHHsza+nJULh0CAqY56aHOy9NEQt5Hni
         cXGfxz6c+l4yM+Ei1smlk3cYrgyhNpPjmAa5Ap3V/NRh3V1cbDS+wE7kxKbq1pq5x12C
         Yln+c7/cFciy/sa9tD83Ab5oRCtZYaGdH6O1fJ45YZ6LyprltkQWuSo80uW+koZdB2hD
         Egyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZDpSc7hVfLKtdp2mG92vWttp0GRekTNOoenfnfXEzk=;
        b=a6Fijq/YfZxKTVFzrkM+s9rUxme/rIH39RRT6uY3Aj0GpzCYWHlaNT90SrAeduZ/ud
         0InD6QLWrdFRPJz/By/sCd+Sa7M3rrA+MWb7XRgHKX4/Hp2DhglWKFMvtHXlV+ePoZod
         onKgfzZ1Mg3Zffnpt4C73p33aBPN4m9zK+ULgUBnbeyf67rYk0UFzYLwBLBvX6Njrux7
         tyuY3RtjAXANrRiIUern4LPiuInB+2mKUootZQEbamqDTu+9GMYDS2JPEyIpSi/Sij19
         Syiigzo1jZIVaOWGWkQaXT23xisPdrrzPAKtJhvpjEkcwQr7ho7aaInV/OCBcCYpnhp/
         MdyQ==
X-Gm-Message-State: APf1xPAng/Lk0QskzTX4s26j1GiC83zDGn9oZWZOEIvcEI36T/8HjC/E
        Jxu5lh60AQKPohBY7zJaJKS92BlbgyI=
X-Google-Smtp-Source: AH8x225M7fXoEeCxyReHTv6Gu47OPU4b8G2LkFGInjMthDvg70WRobpObH2z11ZqUUXdKRkxB5/Q+w==
X-Received: by 10.98.149.138 with SMTP id c10mr15244972pfk.143.1519759825593;
        Tue, 27 Feb 2018 11:30:25 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h186sm24433421pfg.15.2018.02.27.11.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 11:30:24 -0800 (PST)
Date:   Tue, 27 Feb 2018 11:30:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180227193023.GG209668@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
 <20180227065158.GH65699@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227065158.GH65699@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Jonathan Nieder wrote:
> Brandon Williams wrote:
> >  static char *server_capabilities;
> > +static struct argv_array server_capabilities_v2 = ARGV_ARRAY_INIT;
> 
> Can a quick doc comment describe these and how they relate?
> 
> Is only one of them set, based on which protocol version is in use?
> Should server_capabilities be renamed to server_capabilities_v1?

yes that's correct.  I can rename it.

> > +{
> > +	int ret = 1;
> > +	int i = 0;
> > +	struct object_id old_oid;
> > +	struct ref *ref;
> > +	struct string_list line_sections = STRING_LIST_INIT_DUP;
> > +
> > +	if (string_list_split(&line_sections, line, ' ', -1) < 2) {
> 
> Can there be a comment describing the expected format?

Yep I'll write a comment up.

> > +
> > +	oidcpy(&ref->old_oid, &old_oid);
> > +	**list = ref;
> > +	*list = &ref->next;
> > +
> > +	for (; i < line_sections.nr; i++) {
> > +		const char *arg = line_sections.items[i].string;
> > +		if (skip_prefix(arg, "symref-target:", &arg))
> > +			ref->symref = xstrdup(arg);
> 
> Using space-delimited fields in a single pkt-line means that
> - values cannot contains a space
> - total length is limited by the size of a pkt-line
> 
> Given the context, I think that's fine.  More generally it is tempting
> to use a pkt-line per field to avoid the trouble v1 had with
> capability lists crammed into a pkt-line, but I see why you used a
> pkt-line per ref to avoid having to have sections-within-a-section.
> 
> My only potential worry is the length part: do we have an explicit
> limit on the length of a ref name?  git-check-ref-format(1) doesn't
> mention one.  A 32k ref name would be a bit ridiculous, though.

Yeah I think we're fine for now, mostly because we're out of luck with
the current protocol as it is.

> 
> > +
> > +		if (skip_prefix(arg, "peeled:", &arg)) {
> > +			struct object_id peeled_oid;
> > +			char *peeled_name;
> > +			struct ref *peeled;
> > +			if (get_oid_hex(arg, &peeled_oid)) {
> > +				ret = 0;
> > +				goto out;
> > +			}
> 
> Can this also check that there's no trailing garbage after the oid?

Yeah I do that.

> 
> > +
> > +	packet_delim(fd_out);
> > +	/* When pushing we don't want to request the peeled tags */
> 
> Can you say more about this?  In theory it would be nice to have the
> peeled tags since they name commits whose history can be excluded from
> the pack.

I don't believe peeled refs are sent now in v0 for push.

> 
> > +	if (!for_push)
> > +		packet_write_fmt(fd_out, "peel\n");
> > +	packet_write_fmt(fd_out, "symrefs\n");
> 
> Are symrefs useful during push?

They may be at a later point in time when you want to update a symref :)

> 
> > +	for (i = 0; ref_patterns && i < ref_patterns->argc; i++) {
> > +		packet_write_fmt(fd_out, "ref-pattern %s\n",
> > +				 ref_patterns->argv[i]);
> > +	}
> 
> The exciting part.
> 
> Why do these pkts end with \n?  I would have expected the pkt-line
> framing to work to delimit them.

All pkts end with \n, that's just hows its been since v0.  Though the
server isn't supposed to complain if they don't contain newlines.

> 
> > +	packet_flush(fd_out);
> > +
> > +	/* Process response from server */
> > +	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> > +		if (!process_ref_v2(reader->line, &list))
> > +			die("invalid ls-refs response: %s", reader->line);
> > +	}
> > +
> > +	if (reader->status != PACKET_READ_FLUSH)
> > +		die("protocol error");
> 
> Can this protocol error give more detail?  When diagnosing an error in
> servers, proxies, or lower-level networking issues, informative protocol
> errors can be very helpful (similar to syntax errors from a compiler).

I'll update the  error msg.

> [...]
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -151,10 +151,14 @@ void free_refs(struct ref *ref);
> >  
> >  struct oid_array;
> >  struct packet_reader;
> > +struct argv_array;
> >  extern struct ref **get_remote_heads(struct packet_reader *reader,
> >  				     struct ref **list, unsigned int flags,
> >  				     struct oid_array *extra_have,
> >  				     struct oid_array *shallow_points);
> > +extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
> > +				    struct ref **list, int for_push,
> > +				    const struct argv_array *ref_patterns);
> 
> What is the difference between get_remote_heads and get_remote_refs?
> A comment might help.  (BTW, thanks for making the new saner name to
> replace get_remote_heads!)

I'll add a comment saying its used in v2 to retrieve a list of refs from
the remote.

-- 
Brandon Williams

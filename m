Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124A7B3E1
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741734173; cv=none; b=AS9wErCnJ1yHcONkTHWgLESKbQOUIwxGfQX6Hs2Ozdy5MlFPXDpmw5RNXiidDBq16mjVDUYCsKOG3VALXS4rY2+8/nXDT6CB9pLM+YKMxk6w2KSQ9EC8BlZb3gt7fiqFHWYxGI1o3ozakUGgr8lguept2/4S0g6DTwXuZvp0q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741734173; c=relaxed/simple;
	bh=OSnjx41RGim4mDhUB5ncuOITuplNhV/sI96U7ZB8oeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY2OHxcKQ5OVfeeDLXl1z6MNZ6ntk5qfx00x6ojiEQfXat9EyDNKohUSrSF1WjqwT72nGKWWyOu6TJI7bT3X/Z0uj9GnpRe0UJq50AQh45WGBjqRg9Z6iByZ6vm1B/4t807AP+xje+Ot5TuZ6TZ31EVnXu5qM5f4bItdnCfgywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZKPS2A/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZKPS2A/"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7273b0d4409so1342542a34.1
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741734171; x=1742338971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NMf7ob0841RGnAFFTHzb/xNov5iNcGgN0sUWq42wIo4=;
        b=EZKPS2A/rdrKuJpfMhQMpqUI8Y3evm0IXtwL+4T7+PW880FKb7ixeTb2mhKMJOt6SN
         jqxXzF/fB84tXB7Z7Z3UPuhOOZ4SUO4kd3lY8cib+Ylfi44nOtnBmzc0TfOtPvSiWeq+
         uqIWA/coL0bnlpcfTOK4ngOwD2aW07BPCnHu+HhbJbMwRWJ3KIcdUtQJLLlxr8s2FWei
         az7dz+34nVoC+Jh72s5E0kM2IflkhDXRaDcRAB0aq3mDoRAGOKldJS9vpn4n0w1GUpE9
         krt+4Bv0KwRbL5SpI9QPjlVPBnlM4yxFi12jpNDdWUQ+wVU1Tic1K3OwCdjMzzTwhfuN
         As+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741734171; x=1742338971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMf7ob0841RGnAFFTHzb/xNov5iNcGgN0sUWq42wIo4=;
        b=kJwym3BPyACT9HnikwJ4ldSgxgeFJMBH8/3KbraEU93daRrMIE+YY+n8MkfhbkB6m3
         Dhl6rvvv9aPf2pmHdN/q82HUKgntJa7F5nOx15vwBLgfx+ilIWEN71dbllk4UIanuCPl
         OCUH+sA/8l2RUpwsksX4wIXuQ0AhZXQqOYAhTBihcK5XbmIF4/0AjhVz9DzgWjhoiP0B
         aA/o6C0Dl/zQJti206zOXQiYzTqGBWoxNdc+znamGKvxnBeFBAAHhx0q2SqDtMxKSD7+
         8jJdbLcrysgq45CaUOj3UEL7PHmR1dmPwSM53ZWQYCZfAfjmFV4tmiEI640bWwVKvPwT
         3ugw==
X-Gm-Message-State: AOJu0YyDCAbZFQ8fTBBQuQNCkeiI0PoZJKsQE8kPdp7U1z1KAcR8tr4Q
	jv/Gs1ThpeX6i79a5+odJoVn5oBC8H7GH6LanpAvTo4jSwB0YR8pvl5pOQ==
X-Gm-Gg: ASbGnctZkW1/RuFonuXlt4v+IqJAA8sPZO2bGuMova9lP389dUYV3UnE/N0UTH0Tfuz
	gZ81IjiISjFcSs423H/v38VM2YsRQeQzq1uRWX7eDB/1lsfOsRwUSJ+9o24rL2TlLVMs/Pssdp8
	jvbY3V32i7FSWrEopzJJSXW1n17jJ4nwVkdbpXwhx86bTe2yDeUquI6JYqXwSXX4PVMgEzf9R0J
	o+7fARUmskgOoMt821iTIdhBnsU1AVTxTyutpSr8IrHoJmb0lJ06cttKNGWe1RQLskx90r3yatj
	tJVS/HZRweaITQbnPF62sZIMknf9xgj3F8YEvg==
X-Google-Smtp-Source: AGHT+IG3DE8NKFlM2bPGD26o8mR8FttuHI9+W0Q7VI94+8a7Tkj3RFeP65bgDM0H8XN/2BZT3I9oDQ==
X-Received: by 2002:a05:6830:6e99:b0:72b:9d5e:9429 with SMTP id 46e09a7af769-72b9d5e9861mr2795150a34.12.1741734170886;
        Tue, 11 Mar 2025 16:02:50 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72a4ba54601sm1760338a34.26.2025.03.11.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 16:02:50 -0700 (PDT)
Date: Tue, 11 Mar 2025 17:59:23 -0500
From: Justin Tobler <jltobler@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, christian.couder@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <gc4fnq2s57jle5zig4iz5fp3hu6juylp4g3dberzqjfuaszxl3@hucjve73hcbe>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <CALnO6CBh_pYiU0p6pSndJ8rdDiykqBkRgosyrO1QhaQ55BKrkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBh_pYiU0p6pSndJ8rdDiykqBkRgosyrO1QhaQ55BKrkQ@mail.gmail.com>

On 25/03/10 06:38PM, D. Ben Knoble wrote:
> On Mon, Mar 10, 2025 at 3:32 PM Justin Tobler <jltobler@gmail.com> wrote:
> >
> > When walking objects, git-rev-list(1) prints each object entry on a
> > separate line in the form:
> >
> >         <oid> LF
> >
> > Some options, such as `--objects`, may print additional information
> > about the object on the same line:
> >
> >         <oid> SP [<path>] LF
> >
> > In this mode, if the object path contains a newline it is truncated at
> > the newline.
> >
> > When the `--missing={print,print-info}` option is provided, information
> > about any missing objects encountered during the object walk are also
> > printed in the form:
> >
> >         ?<oid> [SP <token>=<value>]... LF
> >
> > where values containing LF or SP are printed in a token specific fashion
> > so that the resulting encoded value does not contain either of these two
> > problematic bytes. For example, missing object paths are quoted in the C
> > style so they contain LF or SP.
> >
> > To make machine parsing easier, this series introduces a NUL-delimited
> > output mode for git-rev-list(1) via a `-z` option following a suggestion
> > from Junio in a previous thread[1]. In this mode, instead of LF, each
> > object is delimited with two NUL bytes and any object metadata is
> > separated with a single NUL byte. Examples:
> >
> >         <oid> NUL NUL
> >         <oid> [NUL <path>] NUL NUL
> >         ?<oid> [NUL <token>=<value>]... NUL NUL
> >
> > In this mode, path and value info are printed as-is without any special
> > encoding or truncation.
> >
> > For now this series only adds support for use with the `--objects` and
> > `--missing` options. Usage of `-z` with other options is rejected, so it
> > can potentially be added in the future.
> >
> > One idea I had, but did not implement in this version, was to also use
> > the `<token>=<value>` format for regular non-missing object info while
> > in the NUL-delimited mode. I could see this being a bit more flexible
> > instead of relying strictly on order. Interested if anyone has thoughts
> > on this. :)
> 
> Without taking a deeper look, I think token=value has the benefit of
> being self-describing at the cost of more output bytes (which might
> matter over the wire, for example). Generally I like the idea;
> sometimes I find it troublesome having to parse prose manuals for the
> specifics of output formats like field order, especially when I end up
> coding a parser for the format. If the field order doesn’t matter to
> the consumer, then perhaps using ordered fields AWK-style is
> inappropriately terse?
> 
> OTOH, the -z format is for machines, and they don’t need human labels
> ;) [I think token labels would be a great parser-writing and debugging
> aid]

One of the challenges with parsing git-rev-list(1) is all the various
forms it can take based on the options provided. For example:

    $ git rev-list --timestamp --objects --parents <rev>

    timestamp SP <oid> [SP <parent oid>] LF   (commit)
    <oid> SP [<path>] LF                      (tree/blob)

Relying strictly on order can be a bit tricky to parse due to how the
output format can change even line to line. So even for machine parsing,
labels may help simplify things if all object records follow something
along the lines of:

    <oid> NUL [<token>=<value> NUL]...

As you mentioned, this could potentially also be useful for users since
the attributes would be self-describing. This series is currently
focussed on the machine parsing side, but I think support for this mode
in a human-readable format could be added via a separate option in the
future.

-Justin

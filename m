Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E743A1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 22:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeCTWbB (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 18:31:01 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32791 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeCTWbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:00 -0400
Received: by mail-wm0-f47.google.com with SMTP id i189so3799302wmf.0
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nicaQNt8O4pUXSk05GpJ0UeqjYI4nHh+ktlakjSK+x8=;
        b=DnTjPrGNtjhYCwZds050wRusDhF++IPpqZEgs39FlcnyGIakK8P8l9OQO4lYD/9Fo8
         ihPTtartv3JzTyonCQ4I8aaSrSoYoX1AdDHGHRBWFcGKEMVTTZiWcCkWq5p8/bHce8n2
         jKEBzSAcww8ZjY1jCiPNZXcJjxx2eX8L/E9UaCTSkga8QvVimnc1g+O7N6rDZCiP3RNT
         BoS68oD+iXy75gAC7DWts7LxeeBL+ufHBJT5teAFzLkOuy6zJuxyPaaFBhEJsxadjrM9
         qvt5C3dJZssq2TLj0J3yY02vDIukAh8YrWo6DqNDEUcP2diSgS+Zo0zpZ/Y+cJwK7fK/
         RwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nicaQNt8O4pUXSk05GpJ0UeqjYI4nHh+ktlakjSK+x8=;
        b=VficHzqe4WVNSiFeBaM6jIsDnvWX3dbpgYvkAcbQaubDi8gPZVKku6e5iQfIxThXiE
         aVPT2pBnP99axyRpEqy4z0gxanL5aEofnpysUCKdSe6mqJZ9QPw83GcYjGAh2D8B2yab
         7qAmpTuzPlZlvP5OBxc+0o5f1qlrtlbanXbF6Ap5+uGRMoEqByCguKchub558PcqJwTB
         VsIHYgMYQBgbGbliDM7jm46U4nXRgk0k62o4oq5LKKc53/nsi7+V1swl8teqn9i874bf
         0MjqBosIzclVM0HC60YpgMNjegSsgG/abYzC/GCUH5HGqBWykgHTUd2UfshSXcwyEnyx
         aC0A==
X-Gm-Message-State: AElRT7GQCJUqTrv6jHHi4e1Wv5dUNmC6/OfEv1b20aIkl0ESSbuIL7qC
        uyhVS78FXLukJJzL+5doW/s=
X-Google-Smtp-Source: AG47ELsNV3C7fZef3YnsAxw0Y1nVYYmFT3SiPh0diPF6dKxPb0oWh2mshFvIM0/hUvtMRXPA2K2Mkw==
X-Received: by 10.28.144.5 with SMTP id s5mr917255wmd.98.1521585058473;
        Tue, 20 Mar 2018 15:30:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k44sm3041260wrk.6.2018.03.20.15.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 15:30:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] ref-filter: get_ref_atom_value() error handling
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
        <010201624428199f-b4b3d8ce-222f-4966-9171-7fcf932ca220-000000@eu-west-1.amazonses.com>
        <CAPig+cSxGgG=1k95j+n4DZHBdtN++7F6_U5fu0gOcjwwPQ5GZw@mail.gmail.com>
Date:   Tue, 20 Mar 2018 15:30:56 -0700
In-Reply-To: <CAPig+cSxGgG=1k95j+n4DZHBdtN++7F6_U5fu0gOcjwwPQ5GZw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 20 Mar 2018 14:19:11 -0400")
Message-ID: <xmqqh8paqt0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Overall, with the need for resource cleanup, this function becomes
> unusually noisy after this change. It could be tamed by doing
> something like this:
>
>     int ret = 0;
>     void *buf = get_obj(oid, obj, &size, &eaten);
>     if (!buf)
>         ret = strbuf_error(_("missing object %s for %s"),
>             oid_to_hex(oid), ref->refname);
>     else if (!*obj)
>         ret = strbuf_error(_("parse_object_buffer failed on %s for %s"),
>             oid_to_hex(oid), ref->refname);
>     else
>         grab_values(ref->value, deref, *obj, buf, size);
>    if (!eaten)
>         free(buf);
>     return ret;

I have no idea what strbuf_error() that does not take any strbuf is
doing, but I think you can initialize ret to -1 (i.e. assume the
worst at the beginning), and then make the "ok, we didn't get any
errors" case do

	else {
		grab_values(...);
		ret = 0;
	}


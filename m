Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB2D1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbdBGUYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:24:34 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32998 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755452AbdBGUYc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:24:32 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so12982830pgd.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MqiQDTOyyjF7zVjl7AsDXlO3akW/UPCQ4Tor20IWRBU=;
        b=FmOpLimKdwzoWPt/xe2GMfXewqJdDlLA4JHA6i9n11TNCXaEljVhVhKXz/ZFublH14
         uY0ihwojjxk/3zmxdEES3TZwt7rhqFA+KH/N4dCMhSJ4pxTuKias3216ucaiz5+z4I1e
         mAbeA7fHtJ1HDbVHvA5eqrtH/83H21nCnKyaASiVy3hm8ECkmKOg+88kDEZBK3S7Wk13
         K6HfFZPHN0DxS/JDHLUQM2pVyXYDLrpMjkjijuAF11Y7NJBMi8ekay2cmawRtuAxa6+w
         kc4tJCmxHdwr8mpK7ww2biHqFJiXw7GaifrrA0W2mvfNSyNLEMFl9iZbMCMnuDM8frpz
         uA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MqiQDTOyyjF7zVjl7AsDXlO3akW/UPCQ4Tor20IWRBU=;
        b=dNg5wk6G8yCRtpNf2EwNGkIoMpwJ8zA+D9UD/KDKmz0DpITiiUuiDMPSXXnpo1S8BH
         U5QZV7wu+tEZAyab1lpOmE0zHcipavIr1bl4qm+BowbxDGgoW+7TjgjSeUh+51LJmeK3
         vURrwOLCJcyR0QxfOppOUhFfKuRKGtis0DHALf/eWE4mQ2K8nj3YLqZ0DzgDD2GIsi2F
         fMJlS6y1JJ8YIy0NVmqQyzRp7iketHenkOikez5E/opZ0MaIqvJHD3w47zTl0pPTBqQu
         bMCh5xlRwBaQponiRoAtXyfzU4S+GURzTogMt12bghP800SBUOy/tC3xLhAaKfQWU3Qg
         iALw==
X-Gm-Message-State: AIkVDXKpK5Q6QQPYo5ygX6x3+Ema3BkixoZkmCdRjocUXsf98f/5fQpb4NdWSRAojrDHAg==
X-Received: by 10.99.101.199 with SMTP id z190mr22033321pgb.219.1486499072034;
        Tue, 07 Feb 2017 12:24:32 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id l12sm13702157pfj.37.2017.02.07.12.24.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:24:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] grep: use '/' delimiter for paths
References: <20170120171126.16269-1-stefanha@redhat.com>
        <20170120171126.16269-3-stefanha@redhat.com>
        <xmqqpojhwf2r.fsf@gitster.mtv.corp.google.com>
        <20170120235133.GA146274@google.com>
        <20170207150414.GD8583@stefanha-x1.localdomain>
Date:   Tue, 07 Feb 2017 12:24:30 -0800
In-Reply-To: <20170207150414.GD8583@stefanha-x1.localdomain> (Stefan
        Hajnoczi's message of "Tue, 7 Feb 2017 15:04:14 +0000")
Message-ID: <xmqq8tphzr41.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Perhaps it's better to leave this than to merge code that doesn't work
> correctly 100% of the time.

I am not sure if you are shooting for is "work correctly" to begin
with, to be honest.  The current code always shows the "correct"
output which is "the tree-ish object name (expressed in a way easier
to understand by the humans), followed by a colon, followed by the
path in the tree-ish the hit lies".  You are making it "incorrect
but often more convenient", and sometimes that is a worth goal, but
for the particular use cases you presented, i.e.

    $ git grep -e "$pattern" "$commit:path"

a more natural way to express "I want to find this pattern in the
commit under that path" exists:

    $ git grep -e "$pattern" "$commit" -- path

and because of that, I do not think the former form of the query
should happen _less_ often in the first place, which would make it
"incorrect but more convenient if the user gives an unusual query".

So I am not sure if the change to "grep" is worth it.

Having said that, I actually think "make it more convenient" without
making anything incorrect would be to teach the revision parser to
understand

    <any-expression-to-name-a-tree-ish:<path>

as an extended SHA-1 expression to name the blob or the tree at that
path in the tree-ish, e.g. if we can make the revision parser to
take this

    master:Documentation:git.txt

as the name of the blob object, then the current output is both
correct and more convenient.  After all, this sample string starts
at "master:Documentation" (which is an extended SHA-1 expression to
name a tree-ish), followed by a colon, then followed by the path
"git.txt" in it, and "grep -e pattern master:Documentation" would
show hits in that blob prefixed with it.

I.e.

	T=$(git rev-parse master:Documentation)
	git cat-file blob $T:git.txt

would give you the contents of the source to the Git manual.  It is
not all that unreasonable to expect

	git cat-file blob master:Documentation:git.txt

to be able to show the same thing as well.  You'd need to backtrack
the parsing (e.g. attempt to find "Documentation:git.txt" in
"master", fail to find any, then fall back to find "git.txt" in
"master:Documentation", find one, and be happy, or something like
that), and define how to resolve potential ambiguity (e.g. there may
indeed be "Documentation:git.txt" and "Documentation/git.txt" in the
tree-ish "master"), though.



Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF33202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 03:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933401AbdJQDdS (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 23:33:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50100 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754964AbdJQDdR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 23:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2649FB1145;
        Mon, 16 Oct 2017 23:33:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jZwA87F/6hnVTt6bDBoyAmq1hUE=; b=EKPB0E
        Pz2MLFMezMc2r90PBIpGh9xauvhflsB4KBkkMQLTdRpjV6fseT+lQ0aKFYbZJpm4
        MyN+e8dF2/TKFtLE3jLit6SUUSM1uaVrzjkjfOmjl38ejw1VxnrdTmr17n/U6PfN
        kY7iNxj74zONGrMiYDaS2m9wi/6rvUPnYJZiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aIRSSQtmrVNzf6opcNe/cdI8Zd7wz3Kf
        +UxNGgKBv8SuIsoovAMVbtNKICRkVECQaO9XjqPKz5Jw+CVripgtUCc7XHFLFmlk
        t2qpMXmcWSY3yJMFPUkeIciM0tj0r/hooMAohjQqnRyID2kVM+USSL3Gh908uQ/V
        sq+zZ1szNvA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CC87B1144;
        Mon, 16 Oct 2017 23:33:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 486B4B1143;
        Mon, 16 Oct 2017 23:33:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
        <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
        <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
        <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
Date:   Tue, 17 Oct 2017 12:33:15 +0900
In-Reply-To: <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 16 Oct 2017 22:42:03 -0400")
Message-ID: <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9876790-B2EB-11E7-BDDA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 17, 2017 at 10:22:31AM +0900, Junio C Hamano wrote:
>
>> > I like the state this puts us in, but there's one catch: we're
>> > completely changing the meaning of "check-ref-format --branch", aren't
>> > we?
>> >
>> > It is going from "this is how you resolve @{-1}" to "this is how you
>> > check the validity of a potential branch name". Do we need to pick a
>> > different name, and/or have a deprecation period?
>>  ...
>> At least that is what I wanted to happen in the patch.
>
> Ah, OK, I did not read carefully enough then. I think that would be OK,
> and probably close to what Jonathan was asking for.
>
> It leaves unresolved the fact that the resolving feature does not belong
> in check-ref-format in the first place, but we can just accept that as a
> historical wart.

Yup, I actually was in favor of removing that and making it a
"purely checking validity" feature, but given that it has been
advertised in the documentation since 604e0cb5 ("Documentation:
describe check-ref-format --branch", 2009-10-12), it is a bit too
late to tell users that rev-parse is the right/kosher thing to do.

> I don't think there is any need to prepare it upon my 4d03f955,
> though.  I'd think it could simply replace it.

Yeah, it ended up that way, it seems.  Still it needs a bit of doc
updates to balance the description.  Right now we stress on @{-n}
resolution too much.

Perhaps something like this?

 Documentation/git-check-ref-format.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 92777cef25..cf0a0b7df2 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -77,7 +77,14 @@ reference name expressions (see linkgit:gitrevisions[7]):
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
-With the `--branch` option, it expands the ``previous branch syntax''
+With the `--branch` option, the command takes a name and checks if
+it can be used as a valid branch name (e.g. when creating a new
+branch).  The rule `git check-ref-format --branch $name` implements
+may be stricter than what `git check-ref-format refs/heads/$name`
+says (e.g. a dash may appear at the beginning of a ref component,
+but it is explicitly forbidden at the beginning of a branch name).
+When run with `--branch` option in a repository, the input is first
+expanded for the ``previous branch syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
 were on.  This option should be used by porcelains to accept this
 syntax anywhere a branch name is expected, so they can act as if you

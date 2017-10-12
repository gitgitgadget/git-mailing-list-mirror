Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3B81FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 05:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdJLFky (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 01:40:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37279 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdJLFkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 01:40:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id z80so4676430pff.4
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 22:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pD3nbnpoqmyvCX1rvay74RTMsTmBsmYwrjCJ7sl5E6U=;
        b=fu1MKVGjrEP4LnVThFFZLOXR+voSHuxll1M9ijnqYrm210okwOqiqfr7aPlHjmLH0/
         0w7hhAuGmcXXUOerkb86UT0FVAakrxyHedt30eTbLNdSOTLgYs0x6ZPkMZwQxXu7Tug1
         6ylsU6PQJ9vNxsMhsM5YhJIekReoEEYcBYgeEEI2kE8NWE5DLkwzENEBRoWGLCrKLSZS
         UCI1oSJv8IP2kTyoBFX3va3+G14u4SZYgj9wCueHXYWq9n4t3xvb3145IKICuMOfhfUX
         0k6LS/e7mQeg+eP1ZaB4/sCmJOrPg9V6HNdXtdqB79GWZ16j4NU7A9iq6+VCP41QACwb
         NiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pD3nbnpoqmyvCX1rvay74RTMsTmBsmYwrjCJ7sl5E6U=;
        b=q4rIm7AkktOc6FlRKD6FOGXJXbVgcaWBePlj2A0UiIIGbXv62mn2LvNi/8kPFctkvu
         gz61u9BdoTFWqO8JxGndkzOajcwuTDb3IumDmOYBWN2irmS9YwGNvWRAKMoKb9Ias2us
         3gPaEboCA37hQEoONAxve85oRzx0usX0YZeimXvDPWwj0vdNPyFXoiMRZQmg2o6PY2zb
         7WYjJGkAkDCwsWKVu+YaFz8UH7kCpr3nO/FH98XpX4QHb/MCLD0MU6DIeWkG9ZrMSyCR
         +mG6xp5ZH/M0hgMIOZI2WVt9M2RNxTAXvFgr92QKU9xaTBn4llCGiBTHUyh3K+y3QDog
         suYA==
X-Gm-Message-State: AMCzsaWOo07OpZJ2bu+05bhmogwoaljQ9p9UojCPJBKYdigs56BtdpYj
        GWNexCMe7lpiHrh+eLruIvA=
X-Google-Smtp-Source: AOwi7QDmmDrq7tBxrVzNmH6t893XCAfxNhP7Zdu6cEIkLaIY53uVXSzny70lc0WLTkQQdxONPxfExg==
X-Received: by 10.84.224.131 with SMTP id s3mr1188805plj.409.1507786852396;
        Wed, 11 Oct 2017 22:40:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id a7sm21643790pgc.40.2017.10.11.22.40.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 22:40:51 -0700 (PDT)
Date:   Wed, 11 Oct 2017 22:40:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171012054049.GF155740@aiede.mtv.corp.google.com>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012044724.GD155740@aiede.mtv.corp.google.com>
 <xmqqa80x0xcw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa80x0xcw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Should we document this special case treatment of color.* in -c
>> somewhere?  E.g.
>
> Perhaps, although I'd save that until we actually add the new option
> to "git" potty, which hasn't happened yet, if I were thinking about
> adding some text like that.  Also I'd call that --default-color=always
> or something like that, to avoid having to answer: what are the
> differences between these two --color thing in the following?
>
>     git --color=foo cmd --color=bar

I agree that the color.status text in the example doc is unfortunate.
But the surprising thing I found when writing that doc is that
color.status ("git status", "git commit --dry-run") and
color.interactive are the only items that needed it (aside from
color.ui that needed it for those two).  All the other commands that
use color already accept

	git cmd --color=bar

color.interactive applies to multiple commands (e.g. "git clean"), so
it would take a little more chasing down to make them all use
OPT__COLOR.

Heading off to sleep, can look more tomorrow.

I don't think we can get around documenting this -c special case
behavior, though.

diff --git i/builtin/commit.c w/builtin/commit.c
index d75b3805ea..fc5b7cd538 100644
--- i/builtin/commit.c
+++ w/builtin/commit.c
@@ -1345,6 +1345,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	struct object_id oid;
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT__COLOR(&s.use_color, N_("use color")),
 		OPT_SET_INT('s', "short", &status_format,
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOL('b', "branch", &s.show_branch,
@@ -1595,6 +1596,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
 		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
+		OPT__COLOR(&s.use_color, N_("use color")),
 
 		OPT_GROUP(N_("Commit message options")),
 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),

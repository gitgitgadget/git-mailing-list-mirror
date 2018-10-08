Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11131F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIBWU (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:22:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46373 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:22:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so8706488pfb.13
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pYZUB8PMJikgwB1QcKGnaiqA8ijOYTSdbr7on+SmJeA=;
        b=0AvNHlIlMAWWo4QlwXOhDbddR5gx35vYZc3onEI/yv4jldLJGjXGQ3Yz9R3ojllcjk
         CNjwb3NNv3M/DnlsMxWgyq02hiGaJFTmTdTLNPjxTbP1/Ho7lBnlnJ+Lt9r4VcrfWKYp
         5i8s8LUFoiXG3kDCV6ANvSmaBMQ9ZMTLLVYZ/zCpO3TUSQ59JvRHt1Nb97wo9KaY5C0t
         WmtZtZjrnPW9m79Wa0piuM5gNO08A1C84PPA3FLTeBfU3tVi0PmejlPNcUXV8JdCy2RH
         620JuxYmXY5ztFXqngP22Pw6PNQwsJSn8RArzEMzQ53nQqbrhXQIL9mK/WkCorJ5ML3p
         lKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYZUB8PMJikgwB1QcKGnaiqA8ijOYTSdbr7on+SmJeA=;
        b=gKPVgv30t1QE/M2m+IjDdqfFuAB1UDpLWKUArsoJcumXDgXFZAtDsHEK6Ml1hfzhy2
         cglEA0be+qgmOvDFivhlhtZ98/s0jmlVRCNM3xAwmg2Fv6bOEisty9XkKagLGDI9aYKD
         YuJqoDeiOobYbnPLqQBe7kwcabOtNpb1eZlz0RLFrkOlnU6qDHYxMnVRLyw4iU1UnaWJ
         +qEPRp2b912EvFVYggixWLFFUPB9oZqC8WK6/b8XSGn+8YvDIRrv2pCv9P6lK3ZRfz/p
         15zTCBtPRS81vVBumDMd7ERrdF+TzImkKAmewMCa4wknWUelgxlyqxuM8R2Yemci3e0h
         m7wA==
X-Gm-Message-State: ABuFfoi6ByWwIkXQpzmUeEx8ZcLif/Abv/nwkC4lRgJ8ZCi0+rYS5aco
        jV690yVyxmEY0YmMfLqu/3lQ32v8/VY=
X-Google-Smtp-Source: ACcGV61O1R4GHTxd8VCVTZAhgNNZTRH9Oa3mJLsIbj2cfMwj9jJM1hyI4rDiVZVPnL8Dms0wLcYyNg==
X-Received: by 2002:a63:c044:: with SMTP id z4-v6mr21968126pgi.274.1539022163059;
        Mon, 08 Oct 2018 11:09:23 -0700 (PDT)
Received: from localhost ([205.175.107.112])
        by smtp.gmail.com with ESMTPSA id o2-v6sm36420590pfj.57.2018.10.08.11.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:09:22 -0700 (PDT)
Date:   Mon, 8 Oct 2018 11:09:20 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v5 0/4] Filter alternate references
Message-ID: <cover.1539021825.git.me@ttaylorr.com>
References: <cover.1537466087.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537466087.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is (what I anticipate to be) the final re-roll of my series to
introduce 'core.alternateRefsCommand' and 'core.alternateRefsPrefixes'
in order to limit the ".have" advertisement when pushing over protocol
v1 to a repository with configured alternates.

Not much has changed from last time, expect for:

  - Taking a documentation suggestion from Peff (in 3/4), and

  - Fixing a typo pointed out by Ramsay (in 4/4).

I believe that this series is otherwise ready for queueing, if everyone
else feels sufficiently OK about the changes.

Thanks in advance for your review.

Thanks,
Taylor

Jeff King (1):
  transport: drop refnames from for_each_alternate_ref

Taylor Blau (3):
  transport.c: extract 'fill_alternate_refs_command'
  transport.c: introduce core.alternateRefsCommand
  transport.c: introduce core.alternateRefsPrefixes

 Documentation/config.txt           | 18 +++++++++++++
 builtin/receive-pack.c             |  3 +--
 fetch-pack.c                       |  3 +--
 t/t5410-receive-pack-alternates.sh | 41 ++++++++++++++++++++++++++++++
 transport.c                        | 38 +++++++++++++++++++++------
 transport.h                        |  2 +-
 6 files changed, 92 insertions(+), 13 deletions(-)
 create mode 100755 t/t5410-receive-pack-alternates.sh

Range-diff against v4:
1:  76482a7eba = 1:  e4947f557b transport: drop refnames from for_each_alternate_ref
2:  120df009df = 2:  3d77a46c61 transport.c: extract 'fill_alternate_refs_command'
3:  c63864c89a ! 3:  7451b4872a transport.c: introduce core.alternateRefsCommand
    @@ -42,14 +42,9 @@
     +	hex object id per line (i.e., the same as produce by `git for-each-ref
     +	--format='%(objectname)'`).
     ++
    -+This is useful when a repository only wishes to advertise some of its
    -+alternate's references as `.have`'s. For example, to only advertise branch
    -+heads, configure `core.alternateRefsCommand` to the path of a script which runs
    -+`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
    -++
    -+Note that the configured value is executed in a shell, and thus
    -+linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
    -+the path argument specially.
    ++Note that you cannot generally put `git for-each-ref` directly into the config
    ++value, as it does not take a repository path as an argument (but you can wrap
    ++the command above in a shell script).
     +
      core.bare::
      	If true this repository is assumed to be 'bare' and has no
4:  0f6cdc7ea4 ! 4:  28cbbe63f7 transport.c: introduce core.alternateRefsPrefixes
    @@ -39,8 +39,8 @@
      --- a/Documentation/config.txt
      +++ b/Documentation/config.txt
     @@
    - linkgit:git-for-each-ref[1] by itself does not work, as scripts have to handle
    - the path argument specially.
    + value, as it does not take a repository path as an argument (but you can wrap
    + the command above in a shell script).

     +core.alternateRefsPrefixes::
     +	When listing references from an alternate, list only references that begin
    @@ -62,7 +62,7 @@

     +test_expect_success 'with core.alternateRefsPrefixes' '
     +	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
    -+	git rev-parse private/branch expect &&
    ++	git rev-parse private/branch >expect &&
     +	printf "0000" | git receive-pack fork >actual &&
     +	extract_haves <actual >actual.haves &&
     +	test_cmp expect actual.haves
--
2.19.0.221.g150f307af

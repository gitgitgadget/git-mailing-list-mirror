Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42A720986
	for <e@80x24.org>; Tue, 27 Sep 2016 21:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbcI0Vs7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 17:48:59 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34236 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbcI0Vs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 17:48:57 -0400
Received: by mail-pf0-f179.google.com with SMTP id l25so9840435pfb.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZTt0+bk3KIsRwqjD55oRdmsgKUYQoFlp5IT+c0tOaAI=;
        b=XUfni+0ndacQE2xwPlLLZwgJmn8fdxkoBZi6c7Bn/o+Atrl9wUztZ4qJduEsuXjDUs
         XS2FRqOAB5/ubTaWwYHRLdICR5da4MEN06GOnVkIe8+ppnziD5FUUo2X9xsd0va7WEe6
         gzxtPh+L8vLAaSOLhPRXgN8ITS4KM5+3GqpauvBNPnlgQrdb55i35ZnsSp//b+ziSvla
         AYnHUtKa5xHYxfsZMuOuqEbXwPQismRZ1m79RoBTmmHazWdXcvQtSjxc1np+2J7I+OaB
         KZuzqjJfukPt4B/Wzc5odLtf0gqbryPRGHYzO1Xua3m44HXGLqLrHCDsOB9UHLLL6AGV
         AcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZTt0+bk3KIsRwqjD55oRdmsgKUYQoFlp5IT+c0tOaAI=;
        b=VUbrZ+Cse8DJfhv7UuhHQ5XUCMabL3OjjpptLZirhHKLYgKe4c7LZ1VTn4fihz3TYa
         1hJzg9zqUYEgUmghtbULuwwR79vnOo7UPGdMwV+WVXqst6BHQAnvT3zrFOrvZojUXrou
         u3X3rG6YUje9SREHL23QQEA5sWJ6QrXI8U6d/JkynZG7VJIBWJvPa/cBEtdQTHtD3Lx6
         SZeatO6ou/eK+ykNsBUXJNNhxVNU6wVyWqjNbe/oVxfVJE51mHsTsppwlWzEOuU4XMyR
         TSy0QRZvoP/H8xDNe5ewQ5hbO2SRj077dXSPyfaQVmZuuWpl5Riu+XoF9+jMug+t8SRe
         xbDQ==
X-Gm-Message-State: AA6/9Rn51noK/1IdYlstC0UzatbC+ebv3fU4RnsTrOEO2Bg1+BXSFt8qNMHcfNm8Ewih7aqP
X-Received: by 10.98.133.132 with SMTP id m4mr40071481pfk.133.1475012936510;
        Tue, 27 Sep 2016 14:48:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b482:c60d:2980:8ef5])
        by smtp.gmail.com with ESMTPSA id id6sm469515pad.28.2016.09.27.14.48.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Sep 2016 14:48:55 -0700 (PDT)
Date:   Tue, 27 Sep 2016 14:48:54 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
Message-ID: <20160927214854.GA180705@google.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
 <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
 <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
 <xmqq60phm39w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60phm39w.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> > What we internally call "prefix" and "--submodule-prefix" is closely
> > related in that they both interact with pathspecs.  "prefix" gets
> > prepended to elements of an end-user supplied pathspec before a
> > full-path-in-the-repository (i.e. a path in the index and a path
> > relative from the top of the working tree) is matched against them.
> 
> In a sense, this new thing is a superset of the existing GIT_PREFIX,
> which gives the current working directory from the end user's point
> of view relative to the actual current working directory.  The "git"
> wrapper, when running a "git thing" from a subdirectory of a working
> tree, chdir(2)s up to the top-level before spawning the "thing"
> subcommand that is not built-in or a third-party "git-thing" binary
> on user's $PATH; so "git-thing" binary will be told via $GIT_PREFIX
> relative to what directory path-like things the end user supplied to
> the command (e.g. "-o outfile" argument and pathspecs) need to be
> interpreted.  The new thing can override the $GIT_PREFIX to allow
> path-like things to be interpreted relative to somewhere _above_ the
> top-level of the working tree.
> 
> I am tempted to suggest GIT_SUPER_PREFIX, 50% because I cannot think
> of any better word, 40% because I think it actually makes sense (in
> the sense that this comes _above_ it, hence "super", and also in the
> sense that this is something your "super" project would give you),
> and 10% because I hope that being ridiculous would nudge people to
> come up with a better alternative ;-)

haha, yeah it seems difficult to come up with a name that is going to
mean the same thing in 5 years from now.  At least GIT_SUPER_PREFIX
makes senese in that it is a path from the superproject down to the
submodule.

> >  * It is unclear how this should interact with commands that are run
> >    in a subdirectory of the working tree.  E.g. what should the
> >    prefix and the pathspec look like if the command in the above
> >    example is started in w/git.git/Documentation subdirectory, i.e.
> >
> >     $ cd ~
> >     $ git -C w/git.git/Documentation ls-files \
> >         --submodule-prefix=??????? -- '???????' |
> >       xargs ls -1 -l
> >
> >    Should we error out if we are not at the top of the working tree
> >    when --submodule-prefix is given?
> 
> ... the answer to this question becomes clear.  It is not possible
> to _be_ in a subdirectory "Documentation" of this working tree and
> in a directory "~" above this working tree at the same time, so we
> simply should forbid running the command from anywhere other than
> the top of the working tree (i.e. the internal "prefix" and
> GIT_PREFIX must be empty) when the super-prefix is set by erroring
> it out.  When we realize that "prefix" adds to the paths that are
> supplied by the user (e.g. when the user says Makefile while in t/
> subdirectory, i.e. GIT_PREFIX=t/, s/he means t/Makefile), but this
> new thing subtracts from the paths given by the user (e.g. when the
> user gives a pathspec 'w/git.git/D*' while setting the super thing
> as w/git.git, because s/he is at ~/, the pathspec matcher
> conceptually subtracts w/git.git/ from the pathspec before matching
> them against the paths it finds in the index), it becomes clear that
> giving both at the same time is awkward and not very useful.

Well maybe...I don't really know much about how the prefix interacts in
every scenario but would what you describe still work if we are in a sub
dir of the superproject (which contains other directorys and perhaps a
submodule) and execute a --recurse-submodules command in the
subdirectory?  I suspect we don't want to force users to be in the root
directory of the project in order to use --recurse-submodules.

-- 
Brandon Williams

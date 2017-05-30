Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111232027C
	for <e@80x24.org>; Tue, 30 May 2017 22:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbdE3Wxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 18:53:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32770 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdE3Wxj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 18:53:39 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so16512pfe.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 15:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PpENXi2J/NDUcttaW5GGpB8oIAZT+UlK0mRUPPBWUSU=;
        b=AjJagackgUN483kDNstuQZOVQ1MPvosvOnJ6/kdTyOdTWzrotPDOxZBgib3PuWkl4d
         F9wZ/gPmOf68gHmWhLRrLI7mzzF08UiMRO6CRpTYxUgYN93LmydeZwoiE+hH2ePwhH2K
         rmWG8sbq6ld7C5oue8lv/y8Mmqu2PMhIP51gaq9D03iNbKrjCnq961Z6DYZNEzZ6er3p
         i+duzOjKyonoAJLADr62puxRAsrB9YjCfl+dUCk9Q2mHKdVqgD8xPbFahZfRdwWLoVAu
         J8bRRDPQVOFVxLSjZ6QNmDEhq+KzyxKviynov0UGXBiAB9TYk3CC7jdwcGEw+G3h5mh2
         k7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PpENXi2J/NDUcttaW5GGpB8oIAZT+UlK0mRUPPBWUSU=;
        b=pQAf78AJSssyWRlYaX71aGH+1yBjoQ9+whCkSLzdoTEazfpmmDuSCIGbJXTYVGE+EA
         fQqMb9FJ7EpjDihikzQovSqv+Xl7O4UjiDO3E95vZqwVub1uj3kj8kHV5w6CGNg0mnxp
         aLVKQg//nCLp7vDdvLKi0aBaHfUtd385YoWI65mIyhKl0R/BcHaa0nsZwLLhgm7Wtv1S
         ZQfJhjF0txQ5XBd7sO52ggt74JkvTzRM5khGFJLNyuTm7NsaH3KhCQ4XJ9hzfP18Ubav
         TD9ZzcmCft1yHOooi7fvcEjQgU/EWWyivbnEPXoHaQm5NHboSdX9MKznxud0F0AReJuK
         Lhlg==
X-Gm-Message-State: AODbwcBwcjeKkMkm02zu1tGvQnf/Au1oljq99a/YCxiBEUcPlPCY5Xdv
        y2DqQkYMgMHcog==
X-Received: by 10.101.86.12 with SMTP id l12mr27662366pgs.114.1496184818860;
        Tue, 30 May 2017 15:53:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id f86sm24644488pfj.128.2017.05.30.15.53.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 15:53:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: revision API design, was Re: [PATCH v4 02/10] rebase -i: generate the script via rebase--helper
References: <cover.1493207864.git.johannes.schindelin@gmx.de>
        <cover.1493414945.git.johannes.schindelin@gmx.de>
        <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
        <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705291252080.3610@virtualbox>
        <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705301700440.3610@virtualbox>
Date:   Wed, 31 May 2017 07:53:37 +0900
In-Reply-To: <alpine.DEB.2.21.1.1705301700440.3610@virtualbox> (Johannes
        Schindelin's message of "Tue, 30 May 2017 17:08:44 +0200 (CEST)")
Message-ID: <xmqq1sr6arda.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> See 66b2ed09 ("Fix "log" family not to be too agressive about
>> ...
>> ask the existing command line parser to set them for you.
>
> This is a very eloquent description of a problem with the API.

Yes, but ...

> The correct suggestion would be to fix the API, of course. Not to declare
> an interface intended for command-line parsing the internal API.
>
> Maybe the introduction of `pretty_given` was a strong hint at a design
> flaw to begin with, pointing to the fact that user_format is a singleton
> (yes, really, you can't have two different user_formats in the same Git
> process, what were we thinking)?

... this tells me that you do not understand the issue.  The
embarrasing but necessary pretty-given field was not about
user_format (let alone singleton-ness of it) at all.  It was about
the show_notes feature that wants to be on by default most of the
time, but needs to be defeated when the end user asked for certain
formats.

Quite frankly, I am not interested in listening to a proposal to
update API by a person who does not understand the issue in the API,
but that is a separate issue.  A more important thing is that the
update to "rebase -i" is important enough and we do not want to
delay it by introducing further dependency.  IOW, I do not want to
spend an extra development cycle or two to update the revision setup
API and have you rebase the series on top after the API update is
done.

The current API to hide such an embarrasing but necessary
implementation details from the code that does not need to know
them, i.e. the consumer of rev-info structure with various settings,
is to invoke the command line parser.  Bypassing and going directly
down to the internal implementation detail of rev_info _is_ being
sloppy.  I would strongly prefer to see that the current series
written for the API to allow us get it over with the "rebase -i"
thing, and think revision setup API separately and later.

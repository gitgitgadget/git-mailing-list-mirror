Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CFE1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeBWW4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:56:41 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37594 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeBWW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:56:40 -0500
Received: by mail-pl0-f68.google.com with SMTP id ay8so5709519plb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PBn8mLdqOiHw2jhFSK22LBv6L+/uC8CyB1FBu65SI0=;
        b=SzILq0d+eys+kg4zitH15ZbVG1YjJEfbdhB0J4yc1rJxzfA0AqS+7ZHBJM4378goAB
         gP/clNl0sYVmaf/DxqtqsMsV0JahM3ETJB245cCewJ6JlsxiGuUbURc9fmMMdJZU7cRE
         Pl5qhfDUcZSCCM346wt+By29kYuaBfAphJAt+NDjoOkUHepJoth4IrTm4bnWwXVWxySr
         dUmk/hqReDBr4lXnvA6oCj3/XIjuaOxkf19kyKIun64tAQnXK/7nuXJ9m29xCwYncMaI
         xLIv8BWD3LHRSRnf3lLuHLJh7vIutxrNzMA5uIpu5m/jCoN7K1SAVyyZubJnyJzGwRPb
         atmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PBn8mLdqOiHw2jhFSK22LBv6L+/uC8CyB1FBu65SI0=;
        b=kV7s3gBkMunREh3Hii5P4f+fUOsJ1p1U4jFZAQ+1MK8vcIJh8G3Cld9Zv5woO0HB/X
         SqPEj/jT3wMK0GJwEjCudUG8jIzd7ASogEaceVug0PkdGT2Lanm834Mor6moAGNrkxkT
         X2O9d0L7P/tjLWNWrJqvAlcmTjQ3jkaEvuAWi4M7UuB+HNIRoEXdcQY+9f07mdzQee4L
         UVKY9QkgnUan6oS5CqtBo9o6CGEzU+KdsIi2NsO3KNJ32yozQSNAKHXDvtUYS20mS3uS
         ZdQzA1b1m7b4TTe3GvjN4RBFJHwQa06qxJw0Y9Uq6691AhLoHDApe6RkaHy4FwfAuAW5
         tbeQ==
X-Gm-Message-State: APf1xPDBri/UakEdmDb8MddoWYUvnW9x5IEafv9o8EUX0Ef+yOb/vj0Y
        4q92ki8eWTvoqMGlPG3Xx0HJRA==
X-Google-Smtp-Source: AH8x225LKyXDo+6qZTKa2pICQdRHHVqf/wbuFrlnQMNwqXcn/ZD+e7iWrGTF86yRxp9/DvrDLazJaQ==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1-v6mr3071185plv.256.1519426599234;
        Fri, 23 Feb 2018 14:56:39 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 66sm6845392pfh.96.2018.02.23.14.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 14:56:38 -0800 (PST)
Date:   Fri, 23 Feb 2018 14:56:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 07/35] connect: convert get_remote_heads to use struct
 packet_reader
Message-ID: <20180223225637.GG234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-8-bmwill@google.com>
 <CAGZ79kbnioP+12xa2qfaYLyzdeCH8hh2Ri0xHD7rNciJiTYxmg@mail.gmail.com>
 <20180223213000.GD234838@google.com>
 <CAGZ79kbh0q8=N07yc+gGnLjggco_+H4YiYAiNOXR3yvO6QX6uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbh0q8=N07yc+gGnLjggco_+H4YiYAiNOXR3yvO6QX6uw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Stefan Beller wrote:
> On Fri, Feb 23, 2018 at 1:30 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 02/22, Stefan Beller wrote:
> >> > +static enum protocol_version discover_version(struct packet_reader *reader)
> >> > +{
> >> ...
> >> > +
> >> > +       /* Maybe process capabilities here, at least for v2 */
> >> > +       switch (version) {
> >> > +       case protocol_v1:
> >> > +               /* Read the peeked version line */
> >> > +               packet_reader_read(reader);
> >> > +               break;
> >> > +       case protocol_v0:
> >> > +               break;
> >> > +       case protocol_unknown_version:
> >> > +               die("unknown protocol version: '%s'\n", reader->line);
> >>
> >> The following patches introduce more of the switch(version) cases.
> >> And there it actually is a
> >>     BUG("protocol version unknown? should have been set in discover_version")
> >> but here it is a mere
> >>   die (_("The server uses a different protocol version than we can
> >> speak: %s\n"),
> >>       reader->line);
> >> so I would think here it is reasonable to add _(translation).
> >
> > This should be a BUG as it shouldn't ever be unknown at this point.  And
> > I'll also drop that comment.
> 
> Huh?
> Then I miss-understood the flow of code. When the server announces its
> answer is version 42, but the client cannot handle it, which die call is
> responsible for reporting it to the user?
> (That is technically a BUG on the server side, as we probably never
> asked for v42, so I would not want to print BUG locally at the client?)

This is handled in 
`determine_protocol_version_client(const char *server_response)`,
which is just a few lines out of context here.

-- 
Brandon Williams

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B7991F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeBWVaE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:30:04 -0500
Received: from mail-pl0-f41.google.com ([209.85.160.41]:45570 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeBWVaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:30:03 -0500
Received: by mail-pl0-f41.google.com with SMTP id v9-v6so3606128plp.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i4AQumz3KD39893v0PhYCnBx5d7Aed99X0trukhyrTk=;
        b=h/HEqsmsJibAzaZSi6mCtPib4tPGr9HNtCBzF76kho8Md/1IORYg+bSTxwtL/pmIZs
         A/LppxEn9ynIsAAUcun4TRhWrHAKLlKEQ9xQHu6nw/wtEXwp9dz2pSx8TQgRs2iyGD4L
         IXtsbATMEuz5MWDJg2L10Do/g19C4Y0VfuT3r6LStO3xKbqs9MBo1tqkkTvs2wCMk3Mz
         Taz17FbPdXn1iPNeBMlTOkbdG063/kKG+yNI/gX46/sDL1eHrY6TFcyJ4mYhSuVwfQnu
         p9NW8z8tvTx2VeNamZMgm0joWoFL9MoP9EaMSjoXXOyU6kA/CBWj/zorGhIcV25QXWrt
         IawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4AQumz3KD39893v0PhYCnBx5d7Aed99X0trukhyrTk=;
        b=tFCBasdMyrhuvEWyTvgkuwiEf0RwN7xCa8yN1XFMop9QIUJKnvVLTmr2MELOmOpy59
         uCtYqYwC5sTFhHGNWnZ+megoSVM9I9+9GqrGWsHlgUzLUAJRTEI/ePj3vLhMWnahnc0Z
         SGfMJuWsuDYHc9kHTt8rSfs+cZmpgkDEnMWyf+QY88tT5ZUf320ok3MgimqHWGpSPdco
         Iw6tp1tq5BP+T17ZAAfvhUoMww+5T1KfCMxMIqJ8n1a4kxVabAEiZBmqrTezw6Oo4lgc
         yUNkAQUbIzU/0J/P75AFBfbYbUfptVNdhVXt+0+Pxn+pXpiufk2rCtKWxlWgpCC5qxDO
         n+Jw==
X-Gm-Message-State: APf1xPAcS3zpUzy7A6iLdSzgueSYODgQFs/jASuEgtT6rOigr9KBZBrD
        RDDJJVVBUQhlF7i5VbPVPaCp8w==
X-Google-Smtp-Source: AH8x225emXd1g8whhGchgG3ZXlDFR8oi7Y/RmH+lSn+6rJuVO4J9ah60RG+zfKf6WdLLhwlHd8+khw==
X-Received: by 2002:a17:902:6805:: with SMTP id h5-v6mr2940862plk.46.1519421402827;
        Fri, 23 Feb 2018 13:30:02 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q65sm7130518pfd.140.2018.02.23.13.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:30:01 -0800 (PST)
Date:   Fri, 23 Feb 2018 13:30:00 -0800
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
Message-ID: <20180223213000.GD234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-8-bmwill@google.com>
 <CAGZ79kbnioP+12xa2qfaYLyzdeCH8hh2Ri0xHD7rNciJiTYxmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbnioP+12xa2qfaYLyzdeCH8hh2Ri0xHD7rNciJiTYxmg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Stefan Beller wrote:
> > +static enum protocol_version discover_version(struct packet_reader *reader)
> > +{
> ...
> > +
> > +       /* Maybe process capabilities here, at least for v2 */
> > +       switch (version) {
> > +       case protocol_v1:
> > +               /* Read the peeked version line */
> > +               packet_reader_read(reader);
> > +               break;
> > +       case protocol_v0:
> > +               break;
> > +       case protocol_unknown_version:
> > +               die("unknown protocol version: '%s'\n", reader->line);
> 
> The following patches introduce more of the switch(version) cases.
> And there it actually is a
>     BUG("protocol version unknown? should have been set in discover_version")
> but here it is a mere
>   die (_("The server uses a different protocol version than we can
> speak: %s\n"),
>       reader->line);
> so I would think here it is reasonable to add _(translation).

This should be a BUG as it shouldn't ever be unknown at this point.  And
I'll also drop that comment.

-- 
Brandon Williams

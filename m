Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FA51F428
	for <e@80x24.org>; Fri,  5 Jan 2018 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeAEXlN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 18:41:13 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:40409 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeAEXlL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 18:41:11 -0500
Received: by mail-pg0-f52.google.com with SMTP id q12so2556608pgt.7
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 15:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J6qwbzXy9V/cDsL9OeE+LJ88utMtH6eUcyPr2LyhkaY=;
        b=KDwKg31lG30fX0qKybCnYFtEV9+7PDvfJ6mSOb5AyrUmtDIU/FbTidXxw361A4VgpM
         XZMvM0k4bVOgUSsdONgLn3qsLWWfSAhqb8GNOJVbFvfRn3FqO8/gpAmW6nj4PWzHzqcl
         S6BVZGS/9DQLMLeLbfB0SaVrqcE7A3O3GfeQ609RXMB2fWbWVPJ6ND28D4uH1Zky19aM
         +5C7T//qa3em/0Df/cESS2mLIrs8pTk/GgYc7YcLXEG1iydVvhOQz5TgudL24bKEuEA2
         aIs34eUQht/4ixCv980Oa4Qp+wmScupsmcD0JbbRv3zFKyyTEO+BfEpdEYLIVY9HLCF8
         8IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J6qwbzXy9V/cDsL9OeE+LJ88utMtH6eUcyPr2LyhkaY=;
        b=Lf4k1hFs97Halh1o4LRJfxSc+V7LQfm25pQ3g/5yrU3R3MyjfR8E+SaJ8T7vc50qbK
         6G6thunyzQhwOoT+KHTtg4NiAJ/fVLuhCZXRWojAd0i3eLPN1HE1p0LS58OGHputvvjA
         3af/NeAZ9A3gFptNBx7Q7LKLXU3GiCqd8K1UxQQW2SgDunXldVks8/4JRt0bWiRsgRwV
         i6SWA0pWK3+uksRz0C5rjchJmvWEfa7nn0VwuNm8dZo27CDIdER6vM/dBFfNw5PMpnb7
         EXviMqYJXD7IPpTZspRY6q06/GhQXen0jivDPIO8N8DNU+2ALci3SXCcj8UHNMS4/c3M
         AOYA==
X-Gm-Message-State: AKGB3mJPOKl4wRocQpuqBvPkx3dP3SmKCspLpdrKwQvq6oj4loENW+zk
        TEV+4iTSba0hKOY7dJNhZ+p7Vw==
X-Google-Smtp-Source: ACJfBovad2QtliRs3XFJ4lqDQBX65ErnK8idVit04z7uXDK2Fe0sjbuu9VXKlXxMCBWwyMWCIRTjrg==
X-Received: by 10.98.21.85 with SMTP id 82mr4396961pfv.17.1515195671025;
        Fri, 05 Jan 2018 15:41:11 -0800 (PST)
Received: from google.com ([2620:0:100e:422:b962:214:60b3:c1cf])
        by smtp.gmail.com with ESMTPSA id e87sm15720740pfd.165.2018.01.05.15.41.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Jan 2018 15:41:10 -0800 (PST)
Date:   Fri, 5 Jan 2018 15:41:08 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/26] pkt-line: introduce packet_read_with_status
Message-ID: <20180105234108.GA172942@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-2-bmwill@google.com>
 <CAGZ79kbd1_nnYEJVN8a_NuwrEfHbT0wiwEfdkUz-kZRdpstqHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbd1_nnYEJVN8a_NuwrEfHbT0wiwEfdkUz-kZRdpstqHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Stefan Beller wrote:
> On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> > The current pkt-line API encodes the status of a pkt-line read in the
> > length of the read content.  An error is indicated with '-1', a flush
> > with '0' (which can be confusing since a return value of '0' can also
> > indicate an empty pkt-line), and a positive integer for the length of
> > the read content otherwise.  This doesn't leave much room for allowing
> > the addition of additional special packets in the future.
> >
> > To solve this introduce 'packet_read_with_status()' which reads a packet
> > and returns the status of the read encoded as an 'enum packet_status'
> > type.  This allows for easily identifying between special and normal
> > packets as well as errors.  It also enables easily adding a new special
> > packet in the future.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  pkt-line.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------------
> >  pkt-line.h | 15 +++++++++++++++
> >  2 files changed, 57 insertions(+), 13 deletions(-)
> >
> > diff --git a/pkt-line.c b/pkt-line.c
> > index 2827ca772..8d7cd389f 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -280,28 +280,33 @@ static int packet_length(const char *linelen)
> >         return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
> >  }
> >
> > -int packet_read(int fd, char **src_buf, size_t *src_len,
> > -               char *buffer, unsigned size, int options)
> > +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> > +                                               char *buffer, unsigned size, int *pktlen,
> > +                                               int options)
> >  {
> > -       int len, ret;
> > +       int len;
> >         char linelen[4];
> >
> > -       ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
> > -       if (ret < 0)
> > -               return ret;
> > +       if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
> > +               return PACKET_READ_EOF;
> > +
> >         len = packet_length(linelen);
> >         if (len < 0)
> >                 die("protocol error: bad line length character: %.4s", linelen);
> > -       if (!len) {
> > +
> > +       if (len == 0) {
> >                 packet_trace("0000", 4, 0);
> > -               return 0;
> > +               return PACKET_READ_FLUSH;
> > +       } else if (len >= 1 && len <= 3) {
> > +               die("protocol error: bad line length character: %.4s", linelen);
> 
> I wonder how much libified code we want here already, maybe we could
> have PACKET_READ_ERROR as a return value here instead of die()ing.
> There could also be an option that tells this code to die on error, this reminds
> me of the repository discovery as well as the refs code, both of which have
> this pattern.
> 
> Currently this series is only upgrading commands that use the network
> anyway, so I guess die()ing in an ls-remote or fetch is no big deal,
> but it could
> be interesting to keep going once we have more of the partial clone
> stuff working
> (e.g. remote assisted log/blame would want to gracefully fall back instead of
> die()ing without any useful output, I would think.)

These are all things we could do, but the current code just dies and it
may be more hassle right now to change all the uses of packet_read to
handle errors gracefully.  But its definitely something we can do in the
future.

> 
> >         }
> > +
> >         len -= 4;
> > -       if (len >= size)
> > +       if ((len < 0) || ((unsigned)len >= size))
> >                 die("protocol error: bad line length %d", len);
> > -       ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
> > -       if (ret < 0)
> > -               return ret;
> > +
> > +       if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
> > +               return PACKET_READ_EOF;
> >
> >         if ((options & PACKET_READ_CHOMP_NEWLINE) &&
> >             len && buffer[len-1] == '\n')
> > @@ -309,7 +314,31 @@ int packet_read(int fd, char **src_buf, size_t *src_len,
> >
> >         buffer[len] = 0;
> >         packet_trace(buffer, len, 0);
> > -       return len;
> > +       *pktlen = len;
> > +       return PACKET_READ_NORMAL;
> > +}
> > +
> > +int packet_read(int fd, char **src_buffer, size_t *src_len,
> > +               char *buffer, unsigned size, int options)
> > +{
> > +       enum packet_read_status status;
> > +       int pktlen;
> > +
> > +       status = packet_read_with_status(fd, src_buffer, src_len,
> > +                                        buffer, size, &pktlen,
> > +                                        options);
> > +       switch (status) {
> > +       case PACKET_READ_EOF:
> > +               pktlen = -1;
> > +               break;
> > +       case PACKET_READ_NORMAL:
> > +               break;
> > +       case PACKET_READ_FLUSH:
> > +               pktlen = 0;
> > +               break;
> > +       }
> > +
> > +       return pktlen;
> >  }
> >
> >  static char *packet_read_line_generic(int fd,
> > diff --git a/pkt-line.h b/pkt-line.h
> > index 3dad583e2..06c468927 100644
> > --- a/pkt-line.h
> > +++ b/pkt-line.h
> > @@ -65,6 +65,21 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
> >  int packet_read(int fd, char **src_buffer, size_t *src_len, char
> >                 *buffer, unsigned size, int options);
> >
> > +/*
> > + * Read a packetized line into a buffer like the 'packet_read()' function but
> > + * returns an 'enum packet_read_status' which indicates the status of the read.
> > + * The number of bytes read will be assigined to *pktlen if the status of the
> > + * read was 'PACKET_READ_NORMAL'.
> > + */
> > +enum packet_read_status {
> > +       PACKET_READ_EOF = -1,
> > +       PACKET_READ_NORMAL,
> > +       PACKET_READ_FLUSH,
> > +};
> > +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> > +                                               char *buffer, unsigned size, int *pktlen,
> > +                                               int options);
> > +
> >  /*
> >   * Convenience wrapper for packet_read that is not gentle, and sets the
> >   * CHOMP_NEWLINE option. The return value is NULL for a flush packet,
> > --
> > 2.15.1.620.gb9897f4670-goog
> >

-- 
Brandon Williams

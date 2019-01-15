Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1E71F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfAOTSs (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:18:48 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45252 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfAOTSs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:18:48 -0500
Received: by mail-qk1-f201.google.com with SMTP id j125so3110783qke.12
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4tij/HRuPS3MEm/gKpJOwXTDn4+uOwWRFavwuI1QK1M=;
        b=MCYIjeJx2H484I7T+o4/aeja4sDZDPkFJASAzkjs3ADqfgsxwQ3TFdYRz+6xIrQQIA
         5TdBGkImD8pia9Ro+6CGU7qFpAIpxjjEJpMgWohmSICAFDoOBi8oaMfw+jX/cB5OlRsW
         nW/fKcQxfqlQey/h4Z10hJzs7LsQjpBKqvbvrBepWVdhi9AMYJ8NAptoB2NeV5PY0tc0
         2YK5oCJqpS1ZKCyVnacMbjA8CnCNl5RgCMaEbBwHWcehkxEhCgDe5Du8eZ87+4YglVG3
         jZ2ss4CmCYhVXJcw39SIqUfJujBqlaQz1lfRAj0l0pZQogLdOfbmTcyDXR7rgrEfWBlN
         /lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4tij/HRuPS3MEm/gKpJOwXTDn4+uOwWRFavwuI1QK1M=;
        b=q1gItfkF7r7T5bMcNE2VWQWMkiD1CKo962plQZpEKkmkVYAqFb0wBLkxGw2f3ARIr3
         u+UCNLjgv52bdpsheUSa/aMaZfu7QkrFnkKiEwXvPCtRfXJaG9yjBFYrv4jIEtoY0YZo
         0Kw4YhTA5kVPw0y0Nsv+KCxT9QoX4WZ729sNw3Glov7YZRyyE+bofsE/l1P+ctfKzTfv
         s9hBCSz12vrJnMIYJ3ehquW639pahciGqOUu5caO93bSCTzvR+bUciioUawrIUhPVX/I
         KqyNtwsLzXBZ/B2FDo0/Qh74RCge25Y27ks2OIU1jU5a/Ztg2C1LR4k6grw9CQKEahC3
         DEqg==
X-Gm-Message-State: AJcUukcjWYmj7onfJefJMj5R7rY19IKjWjOK56cCiHzkeYMOZ+4u1NoX
        TAFOOwaqj10cDisolBFEl9BLuqzDi1cv/7OxmtjU
X-Google-Smtp-Source: ALg8bN4M7LnKtAv0JAS9fZsMDf86bQWS6ci6HCgF4JYs3f9rfIHC7R5dTewPitpFeEmVH0FaLV9PcJirniadEF7do3uJ
X-Received: by 2002:a0c:9642:: with SMTP id 2mr2977769qvy.15.1547579926755;
 Tue, 15 Jan 2019 11:18:46 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:18:42 -0800
In-Reply-To: <xmqqk1j6ub7t.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190115191842.123188-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk1j6ub7t.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 3/4] {fetch,upload}-pack: sideband v2 fetch response
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> OK, so the "fetch" side enables sideband-all any time it knows that
> the other side supports it.
> 
> It feels a bit strange at the logical level that reader.me is set
> only when we are going to talk over "sideband-all".  I know that at
> the implementation level, reader.me is only looked at when sideband
> is use, but it still feels somewhat funny.  Future developers may
> want to use reader.me to identify the entity that found some error
> during a read, even when the sideband is not yet in use, and at that
> point, uninitialized .me would be a source of an error.  IOW, that
> assignment smells like a timebomb waiting to go off.

I think the best solution here is to initialize .me to "git", like how
we do it for trace. I've done that for now.

> > +		switch (retval) {
> > +			case SIDEBAND_PROTOCOL_ERROR:
> 
> Dedent (see previous step).

Done.

> > +			case SIDEBAND_PRIMARY:
> > +				if (reader->pktlen != 1)
> > +					goto nonprogress;
> > +				/*
> > +				 * Since pktlen is 1, this is a keepalive
> > +				 * packet. Wait for the next one.
> > +				 */
> 
> What guarantees that a normal payload packet is never of length==1?

This is indeed assuming that we currently don't send 0004 (the
equivalent of 0005\1 without the sideband). I chose this because it is
currently what we use in create_pack_file() in upload-pack.c, but I'm OK
with alternatives (e.g. if we use 0005\2 instead).

> > +				break;
> > +			default: /* SIDEBAND_PROGRESS */
> > +				;
> > +		}
> > +	}
> >  
> > +nonprogress:
> 
> It is totally unclear why this label is called nonprogress.  Is it
> that the primary purpose of the while loop above is to spin and eat
> the keep-alive packets from the other side?  If so, then it sort-of
> makes sense (i.e. "we are looking for progress-meter related
> packets, but now we found something else, so let's leave the loop").
> 
> It would have greatly helped reviewers to have a comment in front of
> that infinite loop, perhaps like
> 
> 	/*
> 	 * Spin and consume the keep-alive packets
> 	 */

[snip]

Yes, it's meant to spin and consume the progress and keepalive packets.
I've added a comment at the top of the loop and renamed the jump label
to "nonprogress_received".

> >  	if (reader->status == PACKET_READ_NORMAL)
> > -		reader->line = reader->buffer;
> > +		reader->line = reader->use_sideband ?
> > +			reader->buffer + 1 : reader->buffer;
> 
> Is the one byte the sideband designator?

Yes. Added comment to clarify that.

> >  void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
> > @@ -521,7 +548,8 @@ void packet_writer_write(struct packet_writer *writer, const char *fmt, ...)
> >  	va_list args;
> >  
> >  	va_start(args, fmt);
> > -	packet_write_fmt_1(writer->dest_fd, 0, "", fmt, args);
> > +	packet_write_fmt_1(writer->dest_fd, 0,
> > +			   writer->use_sideband ? "\1" : "", fmt, args);
> >  	va_end(args);
> >  }
> 
> As I am superstitious, I'd prefer to see octal literals to be fully
> spelled out as 3-digit sequence, i.e. "\001".  Likewise for "\003".

Done.

> > @@ -530,7 +558,8 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...)
> >  	va_list args;
> >  
> >  	va_start(args, fmt);
> > -	packet_write_fmt_1(writer->dest_fd, 0, "ERR ", fmt, args);
> > +	packet_write_fmt_1(writer->dest_fd, 0,
> > +			   writer->use_sideband ? "\3" : "ERR ", fmt, args);
> 
> OK, band#3 is an error message for emergency exit.  It is a bit
> curious that this patch does not show any line from the existing
> code in the context that reacts to the ERR string, but that is
> because the errors are noticed at a lot lower level when the
> sideband is in use than the code that currently checks for errors?

Yes - the branch that this patch set is on (ms/packet-err-check) handles
this. I have taken care in this patch to ensure that the error message
printed matches what Masaya used, so that in a future patch, when we
force sideband-all (using GIT_TEST_SIDEBAND_ALL), the same message is
printed so that the existing tests still pass.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A2401F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 16:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeGFQp3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 12:45:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933402AbeGFQp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 12:45:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so4798305wrt.11
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=elVoVFM3/nnwpZLbF7nMW9o13MNi2FWxIRuBlxeRLiE=;
        b=fdaA0bRFv3E4vXH4qDMjclSvahmrmeoA3//i6LyNgmFwMkjW7K7cC444r0oQshKOYo
         smQW9TiWHHyax79ikkQQNxRGFYYAZ5vBowXheroEREFcvm01EdLAYKJz24DvKsyIzJZg
         TaTLgVVVHugp0SAxYyKeHcJ7L/pMJVe0LnJjwlujK9SvIDPspYj/2CFrLoz5cRA6WBTr
         C8+DO9CpWYEJBqn+ZanRuujK+huvodXzcE0Dnwz7Fc3jdPrt2fk0Uw6Xz25sQ+uQmpv7
         Ig+stzqx4S3dAjkkXlJQ/+T2GidIU95ELuaoYWaPjzIECAgB+kMCfUb/5n9H/2xg02c7
         /ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=elVoVFM3/nnwpZLbF7nMW9o13MNi2FWxIRuBlxeRLiE=;
        b=RW/GOXytb6GH8vwdbiYfYPCcSks0ZdMOxJXX2iyEIWUvSjs7No9Pu/tqecajfavxgX
         FgCN/kwf367qVy0wd/Y7jZ6Ff2Exo5Nud/DV0Oo9n+p9WGO7sS/w/ITG86e/DH9d0MIc
         I7IAyMsaIGToUVbKMIyA74UEEzK8NCOJ24JnxI6qTAXghOYRcWy4vwrnmkhpRTaIEaxL
         TSzPOf8nwB8kpD0NC44/yWp/4KW3s8Lgy0SXR9bNvWQR4gRZcjy+ZMLdrNfjbw1rxtcS
         2bn/j61fLG5yWKdCv6GzJSwaVvp5sJ28ktTXUNWn8xhB8XyArlVLckgpijDtXLLCVzms
         M7nw==
X-Gm-Message-State: APt69E1e3v0WLE3SLninBExDyAnnNGIJaxiOxYrOWgo5R4CoB5ikx4OA
        v4KLWy6gJcEimnliy9L9iiMAWIfR
X-Google-Smtp-Source: AAOMgpeBJEMy49EMEPKNoujFHxLIZ/TMtK7nYi+wjRgSscCm1KYELX210KskT6OkhTqOxfIU47jI1A==
X-Received: by 2002:adf:f64c:: with SMTP id x12-v6mr7627090wrp.97.1530895526904;
        Fri, 06 Jul 2018 09:45:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j18-v6sm6259931wmh.15.2018.07.06.09.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 09:45:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fast-import: Don't count delta attempts against an empty buffer
References: <20180630214106.19848-1-mh@glandium.org>
        <xmqqmuv8qhzt.fsf@gitster-ct.c.googlers.com>
        <20180703215920.wjzhhp5yn3mt6rqw@glandium.org>
Date:   Fri, 06 Jul 2018 09:45:25 -0700
In-Reply-To: <20180703215920.wjzhhp5yn3mt6rqw@glandium.org> (Mike Hommey's
        message of "Wed, 4 Jul 2018 06:59:20 +0900")
Message-ID: <xmqqlgaomhy2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> On Tue, Jul 03, 2018 at 11:41:42AM -0700, Junio C Hamano wrote:
>> Mike Hommey <mh@glandium.org> writes:
>> 
>> > When the reference buffer is empty, diff_delta returns NULL without
>> > really attempting anything, yet fast-import counts that as a delta
>> > attempt.
>> 
>> But that is an attempt nevertheless, no?  Attempted and failed to
>> find anything useful, that is.  What problem are you trying to solve
>> and what issue are you trying to address, exactly?
>> 
>> ... goes and reads the patch ...
>> 
>> > Signed-off-by: Mike Hommey <mh@glandium.org>
>> > ---
>> >  fast-import.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/fast-import.c b/fast-import.c
>> > index 4d55910ab9..12195d54d7 100644
>> > --- a/fast-import.c
>> > +++ b/fast-import.c
>> > @@ -1076,7 +1076,7 @@ static int store_object(
>> >  		return 1;
>> >  	}
>> >  
>> > -	if (last && last->data.buf && last->depth < max_depth
>> > +	if (last && last->data.len && last->data.buf && last->depth < max_depth
>> >  		&& dat->len > the_hash_algo->rawsz) {
>> >  
>> >  		delta_count_attempts_by_type[type]++;
>> 
>> This is a misleading patch as the title and the proposed log message
>> both talk about "attempts are counted but we didn't actually do
>> anything", implying that the only problem is that the counter is not
>> aligned with reality.  The fact that the post-context we see here
>> only shows the "counting" part does not help us, either.
>> 
>> But the next line in the post-context is actually code that does
>> something important, which is ...
>> 
>> 		delta = diff_delta(last->data.buf, last->data.len,
>> 			dat->buf, dat->len,
>> 			&deltalen, dat->len - the_hash_algo->rawsz);
>> 	} else
>> 		delta = NULL;
>> 
>> 
>> ... and makes the reader realize that the change itself is much
>> better than the patch with 3-line context, the title, and the
>> proposed log message advertises it as ;-)
>> 
>> How about selling it this way instead?
>> 
>> 	fast-import: do not call diff_delta() with empty buffer
>> 
>> 	We know diff_delta() returns NULL, saying "no good delta
>> 	exists for it", when fed an empty data.  Check the length of
>> 	the data in the caller to avoid such a call.  
>> 
>> 	This incidentally reduces the number of attempted deltification
>> 	we see in the final statistics.
>> 
>> or something like that?
>
> Fair enough. Do you want me to send a v2 with this description?

For a single-patch topic like this one, if you like what was in the
e-mail verbatim, saying so is sufficient, as I can just use the
material to run "git commit --amend".  For anything more involved
(e.g. "oh, then insert a code to do this before that function"
and/or a fix to an earlier patch in a multi-patch series), I'd
prefer a re-submission, which can be processed just the same way as
any other new topic.

Thanks.



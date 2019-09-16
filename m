Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428901F463
	for <e@80x24.org>; Mon, 16 Sep 2019 18:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfIPSUh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 14:20:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33169 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIPSUh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 14:20:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so480261pgn.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyD7XU6Lr8XwWjSVQQ3xq2+nMYNge7LYxolOttanwVs=;
        b=IPEQ/HOg7dJ9xeBdCLYwAJnbR/fYMCl7yiJ7lIKn4YhEE6ad7evYGlNjv4gYqnel1w
         NGXWSsMjgPS/far+c+DH6IFynwJoiF1Rd+sI1AhNkB7jfCAPmNQoer94h3n3Eai90ICC
         AopDu+dfTZ416/0jSD8tvqU5I4Bf5gdMzFGVv6S59N/nhYNIuyvkQY7SARcYtTC0GzYm
         QHd9an/Z/vsUxYzHpEd8PA5P3PikwptQVkvS6xBjEjHSJxo3Q6wI6XtT8kPGgMo+0KDg
         lWFPL9itwdDZ3OiyYMaa+IgriyGhWUBEfv9v7UafG/7EEjmrgsB/zOXly46l14xXNJzt
         V/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zyD7XU6Lr8XwWjSVQQ3xq2+nMYNge7LYxolOttanwVs=;
        b=tAa+YhkeJ+oJPcyzQBoZpWjWJy44jykoGNGOgz3NvtSjI6BWR9JZo6KGX2Cm5Zm2K4
         CBLTrigeY3+zpHX51vwa8ThdkpmDEee32GbNeMJRzLnomILTTfR37x+BC6p1gyac0OAO
         BOMdlZaJYA3ilDol6BEhl1ohC2eo/LaOBQwYJ71digjta8w+mEaaVSI1kCSFUgGII3Gn
         yogUMneQZXqn00tzg0liIwQyJGf03r8H2IkzkTTOtEVYNil10SVHDFlPcdGM6A1r1TIL
         iB5Y4dfw0Zjcn7GL3eJs3Pjn1oVUQr0OUEkK/fPoAexHvhP/scVae853DTiNAHfZKhJS
         phVg==
X-Gm-Message-State: APjAAAW39o0hSSELTQjscLzSxCoB6FBWodxl0mIRBQ+LgKSBJOJitdk5
        G9P02ouQnXyN7kcR8QNEKiS/XIfBDRsJUw==
X-Google-Smtp-Source: APXvYqxgqbrathyBTQhW3j7SG8wqloTLJ4iaxRlxJN6wIs1YvYhcyPLv3ikdejn1qJPbWYc5Thdp4w==
X-Received: by 2002:a62:8142:: with SMTP id t63mr685993pfd.246.1568658035905;
        Mon, 16 Sep 2019 11:20:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id w11sm51502665pfd.116.2019.09.16.11.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 11:20:34 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:20:30 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [RFC PATCH v3 3/3] trace2: write overload message to sentinel
 files
Message-ID: <20190916182030.GB11295@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        szeder.dev@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
 <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
 <2bb4edc6-f35c-e1e2-7957-17fd994707a0@gmail.com>
 <4aa3022d-743b-2ff6-8a8b-9cd9dc8692a2@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aa3022d-743b-2ff6-8a8b-9cd9dc8692a2@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.09.16 10:11, Jeff Hostetler wrote:
> 
> 
> On 9/16/2019 8:07 AM, Derrick Stolee wrote:
> > On 9/13/2019 8:26 PM, Josh Steadmon wrote:
> > > Add a new "overload" event type for trace2 event destinations. Write
> > > this event into the sentinel file created by the trace2.maxFiles
> > > feature. Bump up the event format version since we've added a new event
> > > type.
> > > 
> > > Writing this message into the sentinel file is useful for tracking how
> > > often the overload protection feature is triggered in practice.
> > 
> > Putting meaningful data into the sentinel file is valuable. It's
> > important to know a bit about when and why this happened. A user
> > would be able to inspect the modified time, and the directory info
> > you include is unnecessary. The data you include is only for the
> > log aggregator to keep valuable data around overloads.
> > > +`"overload"`::
> > > +	This event is created in a sentinel file if we are overloading a target
> > > +	trace directory (see the trace2.maxFiles config option).
> > > ++
> > > +------------
> > > +{
> > > +	"event":"overload",
> > > +	...
> > > +	"dir":"/trace/target/dir/", # The configured trace2 target directory
> > > +	"evt":"2",		    # EVENT format version
> > > +}
> > That said, do we really need to resort to a new event format and
> > event type? Could we instead use the "data" event with a key
> > "overload" and put the target dir in the value?
> > 
> > Thanks,
> > -Stolee
> > 
> 
> If I understand the code here, the overload event/message is
> only written to the sentinel file -- it is not written to a
> regular trace2 log file, so regular log file consumers will
> never see this event, right?

Well, I guess it's hard to define what is a "regular log file consumer".
In our case, our collection system will treat sentinel files like any
other trace file, so it's useful to have it match the expected trace
format.

At least for our use, we don't want the sentinel files treated
specially, because we want the log collection system to just do its
thing and remove the file after processing, which lets Git know that
it's ok to start writing traces again.

> That message could be in any format, right?  And you could write
> as much or as little data into the sentinel file as you want.

To me it seems that it would be less surprising on the users' side if
any data written to the sentinel file matches the format of the
requested traces. If I have an automated process that's reading JSON
from a directory full of files, I don't want to have to add a special
case where one file might have perf-format data (or vice versa).

> There's no compelling reason to extend the existing trace2 format
> to have a new message type, so I'm not seeing a reason to add the
> event-type nor to increment the version number.
> 
> The existing trace2 formats and messages/event-types are defined
> and driven by the Trace2 API calls presented to upper layers
> (consumers of the public trace2_*() functions and macros defined
> in trace2.h).  This overload event doesn't fit that model.

Yeah, I did feel like this might be overkill. Do you think Stolee's
suggestion to use a "data" event instead would be acceptable?

> I think it'd be better to just directly write() a message -- in
> plain-text or JSON or whatever -- in tr2_create_sentinel() and
> not try to piggy-back on the existing format machinery in the
> tr2_tgt_*.c files.

I had a version that did this originally, but I don't really like having
an unexpected special case where we just write a static JSON string. It
feels like an ugly corner case, and would be surprising to users, IMO.
But if everyone thinks this is a better approach, I suppose I could just
add a switch statement in tr2_create_sentinel() that looks at the
sysenv_var field of the tr2_dst.

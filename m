Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A16205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939127AbdAKR7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 12:59:45 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:36145 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939125AbdAKR7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 12:59:43 -0500
Received: by mail-it0-f52.google.com with SMTP id c7so68052734itd.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 09:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yBCmLPc6uhihe/t8lXIibZHl3gw9kRsWiWHL5+INOvQ=;
        b=Uca3V2HtfvqSN5gRoqsqj/bxz6Sr6DO72fTqZSunKhE13zbOqqHLdCV/S5RIZAp5eP
         bf3XsYgnhFMnKzGJL8l7r/vtPPM5Mj7JgxvqWN0Mn3W0cUC+xDr4OwOENO8JJ2psy+/1
         NiJa6XlIZICXenttjKEwaCDBANvtAiBqGYyLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yBCmLPc6uhihe/t8lXIibZHl3gw9kRsWiWHL5+INOvQ=;
        b=m/GE1BYtIELRYzOkEA1ShOWPMlJpBOnxeWqYPeD1jCnNKi8YUy0CoVD47YR151KIjp
         o0GjDLSI3X2FigfJaDL5TC4W3IUli4ZE6jgbfwTGBjmS7Oq/UTbZyp4MsJC87EF3fDk7
         9WxEt6nP5t9tlhKPdqtLvWh//GGH6cFDgjXkHCSagZtl6CLU2qL5cWIOwobirI91EylF
         MqntDDWo7uGru5npppSJ1y0Oe6rT3O3LdiLy055VSu2BDAcBSBpH529T0XKz7N4cSlc4
         GKlBjlsL7D7x2W4B+9RZIleWtlpLBLeYQqRxy1xWfM3WlDuw2CkqFgPW2mv1P1I4nmbe
         acTw==
X-Gm-Message-State: AIkVDXLTvWPLIYnUmbY8gQ8cySvUfXGaSFmZkGHagsFnVRUrnlZX1LAJ2aLD9q6W0m70C9n3
X-Received: by 10.36.80.145 with SMTP id m139mr6540320itb.24.1484157577904;
        Wed, 11 Jan 2017 09:59:37 -0800 (PST)
Received: from localhost ([206.168.224.82])
        by smtp.gmail.com with ESMTPSA id e5sm3385275ioj.43.2017.01.11.09.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 09:59:37 -0800 (PST)
Date:   Wed, 11 Jan 2017 10:59:36 -0700
From:   Taylor Blau <ttaylorr@github.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        e@80x24.org, jnareb@gmail.com
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170111175936.GA2713@Ida>
References: <20170108191736.47359-1-larsxschneider@gmail.com>
 <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
 <20170109233816.GA70151@Ida>
 <F533857D-9B51-44C1-8889-AA0542AD8250@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F533857D-9B51-44C1-8889-AA0542AD8250@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 11:13:00AM +0100, Lars Schneider wrote:
>
> In v1 I implemented a) with the busy-loop problem in mind.
>
> My thinking was this:
>
> If the filter sees at least one filter request twice then the filter knows that
> Git has already requested all files that require filtering. At that point the
> filter could just block the "delayed" answer to the latest filter request until
> at least one of the previously delayed requests can be fulfilled. Then the filter
> answers "delay" to Git until Git requests the blob that can be fulfilled. This
> process cycles until all requests can be fulfilled. Wouldn't that work?
>
> I think a "done" message by the filter is not easy. Right now the protocol works
> in a mode were Git always asks and the filter always answers. I believe changing
> the filter to be able to initiate a "done" message would complicated the protocol.
>
> > Additionally, the protocol should specify a sentinel "no more entries" value
> > that could be sent from Git to the filter to signal that there are no more files
> > to checkout. Some filters may implement mechanisms for converting files that
> > require a signal to know when all files have been sent. Specifically, Git LFS
> > (https://git-lfs.github.com) batches files to be transferred together, and needs
> > to know when all files have been announced to truncate and send the last batch,
> > if it is not yet full. I'm sure other filter implementations use a similar
> > mechanism and would benefit from this as well.
>
> I agree. I think the filter already has this info implicitly as explained above
> but an explicit message would be better!

This works, but forces some undesirable constraints:

- The filter has to keep track of all items in the checkout to determine how
  many times Git has asked about them. This is probably fine, though annoying.
  Cases where this is not fine is when there are _many_ items in the checkout
  forcing filter implementations to keep track of large sets of data.
- The protocol is now _must_ ask for the status of checkout items in a
  particular order. If the assumption is that "Git has sent me all items in the
  checkout by the point I see Git ask for the status of an item more than once",
  then Git _cannot_ ask for the status of a delayed item while there are still
  more items to checkout. This could be OK, so long as the protocol commits to
  it and documents this behavior.

What are your thoughts?

--
Thanks,
Taylor Blau

ttaylorr@github.com

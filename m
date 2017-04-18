Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF57201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755200AbdDRRmN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:42:13 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:32943 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbdDRRmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:42:11 -0400
Received: by mail-oi0-f46.google.com with SMTP id b187so135996oif.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqCvz8wkPQjk3WR+zYianR3iLYUCzEt5DHSliwSomFE=;
        b=dhgBq9MDJ/oETwD+6vUumGpe3s8Da+Pxaed2ahMHrLsWkSPNDTU3vjOo9AyjA9gGzx
         YANhWw3G8HVUGZC916h9vtcX6Iy255Jg6Y8whxmgM1JTyHF8HXtX5k6kqUVjO/jGiaRb
         9ItG+1N42Y5rRGwJV2geQCOBD4zi/pwqgGWJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqCvz8wkPQjk3WR+zYianR3iLYUCzEt5DHSliwSomFE=;
        b=pau3AKCa4Zw/ySK7bZfEKfUsXBFRuuNH5m3ILqEBvYSKDAKtjlhNltP73Hhugtrk5q
         SZfVvHNO+aWzuWfj9pZ1lOcDZw5bwqe1MDFcGvWVKgxJP8vnBC6G/eH+lewULsDGnrx4
         C5WZDOw8V3kGiRdyb9pHmlG6ATXg1/EeGLvNrR44g+RiXywctelvK7CpQMGbmsOX9HJp
         UASlH0IM8Evz0EYd6JVcjzrKdIAqanFBqNqPGcdH4Cc37EF61qfeEpd0jwJONIyfs099
         J+FLbds4jE8RHufrkow7ycwJKB3h+8CPLYwWptEIumD6PC9ybcm+68Ph+/OzsJIO4BAW
         NXDA==
X-Gm-Message-State: AN3rC/5BQS8Ms2Hs2xzdNr6i7b7IcFdwc/hLUoPuZQDshSxgQ95eqRmn
        B140nr3bXg04SKTj
X-Received: by 10.157.68.193 with SMTP id p1mr9347819otg.15.1492537330984;
        Tue, 18 Apr 2017 10:42:10 -0700 (PDT)
Received: from localhost ([206.168.224.82])
        by smtp.gmail.com with ESMTPSA id k20sm348474oih.29.2017.04.18.10.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 10:42:10 -0700 (PDT)
Date:   Tue, 18 Apr 2017 11:42:09 -0600
From:   Taylor Blau <ttaylorr@github.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tboegi@web.de, e@80x24.org
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170418174209.GA92973@Ida>
References: <20170409191107.20547-1-larsxschneider@gmail.com>
 <20170409191107.20547-5-larsxschneider@gmail.com>
 <20170412174610.GB49694@Ida>
 <1D510C6F-A830-48BE-880B-62F4212F4A7F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1D510C6F-A830-48BE-880B-62F4212F4A7F@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 06:14:36PM +0200, Lars Schneider wrote:
> > Both Git and the filter are going to have to keep these paths in memory
> > somewhere, be that in-process, or on disk. That being said, I can see potential
> > troubles with a large number of long paths that exceed the memory available to
> > Git or the filter when stored in a hashmap/set.
> >
> > On Git's side, I think trading that for some CPU time might make sense. If Git
> > were to SHA1 each path and store that in a hashmap, it would consume more CPU
> > time, but less memory to store each path. Git and the filter could then exchange
> > path names, and Git would simply SHA1 the pathname each time it needed to refer
> > back to memory associated with that entry in a hashmap.
>
> I would be surprised if this would be necessary. If we filter delay 50,000
> files (= a lot!) with a path length of 1000 characters (= very long!) then we
> would use 50MB plus some hashmap data structures. Modern machines should have
> enough RAM I would think...

I agree, and thanks for correcting my thinking here. I ran a simple command to
get the longest path names in a large repository, as:

  $ find . -type f | awk '{ print length($1) }' | sort -r -n | uniq -c

And found a few files close to the 200 character mark as the longest pathnames
in the repository. I think 50k files at 1k bytes per pathname is quite enough
head-room :-).


--
Thanks,
Taylor Blau

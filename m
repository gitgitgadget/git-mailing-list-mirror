Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB13E1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934996AbeF0SGB (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:06:01 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41737 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934784AbeF0SGA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:06:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so1415463ply.8
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtPPo3vNGAUVEIJ+RqDPnN1p7B9/9LWBGq5qs5SL3YA=;
        b=oVaqIvXsesrF/M0uibOsoZHgKmhH7n3yuFm5JSPzeDXyKfeKL4OeXfZx9sxlirjecs
         stWBzLuY7dyE3tutVygCyHxddedngPZeMS/vAfQUgPUaHZCHxuY7/kGgUPIa1k8IHQME
         JEtHQ9BM12n9vUW64XaqozCxOkL8ZlypTbOE+b2E2uA0HX6POkoeuRE9kw3qLtAwbutp
         Ovu5Ms5IPONtcCrdlzsT+3YHVi8UtOiyp1BhKXImLK08th66hnepnAu6TxtOgWn3iNyy
         AA6T87iLtB8ISJqx2OvendbpdW0TgbVW8YNLzOwtp1NVcuyI7SgWlXOwwSeNR6kZ+zIX
         h/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtPPo3vNGAUVEIJ+RqDPnN1p7B9/9LWBGq5qs5SL3YA=;
        b=Bc97j62BOnwW3bgD8Km/IfTtoOk7fF6jbzw7LV8+OD13+dNgDtI65MC3vrtrmh+GAK
         cdhehduVhRY3ZysK/XFiKmxO+vMEJ9dBkHZy6njlI+Ui8LFyDn+nGybqINsuBLgNUXdg
         2pu6VIzQloj5g/9I95a5Tdrwe5yxI5kAi0iEvPrQhmTxi+1+Y2jGlERmnVQ3FRgc6zeI
         weJBA/KXUUpnhtspwItIK6A/1PnvNM2cCUlzW5C/pw9yfnYPzxt3ABNeKBW+ObZoBs/V
         9NFA6b2LnNMfIXScSoPCpMY3KNg7kC/YlJ4zx8V6auXcHqGSmTG8RgZbFWJrI5hAsxR0
         Hc7Q==
X-Gm-Message-State: APt69E3/M2OI3dkL/K8PhbxHlLavO0m1KTpxuRS/gwz++LMRqjrUI1uy
        b0UQZ9qCzy0X/oSYfQJUvoJrrw==
X-Google-Smtp-Source: ADUXVKKIsynMs2bnNxCyCaBHkNvNRUQZDkCTD+l5XaISCIvQB2b9eED51F0swkYXZKeIMEkTLsMDxg==
X-Received: by 2002:a17:902:b418:: with SMTP id x24-v6mr7204729plr.2.1530122759885;
        Wed, 27 Jun 2018 11:05:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p20-v6sm7238314pfn.181.2018.06.27.11.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:05:58 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:05:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 2/8] upload-pack: implement ref-in-want
Message-ID: <20180627180557.GG19910@google.com>
References: <20180625185332.164142-1-bmwill@google.com>
 <20180626205438.110764-1-bmwill@google.com>
 <20180626205438.110764-3-bmwill@google.com>
 <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/26, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +    wanted-refs section
> > +	* This section is only included if the client has requested a
> > +	  ref using a 'want-ref' line and if a packfile section is also
> > +	  included in the response.
> > +
> > +	* Always begins with the section header "wanted-refs".
> > +
> > +	* The server will send a ref listing ("<oid> <refname>") for
> > +	  each reference requested using 'want-ref' lines.
> > +
> > +	* The server SHOULD NOT send any refs which were not requested
> > +	  using 'want-ref' lines and a client MUST ignore refs which
> > +	  weren't requested.
> 
> Just being curious, but the above feels the other way around.  Why
> are we being more lenient to writers of broken server than writers
> of broken clients?  The number of installations they need to take
> back and replace is certainly lower for the former, which means
> that, if exchanges of unsoliclited refs are unwanted, clients should
> notice and barf (or warn) if the server misbehaves, and the server
> should be forbidden from sending unsolicited refs, no?

Ok so should I change the server part to "MUST NOT" and the client part
to "SHOULD"?  And I can add code to die when we see refs that weren't
requested, but i feel like if we add an ability to request a pattern in
the future this will completely change, which is why I currently have a
client just ignoring anything else.

> 
> 
> > diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> > new file mode 100755
> > index 000000000..0ef182970
> > --- /dev/null
> > +++ b/t/t5703-upload-pack-ref-in-want.sh
> > @@ -0,0 +1,153 @@
> > +#!/bin/sh
> > +
> > +test_description='upload-pack ref-in-want'
> > +
> > +. ./test-lib.sh
> > +
> > +get_actual_refs() {
> 
> Style.  "get_actual_refs () {"
> 
> > +	sed -n '/wanted-refs/,/0001/p' <out | sed '1d;$d' | test-pkt-line unpack >actual_refs
> 
> Unnecessary piping of sed output into another sed invocation?
> 
> 	sed -n -e '/wanted-refs/,/0001/{
> 		/wanted-refs/d
> 		/0001/d
> 		p
> 	}'
> 
> or something like that?

Yeah thanks for the help with sed :)

-- 
Brandon Williams

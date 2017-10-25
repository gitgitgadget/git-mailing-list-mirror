Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F6B203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 18:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbdJYS6Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 14:58:16 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:56560 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbdJYS6P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 14:58:15 -0400
Received: by mail-pg0-f42.google.com with SMTP id m18so683847pgd.13
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ShEI1ZafVHfjzJbX11lstfS/mUQj4kHfclFQGdGia70=;
        b=i94p446zq2/C0IREmWK5rCvc4gdIR/XQCzhE6FeaUxfChMEXLb3lTC1ah9WGpCb9i1
         +2esS/zNp+e7SLhwcNNe1CiRC62d3RaJ+L37TSCsAshSbWjBP6DNVFYVm6qKSX99lRzl
         qkxapV+YGzz/g5BDwibdg/NKw59xnFFpUuax5NtALnJaysloUL9Tmq+Gfojh7sVYtFiD
         UKN7W3+guSuF/Vp8+RuSBAggzJ9IRbMa8ycwcStOCk36qgEP+kVHijY2Y++U2eYt5I83
         rrvtpuQFAMvGcs5VyyngKzRUVwePuDojyUPChuAyCbEIXVrAq0aWjW6DnN7mLZRXb8Tu
         NWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShEI1ZafVHfjzJbX11lstfS/mUQj4kHfclFQGdGia70=;
        b=YUsarB0+yjtr+N6tyLenTEgN8DjjNVgjOWHTiKqMrPH6Fst96KXV0i4Z/ld4esyVVR
         yMwZkrEzXLFzrb6pApska63FUzbUtNwyYMqACN7zS+qkF25AMF79RwduFNVBI10nDgBP
         ex2vDtl0Bx015VC6a5Mc2GjN3btRGFDAjdKvcITs82UlClcjYprJqteUvNC+ZiDW9SCb
         3Bgemoz7TvXVSn8yKuHyf2ZgYZHLdPDFVQpD1cn0IUVYRmeoboTX9hXAHTuXBceGmnTd
         CNZv8HhspU9nje0q/5EnFwgoCIhum8L7psJMf/hGdUQmjxGPzaZCQCIDpUjw648g1oxe
         cf+w==
X-Gm-Message-State: AMCzsaXWcQ3DB6jDfFscuJ3/Rsk8V7A0DIr/qglmVLY25hPf9u4G6Zfd
        pjqjmKLdrralxcBIXJeg6lxkOw==
X-Google-Smtp-Source: ABhQp+Tr2f9vLU/6VAOZhRldH1tDDIIIhEUxX7mJFA9bXUG39ZSC63mpgLeliGvgTnGmk/30QbsJYA==
X-Received: by 10.84.216.75 with SMTP id f11mr2503731plj.275.1508957894835;
        Wed, 25 Oct 2017 11:58:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c01f:5e59:5832:ba3a])
        by smtp.gmail.com with ESMTPSA id b68sm6466084pfg.171.2017.10.25.11.58.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 11:58:13 -0700 (PDT)
Date:   Wed, 25 Oct 2017 11:58:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, bturner@atlassian.com,
        git@jeffhostetler.com, git@vger.kernel.org,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        wyan@google.com
Subject: Re: [WIP PATCH] diff: add option to ignore whitespaces for move
 detection only
Message-ID: <20171025185812.GB18778@google.com>
References: <CAGZ79kYwARXNWRS4AgwTP7peZiWiwCBvWFiEr9TbpbWjgysfZA@mail.gmail.com>
 <20171024000931.14814-1-sbeller@google.com>
 <20171024184809.GC79163@google.com>
 <xmqqshe8j9we.fsf@gitster.mtv.corp.google.com>
 <xmqqo9owj9uz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9owj9uz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Brandon Williams <bmwill@google.com> writes:
> >
> >> One simple idea would be to convert the single 'flag' into various bit
> >> fields themselves, that way if you need to add a new flag you would just
> >> make a new bit field.  I'm unaware of any downsides of doing so (though
> >> i may be missing something) but doing so would probably cause a bit of
> >> code churn.
> >
> > The reason why people want to have their own bit in the flags word
> > is because they want to use DIFF_OPT_{SET,CLR,TST,TOUCHED} but they
> > do not want to do the work to extend them beyond a single word.  
> >
> > I think it is doable by making everything a 1-bit wide bitfield
> > without affecting existing users.
> 
> ... but the "touched" thing may be harder---I haven't thought it
> through.

From what I can tell the 'touched' thing is implemented as a parallel
flag field so we would just need to have each flag use 2-bits, one
for the flag itself and one for the 'touched' field.  Then when using
those macros it would just need to update the corresponding 'touched'
field as well as what ever happens with the flag itself.  It may be a
little more involved than the current scheme but it should be doable if
we need to extend the flag space past 32 bits.

-- 
Brandon Williams

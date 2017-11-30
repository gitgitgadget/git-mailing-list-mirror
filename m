Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D0420C11
	for <e@80x24.org>; Thu, 30 Nov 2017 20:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdK3UDv (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 15:03:51 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35111 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdK3UDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 15:03:50 -0500
Received: by mail-it0-f68.google.com with SMTP id f143so9893332itb.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E97bjBI2P0yTIuWf0wJ07sztNuzc3roYFjkoB0flwg4=;
        b=JOyT2hC1ny5A7QB54bKolci3upZvJLekW0RzKwa76m/klpECKLRlGkz2+ZzH0ROGId
         gLCe0WyebGytBCjHBXK6e6gtO29Iv/Do6OAtUFhXVtI4ZsJsbzQBtpQLBlD2EgoQ+Y72
         z3KokRVO1hOseIHCqdql8gfOGWfrFsg32opG/vVL0zzRZgr5e04hdywkpwA5VvweZ1BI
         +flhptKlTBJwchDqkcf7l/2KQdhAbwc9xWX1aoneFVjOFlo7AlgOWdPY++mXxRNrJXVT
         uLzX+Qh3W+TzBxzLisJ+ZToio1OWCt8NVq+8jQJR1SSBEeYCQYfequcUSaADPg8i7t/4
         n+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E97bjBI2P0yTIuWf0wJ07sztNuzc3roYFjkoB0flwg4=;
        b=Zj5t9vx3VKH7akcpd0qdzDIqggrMDSVyzrADvWmRoKx+hT4xrb5wvsetQw5WEUEKnG
         gsJFPL9L6OquBpgahFP4J4b9kf1iXIy+wnv5OWL/mv6LegM4Jk53J7SVPMHTq3vDBapf
         0QKe/53AynjhaSpUkXfbmw+RGSUVK8c85duSWBX6NvYIykoyr1Hj3L+0DyyDdmzk5BQs
         va7/izUOUcPQLf62N66mklQJCqOhpPDHI+n3lCJc3Pxg/Xt8/256kGHNAUodXlRUMJnN
         qh6DUj9+q12LZqiC/+xgDzxmV8OExow9gS+Fi0rGgsjQNiwhsg5vWDXzgbKk0Q2m3onA
         auiQ==
X-Gm-Message-State: AJaThX7wTrrvEX8/MjWw/6E/dobGMWR3HbMOuqEeffXn3cnGmCgIftEi
        Tu3ZWofhXfnalEHsC32mCVo=
X-Google-Smtp-Source: AGs4zMYv33UwGOLVaqtY8XIX7MqG+AwbpjKUjKkej7c2fhSuezDz+ocrlY4jU6e0m9vkSt9lLQuQOQ==
X-Received: by 10.36.55.136 with SMTP id r130mr4671745itr.3.1512072229859;
        Thu, 30 Nov 2017 12:03:49 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 128sm2577174ite.4.2017.11.30.12.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 12:03:48 -0800 (PST)
Date:   Thu, 30 Nov 2017 12:03:41 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Vitaly Arbuzov <vit@uber.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Konstantin Khomoutov <kostix@bswap.ru>,
        git-users@googlegroups.com, jonathantanmy@google.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: How hard would it be to implement sparse fetching/pulling?
Message-ID: <20171130200341.GA20640@aiede.mtv.corp.google.com>
References: <CANxXvsMbpBOSRKaAi8iVUikfxtQp=kofZ60N0pHXs+R+q1k3_Q@mail.gmail.com>
 <e2d5470b-9252-07b4-f3cf-57076d103a17@jeffhostetler.com>
 <CANxXvsNWgYda_unSWoiEnfZnEuX8ktkAD-d_ynVtsTbkOKqeCg@mail.gmail.com>
 <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANxXvsO0xk3K8Wx9pmX1qST1=43BkrKWOcCZjJ8vVcBFYVRB0A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vitaly,

Vitaly Arbuzov wrote:

> Found some details here: https://github.com/jeffhostetler/git/pull/3
>
> Looking at commits I see that you've done a lot of work already,
> including packing, filtering, fetching, cloning etc.
> What are some areas that aren't complete yet? Do you need any help
> with implementation?

That's a great question!  I've filed https://crbug.com/git/2 to track
this project.  Feel free to star it to get updates there, or to add
updates of your own.

As described at https://crbug.com/git/2#c1, currently there are three
patch series for which review would be very welcome.  Building on top
of them is welcome as well.  Please make sure to coordinate with
jeffhost@microsoft.com and jonathantanmy@google.com (e.g. through the
bug tracker or email).

One piece of missing functionality that looks intereseting to me: that
series batches fetches of the missing blobs involved in a "git
checkout" command:

 https://public-inbox.org/git/20171121211528.21891-14-git@jeffhostetler.com/

But if doesn't batch fetches of the missing blobs involved in a "git
diff <commit> <commit>" command.  That might be a good place to get
your hands dirty. :)

Thanks,
Jonathan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D4D2098A
	for <e@80x24.org>; Tue, 11 Oct 2016 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754154AbcJKSt7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:49:59 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35232 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbcJKStz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:49:55 -0400
Received: by mail-pf0-f176.google.com with SMTP id s8so6194890pfj.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KW8QQEh/FJOSFcw5EDivgpDXbrJPR02FRhypn0QjRl4=;
        b=AeRepg4RKyiH2H8LObBTmgeZSJJWV1li2ofRp66/aEf0JvviFPNJAysulxqo+fuvzg
         w1cRnbGyuWWAM56aNf/xldI2M7WC/Xg1dyVKT9o88OWevh0S4kE5RQcjiZfhj9J08Dia
         5dw5t35IslUDJO+9FsFq8RGgnOmH/rEfeWfc4XP7G9VzJHUcGghI2Dzn9XfxC3TGwbFw
         mopLB7sNnyfsowc0CDuwFtHy3bsmPqO4g78zi4VW73ma5nanGIpj04DS89Ww69PP5l/L
         L4DBix9o2Z6zUUVNajottEQ4qS8npgcHZvzOjtbXNqf6tYuLl8vM9D5dE3qd3FBypiyf
         9OBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KW8QQEh/FJOSFcw5EDivgpDXbrJPR02FRhypn0QjRl4=;
        b=Xxs8Pe4NGeRNmMjoBf51GCT6FJe1Yx7lxOipqXCY0o973lMbzVXvaDOevPKZvpD5p+
         2wkq2RGVsFpnuP4693WCeuVKrCbftrN/W6gyV9qLgJHq6iFQlRETcb9z/bnKMiX6fiJZ
         oPn/lhoQ+JT5B7k69U22ONOVLhEG6jOvHYIURd1BGAmEeMKjesw/8Jy2OTi5/8j7adkt
         9/egXneJCxaCTVDzp+E3uDLsJfEl5Zd/r5FcCrFXUU2iVIXnByEAV97C3DYsOiWL6tbL
         H/wkCbqHsWUQModg/Tk3ZGzQ546cWcWfiQXvPRX49y2MhOG8S2MjnGvSufXh0yUt3Y8z
         shMg==
X-Gm-Message-State: AA6/9RkBNMdlSZxHipXgEKX+dtuT282dhKGJJKkVhwEFkgHs29ZLR48Z5YMkY7PTklNC7m6/
X-Received: by 10.99.124.24 with SMTP id x24mr3179321pgc.64.1476211785629;
        Tue, 11 Oct 2016 11:49:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:19ef:1eb0:a061:def1])
        by smtp.gmail.com with ESMTPSA id t29sm5990315pfj.95.2016.10.11.11.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 11:49:44 -0700 (PDT)
Date:   Tue, 11 Oct 2016 11:49:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 17/28] attr: expose validity check for attribute names
Message-ID: <20161011184943.GB16014@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
 <20161011002115.23312-18-sbeller@google.com>
 <20161011172805.GB9085@google.com>
 <CAGZ79kbqikTtUGxXFB3W9k1nL6ST2iwRRi5zEuL9BOpHxZWc8A@mail.gmail.com>
 <20161011184010.GA16014@google.com>
 <CAGZ79kaM_5MGwPPAhQKWgCGirbHvioBY7_PtkKxza8qV6ZyRnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaM_5MGwPPAhQKWgCGirbHvioBY7_PtkKxza8qV6ZyRnw@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11, Stefan Beller wrote:
> On Tue, Oct 11, 2016 at 11:40 AM, Brandon Williams <bmwill@google.com> wrote:
> 
> > Wouldn't a +1 indicate that the attr name is valid while the 0
> > indicates that it is invalid?
> 
> Right.
> 
> >  It looks to me like we are checking each
> > character and if we run into one that doesn't work then we have an error
> > and return 0 indicating that the attr name we are checking is invalid,
> > otherwise the name is valid and we would want to return a +1 indicating
> > a success.
> >
> > Am I understanding the intent of this function properly?
> >
> 
> I will change it to +1; I was just rambling about when you may
> expect -1 in this project. :)

Ah got it :D

-- 
Brandon Williams

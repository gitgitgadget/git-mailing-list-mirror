X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Thu, 20 Nov 2014 15:26:28 -0800
Message-ID: <20141120232628.GA30554@google.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
 <xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
 <xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
 <xmqqd28ly6p1.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3m9aouYKXfk-vE4AGbTxdyH6=k8ey5n-kF1OLux2Ah0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 20 Nov 2014 23:26:44 +0000 (UTC)
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kKppxVxc9MrwarpmfyhTthN9f7iBOG6Ay3EnLz4EIgQ=;
        b=VdMEKDNK5bnX1I5RjcFqYgykXInseJx7xcVPgfokQz0KIxaQT667GDa6K5jDF2wxQN
         Ky4EuhyERAhyw1taJl6IgggkkMR1z2XpcEbvCD2o56ioDjvBYUuuoDAW+C8mUXBWTgJi
         wpWimRphsRWm4kcNtm4YfMM+CRjHmi5XpTQBUQC2lV1VfCBfbkik4b/5MysnVyRS7rJV
         RAREgWYe4RJ7E42Lg5He+3F/E81j9kFrEPQVLvaAsJ18ZJrwyNwWLoF6FrHX7XMbbZvJ
         fQ3TmUEEwRZsAFnXbz/DCpCBN0PN7ebw9Pz2OWgjmRElYUFTYMVBebNxBTpUXUVvByU/
         Wmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kKppxVxc9MrwarpmfyhTthN9f7iBOG6Ay3EnLz4EIgQ=;
        b=ipBX/hgdI78GBN+K7zjZ6JerXxWgYjz8pwIb3fWMI0RadEiH9aJVAho0ScyEhqvRGK
         BqeV1+HsMBdmKqXnbHjYtK9OsqA3waWgTlFqg5fxRrg4k9soKb3zc5QtGXQFPjW6HxzG
         ybd8dITODa1DYMFYmMjbhOpRVjCpiSjI6uo9fyXYAklVB3G3hK93d1QnYcpHeM4IW6u8
         n2bmxuqHVznUfgSKU3qN2GwA42z9Z6t4XWqH8JjSJqBaiD6nZJcPsMOX2FZt9KX2vMHV
         D/5oaQ0+dsfsO5pjOVWyjFCqEm6FvUEuLNud5qRpJBmzmMfcxGo+wuCmbpO0JW88aJvd
         tpLg==
X-Gm-Message-State: ALoCoQmu+xxp6LX0+crBBiEPF0dOMIuhJyS3sIVx1ZMi3cjzaPfQRt0238anxnVDITGfJ1aiRNeu
X-Received: by 10.43.104.66 with SMTP id dl2mr11779638icc.9.1416525989779;
        Thu, 20 Nov 2014 15:26:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAP8UFD3m9aouYKXfk-vE4AGbTxdyH6=k8ey5n-kF1OLux2Ah0g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1Xrb7T-0006db-4y for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 00:26:35
 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757484AbaKTX0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014
 18:26:31 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:50238 "EHLO
 mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1756935AbaKTX0a (ORCPT <rfc822;git@vger.kernel.org>); Thu, 20 Nov
 2014 18:26:30 -0500
Received: by mail-oi0-f74.google.com with SMTP id e131so528887oig.3 for
 <git@vger.kernel.org>; Thu, 20 Nov 2014 15:26:29 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104]) by
 gmr-mx.google.com with ESMTPS id kb8si920645qcb.1.2014.11.20.15.26.29 for
 <multiple recipients> (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
 bits=128/128); Thu, 20 Nov 2014 15:26:29 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125]) by
 corpmail-nozzle1-1.hot.corp.google.com with ESMTP id oTSYBdYV.1; Thu, 20 Nov
 2014 15:26:29 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346) id
 89CA51411F5; Thu, 20 Nov 2014 15:26:28 -0800 (PST)
Sender: git-owner@vger.kernel.org

On Tue, Nov 18, 2014 at 07:40:07AM +0100, Christian Couder wrote:
> On Mon, Nov 17, 2014 at 8:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> (I am not saying that there should be an easy way to drop cruft left
> >> by third-party systems such as "Change-id:" line) ...
> >
> > Heh, that was "should not be", but I guess it was probably obvious.
> >
> > Sorry for the noise.
> 
> I am not sure it is very easy yet but as Change-id: ... line are
> trailers, you can do that with git interpret-trailers.
> 
> For example:
> 
> $ echo -e "\nChange-id: stuff\nOther: thing"  | git -c
> trailer.Change-id.ifexists=replace interpret-trailers --trim-empty
> --trailer Change-id=
> >
> > Other: thing
> 
> The idea is that the above command replaces an existing "Change-id:
> stuff" trailer with an empty "Change-id:" trailer and then removes all
> the empty trailers.
> 

So I have read the man page on the trailers and it seems like the solution
to my problem in removing parts from the commit message.
However I did not find out, if it can be run automatically, whenever
calling format-patch

Maybe all that is missing here is an option

	git config format.enable_trailers 
?

Best,
Stefan

> Best,

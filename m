From: Andreas Ericsson <ae@op5.se>
Subject: Re: [rfh] do I need to use something more complex to do this?
Date: Wed, 10 Apr 2013 17:23:21 +0200
Message-ID: <516583E9.9030200@op5.se>
References: <7vk3oao3e5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 17:23:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPws2-0006j1-0r
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 17:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936776Ab3DJPX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 11:23:27 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:51707 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935896Ab3DJPX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 11:23:26 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so661241lbi.0
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 08:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Fy6IgoCWnN38KPKpOHK9/dbKGcOoCtPb6IfkRYpdh5g=;
        b=be/z7wvQvSkVI9fUsbYBbr75sPvnEs0E10AM2cfZnxkf4wjrYpAMTdv+FnxkjO7cPF
         3WvyAhcqlYx+9y34V7gn6pPs4os/c/VTV7RH8EsSBKwKp8ql9nqAz4hVP72V4xWqu+gs
         AaUxmkgLOjyjl3k1geFhEBasg/bqUjWxwiN41jnuUf8BQgjD350o0tJGhnWFvjSrr6Hi
         XrENRgMtOUd9XaAMopY2dzUQBcoqnIKJPVsPTWAkPmySKA3lSBiKn0Usn3JC1p5PqQhx
         7U/xwVK9x0SXEnyIfL87ENij1YloeEysiH7pbVjlh8EGaQpobAuoHuBnGDSWIXjPDe0e
         F+JQ==
X-Received: by 10.152.133.67 with SMTP id pa3mr1244193lab.44.1365607404588;
        Wed, 10 Apr 2013 08:23:24 -0700 (PDT)
Received: from [192.168.1.170] (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id w6sm135469lad.5.2013.04.10.08.23.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 08:23:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vk3oao3e5.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkWSLuxsfIAR847ypJFahc0Q25XJHWgXP4+gjp1KRuDsQj+vriiATdMaYeDPbPUdLFvTqJP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220695>

On 04/10/2013 04:40 PM, Junio C Hamano wrote:
> I have set of items with two attributes, <X,Y>, and would like to
> keep them in some data structure in such a way that it is efficient
> to (1) add a new item to the data structure, and (2) pick an item in
> a specific order. There can be multiple items that share the same
> value for X, or Y, or both X and Y, and it does not matter in what
> order items comes out among those that share the same <X,Y>.
>
> The type of X is totally ordered. The type of Y also usually is, but
> Y can take a special value U(nspecified).
>
> Now on to the "specific" order I want to pick an item.  I'd like to
> take the item with the largest value of Y in general, and tiebreaking
> on the value of X which also I prefer to take from larger to smaller.
>
> But with a twist.
>
> When I am picking an item <X=n,Y=m>, there should be no item
> remaining in the data store with a value of Y that is smaller than m
> (duplicates are allowed, so there can still be items with Y=m), and
> also when I am picking <X=n,Y=m>, there should be no item with
> Y=Unspecified that has a value of X that is equal or smaller than n.
>

So X is primary sort and Y is secondary, except Y=Undefined trumps all
other values for Y, but never trumps X as primary sort.

Can't you just have U be the largest unsigned integer value of the
type you choose? For this particular application, I doubt there's any
risk of the defined numbers catching up with it.

I might have missed something though. This seems a bit too trivial for
you to ask for help.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

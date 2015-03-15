From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Sun, 15 Mar 2015 15:21:17 -0700
Message-ID: <471A97CA-0004-48F7-B6C9-50266EE370D4@gmail.com>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c> <xmqqa8zevhya.fsf@gitster.dls.corp.google.com> <xmqq3856vhtt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 23:21:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXGuU-0000pr-Sz
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 23:21:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbbCOWVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 18:21:22 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34287 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbCOWVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 18:21:21 -0400
Received: by pdbni2 with SMTP id ni2so39521771pdb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=w6v/vEwcZPF6/ETJeBFIIlPQ9rqhGwr3QbqdYFWr1Es=;
        b=wpWeftqueSZbiuq7rnqkqdKgX0Y6XVR6RddCuyeCZIwcWjCo+hOcEIMeFekuTnX6Rn
         Ho0wD684nk57tI41BbSwQ9GBwlfLmMfqrvYKcQfF1AwUCWHLWhOU6bRD59gr24VlV6vP
         Td6J6Et40PhYBhV5PvY3zq0Z+90/5dDl2Ui5fKiinBA1DzAwShqO3fm3ONqKSrh5byQm
         yRnNHpsy80qj7kEOkAsuZYQljlcGu5Ll1TBwxbMTo7q4hhfBCSYEM0NO2H1v/Kz2BNZc
         fSBt891E2IBzjTpVqz+IViHvhgSUXawY8MJxab8bf9m1joaaNZp0kkpAQuZMFOTAtBbe
         sgjA==
X-Received: by 10.67.7.102 with SMTP id db6mr130002288pad.14.1426458080903;
        Sun, 15 Mar 2015 15:21:20 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id o17sm13846830pdj.26.2015.03.15.15.21.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Mar 2015 15:21:20 -0700 (PDT)
In-Reply-To: <xmqq3856vhtt.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265530>

On Mar 15, 2015, at 00:30, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>> Hi guys,
>>>
>>> So I was looking at fetch-pack.c (from master @ 52cae643, but I  
>>> think
>>> it's the same everywhere):
>>>
>> ...
>>> -		hashcpy(ref->new_sha1, local);
>>> +		hashcpy(ref->new_sha1, o->sha1);
>>> 		if (!args->verbose)
>>> 			continue;
>>> 		fprintf(stderr,
>>> 			"already have %s (%s)\n", sha1_to_hex(remote),
>>> 			ref->name);
>>> 	}
>>> 	return retval;
>>> ---
>
> One thing I wonder is if this hashcpy() is doing anything useful,
> though.  Is ref->new_sha1 used after we are done in this codepath,
> or is the reason nobody noticed it is because it does not matter
> whatever garbage is in that field nobody looks at it?

My thoughts exactly. hence the "please confirm" request.  I'm not  
familiar enough with the fetch pack code to know the answer off the  
top of my head.  I was hoping someone else who's been in the fetch  
pack code recently (*Hi Peff*) might just already know.  :)

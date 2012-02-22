From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] Do attempt pretty print in ASCII-incompatible encodings
Date: Wed, 22 Feb 2012 09:17:58 +0700
Message-ID: <CACsJy8AJBzZnkKSVYRuwO2T1XEWp+N1HEfiir0oWPpo0vron-A@mail.gmail.com>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
 <1329834292-2511-2-git-send-email-pclouds@gmail.com> <20120221182118.GA32668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:18:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01ms-0001Tn-R3
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab2BVCSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 21:18:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52128 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2BVCS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 21:18:29 -0500
Received: by wgbdt10 with SMTP id dt10so6231101wgb.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 18:18:28 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.92.227 as permitted sender) client-ip=10.180.92.227;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.92.227 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.92.227])
        by 10.180.92.227 with SMTP id cp3mr30946666wib.13.1329877108298 (num_hops = 1);
        Tue, 21 Feb 2012 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8DV8GqGi+8Dc8+en/N1yTtsGnAM/UoSVN0p/IRR1/n4=;
        b=E/qe0pnBiegqul7nO+788DkTaiSBnsbNH2EBjM1LLLSE7rNIie3XmLILRKB67o/cGh
         UiFLg8MYUukoxL9U/BCGg00qqc15fYqIf+DOPItDxAX7uCrps6Vct/Jo7DcueqFUxvit
         h51C8A/KZq3C84wlNXVGNzTOSbxCI1s6qXjR0=
Received: by 10.180.92.227 with SMTP id cp3mr25708250wib.13.1329877108226;
 Tue, 21 Feb 2012 18:18:28 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 18:17:58 -0800 (PST)
In-Reply-To: <20120221182118.GA32668@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191222>

2012/2/22 Jeff King <peff@peff.net>:
> On Tue, Feb 21, 2012 at 09:24:50PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> We rely on ASCII everywhere. We print "\n" directly without conversion
>> for example. The end result would be a mix of some encoding and ASCII
>> if they are incompatible. Do not do that.
>>
>> In theory we could convert everything to utf-8 as intermediate medium,
>> process process process, then convert final output to the desired
>> encoding. But that's a lot of work (unless we have a pager-like
>> converter) with little real use. Users can just pipe everything to
>> iconv instead.
>
> I'm not sure why we bother checking this. Using non-ASCII-superset
> encodings is broken, yes, but are people actually doing that? I assume
> that the common one is utf-16, and anybody using it will experience
> severe breakage immediately. So are people actually doing this? Are
> there actually encodings that will cause subtle breakage that we want to
> catch?

I did :-) once actually. But that's a good point, using unsuitable
encoding leads to garbage output, but no subtle breakage there. It'd
be nice to say "your encoding is not supported" than throw garbage,
but again probably no one did it but me, and I don't feel like doing
it again.
-- 
Duy

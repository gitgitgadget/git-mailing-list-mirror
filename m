From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Relative ls-files
Date: Thu, 24 Mar 2011 20:26:45 +0700
Message-ID: <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net> <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net> <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org> <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
 <7v39mdhni3.fsf@alter.siamese.dyndns.org> <AANLkTin=y=THaQEzgMhyBVLBriJBCa-pVvONXDnzUmew@mail.gmail.com>
 <7vaaglcv9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 14:27:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2kZT-0001Jv-7S
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 14:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab1CXN1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 09:27:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41550 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab1CXN1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 09:27:19 -0400
Received: by wya21 with SMTP id 21so8769678wya.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=e3yURHTYbncDRMWs23k+ezKQHoGCUyDZ/i2s/6yj0WI=;
        b=VP+EHbicJFVFunh67R5McxmM+BhVJlwjpRkLqAmbUyoGRqxn5Ldn/5TZe8GRg7xi5o
         1lYgwFRMIu0gNxtjcPrgLZU8gK1UCDZsrFcz5pqDiAo5fxc0sl8Z9pJlT40yaYl7qd0y
         pv+Uyo7MERtldSiFXPqEM48/5zyd89SRFDV50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uSkTl6Ztk2hmbvhNULfK1it4kdKO03iraY4csVH7StR2caX8RCcnyr/GtEwD7cjL4v
         UjNDOQXxsWrrN1PeLEwFtEJBCClNBPeXqWPh0z7+M7eWQH98cbervNUMSoSoSBCn1Wtl
         xFAEFCwgNg6dsbkoL0VQBaQDDMtwQLAwIdMvM=
Received: by 10.216.157.68 with SMTP id n46mr760085wek.111.1300973237958; Thu,
 24 Mar 2011 06:27:17 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Thu, 24 Mar 2011 06:26:45 -0700 (PDT)
In-Reply-To: <7vaaglcv9f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169915>

On Thu, Mar 24, 2011 at 5:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Wouldn't it be more sensible to add a bit ("is this a glob or are we
> expected to match it literally") to each element in the pathspec array,
> and pass a pathspec whose elements are all marked as "literal" down from
> ls-tree?
>
> The internal matcher (and traversal optimizer) would need to become aware
> of "not a glob" match (and possibly different kinds of matches like "**/"
> support) sooner or later, and when that happens you would need something
> like the above on the caller side in ls-tree.

I think it's possible even now. fnmatch() is only used if
pathspec_item.has_wildcard is true. So ls-tree.c only needs to clear
this field for all pathspecs and they will be treated literally. Let
me try..
-- 
Duy

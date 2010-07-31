From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Sat, 31 Jul 2010 13:28:01 +1000
Message-ID: <AANLkTi=n-LYGiYw=g4QsO=9GtvzHc8Vn=m99pcDR5r00@mail.gmail.com>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
	<20100730013534.GB2182@burratino>
	<AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
	<20100730195022.GB2448@burratino>
	<20100731010439.GB5817@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of2kA-0004g9-NW
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0GaD2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 23:28:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54657 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab0GaD2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 23:28:04 -0400
Received: by wwj40 with SMTP id 40so2201575wwj.1
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Hvq19ZTfwGxy9aS23M1wTPslalvGuuttyXfriSwbYzA=;
        b=gax1F9eld0lqaLDebDn/UkVQLtm50KPMBg9JMDmVbIlQblFntr9iViHVOLDoUUhi0L
         QoT2kFANAYPMS6+IGS4fHCFU+K0wUBeCjuGf9Dj2+QDsREUzXeM0uQ/DrE0RzfOQYQ6c
         BvEUihZThOcMmQ48e9KGsSi/jeKm1M8GNGOQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=npCmz4kRY5rRyM7fjqbFehgxzhmCTfcN0yp/48wkjDQBAQjHJwYphkIfrK/qKSqBBu
         WQda6PDrAuqr4SgqmBRtcFYz1S5A/UFBT3/LJmw+7HyL/HYSGdBzOlHnAA19FbHyj7fF
         aUjoxXORycPGCjto4igPd6ssrb+VT031bW3YM=
Received: by 10.216.0.85 with SMTP id 63mr352593wea.29.1280546881282; Fri, 30 
	Jul 2010 20:28:01 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 30 Jul 2010 20:28:01 -0700 (PDT)
In-Reply-To: <20100731010439.GB5817@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152295>

On Sat, Jul 31, 2010 at 11:04 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Nieder wrote:
>
>> What happens if an index entry is removed at the same time as the
>> checkout is narrowed?
>
> Hm, maybe something like this would help.

Or maybe we should move the CE_UPDATE/CE_WT_REMOVE removal code into
apply_sparse_checkout(). That function knows when checkout area is
narrowed and CE_WT_REMOVE should not be removed in that case,
regardless CE_REMOVE|CE_WT_REMOVE combination.
-- 
Duy

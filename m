From: "James Pickens" <jepicken@gmail.com>
Subject: Re: [RFC PATCH 0/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 14:42:21 -0700
Message-ID: <885649360812181342u2978038fj3a11670acd9fd873@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
	 <494ABDC9.9060001@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Thu Dec 18 22:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQej-00030E-IJ
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYLRVmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYLRVmX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:42:23 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:19121 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbYLRVmW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:42:22 -0500
Received: by wa-out-1112.google.com with SMTP id v27so328262wah.21
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 13:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rI5UeiNwVc3rlDXzgDGnOEBeF3Neg/TJH+6LCCaXwQ0=;
        b=HZKZ3PNtRhddBl8jg8wqOXglm8lntvsMi0365/fSpzd7/+jsVqgYkhLwCfHGi+aTf5
         MgxwWntBY4sniHLYesI36Q0ByrZvPT7viPluA86gJp6an0dPIN6YYm8kF/pHqKFEZGWj
         Qtk+B2VX+OEqROixE2Sa2yveL6Dqif7BuwJCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hDni26gTftBvDS8a8/GtQw9SsfebwzIeaIlDMt2v+gH7CK4RzAx0yBXRH8E6ZT4+/l
         y8aktv23k/i9LlCdgJo4JSsMUta+HRsEZkur6Yh4S2GqujZ4e9YJFCPolE1ZK0auYu2c
         qaEfB0lxmEWeH999pfgHfRvL6ITPuuuybvx6g=
Received: by 10.114.197.1 with SMTP id u1mr1414537waf.120.1229636541288;
        Thu, 18 Dec 2008 13:42:21 -0800 (PST)
Received: by 10.114.80.15 with HTTP; Thu, 18 Dec 2008 13:42:21 -0800 (PST)
In-Reply-To: <494ABDC9.9060001@morey-chaisemartin.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103498>

On Thu, Dec 18, 2008 at 2:16 PM, Nicolas Morey-Chaisemartin
<devel@morey-chaisemartin.com> wrote:
> I guess you could do something like :
>
> #define checkout_lock()         core_threaded_checkout ?pthread_mutex_lock(&checkout_mutex) : (void) 0
> #define checkout_unlock()               core_threaded_checkout ?pthread_mutex_unlock(&checkout_mutex) : (void) 0
>
> It should be faster when you don't actually use threaded checkouts, as you won't unnecessarily lock/unlock your mutex.
>
> Have you looked at the perf from local to local? I'm just curious.


I had looked at it before but didn't record any numbers.  I just took the
following timings (2 runs each):

master             13.78    12.79
threads enabled    16.84    20.45
threads disabled   14.07    13.27

James

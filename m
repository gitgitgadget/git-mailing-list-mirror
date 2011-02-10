From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] compat: helper for detecting unsigned overflow
Date: Thu, 10 Feb 2011 05:23:25 -0800
Message-ID: <E84FF9D8-92D7-4CA0-9CF4-77FF33893977@gmail.com>
References: <1286263450-5372-1-git-send-email-kusmabite@gmail.com> <20110210093536.GB365@elie> <AANLkTinqkSxj0C+GyMVR4a7d=yy_mh+oDuar0moZjZ8_@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 14:23:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnWUi-00086l-EE
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 14:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1BJNXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 08:23:31 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52144 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab1BJNXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 08:23:30 -0500
Received: by iwn9 with SMTP id 9so1289361iwn.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=nVvdDa2N1AA069jAnZNbELZ75p2MDWngSx4KF/47VmA=;
        b=c3hkgk+qWz469EP0wQUT0K7XQtJuz9mSQ1B+VWmnZNiR1YKaJfBAiYbn2meJVGvrGY
         RSZhDdl0AVXZ4q/amLo4NnpUQzSlTcAsbNZt9aLid2c/jMcHlKsdbUU+mTlyD5X7kyqp
         SR33bs6kiXm8CAwikK6DcJAt08X8kRIuqyEgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=S1AzPh7o7AfQKwPMjvzgf3+NT1BoEDbyJY6SMsGd0yh4rjpviA3xgRFBIsC+oCfES/
         0tUcC8pVB+zQVW9rOU2HWsGEMiI9iO+SWHF56FZ0e/99waW18VPEl4YEl9RFBQ3NS0GW
         Jf7SoLgEqDW+iDnUJ++xB16OIea3VbvMn4FTg=
Received: by 10.42.222.71 with SMTP id if7mr11551817icb.50.1297344209556;
        Thu, 10 Feb 2011 05:23:29 -0800 (PST)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id y8sm5177ica.2.2011.02.10.05.23.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 05:23:28 -0800 (PST)
In-Reply-To: <AANLkTinqkSxj0C+GyMVR4a7d=yy_mh+oDuar0moZjZ8_@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166481>

On Feb 10, 2011, at 4:11 AM, Sverre Rabbelier wrote:

> On Thu, Feb 10, 2011 at 10:35, Jonathan Nieder <jrnieder@gmail.com>  
> wrote:
>>       unsigned_add_overflows(a, b)
>
>> Define such a macro, expanding roughly to ((a) < UINT_MAX - (b)).
>> Because the expansion uses each argument only once outside of  
>> sizeof()
>> expressions, it is safe to use with arguments that have side effects.
>
>> +#define unsigned_add_overflows(a, b) \
>> +    ((b) > maximum_unsigned_value_of_type(a) - (a))
>
> I'm confused, you say you won't use it twice, and then you do use it  
> twice?

The author is asserting that maximum_unsigned_value_of_type() is a  
function of sizeof a, which would have no runtime effect.

Josh

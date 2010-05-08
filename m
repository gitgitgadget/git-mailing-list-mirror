From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH] pretty: initialize new cmt_fmt_map to 0
Date: Sat, 08 May 2010 23:04:54 +0100
Message-ID: <1273356294.12996.5.camel@walleee>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
	 <1272798044-10487-4-git-send-email-wmpalmer@gmail.com>
	 <20100508210739.GA6486@progeny.tock>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 00:05:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAs8w-0003nB-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 00:05:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab0EHWFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 18:05:00 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58777 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0EHWE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 18:04:59 -0400
Received: by wyf19 with SMTP id 19so78802wyf.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=O4c+r2KBBRFfxnKzuS+c0vcY44X0O/XXzNFEz9zVMrA=;
        b=j6JR0228W0BcU7TmP445XsJ/69VPL/WxiMkj+bc/HFQTG9Fzm16X3uzjOlkEtSzEBd
         qJQh795v9XbX2Lo9ReW5ET59UN7z0/rpRd174yREYikcYM+yHH+85DZjUQ6aCcB/DTic
         N2PzhlqxNRqPXRnDhxQyPibGqHd2IWptbaVgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KzyPzd0Kp4ilUJDV+vo2uxNZez5/DSRUMPXedW8HQuznXS7bxJC/K55jVfH/iFYSwq
         yrVW/VJbkLTC+kojGKVfISLph9IxilhMWPD0FRymhTFZpVDMEuMrI7n0a2h6z0sdYeYZ
         nLjcx0GCIGP55pPfCVYy2Q2p3unhfDMafM3Gs=
Received: by 10.227.146.13 with SMTP id f13mr1760267wbv.179.1273356297336;
        Sat, 08 May 2010 15:04:57 -0700 (PDT)
Received: from [192.168.0.3] (5acc3abb.bb.sky.com [90.204.58.187])
        by mx.google.com with ESMTPS id r29sm27307354wbv.3.2010.05.08.15.04.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 15:04:56 -0700 (PDT)
In-Reply-To: <20100508210739.GA6486@progeny.tock>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146681>

On Sat, 2010-05-08 at 16:07 -0500, Jonathan Nieder wrote:
> Without this change, is_alias is likely to happen to be nonzero,
> resulting in "fatal: invalid --pretty format" when the fake alias
> cannot be resolved.
> 
> Use memset instead of initializing the members one by one to make it
> easier to expand the struct in the future if needed.
> 
> t4205 (log --pretty) does not pass for me without this fix.
> 
> Cc: Will Palmer <wmpalmer@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Sorry I missed this before.  Sane?
> 
> Jonathan

Ah, looks right. I think previous versions of my patch were building in
a local variable (which /was/ initialized), then copied the whole thing
into the newly-allocated space. When this was changed to building
in-place, the initialization was lost. Good catch, thanks.

Not sure if Signed-off-by or Reviewed-by is the appropriate tag to
mention here, but one of those, I assume.
-- 
-- Will

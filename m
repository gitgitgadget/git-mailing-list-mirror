From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 0/5] "best effort" checkout
Date: Thu, 29 May 2008 21:09:44 -0400
Message-ID: <483F53D8.1020201@gmail.com>
References: <1212020246-26480-1-git-send-email-gitster@pobox.com> <483F3B32.9000907@verizon.net> <7vabi8ocju.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 03:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1t8k-0001vV-2M
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 03:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYE3BJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 21:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbYE3BJu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 21:09:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:19123 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbYE3BJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 21:09:49 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2855233wxd.4
        for <git@vger.kernel.org>; Thu, 29 May 2008 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=mILPVJ9CoIGAQw1tT1mxv/ADMRCXNFZ5O3I60q5HhUU=;
        b=Ze2ObDJt7uqLiaTi4IuQhjnvtR4Ef1DXwM0Mpzah7ZfXZEx9GUa0JGBG/IBWqkR5WAOraInEwEXR4AY1VF5rLAnETKVDbPa9Ah7NnA0KxAnFNsGn7jDQ0NdyAefjwWAdrbOWUxnZkjbf4V8jdg2gWinnO4+cRvlqZR+9gwRBxFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Jfetaf4HiSn8pW5sLRQNSAvFckTod380tw9eHIn7RxCUjDZpLObY1EW4i4XJnuQKplcBQX9jUvip6e4jLF56kTPnmYUlxnl91pFkDEK97GSB7SeF24gVgUr3zlZMQiiL8N3UGoz5BpwPgH5qYslIgHKQtBMbRjPWacFsKgrCAS4=
Received: by 10.70.76.2 with SMTP id y2mr5651603wxa.33.1212109788689;
        Thu, 29 May 2008 18:09:48 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.126.133.203])
        by mx.google.com with ESMTPS id i33sm5056099wxd.10.2008.05.29.18.09.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 18:09:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vabi8ocju.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83262>

Junio C Hamano wrote:
> I hope you did not use 6/5.  My understanding is that your platform
> natively supports it without that compatibility layer ;-)
>   
That is a very polite way to express things, and no I did not apply that 
patch.
>
> I expected to see "deleted" here.  I guess lstat("anything/nul") says "it
> exists" everywhere, and that probably is why you are getting EEXIST.
>
>   
Indeed:

git>ls nul
nul
git>ls nul*
ls: cannot access nul*: No such file or directory

So, any test for existence of <path>NUL will pass, but NUL never appears 
in a directory listing. The same is true of the other special filenames 
under Windows (aux, ...).

Mark

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 09:25:36 -0700
Message-ID: <20140428162536.GB13002@google.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:26:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeoNU-0002XX-51
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 18:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbaD1QZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 12:25:47 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40271 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411AbaD1QZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 12:25:39 -0400
Received: by mail-pb0-f45.google.com with SMTP id rq2so1104097pbb.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=82iO3pbQnVmuvE+QTsVPp0EmvluWAQyvEuWxLEf/eRA=;
        b=PXEP3bQ41NtyQ/TLvl71I508BrOGSVDOu06FxCjClQ7HCYQ80qqp5ho9yvv3sT3msO
         zTPtCnqcvhfdo0I1uLucH4AaDVOv6ZnX85j15cNAAhaRyV8gd11mHDxFeyRWRB+DKNzE
         FyLsbMyhhOv2AedZH7LN40GanSyW/mNNbecY/o5I+oqGMSHPHpd05fjvTT4teMq/yAL2
         5nubNcubdO8KuUaAuKzhqy7fPR9TbwA+KZPzqCDF7ucS0LN1Q6HAZ8fjbLmIDk0S0ZG+
         bSju/IaUGJHHHBwhKuoVldDo+0Su8rRU3FAdk+bwB+E4Lxje0fH4GHOkFHal9niCSncp
         yZjg==
X-Received: by 10.66.248.6 with SMTP id yi6mr9635798pac.127.1398702339307;
        Mon, 28 Apr 2014 09:25:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id de5sm35960109pbc.66.2014.04.28.09.25.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 09:25:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247376>

Hi,

Marat Radchenko wrote:

> +# Define CROSS_COMPILE to specify the prefix used for all executables used
> +# during compilation. Only gcc and related bin-utils executables
> +# are prefixed with $(CROSS_COMPILE).

Please include an example.

	# Define CROSS_COMPILE=foo- if your compiler and binary utilities
	# are foo-cc, foo-ar, foo-strip, etc.  More specific variables
	# override this, so if you set CC=gcc CROSS_COMPILE=ia64-linux-gnu-
	# then the compiler will be 'gcc', not 'ia64-linux-gnu-gcc'.

Otherwise unless I happen to know the convention from other packages I
would not know whether to include a trailing '-' in CROSS_COMPILE,
etc.

Does the effect of this setting depend on whether CC=gcc (i.e., is the
Makefile checking the value of CC and ignoring CROSS_COMPILE when it
is e.g. the Intel compiler)?

[...]
> -STRIP ?= strip
> +STRIP = $(CROSS_COMPILE)strip

Before, STRIP from the environment took precedence over STRIP from the
makefile.  Switching to the more usual 'environment can't be trusted'
convention is a good change, but please mention it in the commit
message.

The rest looks good from a quick look.

Thanks,
Jonathan

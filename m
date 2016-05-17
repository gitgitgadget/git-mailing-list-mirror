From: David Turner <dturner@twopensource.com>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Tue, 17 May 2016 01:46:46 -0400
Organization: Twitter
Message-ID: <1463464006.24478.71.camel@twopensource.com>
References: <20160517032247.25092-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue May 17 07:46:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2XqH-00025c-0E
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 07:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbcEQFqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 01:46:49 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35494 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730AbcEQFqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 01:46:48 -0400
Received: by mail-qk0-f175.google.com with SMTP id n62so2618730qkc.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 22:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cSLsv0h6g50r7dUU4cH3l0XtUALr9I4cWH9Jm5jDy6E=;
        b=uly8SGSwy0zaFOe2kkdGNMH/fRl8LCJOptrJ6rAOtZxSmSkmLRLcdqsrQ805H9+nMb
         kkl3CQThW7tTKY42Rg6O0rhfyTeyNrEP5B9tX/mebeGNdnnpor6hOJEy2g8tkUPf6AOw
         +uaej3CXo3HWMuN4FE6t8my6DWGwV8RTT6ZCdGSzrL/87ykCayQmNdY3OvHqObwN7HYV
         +J+9aIPnhwydWm7oihNyTXaoJ3ZODfcuYihqxbqSXEw5D6tfNZZNRU76lVaoqgmqzVtn
         Qh4pzbNLq8NgO06GiDJeaI9UFm5m5keEaIZcmaBsgu4izJQp+HnFi+UwiVw5x5aQyFMI
         W1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cSLsv0h6g50r7dUU4cH3l0XtUALr9I4cWH9Jm5jDy6E=;
        b=bupsMmism+FmZnQ+PbdzbKReRPSBSsbwDDidK8pKBj+su6nHDEmT2xlCSuP56X87wt
         q8SxJtsQoo3/lyhsFcx342k0gntiI5+/curtyrmNBi5qyetce45eyznu8AY8h1V7LJsS
         qIwJZWtkIJNfn3LdkQWTCCtYPVxJvulAXN9yaembwXX1co6t6e4T9mR1HkkDXul76C2s
         FNwC28FsdOIMwLSTqRNJ26jgVnV0SqWKOcmTp3eU+XtLJg2w3zyWLfVQ61Sdy7Ywi1up
         X3wEY9hanT6wkGt2xDvH4VL0FCIh/Y3+xsNj3139sDWwzNhPS3sWZg/lGFIuf4ohgHTE
         Bq/g==
X-Gm-Message-State: AOPr4FWOp6DWDZeOUstT3qPNTS8ncPXQIua+OBOFQ28f9YncIvOhhrUDyZ3Xf07Pdhjn0w==
X-Received: by 10.55.157.204 with SMTP id g195mr35399210qke.68.1463464007601;
        Mon, 16 May 2016 22:46:47 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 39sm510633qgg.8.2016.05.16.22.46.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 May 2016 22:46:46 -0700 (PDT)
In-Reply-To: <20160517032247.25092-1-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294857>

On Mon, 2016-05-16 at 20:22 -0700, Stefan Beller wrote:
> When using automated tools to find memory leaks, it is hard to
> distinguish
> between actual leaks and intentional non-cleanups at the end of the
> program,
> such that the actual leaks hide in the noise.

valgrind on git rev-parse HEAD shows:
==21785==    definitely lost: 153
bytes in 2 blocks
==21785==    indirectly lost: 0 bytes in 0 blocks
==217
85==      possibly lost: 0 bytes in 0 blocks
==21785==    still
reachable: 58,635 bytes in 570 blocks
==21785==         suppressed: 0
bytes in 0 blocks

AFAIK, nothing in the "definitely lost" category is fixed by your rev-parse patch. 

I don't think we care that much about "still reachable" memory -- I only care about lost memory.  I could imagine, I guess, something that happens to save a pointer to a bunch of memory that should be freed, but I don't think that's the common case.

Unless, I guess, you're planning on making a library out of git.  Then it would be worth doing much more cleanup.

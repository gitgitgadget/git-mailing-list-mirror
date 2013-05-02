From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Thu, 2 May 2013 07:51:17 +0400
Message-ID: <909519096.20130502075117@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 02 05:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXka6-0003UO-6I
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 05:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757234Ab3EBDw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 23:52:59 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:63013 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3EBDw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 23:52:58 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so128850lbi.40
        for <git@vger.kernel.org>; Wed, 01 May 2013 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=YNW+DlzXVNWjksHpa3KqE6mVr9KNZuNVUKy4Z6LC/ac=;
        b=k3DkD0ckOgKe6CbePVh/5WdbObi5RAStx8EU524boKCFhNhVjHE6fPP0nBvXw3e2Av
         CBdQZhr0d7XlxrKTXW4iSyW5FK8QQPJ/P8US2Ydamp5kHbnI21SCfXqfyooI7TPC+BF3
         4i5F6b3G5tjxcoESp40v10gHmxl3r7efYoeq2RdjPWH5EY5CS/jUGN6T9tMKJAa5+Thg
         zalvNaqDglzfafBy5AKCDqtgqEmSyb9hHgAfodaOisEICsFl9FjdhFvpvwFaJ8q6Cuwl
         0HmDXqpCYhxfyercxMDannoBu1+KPmMxzHwnxsidg/Un9KsbuAmERuMOdAsr7JpLty1h
         xRfg==
X-Received: by 10.152.87.69 with SMTP id v5mr1847328laz.24.1367466776404;
        Wed, 01 May 2013 20:52:56 -0700 (PDT)
Received: from [192.168.0.78] (92-100-225-116.dynamic.avangarddsl.ru. [92.100.225.116])
        by mx.google.com with ESMTPSA id 6sm2111849lbp.0.2013.05.01.20.52.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 20:52:55 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130501213031.GA13056@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223177>

EW> My personal philosophy has always been: git svn users should leave
EW> no trace or indication they're using a non-standard SVN client.
Placeholders aren't pushed back to svn.

-- 

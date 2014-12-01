From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Mon, 1 Dec 2014 15:35:15 -0800
Message-ID: <20141201233515.GV6527@google.com>
References: <547C8610.8080301@cs.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Christoph Mallon <mallon@cs.uni-saarland.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 00:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvaV9-0005Ch-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 00:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbaLAXfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 18:35:23 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45437 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbaLAXfT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 18:35:19 -0500
Received: by mail-ie0-f172.google.com with SMTP id tr6so10536509ieb.31
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 15:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=P59zML/beaOVUcWHwc9HxzoZKfVAUHDR2b0BHiTHFFY=;
        b=K5w8gCjnbd8v5iL2t0FSxUu9tp394dKKMhlbx8Ob1olw0YCe4TfvOY6UX3V/vJMU2u
         fC0OCAt4T/jTQU1xPJFkBjMrutON/0mbzcxbyvHkKObcDpMdK+14ZHP6shQAGXPE84Gy
         vnjQ2LGJq4WuTXW++UTRlVSQooXS+vm5DHhT9io1k5+lGjWRsZ4FSNxSscc1y72lNk0s
         8n85lsfvOzqzVt6CysiBn7kbCXTeQreqxpzl0q7D/J0WhZ7e0J8JTeNzwS5IcrtrhBrM
         eWqXpwb72XzxTMsrxMEfOBb3iP0zbVgY/7DA2Yo+tNkOFMJD5zFEmI7lebKT3dcmR+QV
         X3VQ==
X-Received: by 10.50.134.101 with SMTP id pj5mr455546igb.28.1417476918548;
        Mon, 01 Dec 2014 15:35:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:adae:4a7e:fb33:5785])
        by mx.google.com with ESMTPSA id h77sm6412159ioe.35.2014.12.01.15.35.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 15:35:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <547C8610.8080301@cs.uni-saarland.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260515>

Hi Christoph,

Christoph Mallon wrote:

> % git rev-parse 'master@{52}'
> warning: Log for ref refs/heads/master has gap after Thu, 1 Jan 1970 00:00:01 +0000.
> 0000000000000000000000000000000000000036

Can you say more?  What output did you expect and how does this differ
from it?

I tried, with git 2.2.0,

	git init gitbug &&
	cd gitbug &&
	git commit --allow-empty -m a &&
	wget http://tron.yamagi.org/zeug/reflog.bad &&
	mv reflog.bad .git/logs/refs/heads/master &&
	sha1sum .git/logs/refs/heads/master &&
	git rev-parse 'master@{52}'

The output:

 9ffe44715d0e542a60916255f144c74e6760ffd0  .git/logs/refs/heads/master
 0000000000000000000000000000000000000035

Could you make a test script that illustrates and reproduces the
problem?  I.e., a patch to a file like t/t1410-reflog.sh, such that
if I run

	cd git
	make
	cd t
	./t1410-reflog.sh

then I can reproduce the bug?

Thanks,
Jonathan

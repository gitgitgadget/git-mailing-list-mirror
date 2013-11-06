From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/2] Rename suffixcmp() to has_suffix() and invert its
 result
Date: Wed, 6 Nov 2013 14:17:35 -0800
Message-ID: <20131106221735.GB10302@google.com>
References: <20131105210237.21525.61810.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeBQ2-0002tb-JK
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab3KFWRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:17:42 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:60918 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685Ab3KFWRl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 17:17:41 -0500
Received: by mail-pd0-f174.google.com with SMTP id z10so141136pdj.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ks+phNItU9f8/Wf9OYDbjB+mJSyX+5ZWZgrLqWinJjc=;
        b=dBYnlAvzT+eyB2a5HWcFfiLUHOn3VvkxnDLkBIM1RnaZoG2bjHyjS0MtHlkUjmuCMg
         FEb2N5dHMd670fM/tyV0FZqCLq/6PMVKxVMJ0jI/QjKQAeB9DCN1kFpddAfKTugOgp+e
         DL/sqM5rOud86vrdSCS+OXhUf0tUPxLIG+gJ14E2o9qbdeDqX42+ixxps13sQwDtBf76
         M6TwzgwlGuKE9xhW9Kk/OBgRnqPUR6jBzuSPyF4cRh4cPak9ZFA940LuhFLmKC9L8Y2e
         wPKpU2EQ4P2VQFCRgb/yuMGHmVezEyPc0XqYqtJhP8cjgRoW0/HI06vUcnMnJi3AmLET
         W/jQ==
X-Received: by 10.68.166.67 with SMTP id ze3mr5453373pbb.173.1383776258456;
        Wed, 06 Nov 2013 14:17:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gg10sm303020pbc.46.2013.11.06.14.17.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Nov 2013 14:17:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131105210237.21525.61810.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237374>

Hi,

Christian Couder wrote:

> Now has_suffix() returns 1 when the suffix is present and 0 otherwise.

Ok.  My only worry is that the function is less discoverable since
its name is so different from prefixcmp(), which might cause someone
to invent yet another postfixcmp.

> The old name followed the pattern anything-cmp(), which suggests
> a general comparison function suitable for e.g. sorting objects.
> But this was not the case for suffixcmp().

It's not clear to me that prefixcmp() is usable for sorting objects,
either.  Shouldn't it get the same treatment?

Except for that concern, the patch looks good.

If some day we invent a type for 4-byte-aligned object names, it might
make sense to do something similar to hashcmp, distinguishing between
hashcmp for use where ordering is important and something like hash_eq
when checking for equality (since I suspect the latter can be made
faster).

Thanks,
Jonathan

From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/3] index-helper: fix UNIX_PATH_MAX redefinition error
 on cygwin
Date: Mon, 11 Apr 2016 17:29:22 -0400
Organization: Twitter
Message-ID: <1460410162.5540.20.camel@twopensource.com>
References: <570ADA5B.5030408@ramsayjones.plus.com>
	 <20160411133343.GA7492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:29:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apjOm-0001ij-14
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 23:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbcDKV30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 17:29:26 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34609 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbcDKV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 17:29:24 -0400
Received: by mail-qg0-f49.google.com with SMTP id c6so156515700qga.1
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jCq2n7Qqd5KWXYVXpSF1F/WIxbL/xe8qnzJV5HeJ1Qs=;
        b=TidUutNbuD3uaozBWkzaM8m5DaqHGG20kN0IT/Tk9HbUl7Nh49f4yYvHyhhyGqww+t
         8FdAyLoiSvBzzEYSn+E95HNpbNGmhKmuKhvMd37n9ZnVvphfCdM8o47Fn81fimRZsmkm
         1/Kc38mqq4P6V0yD5MG7YO467AMZ+2hX604Xbh51n0HIObnHjyNcPiCbKBqIVznoPKph
         XCww85uSRUfRPCmjEO7xDlAj2Eel3/SHiWaklqtGZ4aDfZmhjOQapZe4zgDA12IwObxu
         vAjPIPB/xf98cFLeqO7DTPImGQ5P0Mgtb1LGWb+gmvgiHFPHoyVJxBkkTDYZ+pd3fmEd
         Lqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jCq2n7Qqd5KWXYVXpSF1F/WIxbL/xe8qnzJV5HeJ1Qs=;
        b=EYcksBTVbTywDEEMLgsRC+RJ+3G6LaVNGVl8R969ue+gKNajRo2OpOUa3crdWt9qTQ
         j5KMznTvKFzNwXNaJmzdVQJ71T8/YrKr+L+yNsKTivqrmLOFkOW1snd0LWg8RcvWqarP
         /E9n+3CatQ+7h6VDNxUvmHhoMmbPPMyXYV6ut8DjA2DfVNGVGdKbruW+RfMC5KZLxj6Y
         +vYEXcdZfboanHUaNEgDvSLpOHF6fekGp5oJBx/gjrJhMsw6mNAiPDy2rj218QoEkFp0
         TISdJtBQAXEVmfmBc1U6x0MyEMoHYSPdmMQHEmQdMWrVKT1J0rrEj9xr3asDZMLnyeOO
         PE1g==
X-Gm-Message-State: AD7BkJIy6PYwQGRoabjBgu57kPi8I1nn5H4dSi+Qw5QoJq7MEFRugrevF5cIcuJGMFnMWg==
X-Received: by 10.140.97.202 with SMTP id m68mr31528409qge.102.1460410163872;
        Mon, 11 Apr 2016 14:29:23 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l126sm11989879qhb.30.2016.04.11.14.29.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 14:29:22 -0700 (PDT)
In-Reply-To: <20160411133343.GA7492@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291233>

On Mon, 2016-04-11 at 09:33 -0400, Jeff King wrote:
> On Sun, Apr 10, 2016 at 11:57:31PM +0100, Ramsay Jones wrote:
> 
> > So, the approach taken by patch #1 is to forget about UNIX_PATH_MAX
> > and
> > simply use sizeof(address.sun_path) instead!
> 
> That's what the existing code in unix-socket.c does. Which makes me
> wonder why the index-helper code is not simply calling that.

Because I didn't notice it at the time.  Duy pointed it out on another
comment on this series; I'll fix it.

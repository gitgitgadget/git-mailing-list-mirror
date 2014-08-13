From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Wed, 13 Aug 2014 15:28:28 -0400
Organization: Twitter
Message-ID: <1407958108.9673.14.camel@leckie>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	 <CAL=YDW=5ynUFFLVNAG=M9x-DRyEyM2q=GPVxzxHVPYDNGHYm=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 21:28:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeDt-0004c9-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 21:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbaHMT2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 15:28:33 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42156 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbaHMT2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 15:28:30 -0400
Received: by mail-qc0-f171.google.com with SMTP id r5so207927qcx.30
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 12:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=aJqLz14mTB23fA+O15HXRR/dvFQnNrjMWCq3spGwA88=;
        b=jyPSoxreT+QkmjUk45E2H/nVu07ciRKUfG4t1Ok4S5jTL3/68B1PXwdsP024S0aiSG
         NMrMiaDb8Uw4nCZulumT8TUI11I8KLaJr85T/lIjoXZwPZNppWMmMTQaQbJ7wkkaryam
         AW05TT1QbYJ8Bwe4Jxmz3NS3ju87MLPT8aAqsfIyc81ihOS1W2VaXegVmtwftnL7yVz7
         P0RkudYDl25AfQGXC6+gCFSWSmlH+yB7978WOQlzaZMDeGIQiEPTzbW0J/56cEHgbb3T
         w+nYD9UsUlke+apnZj2n2rTm2K+wBbv+x8+nn9sfLcJVa+rFmRcp8kxZ5tWeBeLTCpSo
         23MA==
X-Gm-Message-State: ALoCoQnpgEysE2sJhDQf8aBb7FcFIy+YiNCTOAlyy13MiSUq1OPN9oCwwv5Sn+GeDh0mhYTrL2Hm
X-Received: by 10.140.47.129 with SMTP id m1mr9584804qga.95.1407958109818;
        Wed, 13 Aug 2014 12:28:29 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id 106sm3013431qgo.16.2014.08.13.12.28.28
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 12:28:29 -0700 (PDT)
In-Reply-To: <CAL=YDW=5ynUFFLVNAG=M9x-DRyEyM2q=GPVxzxHVPYDNGHYm=A@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255225>

On Wed, 2014-08-13 at 09:20 -0700, Ronnie Sahlberg wrote:
> David,
> 
> One possible solution can be to use the external database daemon I am
> working of for ref transactions.
> Since this makes all refs be stored in a dedicated database instead of
> the filesystem you no longer are dependent on file system semantics.
> 
> While not in the official git trees yet I would appreciate any testing
> and comments you may have it you want to test it.
> https://github.com/rsahlberg/git/tree/backend-struct-db-2
> 
> Not for production use but seeing if it does build and works on your
> platforms would be great.

Thanks. We ultimately went with a custom hook (which also enforces other
business rules), but I'm very excited about the new backend and hope it
will improve performance generally.

One thing you could do to increase adoption would be to make a Homebrew
formula for tdb. Homebrew is the defacto standard Mac packaging system.
Sadly, a large number of engineers use Macs, so this is a large barrier
-- especially since the tdb build is somewhat baroque.

It would also be great if it didn't require a fresh clone; for a large
organization with large repos, requiring every engineer to re-clone is
somewhat onerous.  I assume it's straightforward to do a conversion from
an existing set of refs but that it just hasn't been a priority for you
yet.

Thanks so much for working on this!

From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Sat, 16 Feb 2013 13:11:10 -0500
Message-ID: <20130216181110.GA27233@padd.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 <1360999078-27196-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 19:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6mEf-0007dQ-38
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 19:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972Ab3BPSLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 13:11:15 -0500
Received: from honk.padd.com ([74.3.171.149]:44539 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871Ab3BPSLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 13:11:15 -0500
Received: from arf.padd.com (unknown [50.124.137.41])
	by honk.padd.com (Postfix) with ESMTPSA id 6586E2C15;
	Sat, 16 Feb 2013 10:11:13 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7118D225C5; Sat, 16 Feb 2013 13:11:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1360999078-27196-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216383>

pclouds@gmail.com wrote on Sat, 16 Feb 2013 14:17 +0700:
> Finally some numbers (best of 20 runs) that shows why it's worth all
> the hassle:
> 
> git status   | webkit linux-2.6 libreoffice-core gentoo-x86
> -------------+----------------------------------------------
> before       | 1.097s    0.208s           0.399s     0.539s
> after        | 0.736s    0.159s           0.248s     0.501s
> nr. patterns |    89       376               19          0
> nr. tracked  |   182k       40k              63k       101k

Thanks for this work.  I repeated some of the tests across NFS,
where I'd expect to see bigger differences.  Best of 20 values
reported in "min ...".

    webkit
    Stock min  9.61 avg 11.61 +/- 1.35 max 14.26
    Duy   min  6.91 avg  7.67 +/- 0.46 max  8.71

    linux
    Stock min  2.27 avg  3.16 +/- 0.56 max  4.49
    Duy   min  2.04 avg  3.12 +/- 0.69 max  4.87

    libreoffice-core
    Stock min  4.56 avg  5.79 +/- 0.79 max  7.08
    Duy   min  3.96 avg  5.25 +/- 0.95 max  6.95

Similar 30%-ish speedup on webkit.  And an absolute gain
of 2.7 seconds is quite nice.

		-- Pete

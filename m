From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t0000: simplify HARNESS_ACTIVE hack
Date: Sat, 28 Dec 2013 14:14:17 -0800
Message-ID: <20131228221417.GC5544@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228093149.GB21109@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 28 23:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx29J-000649-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 23:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab3L1WOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 17:14:22 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:48401 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3L1WOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 17:14:21 -0500
Received: by mail-yh0-f49.google.com with SMTP id z20so2163271yhz.8
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 14:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dXfPR1faV1ZSmHREQh/8dAyfpMgVLBlAtpncmhb2kDE=;
        b=omIEkMqEX2VkXAh+7l0Yd5CAkAyZKoq7TxfQiFns7+TU0kwdT8NbQ+oU71xUtBzQR4
         KAEXdAqPUB63+h73pLipulnDZv7LRanaUz/Wlli2UFUCwCCAEhiZEeKu96CS0Gjqovuc
         4PtSwJNQliU2xMZtLMVunApE0aZzRqwspK/bv7ebtTiv2Tk6I0r5zsSg5ptPDdkD1VwZ
         c7puCb3+rHAx3UstFI/lGHdPdZkRCpvbrSsGJx1AyyIwSB6FC4nA7gfFSkeg/Hvt82wr
         hGP5D5m5fSiGIU9Be2/lawAAeHiN7UE97r3tAO9xnX4acjQbauurHziDf4KnTPc3xsVR
         dsWw==
X-Received: by 10.236.20.75 with SMTP id o51mr14076821yho.65.1388268861103;
        Sat, 28 Dec 2013 14:14:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w8sm53474765yhg.8.2013.12.28.14.14.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 28 Dec 2013 14:14:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131228093149.GB21109@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239791>

Jeff King wrote:

> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -50,11 +50,11 @@ run_sub_test_lib_test () {
>  	shift 2
>  	mkdir "$name" &&
>  	(
> -		# Pretend we're a test harness.  This prevents
> -		# test-lib from writing the counts to a file that will
> -		# later be summarized, showing spurious "failed" tests
> -		HARNESS_ACTIVE=t &&
> -		export HARNESS_ACTIVE &&
> +		# Pretend we're not running under a test harness, whether we
> +		# are or not. The test-lib output depends on the setting of
> +		# this variable, so we need a stable setting under which to run
> +		# the sub-test.
> +		sane_unset HARNESS_ACTIVE &&

Makes sense.

Thanks,
Jonathan

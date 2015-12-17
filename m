From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 02/10] update-index: add --test-untracked-cache
Date: Thu, 17 Dec 2015 13:05:27 -0500
Organization: Twitter
Message-ID: <1450375527.11927.3.camel@twopensource.com>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
	 <1450196907-17805-3-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 19:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9cvr-0006MJ-IP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 19:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbbLQSFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 13:05:32 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35749 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbLQSFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 13:05:30 -0500
Received: by mail-qg0-f48.google.com with SMTP id v36so13538687qgd.2
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=JkI2SJ+++DayW0RQGbQCcL20+rGOwhEqofyaMh8E8bk=;
        b=ewpk90LMxp21O1cq+0cdQ1rNM6zLY6Hr5TCTd3ZA1krL6ExH0+VURsxvRlFNfzZFvT
         /VFYxFzgYs+t/sgwPnjPH6Zizzf9eItl9L9pVIXE9WpgFN9AjZB7buCPrxLdBUfhjphb
         PRx8rg15PPcIOX+EYkIjwI6t3HiNE/qHyryW7ZJuZ3JWMf5sD6LX5IDXCxYbGPhpoacv
         kvOERR1ewrmI7apsxJSVrEGuxZaFNENBJeZM++CFojd5E5PQM/Wh2T1JbIKFKSZrzJw4
         ekq3nUTnyuyw2fA32BxJ9iFei0SW9+EIwmY/yH2AtZTSZZ8SYoAN5LnrhEQF3OzMIDCP
         V+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=JkI2SJ+++DayW0RQGbQCcL20+rGOwhEqofyaMh8E8bk=;
        b=NihL9k+r86uUiv5n3QHJI52XNQz88cHVwDe3Ztyz94oRYrAvEW6KIMGa1FkYBbWyHA
         F4K5/WFLx/Ze5hYwFfmOCUdIFdpTcnXNWA8LNuuipg8GEzFiATA7NscvTVSw2SUME3FK
         I5D2i93W3OgW0XgB8W8NLXYIHaX3REUosjnrYdnUEE0d7z2o3ZzmpNJEYVb0USivBvaQ
         xXHztsFHALJWmANQMf4DvtIYXWOqrYVRzwn4KL2Nwp8IxRZpePWLm7ZHkGLdO745GXsw
         zr+QjLp/I6RB+W0XgRhEgpWnBa8LUIzqAnZvfTESsAEFeo4yIHKxlcLOIAhYoco08Cb1
         pLAQ==
X-Gm-Message-State: ALoCoQmVY5Dkhv5SIlU+C04NOCADFfWGbz3IVDqkVDjOtsjagCvREEvN8cwDkt2CfMpEZ5Y5p24U5bcWeeW3ktIcphH73sVVYA==
X-Received: by 10.140.153.73 with SMTP id 70mr42085096qhz.30.1450375529273;
        Thu, 17 Dec 2015 10:05:29 -0800 (PST)
Received: from ubuntu (amctrendout.amcny.org. [65.206.11.162])
        by smtp.gmail.com with ESMTPSA id c2sm5128050qkb.41.2015.12.17.10.05.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Dec 2015 10:05:28 -0800 (PST)
In-Reply-To: <1450196907-17805-3-git-send-email-chriscool@tuxfamily.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282661>

On Tue, 2015-12-15 at 17:28 +0100, Christian Couder wrote: 
> +--test-untracked-cache::
> +	Only perform tests on the working directory to make sure
> +	untracked cache can be used. You have to manually enable
> +	untracked cache using `--force-untracked-cache` (or
> +	`--untracked-cache` but this will run the tests again)
> +	afterwards if you really want to use it.

It would be nice if this said how the result would be reported (by exit
code, it appears).

From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 08/11] dir: simplify untracked cache "ident" field
Date: Sat, 16 Jan 2016 15:55:22 +0100
Message-ID: <569A59DA.9050008@web.de>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
 <1452841192-620-9-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 15:56:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKSHO-00068N-1x
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 15:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbcAPOz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2016 09:55:56 -0500
Received: from mout.web.de ([212.227.15.3]:51512 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbcAPOzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2016 09:55:55 -0500
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LrYLd-1aAvYS41XB-013Kxx; Sat, 16 Jan 2016 15:55:30
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <1452841192-620-9-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:bUc22JMlNdIN6Wshoe7V3AL2qOMwBDmDWxUQO09wyQnRXim3dEn
 jrrvblynj1GXESiRcsNB5bTlcK+bW4h+Hg8J0T8rKyJGNVF9anhsfuw7OutDW8AeiYs7iZP
 KKG/R44MzaNV7XUiBYJegQI2z1M8vwSvdFpo5DGCB10s0CjRvfXiRTprj7cabhZfInNlEq+
 221ZnZ3R3V1jvNf0Y3mFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cGV2UkPbzQk=:eqJoqIpo/1IY6KwLpt4PKf
 hCnrviBslNR2gYcSWmVhwGLMeWSrm5nf5QMmy2oPXiB5YPleZWsMoz757j8+ErF0sx178v5iV
 LMljaG7UZXFJoBfqxyIFTHDGY0lZsRQWBn6AroLsGgQkCSqJN0Cc6DAcNTO4bp8gSJLvHA+h1
 shOaEVwFaccM0kOx8Z6NjdTrzHffmT7DpoPxEuBd1E0TOXmshoV9CDmi+VjHU1Qz9lU8huYbc
 IMqLHNggH5jC+2QhxhqER01zRRtOGap30ynUMUNkjX8h5vp7p/OEt5nxPOpXp41iCbdPqjmBG
 ti/4VQmRoO8QD0yTuYsUJsvmPzDtqvMIyRE5KDzWQLR2jU0AFxVGyCa9zrf6GaXRvcuTusd9w
 1FWBsJ7/CRwCkPgg3IRcEdfhPYx/n7loquXk/7sUbI2W25lfjnbu12G46lCRjNFQ+WLNI5zaD
 QcsLSwDNShoavR1rd2Up0xLMXzSGTA5nKMzjDsAT7o36w9QnseE1/uvntpo/rTu+fpkGzd3g5
 9bZqAGP+y7YRjnHI226ekFXLY+dMtKf0yZFQRi8qyi4cdG4t1rT6PluRByNL+mp8qnMS96g8B
 TWSTdTzscFJDue06Lz6EoztPy97aHabCcxZypAditLrhdY26GAM4UahBLye8QHFlwTe2Bg3z0
 C0nzB2AOuxBp+Sz6V9NGFHfKoHG/GZfCNW7VL+Om5h4OGIz/R3ysescYc5jHOfBGZ5L3ZATft
 heIdgadvwIqq3mg89dZv0AhqS9ooUFVDvHVRim8i8nsY1SM90rUoqeSQqL5BJeknLNyrnb+x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284243>



On 2016-01-15 07.59, Christian Couder wrote:
> It is not a good idea to compare kernel versions and disable
> the untracked cache if it changes as people may upgrade and
> still want the untracked cache to work. So let's just
> compare work tree locations and kernel name to decide if we
> should disable it.
>
> Also it's not useful to store many locations in the ident
> field and compare to any of them. It can even be dangerous
> if GIT_WORK_TREE is used with different values. So let's
> just store one location, the location of the current work
> tree.
>
> If this location changed and we still want an untracked
> cache, let's delete the cache and recreate it.
>
> Note that if an untracked cache has been created by a
> previous Git version, then the kernel version is stored in
> the ident field. As we now compare with just the kernel
> name the comparison will fail and the untracked cache will
> be disabled until it's recreated.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
This could be my version of a commit message:

It is not a good idea to compare kernel versions and disable
the untracked cache if it changes as people may upgrade and
still want the untracked cache to work.

Drop the major and minor version from uname stored in ident.

It can be dangerous if GIT_WORK_TREE is used with different values.

So let's simplify the handling and store just store one line,
the uname of the system the location of the current work tree.

If this location changed and we still want an untracked
cache, let's delete the cache and recreate it.

The untracked cache can only be used by one type of OS, exporting a git=
 repo
to different clients via a network to e.g. Linux and Windows means that
only one can use the untracked cache.

Note that if an untracked cache has been created by a
previous Git version, then the kernel version is stored in
the ident field. As we now compare with just the kernel
name the comparison will fail and the untracked cache will
be disabled until it's recreated.

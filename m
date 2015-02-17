From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git gc removes all packs
Date: Tue, 17 Feb 2015 17:39:27 +0100
Message-ID: <54E36EBF.2070600@alum.mit.edu>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com> <20150205200332.GD15326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Dmitry Neverov <dmitry.neverov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:39:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNlBQ-0002LA-30
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 17:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbbBQQjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 11:39:32 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57233 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873AbbBQQjb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 11:39:31 -0500
X-AuditID: 12074411-f79fa6d000006b8a-f6-54e36ec17c23
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F3.C9.27530.1CE63E45; Tue, 17 Feb 2015 11:39:29 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HGdSqb031776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 11:39:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <20150205200332.GD15326@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1D2Y9zjEoLPZ3KL33Cdmi64r3UwW
	P1p6mB2YPXbOusvu8ax3D6PH501yAcxR3DZJiSVlwZnpefp2CdwZjWcaWQo+8lQ8vL6PuYFx
	KVcXIyeHhICJxMxpl5ghbDGJC/fWs4HYQgKXGSVOHlbpYuQCss8xSRz5eZERJMEroC3RtmsX
	K4jNIqAq8ev3DCYQm01AV2JRTzOYLSoQJHHo9GMWiHpBiZMzn4DZIgIeEgv63gAt4OBgFhCX
	6P8HFhYGGrP4+kJWiL1FEhN3nmICKeEU0JPYs7QKJMwsoC7xZx7EmcwC8hLNW2czT2AUmIVk
	wSwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERK4gjsYZ5yU
	O8QowMGoxMNrMeFRiBBrYllxZe4hRkkOJiVR3tNZj0OE+JLyUyozEosz4otKc1KLDzFKcDAr
	ifAGpQDleFMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvI25QI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCiNLwbGKUiKB2hvNUg7b3FBYi5QFKL1FKOi
	lDivP0hCACSRUZoHNxaWjl4xigN9KcxbBVLFA0xlcN2vgAYzAQ2e/+cRyOCSRISUVAPjDO3e
	htsFC/Oag/49Xv/GNCiib+p64bRIh5neC9wL8gT/nKkSWncmbKbmRkZBtSnT3j6PPL1OxqFK
	rGzJPve1mhkHvU4fmv1Y+p1y3QvVijXXVu1UkOrZYNPPcPSSifpHEVVxq79Fyk96 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263952>

On 02/05/2015 09:03 PM, Jeff King wrote:
> On Thu, Feb 05, 2015 at 04:13:03PM +0100, Dmitry Neverov wrote:
>> [...]
>> One more thing about my setup: since git p4 promotes a use of a linear
>> history I use a separate repository for another branch in perforce. In
>> order to be able to cherry-pick between repositories I added this
>> another repo objects dir as an alternate and also added a ref which is a
>> symbolic link to a branch in another repo (so I don't have to do any
>> fetches).
> 
> You can't symlink refs like this. The loose refs in the filesystem may
> be migrated into the "packed-refs" file, at which point your symlink
> will be broken. That is a likely reason why git would not find any refs.
> 
> So your setup will not ever work reliably.  But IMHO, it is a bug that
> git does not notice the broken symlink and abort an operation which is
> computing reachability in order to drop objects. As you noticed, it
> means a misconfiguration or filesystem error results in data loss.

There's a bunch of code in refs.c that is there explicitly for reading
loose references that are symlinks. If the link contents literally start
with "refs/", then they are read and treated as a symbolic ref.
Otherwise, the symlink is just followed.

It is still possible to write symbolic refs that are represented as
symlinks (see core.preferSymlinkRefs), but that backwards-compatibility
code was added in 2006(!) Maybe it's time to deprecate it. And maybe we
should start working towards a future where any symlinks under "refs"
cause git to complain.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu

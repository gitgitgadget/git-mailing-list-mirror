From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Summer of Code project ideas due this Friday
Date: Sat, 12 Mar 2011 22:41:11 +0100
Message-ID: <4D7BE877.2000607@miseler.de>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <4D7A1325.1090003@miseler.de> <20110311125259.GA777@LK-Perkele-VI.localdomain> <AANLkTin30fZURU-PxddSai5Qzfqjtwej=maGssyr2b7W@mail.gmail.com> <4D7A2D47.9010101@miseler.de> <AANLkTinKnfiE9zQwYxfCX8VhRfgJhQopDbqBA+oQLL0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 22:41:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyWYy-0002xe-Jl
	for gcvg-git-2@lo.gmane.org; Sat, 12 Mar 2011 22:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab1CLVlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 16:41:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:52554 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab1CLVlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 16:41:12 -0500
Received: from [192.168.22.13] (f055073147.adsl.alicedsl.de [78.55.73.147])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0M5tNd-1Q93ID3KuH-00xRSI; Sat, 12 Mar 2011 22:41:09 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTinKnfiE9zQwYxfCX8VhRfgJhQopDbqBA+oQLL0w@mail.gmail.com>
X-Provags-ID: V02:K0:dbN9q9R4bX2teWl6CyaGTgf3fYPafN3C/8hUEeADUoZ
 QW8iIOeKpuatjtX5/6B/of3uwkbzVqcdpIpKosEk64ApIRPJMW
 bT/KjP1u1L6VRwVDC8XnZS3KkL1FbM1npZdaBTOzM/+E5yrt1f
 Je1W73D4YqAa+b3IG6471PJzDX8GTseHoaQ4/VYLU3WpsuKsHs
 1yK3kk0+vPduwm39k9lVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168951>

> Your move :)

Heh, I'm still pretty hampered by having no clue ^_^


> My way is "give me a chain of deltas starting from this SHA-1". A big
> blob can be considered as a history of smaller pieces.

I originally missed the fact that it is completely irrelevant where in the chain the reference point is and that you can go easily from any arbitrary point in the chain to any other arbitrary point in the same chain. This makes it a lot more flexible than I thought. But to support more than just resumable cloning You would still need a more powerful way to negotiate "I have this; I want that" between client and server.

My point was mostly that lazy clone, sparse clone and resumable clone are closely related and should ideally be solved in one go. You currently seem to aim at only one of them, which is a shame.
For lazy clone the client would start with all blobs referenced by HEAD (and possibly other branches) and then it would walk backwards through the delta chains if/as far/whenever it wants. Though it would also need to detect when it needs to start reading new delta chains as it walks backwards through history. Sparse clone would use the same mechanism and just restrict it to certain paths.

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/2] Rename suffixcmp() to has_suffix() and invert its
 result
Date: Wed, 6 Nov 2013 15:28:05 -0800
Message-ID: <20131106232805.GD10302@google.com>
References: <20131105210237.21525.61810.chriscool@tuxfamily.org>
 <20131106221735.GB10302@google.com>
 <61456C34-834F-4E7B-89D2-9DB45690C9ED@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Nov 07 00:28:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeCWF-0006No-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 00:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab3KFX2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 18:28:11 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:60910 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3KFX2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 18:28:10 -0500
Received: by mail-pd0-f180.google.com with SMTP id p10so210234pdj.11
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h4Ah7I27CyxSuSC5aXMtq/+rC/5c124HQ20nBsMnJ94=;
        b=KZlMVTDh/wNM23AlXavkMHE9bzJrASqisouSHNLMaKHkiihIn72Qu+u7fbnSL2EERd
         ydVwjDHMjnYGkkJLT1DxR2kDIPbTRBbFffXQsYl9Z9A84FaCsxfKn21K6kaAua3kX/Hc
         wZhwv9F00AvPS+4oAcbrJuDspK7OFtSt6zhnN56Tjiv5CfaQmXRlqlAoBqHpAj+wsprp
         52PtOlVgdrumD//untjirpjf6SZEPcBRvZhh2Bym2R7nYHul92Napm8HbNxUtQzIlqeU
         FKZU0tXjP6VfZc2kccnENOjp1g4EhG2DHWIvfJHmM3Ac/wtxkaK+i9OVsWR03BgEAqAM
         +iwA==
X-Received: by 10.66.196.168 with SMTP id in8mr6466450pac.18.1383780489260;
        Wed, 06 Nov 2013 15:28:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dq3sm539821pbc.35.2013.11.06.15.28.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Nov 2013 15:28:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <61456C34-834F-4E7B-89D2-9DB45690C9ED@quendi.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237381>

Max Horn wrote:

> Well, unlike suffixcmp, it is transitive, so it could be used for sorting.

It is not antisymmetric.

	prefixcmp("foo", "foobar") < 0
	prefixcmp("foobar", "foo") == 0

I can see how it's possible to care about the sign of the return
value, but it's equally possible to care about the sign from
suffixcmp.  Neither is suitable as a function for passing to qsort.

Hoping that clarifies,
Jonathan

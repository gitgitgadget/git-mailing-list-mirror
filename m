From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 13:49:23 -0400
Message-ID: <1189100963.3423.9.camel@hinata.boston.redhat.com>
References: <20070902224213.GB431@artemis.corp>
	 <11890776114037-git-send-email-madcoder@debian.org>
	 <118907761140-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:49:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLU9-0002ww-Um
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbXIFRtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050AbXIFRtc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:49:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbXIFRtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 13:49:32 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l86HnUPA013656;
	Thu, 6 Sep 2007 13:49:30 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l86HnUxV026541;
	Thu, 6 Sep 2007 13:49:30 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l86HnTll007388;
	Thu, 6 Sep 2007 13:49:29 -0400
In-Reply-To: <118907761140-git-send-email-madcoder@debian.org>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57917>

On Thu, 2007-09-06 at 13:20 +0200, Pierre Habouzit wrote:
> The gory details are explained in strbuf.h. The change of semantics this
> patch enforces is that the embeded buffer has always a '\0' character after
> its last byte, to always make it a C-string. The offs-by-one changes are all
> related to that very change.
> 
>   A strbuf can be used to store byte arrays, or as an extended string
> library. The `buf' member can be passed to any C legacy string function,
> because strbuf operations always ensure there is a terminating \0 at the end
> of the buffer, not accounted in the `len' field of the structure.
> 
>   A strbuf can be used to generate a string/buffer whose final size is not
> really known, and then "strbuf_detach" can be used to get the built buffer,
> and keep the wrapping "strbuf" structure usable for further work again.
> 
>   Other interesting feature: strbuf_grow(sb, size) ensure that there is
> enough allocated space in `sb' to put `size' new octets of data in the
> buffer. It helps avoiding reallocating data for nothing when the problem the
> strbuf helps to solve has a known typical size.

This looks good, should be very useful.

Kristian

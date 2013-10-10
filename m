From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Thu, 10 Oct 2013 01:14:28 -0700
Message-ID: <CAJo=hJtBapzmF7BEawwRGJ0NKH1W0J5P4c4iGK6G_==gZahhgg@mail.gmail.com>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
 <20131009193054.GA3767@sigill.intra.peff.net> <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
 <20131009213742.GA8362@sigill.intra.peff.net> <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Oct 10 10:14:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUBOb-0001Uf-W8
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 10:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab3JJIOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 04:14:53 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:60167 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab3JJIOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 04:14:50 -0400
Received: by mail-wg0-f42.google.com with SMTP id m15so8800848wgh.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NyXRH/mtf/jRnkbuws8llqUYHrJqgiBDmiREj4vO8l8=;
        b=TE+XQ/rs+wtCM4ztk6iuow3fgQfVWyC2y9BA3208kK/TsPvYvs3PVIx0n2fwYQHEQJ
         Clw9vOe0vVKECsVRhDtVAX7ifEGhi284rdf40LiRcl9hqYlylzG4DzD7Gqrbe+3cHWs6
         NSSUcObMax73FpzQ0d68U+O1/z9hPeeEjjC7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NyXRH/mtf/jRnkbuws8llqUYHrJqgiBDmiREj4vO8l8=;
        b=CA4+RdVV5Vb8KJeNFmjDkidUnpFbr4MYxdj0s09PkPoiYhDSraM7eezMfcYZWfMO+u
         NxQarnrfU127bvPazoZPQ2YJ7lovVUnaH4DNjkI9QRkeHMpaHWgWM+eVd8T5m+mb3LHi
         tzU17qOQjIaf+BFcGVZqBlnTHpZphH+OQr1bFmPYAlH+H66HFU0E5A/nzOyzPwR+UugY
         Rtcric1WjrhDd1OFXX9In0VU5cblTQ9P5HRoVDza2qYwo5NiWAEDAIKhNWoNuZsDVONA
         OO9M/fgcijxUWZg2x9hKwq4U3jCxQszwDfDqfMTQpdHjq4FbkpvZi8mJHGAQrX+hHQTS
         IH2Q==
X-Gm-Message-State: ALoCoQnr7PuIcbHuYDrGhBATrdkttiR3fNHLOrvQxeQKO+ol07PbAMINXyFqTRsR7ZAxP1ugIBXY
X-Received: by 10.194.24.168 with SMTP id v8mr11023265wjf.28.1381392888477;
 Thu, 10 Oct 2013 01:14:48 -0700 (PDT)
Received: by 10.227.204.72 with HTTP; Thu, 10 Oct 2013 01:14:28 -0700 (PDT)
In-Reply-To: <20131010013547.GA62549@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235858>

On Wed, Oct 9, 2013 at 6:35 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Wed, Oct 09, 2013 at 05:37:42PM -0400, Jeff King wrote:
>> On Wed, Oct 09, 2013 at 02:19:36PM -0700, Shawn O. Pearce wrote:
>> > 206b099 was written because the Google web servers for
>> > android.googlesource.com and code.google.com do not support
>> > 100-continue semantics. This caused the client to stall a full 1
>> > second before each POST exchange. If ancestor negotiation required
>> > O(128) have lines to be advertised I think this was 2 or 4 POSTs,
>> > resulting in 2-4 second stalls above the other latency of the network
>> > and the server.
>>
>> Yuck.
>
> Shame on Google.  Of all people, they should be able to implement HTTP
> 1.1 properly.

Heh. =)

If a large enough percentage of users are stuck behind a proxy that
doesn't support 100-continue, it is hard to rely on that part of HTTP
1.1. You need to build the work-around for them anyway, so you might
as well just make everyone use the work-around and assume 100-continue
does not exist.

100-continue is frequently used when there is a large POST body, but
those suck for users on slow or unstable connections. Typically the
POST cannot be resumed where the connection was broken. To be friendly
to users on less reliable connections than your gigabit office
ethernet, you need to design the client side with some sort of
chunking and gracefully retrying. So Git is really doing it all wrong.
:-)

Properly using 100-continue adds a full RTT to any request using it.
If the RTT time for an end-user to server is already 100-160ms on the
public Internet, using 100-continue just added an extra 160ms of
latency to whatever the operation was. That is hardly useful to
anyone. During that RTT the server has resources tied up associated
with that client connection. For your 10-person workgroup server this
is probably no big deal; at scale it can be a daunting additional
resource load.

Etc.


Even if you want to live in the fairy land where all servers support
100-continue, I'm not sure clients should pay that 100-160ms latency
penalty during ancestor negotiation. Do 5 rounds of negotiation and
its suddenly an extra half second for `git fetch`, and that is a
fairly well connected client. Let me know how it works from India to a
server on the west coast of the US, latency might be more like 200ms,
and 5 rounds is now 1 full second of additional lag.

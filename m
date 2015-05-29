From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Fri, 29 May 2015 18:08:11 -0400
Message-ID: <20150529220811.GA15678@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-7-git-send-email-sbeller@google.com>
 <20150527064521.GD885@peff.net>
 <CAGZ79kbm5FCjMH-vV+_ByNvAdOD2idVtd8-bizEJpZpdE9cGjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 30 00:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YySRw-0008KC-5v
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 00:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbbE2WIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 18:08:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:37938 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757194AbbE2WIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 18:08:14 -0400
Received: (qmail 26648 invoked by uid 102); 29 May 2015 22:08:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 17:08:14 -0500
Received: (qmail 9530 invoked by uid 107); 29 May 2015 22:08:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 18:08:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 18:08:11 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kbm5FCjMH-vV+_ByNvAdOD2idVtd8-bizEJpZpdE9cGjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270275>

On Fri, May 29, 2015 at 12:39:35PM -0700, Stefan Beller wrote:

> > I think this is the reverse case of next_capabilities in the upload-pack
> > side, so I'll make the reverse suggestion. :) Would it make things nicer
> > if both v1 and v2 parsed the capabilities into a string_list?
> 
> Ok, I'll do that. Though this makes future enhancements a bit uneasy.
> Say we want to transport a message by the server admins, this might be
> the right place to do.
> 
>     if (starts_with("message"))
>         fprintf(stderr, ....
> 
> Of course we can later add this in the future, but it would break older
> clients (clients as of this patch series). That's why I like the idea of
> adding a prefix here. Maybe just a "c:" as an abbreviation for capability.

I don't understand how that breaks existing clients. Under your scheme,
the older client says "message? That does not start with capability:, so
I must ignore it". Without the "capability:" flag, it becomes "message?
I do not know that type, so I must ignore it".

-Peff

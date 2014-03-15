From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Sat, 15 Mar 2014 08:23:08 +0700
Message-ID: <CACsJy8A1=U2=TGoKyo5mo1fLW+hBR1psn1J6S0=391fei2JULw@mail.gmail.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org> <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org> <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 02:24:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOdKd-0003wK-KU
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 02:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbaCOBXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 21:23:40 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:38996 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbaCOBXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 21:23:39 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so3758671qcq.17
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 18:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D2gBLu1Se9JDYyQMq1KzID+iPWdSPvBLrq/VqB+UL+8=;
        b=zvVKIdTjdjP/iNCpFKrJerJAzONiun4IlWaVD3plm+tyx7/VPpyJhBq6se6+9g5G1F
         TrPChsCJ8r0dfTeGFF89BMSrldYiwUrVm23LhYOrG1d5b8FA+prFx8GkGKRq+omq9wk6
         WAed0Zl9SLjU1wVxfk/tYjQHBgKib9HWHMIs0VxsulcZpOeanetuxlJyos7qu5ItB1L/
         6kvSXgA2Mc9iQF1jXpBLPCyFTh5eCLD83mza2Tnrh/LbaqhbnidAc4U36sE+XjxV7sYo
         YMrP2zX4jNKKgFuvF7C+Eyl4OovmsWBaS4oVsXjL9zLGSBoKn2E1NYNMu/DMkn82/9Zr
         SHVg==
X-Received: by 10.140.106.119 with SMTP id d110mr12967535qgf.69.1394846618543;
 Fri, 14 Mar 2014 18:23:38 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 14 Mar 2014 18:23:08 -0700 (PDT)
In-Reply-To: <20140311014945.GB12033@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244131>

On Tue, Mar 11, 2014 at 8:49 AM, Jeff King <peff@peff.net> wrote:
> Right, I recall the general feeling being that such a system would work,
> and the transition would be managed by a config variable like
> "remote.*.useUploadPack2". Probably with settings like:
>
>   true:
>     always try, but allow fall back to upload-pack
>
>   false:
>     never try, always use upload-pack
>
>   auto:
>     try, but if we fail, set remote.*.uploadPackTimestamp, and do not
>     try again for N days
>
> The default would start at false, and people who know their server is
> very up-to-date can turn it on. And then when many server
> implementations support it, flip the default to auto. And either leave
> it there forever, or eventually just set it to "true" and drop "auto"
> entirely as a code cleanup.

I would add that upload-pack also advertises about the availability of
upload-pack2 and the client may set the remote.*.useUploadPack2 to
either yes or auto so next time upload-pack2 will be used.
-- 
Duy

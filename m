From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Tue, 25 Oct 2011 11:01:14 +1100
Message-ID: <CACsJy8A7yVk15aAgqDkKTz31rChA7Oj-kS2VT2y2tWS6h01GyA@mail.gmail.com>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr>
 <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx>
 <20111023162944.GB28156@sigill.intra.peff.net> <4EA453D3.7080002@lsrfire.ath.cx>
 <4EA4B8E7.5070106@lsrfire.ath.cx> <7vipne50lz.fsf@alter.siamese.dyndns.org>
 <4EA5DFB2.3050406@lsrfire.ath.cx> <20111024233427.GA24956@duynguyen-vnpc.dektech.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 25 02:01:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIUSl-0005Vx-9E
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 02:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab1JYABq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 20:01:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59628 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab1JYABp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 20:01:45 -0400
Received: by bkbzt19 with SMTP id zt19so8758474bkb.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 17:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=or0hVffm+EOUp9DRetoYSeO6adcOVV+U1j2QZZuVrCM=;
        b=x4bN/0hjM9urYUDQGX7ksKGF3ckPjpL2z7wdiJ+D9lg1Sn6If0qAvfI6Zz/X/OIbqm
         dBya2gCcGUH4QkrRG4Hq9twthe0E35nFsPMQGhOfsgziOnaefy8fwFCphP7A3/DqqqSZ
         /VUjxnxZ8wONr7LSUhbT8x6AcaocSn3J+hqps=
Received: by 10.204.0.67 with SMTP id 3mr13673708bka.55.1319500904157; Mon, 24
 Oct 2011 17:01:44 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Mon, 24 Oct 2011 17:01:14 -0700 (PDT)
In-Reply-To: <20111024233427.GA24956@duynguyen-vnpc.dektech.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184195>

On Tue, Oct 25, 2011 at 10:34 AM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> "git status" is slow. If your changes causes slowdown, it won't likely
> stand out while other fast commands may show (read_cache() is used in
> nearly all commands). So I tested using the following patch.
>
> The result on linux-2.6 shows about 10-20 us slowdown per each
> read_cache() call (30-40 us on webkit, ~50k files) I think your patch
> is good enough :-)

That was with -O0 by the way. valgrind/massif shows about 200kb memory
more with your patch on webkit repository (7.497 MB vs 7.285 MB),
using the same test, so memory overhead is ok too.
-- 
Duy

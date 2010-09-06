From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 23:29:02 +0530
Message-ID: <AANLkTikmU9_Vg2+=73yjPyaaDSqk73Bvs1HyNjFDWqNY@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
	<AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
	<201009061049.38546.jnareb@gmail.com>
	<EC704F6E-3075-459C-9210-10C234523D80@gmail.com>
	<20100906145606.GM32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Juran <jjuran@gmail.com>, Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 06 19:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsfyK-0006nv-Hy
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 19:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab0IFR7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 13:59:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44008 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0IFR7E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 13:59:04 -0400
Received: by gyd8 with SMTP id 8so1698268gyd.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oagKsbglwoTC7mnuI8gMY1seCaoWn9O84PYUk/66Rto=;
        b=adgnnPDn80sZGHgu5K4A7YH1RUSu0WehirdQVpuvVDedTfg1VGzA0onpuvu/d8+Ld/
         Q05Hu9TJUeq5PCc3iBNhJmiCtK3FbHLvoGieocglLZ8a9px8iYko9KmBwBl8RKdvXMeb
         pu9dn7/emGKACN3Ps3tM89IRkqd2VzTdcJuoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J5YcqO0F99hm5JSWqOLFI+AIH7ZKvipUxYxizBUvtjgwZUa/9IWMqjgAkbzH7MJuyV
         B+eqXvYnkUBVl0tn0K0redOtMWrEfGF57pe9Wg0QTlZ69s2UyYLWjNoavixCYjrBBii0
         A80v2yN0vH4P68gLbitXPr12J8MG7f1KDX7JU=
Received: by 10.90.63.7 with SMTP id l7mr777112aga.52.1283795942949; Mon, 06
 Sep 2010 10:59:02 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Mon, 6 Sep 2010 10:59:02 -0700 (PDT)
In-Reply-To: <20100906145606.GM32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155590>

On Mon, Sep 6, 2010 at 8:26 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:

> That is, the following will trigger a correct error on the client:
>
> =C2=A0200 OK
> =C2=A0Content-Type: application/x-git-upload-pack-advertisement
>
> =C2=A0001e# service=3Dgit-upload-pack
> =C2=A00022ERR You shall not do this

are those counts accurate for the specific example you show or just mad=
e up?

It seems the first line has a count in hex that includes the newline
at the end, and the second one has a count in decimal that does not
include the newline nor even the 4-digits plus "ERR"

> Likewise if you wanted to do this with receive-pack, replace upload
> with receive above and adjust the pkt-line lengths.

ok... what about all the other service commands?  like /info/refs?
What should I put there?

Sorry if I'm being stupid but I couldn't find this info anywhere (my C
grokking isn't as good as it used to be anyway).  I've tried all sorts
of combinations of sending out two such lines -- variations on length,
\r, \n, \r\n, neither, etc etc but I can't get the correct output.

Also, experimenting with making the update hook die similarly and
wireshark-ing the responde does not show similar pattern coming
through.

If you could point me to some place that says the precise format,
including \r\n, I'd greatly appreciate it.

Thanks,

Sitaram

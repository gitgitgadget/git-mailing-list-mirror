From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Mon, 2 Apr 2012 08:00:22 +0700
Message-ID: <CACsJy8CJK4gZwnrqkhq2DUqErS94X=99kvB9z=x9TefG=MrE4A@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net> <4F7768D6.3010400@gmail.com>
 <CA+M5ThTKtSFPq8A3oc1wvc9i0vG1NMyHCRE+poYaq+65FQWOxw@mail.gmail.com>
 <CACsJy8DTegW78Qw7-T6uK_oZj2CELv57bbH6sU=bScHDesGYPQ@mail.gmail.com> <CA+M5ThTnd+TST6WsAn-Jd=Gb=1EWaJ+QbLMxXgtAVFNVqnRcMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jeff King <peff@peff.net>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Bo Chen <chen@chenirvine.org>
X-From: git-owner@vger.kernel.org Mon Apr 02 03:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEVdj-0008Rm-LM
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 03:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab2DBBAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Apr 2012 21:00:55 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42776 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2DBBAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 21:00:54 -0400
Received: by wgbdr13 with SMTP id dr13so2192965wgb.1
        for <git@vger.kernel.org>; Sun, 01 Apr 2012 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JiXiFt4p7PqcdQYo1N1DBoGwT5KEMuDeIR7lmLdgviQ=;
        b=ACMVI4re6Zq6ne2DhdPv2U0S06z48nwBAn7WN64hMtkCbWmh9rrHMP3TiRzQ+WYscx
         6B0wUwrmdiqFEkuUbVoT4jRX7GoSjQYvSn+qEgwIg55W3ccoiubcDXrt+AYllWXBoLEy
         CsZu9b9no8h6cX5DtbYu6ROPIz3FN+S2zdQkBZqCDdnqurTqPbBQNBxaeTYwjp0wd/vo
         aXQ9S1nKl747W6FyCeNmv7QsxIQ8YvloCFHytxTm1YB0XwFS0lFwrmYbcsrO4i/TRzKT
         P1VMiWa8NO5Wm4o1T0ghL6FCF6u5QrEmSNTOKQWaZTSY21qho/ekQeUtjQ5nyw3d+VHr
         5AGA==
Received: by 10.180.97.41 with SMTP id dx9mr20042047wib.9.1333328453130; Sun,
 01 Apr 2012 18:00:53 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Sun, 1 Apr 2012 18:00:22 -0700 (PDT)
In-Reply-To: <CA+M5ThTnd+TST6WsAn-Jd=Gb=1EWaJ+QbLMxXgtAVFNVqnRcMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194496>

On Mon, Apr 2, 2012 at 6:30 AM, Bo Chen <chen@chenirvine.org> wrote:
> One question, =C2=A0can anyone help me clear?
>
> My .git/objects has 3 blobs, a, b, and c. a is a unique file, b and c
> two sequential versions of the same file. When I run "git gc", what
> exactly happens here, e.g., how exactly git (in the latest version)
> delta compresses-the blobs here?

See Documentation/technical/pack-heuristics.txt for how pack-objects
(called by"git gc") decides to delta either b or c based on the other
one. Once it chooses, say, b to be delta against c, it generates delta
using diff-delta.c, then store the delta in either ref-delta or
ofs-delta format. The former stores sha-1 of c, the latter the offset
of c in the pack.
--=20
Duy

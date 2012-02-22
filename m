From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Wed, 22 Feb 2012 09:12:22 +0700
Message-ID: <CACsJy8C3Myqs4=GvURWqCTxGp0R1RWotdiHGnnvBSaxyTteujw@mail.gmail.com>
References: <20120215190318.GA5992@sigill.intra.peff.net> <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net> <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net> <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net> <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net> <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do> <CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
 <7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:13:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01hT-0006I8-Bd
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab2BVCMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 21:12:54 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55839 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2BVCMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 21:12:53 -0500
Received: by wics10 with SMTP id s10so3899788wic.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 18:12:52 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) client-ip=10.180.99.65;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.99.65 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.99.65])
        by 10.180.99.65 with SMTP id eo1mr31751111wib.13.1329876772641 (num_hops = 1);
        Tue, 21 Feb 2012 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TiCoO2ovhE0sHbTg7x3aCtaGiYBWpluhyHM2uVY/FvE=;
        b=bQVRNJ7zNDExO81qX3qk5zS0t6YggBhjPI4J5W0TDItGGBwUTJFreZ7ltpg879K4yS
         6i/mAUrW0D8Jz1i6dONsSnkhtNirBVoQojjOOilHe7uKe0DbAOqD829IvVRkXzALg0V/
         3oIJMBaQ2ye/PLviIyzxQHkaxiBvLYyVpiU6M=
Received: by 10.180.99.65 with SMTP id eo1mr26491400wib.13.1329876772590; Tue,
 21 Feb 2012 18:12:52 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Tue, 21 Feb 2012 18:12:22 -0800 (PST)
In-Reply-To: <7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191220>

On Wed, Feb 22, 2012 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Because prime_cache_tree() by itself is a fairly expensive operation =
that
> reads all the trees recursively, its benefits need to be evaluated. I=
t
> should to happen only in an operation that is already heavy-weight, i=
s
> likely to have read all the trees and have many of them in-core cache=
, and
> also relatively rarely happens compared to "git add" so that the cost=
 can
> be amortised over time, such as "reset --(hard|mixed)".
>
> Switching branches is likely to fall into that category, but that is =
just
> my gut feeling. =C2=A0I would feel better at night if somebody did a =
benchmark
> ;-)

In this particular case, "git diff --cached" is run internally, so I
say all trees are read once and hopefully most of them still in OS
cache. Will run some benchmark, maybe with the coming perf test suite.

> One thing we do not currently do anywhere that _might_ be of merit is=
 to
> make a call to cache_tree_update() instead of prime_cache_tree() when=
 we
> already know that only a very small subpart of the cache-tree is inva=
lid
> and it is cheaper to repair it by rehashing only a small portion of t=
he
> index than to re-prime the entire cache tree with prime_cache_tree().

That makes me think if "diff --cached" can take advantage of
cache-tree to avoid walking down valid cached trees and do tree-tree
diff in those cases instead. Not sure if it gains us anything but code
complexity.
--=20
Duy

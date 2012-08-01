From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 1 Aug 2012 13:34:23 +0700
Message-ID: <CACsJy8Aa_YohFEApGQxL5086vOviAKBc1AB0QyWVsda6byrYzg@mail.gmail.com>
References: <20120731141536.GA26283@do> <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net> <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net> <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
 <7v4nongn3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 08:35:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwSWL-00078l-Lk
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 08:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab2HAGez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 02:34:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55678 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2HAGey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 02:34:54 -0400
Received: by yhmm54 with SMTP id m54so6962428yhm.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 23:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GdWmXJ3ft7I2mJymoDRYHPtLe38zOSA3j5m3kBmFSfA=;
        b=cUTjhatsB6ioXtOsES0CptrDo22YME1nKN4wPopWEtzkgVTTHPbmeurxeg5+Xi/YhE
         L7ittEhuYKuQjvkt1SURTrnDApydnqQPyNsj7bb7ZJVIK4lj9jqLvszlJOeZOaE8kB+F
         9kmcuM4rTkwPklnZDb4GCtClH9R/DuwsZqb70vROdHtNWZCVXf0tt6tLet1T8Qg4Ueyc
         SfOqH6DhyHiHhUILFhrlk+IuT9kM7Wi5nWKH6ODGXep0qmeFzZYncsPAZrMjzuH3eV5Z
         aPhKyu0tzU/XLGIOBnGaJKcsWAvbdD0JM5G2DvwkHi09xrq2tHg3Q/Vh+5OAm+/j0eIu
         d5YA==
Received: by 10.50.188.201 with SMTP id gc9mr4201560igc.44.1343802893444; Tue,
 31 Jul 2012 23:34:53 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Tue, 31 Jul 2012 23:34:23 -0700 (PDT)
In-Reply-To: <7v4nongn3e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202705>

On Wed, Aug 1, 2012 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Yes. This is probably cosmetics only, but without path information, we
>> leave it to chance to decide which A to pair with B and C (in the
>> A->B, A->C case above). Wrong path might lead to funny effects (i'm
>> thinking of git log --follow).
>
> Isn't that why <A,B> and <A,C> can have different scores per object
> name pair?  And if you mean by B and C the paths not object names,
> and the blob at B and C are indeed identical, why would it matter?

I don't see how scores affect that. Suppose I have two trees and a
rename-cache file:

$ git ls-tree -r HEAD^
100644 blob d00491    path1/foo
100644 blob d00491    path2/bar
$ git ls-tree -r HEAD
100644 blob 0cfbf0    path1/fooo
100644 blob 00750e    path2/barr
$ cat rename-cache
d00491 0cfbf0 <score 1>
d00491 00750e <score 2>

How can I be sure "git diff HEAD^!" will rename path1/foo =>
path1/fooo and path2/bar => path2/barr, not path1/foo => path2/barr
and path2/bar => path1/fooo?
-- 
Duy

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Thin pack
Date: Thu, 5 Dec 2013 10:43:31 +0700
Message-ID: <CACsJy8D0wrBJnigNaPt=_5Sa1PWrqaWzttA8Mun3H74mzYRNVA@mail.gmail.com>
References: <CAHtLG6SBOi+v7uchwr1iHtMvzwLOW1hkpNT5x4vVhOKL=t2SdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 04:44:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoPrF-0001jC-3n
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 04:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab3LEDoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 22:44:05 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:65175 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab3LEDoC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 22:44:02 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so3034312qcz.16
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 19:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VpOkgVR9mKwK1sSdAn/BthRe2aPsDSAQksRYC7ypp+o=;
        b=IJjEv4hmMH/BFvjGa2EgBoPZSN+eU2/GEekQM57L7eEzCHscTGwNerSXvFxPPH+dJO
         CeMRKgudLFPqEcyk/jFo43XSe4H9Yl5h7KXx/iISQVftOZVNGpJIb1oiRCkypDpV6q+A
         v1h1ZSJpoPRvm1zHNZmWvvd5moPJaZNCPCgtaS7+E4pw4c7o6TEXrJara05nClIaF9Hl
         +pl3AOT5Rn/xbPA/BxMaG6ZhpdN49W/un7en7/ZndBX964unbFjReFcfbric8VzWSAOv
         1rubwoIN80poP2oFP2GBo7Nild+HMXwLa1eORPqlhvItjNLiC86sKC/RJVNGDlftToOU
         K6Ww==
X-Received: by 10.224.61.1 with SMTP id r1mr100809123qah.97.1386215041531;
 Wed, 04 Dec 2013 19:44:01 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 4 Dec 2013 19:43:31 -0800 (PST)
In-Reply-To: <CAHtLG6SBOi+v7uchwr1iHtMvzwLOW1hkpNT5x4vVhOKL=t2SdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238843>

On Thu, Dec 5, 2013 at 8:44 AM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@g=
mail.com> wrote:
> What are the difference between pre 1.8.5 and 1.8.5 about thin pack s=
upport?

No idea.

> Could you describe thin pack?

It gets a bit technical. Under the hood objects are deltified, only
the differences between an object and its base are stored. If both the
diff and the base are in a pack, it's a normal pack. If the pack lacks
the base, it's "thin". This makes thin packs more suited for network
transfer because you transfer much less. Imagine you have a 5k file,
you fetch another version of the same file that changes 1 line. With
thin pack, you receive just that line (not entirely true, but good
enough). Without thin pack, you also receive the 5k file you already
have because it's the base of the new version.

> From the doc, it says --thin is default option. Is that true?

Yes.
--=20
Duy

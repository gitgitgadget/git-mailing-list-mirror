From: skillzero@gmail.com
Subject: Re: Restore annotated tag?
Date: Wed, 22 Sep 2010 11:38:13 -0700
Message-ID: <AANLkTingnVMsRp8+r5-D=c-7mxfaMY1V06YXT2FQzAoL@mail.gmail.com>
References: <AANLkTinafiikD0Lzgw2gw1ti2pCK6cSTk5bQZFcCRJnS@mail.gmail.com>
	<20100922182353.GO32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 22 20:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyUD0-0004Vi-Qx
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0IVSiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 14:38:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54557 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab0IVSiO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 14:38:14 -0400
Received: by wwi17 with SMTP id 17so211748wwi.1
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FdHz3dDhfrnKWSo+67+WALINpIofDZcGmOnDmTzDlmk=;
        b=WKyizMtHAikPg5WzCSmIJdTDf2IaZom6IL7HszneO6UcGQMJAT6XNZIecwfw8eBc/D
         XX+P5BEZ11K7Uy5aThvEEN5YvPJXb6or39G8K0IzDELdVshkvYeMDKJabUlmhOYbXHb4
         xA4onqMWXVDIdW9sqVamZaTIyBbsFHRxjUUX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sibAckBC3BYXtjghQJ38uZ77rDPW31lQD38y2bZyUNHPIy/kGgN59YuTYX7lT7jUN+
         Gsdlkq4RaYk4Ug0+isOdMqZsLvTwf4LtDd4eT2x5ydhE5D5O9pNXRjtZZB7tZvkVPesV
         fDeuZr2+DBEExi/1/JDbLT1odo3om9+dgQpN0=
Received: by 10.227.152.18 with SMTP id e18mr624111wbw.1.1285180693070; Wed,
 22 Sep 2010 11:38:13 -0700 (PDT)
Received: by 10.227.135.202 with HTTP; Wed, 22 Sep 2010 11:38:13 -0700 (PDT)
In-Reply-To: <20100922182353.GO32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156820>

On Wed, Sep 22, 2010 at 11:23 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> skillzero@gmail.com wrote:
>> Is there a way to restore an annotated tag? One was accidentally
>> deleted and pushed. I can restore normal tags by just using git tag
>> again, but for an annotated tag, there's a tag object and I'm not su=
re
>> how to restore it.
>
> If the tag still exists, `git fsck --unreachable | grep tag` should
> show you output listing the dangling tag objects. =C2=A0Once you have=
 that
> list, use `git show SHA1` to view the object. =C2=A0When you find the=
 tag,
> make a reference to it with `git update-ref refs/tags/NAME SHA1`.

Thanks, that worked.

One thing I noticed that I wasn't sure about is that I SSH'd into the
server and ran git update-ref to restore the tag. That created the
symbolic name in .git/refs/tags/NAME to point to that tag object. But
what I noticed is that the only file listed in .git/refs/tags is the
tag I restored. There are other tags in the repository (and a fresh
clone gets them), but they don't show up in that directory. Is it
going to be a problem that ran git update-ref on the server (which is
a bare repository) rather than on a clone that I push? I just want to
make sure that the tag objects are referenced so they don't go away
after the 2 week garbage collection grace period.

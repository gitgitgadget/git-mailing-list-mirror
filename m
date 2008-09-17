From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 05:57:21 -0700
Message-ID: <cfd18e0f0809170557n2aa6c290j69dafd412c92cc64@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <48D0BEF1.10008@drmicha.warpmail.net>
	 <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
	 <20080917110510.GB13144@atjola.homenet>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>, git@vger.kernel.org,
	michael.kerrisk@gmail.com
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:58:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfwc3-0000D6-AU
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbYIQM5X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 08:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752361AbYIQM5X
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:57:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:38561 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbYIQM5W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2008 08:57:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3172242rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MSV6jdS+xlFj/Q4QuI2q7SyBCAyo7ZiuM6ob7qOOAXs=;
        b=qPnuvYHQvlINsaTr7X/N52bcbPb4ew3rduZEfE/1MZqkGkkEMacOyRkJeM596CYFrj
         hCqvwGEzl76wogz2SM7le4n5kxW/di8UuyvqaSVZaoyNfCvKFrXG7sMb8HjO4WuOvecZ
         zwhza1Vfzc1RmKGFI6bJ6zGT++O10S+E0B3sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Hrco5Fef9zkd0Yk3FKIYgJSmVNGDItvGO+r4aZ8Wxt2z7e19i0r/Rje4CjiKvtMhpI
         a5rhzGYd97QVDZG0MWil+R3dbBd/5eRjMt2Rc1rAf8x9XtJWZPE+CmRL2V/2i0ReS87v
         jzmUUKj5eHwU2YBDYAyvkDqbatyNYSzftaBDQ=
Received: by 10.141.76.1 with SMTP id d1mr6457994rvl.269.1221656241410;
        Wed, 17 Sep 2008 05:57:21 -0700 (PDT)
Received: by 10.141.176.2 with HTTP; Wed, 17 Sep 2008 05:57:21 -0700 (PDT)
In-Reply-To: <20080917110510.GB13144@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96107>

Hi Bj=F6rn,

D'oh -- the fix was from you too ;-).  See below.

On Wed, Sep 17, 2008 at 4:05 AM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.d=
e> wrote:
> On 2008.09.17 03:38:12 -0700, Michael Kerrisk wrote:
>> $ svn list file:///home/mtk/man-pages-rep/tags
>> man-pages-2.00
>> man-pages-2.01
>> man-pages-2.02
>> man-pages-2.03
>> ...
>> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.00
>> man-pages
>> $ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.01
>> man-pages
>> [and so on]
>> $ svn list file:///home/mtk/man-pages-rep/branches
>> $
>> (i.e., no branches, since this has been a linear svn repo.)
>
> That means that you also need to pass the "man-pages" suffix for the
> tags and branches.
>
> git svn clone file:///path/to/repo \
>        -T trunk/man-pages \
>        -b branches/*/man-pages \
>        -t tags/*/man-pages
>
> Might require a more recent git-svn version, not sure about that.

Using my current git version, this seems to produce the right result.
Thank you!  (I guess Michael's solution is essentially equivalent, but
I tried yours first.)

Thanks everyone!

Cheers,

Michael


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
=46ound a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html

From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Tue, 17 Aug 2010 21:07:29 +0400
Message-ID: <AANLkTimDx1Vg6kUaHgap6+khTmJYsxdiSDB6cb88-fnN@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
	<wesy6cgm6wd.fsf_-_@kanis.fr>
	<AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
	<westyn3n3sa.fsf@kanis.fr>
	<AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
	<weshbj1xiav.fsf@kanis.fr>
	<AANLkTimi8iS-vdO+=WHEGLQTQuBi75nVUM_eO=oYV+GU@mail.gmail.com>
	<wes4oetv31i.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Sam Vilain <sam@vilain.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-22@kanis.fr>
X-From: git-owner@vger.kernel.org Tue Aug 17 19:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPdf-0001dr-8x
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 19:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934Ab0HQRHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 13:07:32 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64565 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab0HQRHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 13:07:31 -0400
Received: by qyk9 with SMTP id 9so25530qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=wX1Q/GtVdU6OCFfhXoc3G/9wu6h7+/HixntCx/rUKBs=;
        b=VceQMIu6mYod6GzM12/ocdefGfYhR9rD54PSmbbS3xt1+6f2RZQEK0QQdek12lmLh0
         gyXtyLXQm/lX5c4yKsYYhg/IB30sT4FJ10EGnh6mAL3QCHdQSI6xt4ooPi0jyXvZZ2ct
         KkMRPC7F6IWghnOtMpV215Hp90ggnzWGQB2aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qtPYm60/+g2lLmkohQxisqLPF1bZc4zpLJekXo2bG1ZBO6XaAkfPy6o7HML7HEYZZw
         yxkeXedN6JksvxNYviovORptgjQ5HNCL2Zb+iathv+TKfJKzkwejW6FvmusB5ewUZ9Rt
         HQkjnyKWnl+/7DcuFmWMOzdIut57DwxB0lNQc=
Received: by 10.229.251.197 with SMTP id mt5mr5013170qcb.131.1282064850171;
 Tue, 17 Aug 2010 10:07:30 -0700 (PDT)
Received: by 10.229.251.3 with HTTP; Tue, 17 Aug 2010 10:07:29 -0700 (PDT)
In-Reply-To: <wes4oetv31i.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153764>

Hi Ivan,

On Tue, Aug 17, 2010 at 02:26:01PM +0200, Ivan Kanis wrote:
>
> I have ran the following command for my tests: vmstat -SM -n 60
>
> Here's the stat for one git clone, I see that 4237M of memory is
> consumed. That is roughly the size of the repository. This raises my
> first question: why is the memory not reclaimed, at the end of the run?

It is consumed by system cache to hold the last read data, and it will
hold it as long as there is enough free memory. When there is not enough
free memory, the system will free some old (long time unused) pages from
the system cache. This allows the system to avoid re-reading same files
when there is enough memory to keep them.

>
> ls -lh objects/pack/*.pack
> 4.2G objects/pack/pack-55ad6d01f37427ca69e6267b0cd4e5257e57272c.pack
>
> Is it a sensible behavior to leave a 4G file lying around?

I am not sure I understand your question. This pack contains all data
of your repository. So what did you expect to happen?

> Does it get erased when people are pushing changes in?

No, usually, push adds a new pack. However, when there are too many
packs, the garbage collector will try to repack everything in one new
pack.  You can create an empty file with the same name but with .keep
extension to preserve the specified pack from being repacked.


Dmitry

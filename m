From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Re: [BUG] git gui blame: Show History Context broken since 
	29e5573d
Date: Tue, 23 Feb 2010 00:29:03 +0100
Message-ID: <cb7bb73a1002221529r6aee3202l5b6609b59aea01fd@mail.gmail.com>
References: <vpqaav1llpn.fsf@bauges.imag.fr> <cb7bb73a1002220718p6b6621der6df062cd2f490d89@mail.gmail.com> 
	<20100222223802.GA9898@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:29:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjhiV-0004MO-Fl
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 00:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab0BVX31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 18:29:27 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:34944 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab0BVX30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 18:29:26 -0500
Received: by ewy28 with SMTP id 28so3402714ewy.28
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 15:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=l9Cr5lQt2+c7kjZY0yuqEqzCQceJtssCtb1KME2VNfA=;
        b=gvEq2T8FMr33JgYDDZ4q8Ucvf/quVb3XKo+LSF2eJK13WNCiOpb3F2o4KUWa7peusb
         Mf/NvNN40UsKLCzUYoqWi3AntMJ7/S5RiI+ji7e/H9bVa7Hfv/X4ivO+ZThFsBwTBg8i
         8o//j6pgEQkqgOAp37WJ/OYv1Z3Y5mX++Kddc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LT44PYMmf9CBeJ5zvYemn1LzQY0yumOXhRf9c8GS7QgbstB+ajM1Edc6N2yfdIBs4Q
         St+yn8UkIeB63QI4bASRd+xqZU42H2L8rx06OWGWBzaJcon2OouN56W0frLoPAb8Zbq7
         7SI3HUmrJqSoEhS6stfoCQheg6Bic7QqECQxA=
Received: by 10.213.97.83 with SMTP id k19mr9459484ebn.22.1266881363223; Mon, 
	22 Feb 2010 15:29:23 -0800 (PST)
In-Reply-To: <20100222223802.GA9898@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140739>

On Mon, Feb 22, 2010 at 11:38 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Mon, Feb 22, 2010 at 04:18:11PM +0100, Giuseppe Bilotta wrote:
>> On Mon, Feb 22, 2010 at 9:27 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> > Hi,
>> >
>> > In "git gui blame", right-clicking on the left fringe and chosing
>> > "Show History Context" in the context-menu doesn't work for me in the
>> > latest git. It says:
>> >
>> > couldn't change working directory to "": no such file or directory
>>
>> Definitely my fault. _gitworktree was not being set up correctly when
>> support for bare repositories was enabled and the repo was not bare
>> (like in the blame case). Patch incoming, can you see if it does the
>> job for you? It seems to fix it here.
>
> Isn't this the same bug as this one fixes:
>
> http://article.gmane.org/gmane.comp.version-control.git/140288
>
> cheers Heiko

Interesting, I missed that patch. However, I strongly suspect that
patch is not correct, since in that case the setup of gitworktree is
done before checking for bareness, meaning that when working in
somerepo.git (bare repo) for which the config flag is not set, it
might misdetect the situation as being in the non-bare case. I believe
my fix to be more correct in this regard.

-- 
Giuseppe "Oblomov" Bilotta

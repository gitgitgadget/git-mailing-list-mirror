From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] git-submodule should obey --quiet for subcommands
Date: Thu, 24 Sep 2009 08:34:13 +0100
Message-ID: <57518fd10909240034p668f858bh17fc20715b4838c3@mail.gmail.com>
References: <57518fd10909210946p425d275fy76362a4b2ccc0e05@mail.gmail.com> 
	<57518fd10909231433i773aff78kae6b763d0a533279@mail.gmail.com> 
	<20090924143130.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 09:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqiqe-0003ff-Ly
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 09:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbZIXHea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 03:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbZIXHea
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 03:34:30 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:48768 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbZIXHea convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Sep 2009 03:34:30 -0400
Received: by ywh4 with SMTP id 4so1663468ywh.33
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=k4UfTAwWFZ+IF5e3MAKNXS4LE/Ymlu2uQw5yJ84+MN0=;
        b=Z2D2nwkQUcatkGNQXr/YKdv9yy+Xnmu02+ihds6UuLhewHImo3Cepwuc0ELAGAa1rt
         mj+GJ5vPs/pw0Drnn9qmYQLxKKvDRrLOzPax5NYGa6tbAONgawFyvSUpA+6ex0Uten1A
         dgHvG8OhaAUJllcrSSEbNqNjdCQrKpWWoF/m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=xFsWe3RZ0LEGy9KqXRbxoPafBQOTFj+1OtTXoMFDodp6iyNnjb0nBWodMTqshvvi2I
         LsT1KDC6ZH1lDfM1VWeQJWYb8iVt9ShdRyFnb6nEvkeR1eHUYKpHw7v3bS1E2qcKPLM6
         Ipo/ew+ovoNrF9meDO/JZfAyOIrNOzz1KG/cU=
Received: by 10.150.90.15 with SMTP id n15mr6063499ybb.306.1253777673882; Thu, 
	24 Sep 2009 00:34:33 -0700 (PDT)
In-Reply-To: <20090924143130.6117@nanako3.lavabit.com>
X-Google-Sender-Auth: 250fe389c7c100e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129028>

On Thu, Sep 24, 2009 at 6:31 AM, Nanako Shiraishi <nanako3@lavabit.com>=
 wrote:
> Quoting Jonathan del Strother <maillist@steelskies.com>
>
>> No takers? =C2=A0Perhaps I should explain my interest in this patch =
: we
>> use Capistrano to deploy our Rails app which contains a bunch of
>> submodules. =C2=A0It's done over ssh, so the 'git submodule update' =
step
>> during deployment spews something along the lines of :
>>
>> Receiving objects: 0% (0/401), 1.55 MiB | 424 KiB/s
>> Receiving objects: 1% (4/401), 2.15 MiB | 612 KiB/s
>> Receiving objects: 2% (8/401), 2.90 MiB | 510 KiB/s
>> ....
>> ..
>
> Does 'git clone' itself do that to you, too, or do you see these outp=
ut on separate lines only when running 'git submodule clone'? I never u=
sed 'git submodule clone' but with 'git clone' these lines seem to over=
write one after another and they never bothered me. Could your terminal=
 emulator be broken?
>

No, git clone has the same problem when run under Capistrano, but it
obeys --quiet.

That said, I always assumed that, say, 'ssh -t myhost git clone foo'
would have the same problem (ie printing each progress update on a new
line), but I see it works correctly.  Looks like Capistrano is eating
the \r somewhere.  I still think my patch is valid, but I'll
investigate into Capistrano some more & see if I can fix it there.

Jonathan

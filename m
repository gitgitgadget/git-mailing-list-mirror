From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Massive repository corruptions
Date: Tue, 13 Jul 2010 13:59:31 -0400
Message-ID: <AANLkTimYeKr0asVE9mo8VcQEp5kdC18Wk5ykY9OFwixN@mail.gmail.com>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> 
	<20100713050350.GB29392@nibiru.local> <AANLkTimQPv5MhLo4wwVTt2LiaWxqWwoYykEbz3wBS-OY@mail.gmail.com> 
	<20100713102245.GE29392@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: weigelt@metux.de
X-From: git-owner@vger.kernel.org Tue Jul 13 20:00:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYjm9-0004hm-IR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 20:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab0GMR7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 13:59:55 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50529 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab0GMR7y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 13:59:54 -0400
Received: by yxk8 with SMTP id 8so1271610yxk.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mfuwRBPFy/m/R7ugt02AUoC61ybFeGF4klg5R/fElk8=;
        b=Gs8+QGOiSJ2alZUM8eJLElV59ZJKpf1sqDADsvCHWZWePeL6nXEZTszcFjghUu4LEF
         rL2kbPRXbjbNJw7QWznp/56v0MpxfyFSFTXl0k1MjdqvMeSXzLaTPfgPKm0icMcdsodb
         YMmFv4VLgXFSDJtFP9FR645kSmY+WPvJ77XY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=SWXA+Ss406BE+s0VrTW5YV3CH9WrVPIenobRQPFI4P8WGCxIaslHeD0QTEejDX7FAP
         31bOjCV3NmsmPWC3X8Yh6rDdWpp5VG55xw+zekRalGtMSnLZMgz6k9CoZa1MVyP8+AwZ
         oajBZWDsZZcW68qH3GT33NleitxnyISoCXYEM=
Received: by 10.150.114.10 with SMTP id m10mr7017370ybc.298.1279043991300; 
	Tue, 13 Jul 2010 10:59:51 -0700 (PDT)
Received: by 10.151.85.19 with HTTP; Tue, 13 Jul 2010 10:59:31 -0700 (PDT)
In-Reply-To: <20100713102245.GE29392@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150905>

On Tue, Jul 13, 2010 at 6:22 AM, Enrico Weigelt <weigelt@metux.de> wrot=
e:
> * Avery Pennarun <apenwarr@gmail.com> wrote:
>> On Tue, Jul 13, 2010 at 1:03 AM, Enrico Weigelt <weigelt@metux.de> w=
rote:
>> > * Avery Pennarun <apenwarr@gmail.com> wrote:
>> >> Do you know which packfiles are corrupted? =A0Does 'git index-pac=
k' on
>> >> the files reveal anything?
>> >
>> > git@blackwidow ~/metux/work.git/pack $ git index-pack pack-3b6cbd5=
dc5f54cf390cfaa479cac6a99d7401375.pack
>> > error: inflate: data stream error (incorrect data check)
>> > fatal: pack has bad object at offset 37075832: inflate returned -3
>> >
>> > (that's essentially the same git-gc says)
>>
>> What's the size of that .pack file?
>
> Somewhat over 300MB.
>
> Lowering the packfile size seemed to help.
> (but I still only can do that for git-repack, not remote transfers)

If you got corruption at offset 37,075,832 (about 37 megs) and the
pack is over 300 megs, then the file itself is corrupted right in the
middle (not truncated) and this couldn't have been caused by disk full
errors.  Either you have memory corruption problems, or disk
corruption problems, or filesystem corruption problems.  You'd better
watch out.

=46orcing the packfile size to be smaller probably just changes your
memory access patterns and moves your errors around.  But it doesn't
sound like a git bug at this point.

Avery

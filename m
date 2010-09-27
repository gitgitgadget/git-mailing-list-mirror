From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] builtin/fetch: print hash of deleted tag when updating
Date: Mon, 27 Sep 2010 09:09:19 +0200
Message-ID: <AANLkTinrx-S-6FpLAOnAVWk4gRH8sHStqDf973TZkseG@mail.gmail.com>
References: <AANLkTi=KVDRzE3-NW+GTO_CL-KtNZ+BjkErgNKMPPtGf@mail.gmail.com> <7vsk0wmbcd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:09:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P07qS-0001of-NQ
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758817Ab0I0HJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:09:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60803 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab0I0HJl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:09:41 -0400
Received: by wyb28 with SMTP id 28so3565087wyb.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LLoEr4QjCZUc4r10tTJFFmpczs+/Zs6V+q2v6MwSqgo=;
        b=MKuXLmaBhlPHGXNH7pOvWvNICSq87PV2xbLUNuUnLOgkLBv5skA0rBMD3HaWlhIBVb
         SHxWqT/4CEVkX/lw7/9bcQsKp2GjG83gpODbabSANuN93XfRAoPsOsn1L1+uQannmFBO
         hCqhUGrfo9MYv6KoNxq0E7z7Z1N+9c54dMSaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Cwt5qWt1SbthnBaHM2RfsyAnWwlInIR1bCF7lCJgPI80L2jmV8r9YCeS60AHm1RZwi
         XdCWNv1GqxvtQRITjzVJYS54fM6Rzdc5URg4C+OcDr1O6aIiR3qmN03LNkEfOltKIS8s
         +lNPansNU49vaKDPNedT52e5u7htd2uIzVV3Q=
Received: by 10.216.162.78 with SMTP id x56mr5698177wek.80.1285571379867; Mon,
 27 Sep 2010 00:09:39 -0700 (PDT)
Received: by 10.216.157.197 with HTTP; Mon, 27 Sep 2010 00:09:19 -0700 (PDT)
In-Reply-To: <7vsk0wmbcd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157309>

On Sun, Sep 26, 2010 at 11:41 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Knittl <knittl89@googlemail.com> writes:
>
>> From b1c2b07aa1f5db25ebdf190aa12ccb66a17f131a Mon Sep 17 00:00:00 20=
01
>> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
>> Date: Sun, 26 Sep 2010 11:29:16 +0200
>> Subject: [PATCH] builtin/fetch: print hash of deleted tag when updat=
ing
>>
>> `git fetch --tags` will unconditionally update (and thus overwrite)
>> existing tags, which is especially annoying for annotated and signed
>> tags.
>
> The first question is why s/he is running fetch with --tags if overwr=
iting
> is unwelcome/annoying. =A0"--tags" is meant to be used when the auto-=
follow
> behaviour of normal fetch is not sufficient and the user actively wan=
ts to
> get the latest (potentially updated) ones; would it be possible that =
you
> are solving a wrong problem?

yes, i know that tags are only overwritten with `git fetch --tags` and
not during normal fetch operations. nevertheless, manually looking at
tags and find the ones which would be overwritten is cumbersome and
errorprone.

imho this patch doesn't hurt, only adding "(was $HASH)" -- and in case
a user decides, that he suddenly wants to keep one of his (updated)
tags, he can recover them quickly by echoing the hash into
=2Egit/refs/tags/new-name-for-my-tag. otherwise the use would have to
run git fsck and find dangling hashes.

again, i'm not changing behavior of `git fetch --tags`, i'm simply
providing additional output to help you recover your own tags. case:
possibly conflicting tags and you want to 'merge' your tags with
upstream tags.

if you deem it unnecessary, ok, nothing i can do about that ;)

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!

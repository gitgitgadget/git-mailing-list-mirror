From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Why don't git-init and git-clone probe for core.ignorecase on
 Windows > XP?
Date: Mon, 24 Jan 2011 15:15:30 -0600
Message-ID: <AANLkTinGUR=ny7kg-2TUAn=p=VDs-XrVfOdYgm+uRvrP@mail.gmail.com>
References: <AANLkTimqgCsmC96fkWQJ0yB+FuyC6Xkgn3UAfZrqMqK_@mail.gmail.com>
	<7voc7s5uy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 24 22:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhTlC-0008Bt-9u
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 22:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586Ab1AXVPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jan 2011 16:15:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36778 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab1AXVPc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jan 2011 16:15:32 -0500
Received: by qwa26 with SMTP id 26so4467309qwa.19
        for <git@vger.kernel.org>; Mon, 24 Jan 2011 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KR/aINFtM8Ph8C5qdsqXrPattOzBnni8oHofvshEp3g=;
        b=OqjTxZLvQAk+ibzuiK0HAjRhWDzvcpwowtpb65OsDpRZVss8GI4wdvqGDtilLRF95h
         AUXOlnh9CZC2selM2E2kxCbxQE8W0yLu+LF1uvsKVEskRIsbbGQKlUrBK+MelViJZLzX
         XCXTK00hxMUzf7J47RGc4q8hhqddacdmPnqOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=U67in5YjpX0gkHDqxJ4uCIy7g0BV9H7HsKnzgQHRfB7Y36xLorIoCw64jUMw9mH8Nz
         Pgyy37EQ5deF3ee3WXmgUb4EkfjLuMyhaL3NRBtLSUbSU7bO4kvpNjBxey6ICh79S71y
         Gp072Q7XHuM4jUZg2XDSh5vG3d8GjulvhnA80=
Received: by 10.229.43.74 with SMTP id v10mr4155513qce.293.1295903730958; Mon,
 24 Jan 2011 13:15:30 -0800 (PST)
Received: by 10.220.191.66 with HTTP; Mon, 24 Jan 2011 13:15:30 -0800 (PST)
In-Reply-To: <7voc7s5uy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165459>

Thanks Junio, this question was due to a misunderstanding on my part:

=46or some reason, I thought "probe" in the man meant asking the user
whether core.ignorecase should be set. I vaguely recall there's
another (also Windows-related) setting that is interactively queried
like that.

=46ollowing your reply I tested with recent (1.7) installations of
msysgit and core.ignorecase is set automatically to true in
=2Egit/config for newly created / cloned repo on NTFS over Windows 7.

Thanks again and sorry for the misunderstanding, D.

On Fri, Jan 7, 2011 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Dun Peal <dunpealer@gmail.com> writes:
>
>> The git-config manpage says about core.ignorecase:
>>
>> "The default is false, except git-clone(1) or git-init(1) will probe
>> and set core.ignorecase true if appropriate when the repository is
>> created."
>>
>> I assume this is happening when you clone or init on FAT, which is
>> explicitly mentioned earlier in that section. But apparently it
>> doesn't happen for either XP, Vista or 7. While those newer releases
>> use NTFS, which technically supports case-sensitivity, the operating
>> itself still apparently doesn't, so it would seem like git-clone and
>> git-init should probe regarding the core.ignorecase on any version o=
f
>> Windows, no?
>
> Sorry, but it is unclear if you are complaining that core.ignorecase =
is
> set (but you believe it shouldn't be) or it is not set (but you belie=
ve it
> should be) on NTFS from the description.
>
> As far as I can tell from the code (I obviously only look at the plai=
n
> vanilla git, and msysgit might have some patch to this part, I dunno.=
 =A0Oh
> by the way you didn't say which version you are complaining about,
> either), we do the probing on all systems (including POSIX folks with=
 FAT
> filesystem mounted) by first creating .git/config and then checking i=
f a
> file .git/CoNfIg which we know we never created can be accessed. =A0I=
f we
> can, that means the filesystem ignores case, iow, we cannot have two =
files
> config and CoNfIg at the same time, and set core.ignorecase to true.
>

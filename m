From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git submodule: add submodules with git add -f <path>
Date: Tue, 6 Jul 2010 22:33:34 +0000
Message-ID: <AANLkTinn_Vz6I619Do4AOCVMUgfpyy84L1wh3lkuCP7R@mail.gmail.com>
References: <1278098521-5321-1-git-send-email-avarab@gmail.com>
	<1278351183-18734-1-git-send-email-avarab@gmail.com>
	<7vmxu572w5.fsf@alter.siamese.dyndns.org>
	<4C33A552.5060008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 07 00:33:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWGhx-0002rs-LY
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 00:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab0GFWdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 18:33:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56733 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab0GFWdf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 18:33:35 -0400
Received: by iwn7 with SMTP id 7so7139851iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RKXRhGFWD57C9sxxq0qFe4x+fkIGLhc99EqS6M0KVcc=;
        b=L4NYXHn45HnlWoLdJX2t7Kq9Td9MiVhmYm1Rjwg+ocZjhJknUoZf/+GYUgxzGwWHwn
         0ReUj2GpqKjQTR/UaGBbXl7kGp4B2YuNfCLgxS2KhuNlwHBLfJKpSlpPy/8tuthwWcbY
         U8a5vEeimfLtGgCgp9/fni1qVwnJjAsTpCjqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DBJ5uoHvkvZ+dGhsrc2JeR4uOPH5jpQfZ1IdPBz82cmSQ+PYIvz36KNtcMZoDA5LvD
         2uoYqjNFjQPVpPix3oRKDvAOYqcmhM08XQ2gXpvHVcDoJ/LDgo0wnO2Zuz2L2ngfSG5C
         IsXmo6dSD/0rKmGmRCe/RnXqNzESSDQqZwWCw=
Received: by 10.231.118.28 with SMTP id t28mr5003730ibq.131.1278455614777; 
	Tue, 06 Jul 2010 15:33:34 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 6 Jul 2010 15:33:34 -0700 (PDT)
In-Reply-To: <4C33A552.5060008@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150414>

On Tue, Jul 6, 2010 at 21:51, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> [...]
> But while I think adding the --force option to the "git add .gitmodul=
es"
> makes perfect sense (as the submodule can't be successfully added unt=
il
> it is recorded in this file and there is really no point in ignoring
> .gitmodules when you decide to use submodules), I'm not so sure about
> what to do when the submodule path itself is ignored.
>
> I see two possible behaviors here:
>
> a) We just ignore .gitignore and add the submodule anyways (which is
> =C2=A0 what this patch does)
>
> b) We do the same a "git add <ignored file>" does: Print an error
> =C2=A0 message, maybe even tell the user to use a - still to be added=
 -
> =C2=A0 "--force" (or "-f") option and exit. But without checking out =
the
> =C2=A0 submodule first nor adding or changing .gitmodules.
>
> IMHO b) is more consistent with the current behavior of "git add". An=
d
> when you later decide that the submodules files should live in the
> superproject and you drop the submodule, the then probably still
> present entry in .gitignore might really shoot you in the foot when
> you add new files there and they won't show up because they are still
> ignored.
>
> What do others think?

Option C would be treating it like git init as the current patch
does. But init isn't strictly comparable to git add or git submodule
add since it's not adding something to *another* repository.

I really don't care, B or C works for me, although C is of course
easier since I don't have to write another patch :)

Option b) is more consistent with git-add, but I can't find a way to
ask any git tool whether a non-existing path is ignored without
actually adding something. git add --dry-run will die on "pathspec
'foo' did not match any files" unless the file exists already.

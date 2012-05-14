From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and index-pack
Date: Mon, 14 May 2012 16:09:17 +0700
Message-ID: <CACsJy8DxoRHYnBvJn7P9dS1A0Y88Bm0ur1meWCUBp09UEfuOgg@mail.gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.02.1205121326380.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon May 14 11:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STrHu-0002mT-9d
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 11:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab2ENJJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 05:09:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44703 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab2ENJJs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 05:09:48 -0400
Received: by wgbdr13 with SMTP id dr13so4434486wgb.1
        for <git@vger.kernel.org>; Mon, 14 May 2012 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=S7HvrbeZyze0CZw14ofa0Zq9NcuJpahDofbBmMGMkRI=;
        b=sqTI84N/jHwH3GVwSrgSgbRlyKrEBkBEoqIHONcMMuUZwYaJc/eo75w/g8aROlRY4k
         JjQoDR8WyKpFoH+FQdaO2aJ6DvE12kxHOYzgky8Daw/MbxTJTJ/bqtqcNpoxCu4iEZsl
         lH0LtfLUlQcPF/92sqtSV+7RQxPKIR7sJ9/FwuPQfuDU5WvII/KI/5qLyR4vqsjJDh4f
         Pyfsid5rX07e4YPNtMybozhnhtTbXGImIYSgB+Tw9IyPUaIr/PaU+C+AltNAKdLQ8vA4
         ufJ/htruOMSxE7Un3U5RAySGqgUA7xLWjdiZB6MSa1kdsR+bgIw3AUqFJcpNew954PZW
         u9Sg==
Received: by 10.216.142.38 with SMTP id h38mr4626862wej.54.1336986587809; Mon,
 14 May 2012 02:09:47 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Mon, 14 May 2012 02:09:17 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1205121326380.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197765>

On Sun, May 13, 2012 at 12:36 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Sat, 12 May 2012, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> A few attempts have been made in the past to change 'gc --auto' [1]
>> [2]. This is another such attempt.
>>
>> Commit d4bb43e (Invoke "git gc --auto" from commit, merge, am and
>> rebase. - 2007-09-05) used the rule to put "gc --auto" is "where
>> update-ref occurs". I would argue that this is not a good condition =
to
>> run gc, because (at least current) gc is slow. We encourage commit
>> often and rebase to make all patches in good shape and this workflow
>> should not be interrupted/slowed down by random "gc --auto".
>>
>> Instead, we could just inform users that "gc" should be run soon in
>> commonly used commands (this patch also reinstates "gc" check in
>> commit, which was lost at the sh->C conversion). [1] and [2] can ann=
oy
>> users constantly with warnings. This patch shows the warning at most
>> once a day.
>
> I agree with this. =C2=A0However don't bother making this once a day.=
 =C2=A0There
> is no harm in warning every time. =C2=A0Referring to the man page as =
git
> --auto does when it actually meets its treshold wouldn't be a bad thi=
ng
> either as incidentally that would contain the info to get rid of the
> warning.

I'm good with always warning too. The moment it shows up, I can just
open another terminal for "gc". Though (I guess) a new user in the
middle of the work may not want to do that as they fear "gc" may
interfere their work. Then the warning becomes a constant annoyance
(and maybe forgotten after they're used to seeing the warning).

If everybody's good with always warning, I'll make a new patch.
--=20
Duy

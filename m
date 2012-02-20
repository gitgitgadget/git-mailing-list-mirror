From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2] Document format of basic Git objects
Date: Mon, 20 Feb 2012 20:55:28 +0700
Message-ID: <CACsJy8CEeZPf55idLB9NE-rf--ySmZh_9gkMc_zo0VmiVftMUg@mail.gmail.com>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
 <1329624946-32173-1-git-send-email-pclouds@gmail.com> <7vlinzp67m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 14:56:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzTiy-0006gd-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 14:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591Ab2BTN4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 08:56:00 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34621 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab2BTNz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 08:55:59 -0500
Received: by werb13 with SMTP id b13so3175671wer.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 05:55:58 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.134 as permitted sender) client-ip=10.216.134.134;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.134 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.134])
        by 10.216.134.134 with SMTP id s6mr4392132wei.27.1329746158281 (num_hops = 1);
        Mon, 20 Feb 2012 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cQiQZcYyCxmKrXyksV4OLiBJFiapH702yH1Ecy+rEng=;
        b=xb8819h+vwI9WaNZ9jjHTlYV0XBocZRawgtFKeU8bVm5JMCwyEay34FnjX0ORmgGPA
         cv65Hskgm/xtBckWvEiRyv/sCwk+SAbTGISb0Ks8AOw+TsBxCN1STpvRoL4jBxmt2W9c
         VFWwRFgS+M30sngr89lS0UMEz8Sk6aslYOJXU=
Received: by 10.216.134.134 with SMTP id s6mr3625436wei.27.1329746158219; Mon,
 20 Feb 2012 05:55:58 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Mon, 20 Feb 2012 05:55:28 -0800 (PST)
In-Reply-To: <7vlinzp67m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191067>

2012/2/19 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0- Do we assume tag/commit header in utf-8 or ascii?
>
> Author-ident is typically utf-8 already, so you cannot assume "ASCII"=
=2E

I wonder if anyone puts non utf-8 strings in there, or could we
enforce utf-8 (i.e. validate and reject non utf-8 strings) and accept
encoded word syntax (rfc 2047) with the help of the new
$GIT_IDENT_ENCODING variable. The "accept ..." part can wait until
someone is hit by "utf-8 only" check and steps up.

By the same reasoning, maybe we should declare tag content is utf-8
only, until someone needs and adds "encoding" support for it.

>> +The filename may be an arbitrary nonempty string of bytes, as long =
as
>> +it contains no '/' or NUL character.
>
> s/, as long as it contains no/; it cannot contain any/

Pathname also cannot be "." nor "..", I suppose.
Since we also support Windows, should '\\' be banned too? ... probably
not worth it.

>> +The header must not contain NUL.
>
> I vaguely recall that you made sure neither the header nor the body
> contains NUL.

One of the purposes of this document is to note all constraints and
limitations (another one is a reference for users who want to dig deep
in git data structure without looking at the code). The problem with
handling NUL probably only exists in C Git (and maybe libgit2). I'll
turn that to "should not contain NUL".
--=20
Duy

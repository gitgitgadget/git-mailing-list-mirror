From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git ignore help
Date: Tue, 24 Mar 2015 20:11:12 +0700
Message-ID: <CACsJy8CY20niCrFYq04KHxS-8xsWdGWcr_vLBvcphcSznbJzFw@mail.gmail.com>
References: <CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
 <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz> <CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
 <CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
 <CACsJy8DDC2FbKnu7o1cJR6F6Lh-NabaYtMYOKbm0xbn8PuKoEg@mail.gmail.com> <1PE.3lxh4.2cruo5kZ0hh.1L4LoZ@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: mdconf@seznam.cz
X-From: git-owner@vger.kernel.org Tue Mar 24 14:12:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaOcW-0007lM-2d
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 14:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbbCXNLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 09:11:43 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35046 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbbCXNLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 09:11:42 -0400
Received: by igcau2 with SMTP id au2so71048208igc.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8+4d+IiaioHTscSbw+C4xvKA1FoBlsOFEJ5f+vIPJW8=;
        b=Z+b1i+c+duYai4u4A6DPmOouyLlCFfY6oxEht25NhyAzgLG9mfkhSRtYJrHokB7MC3
         C6ethC61Sc8Jg6rWWxSZ5VIezo2+MptT8i/joqBOjFxCobmR2CGcLzdRGJJ37TAkeTdl
         WKOEsFadx9elfB05hYmDjYSjuGX1W2ZNOJ2QZwijkPeZ/lDnu12PQy8Du2/r+WaL+NwA
         n+afRlAEBwtsLPDZNY9o7rLSiZRrrhYqKntnxPvQJ9xW9s6ZszLC90y8VkgcU4wfCt0Z
         WUhgzglo3q7ZzNxCwDXhf0xz2fkNl/BCSixwV9lHIJsTulzuSMn6irv91Zaw35aQrupA
         xVHg==
X-Received: by 10.50.122.5 with SMTP id lo5mr21903584igb.37.1427202702249;
 Tue, 24 Mar 2015 06:11:42 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Tue, 24 Mar 2015 06:11:12 -0700 (PDT)
In-Reply-To: <1PE.3lxh4.2cruo5kZ0hh.1L4LoZ@seznam.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266186>

On Tue, Mar 24, 2015 at 7:46 PM,  <mdconf@seznam.cz> wrote:
> Duy, you wrote:
>
> "This is true. To elaborate, if we have to recurse in excluded directories so that we can include some back, then the reason for excluding is already defeated as we may need to traverse the entire directory structure. However in this particular case where we do know in advance that only certain directories may have "re-include" rules, e.g. "db", "reports" or "scripts", we could keep going for a while."
>
> ... so according to that it sounds like including /db, /reports, /scripts should actually also NOT work. But it does work - i.e. when I add the following:
>
> # exclude
> /*
>
> # except
> !/db
> !/reports
> !/scripts
>
> then any content within those 3 directories (and their sub directories) is included and not ignored...
>
> It ONLY does not work when I add more levels - e.g.:
>
> !/reports/something
>
> In this case neither /reports nor /reports/something or any sub directory is included.

Yes. It's the subtlety of optimizing ;-) If you read the man page
really carefully (*), "if the _parent_ directory of that file(**) is
excluded" and the parent of these three directories is _not_ excluded.

(*) I'm not saying this is a good thing. Only docs such as language
spec or RFCs need that level of attention. But I'm not a good document
writer myself, can't blame others. Improvements are welcome though.

(**) "that file" should be "that file or directory" but I guess
simplification here is ok
-- 
Duy

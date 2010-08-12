From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 06:43:25 -0600
Message-ID: <AANLkTikWnVKxdUcuNHLet20HOuBuzdF9C5fOOtVaY5p8@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 14:43:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjX8I-000193-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 14:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab0HLMn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 08:43:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59047 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab0HLMn1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 08:43:27 -0400
Received: by fxm13 with SMTP id 13so671982fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1ngQAQ2cY3sBuUZ+s28JJGxzRWvc61UmKDTey9PmdAw=;
        b=GdPQPaxCUhlT5XM24pd178vJBuzcN12qveSW5L5plHb55zEdBeJCsONY9CbrvXvL4U
         ks00ItW23h5a0LWzDVD4EEMeDf/5NnPmVmNJhuPhbzzhf6JhPPByWpNIAI1QFuo8tMYV
         uaGWyeIEiwFrk1YR1KWe/4lcc0TJZ98EHbuUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CaCOpZgj7fbkEvTBViQ7diTbRKsnlnrmqamBJs/lcTwxWilYhaTu7bipJ/gNBcroHZ
         y7uT/ww94l/HBJ043wxUp6zJDTfv0RcxM3ubxbaCO1+qSTfFxzxYMAQzWGEf8xqa2OGF
         2ssG0fGMiu4UqlkRJ3zU6ubqXHkGu4sJfPKyU=
Received: by 10.223.111.200 with SMTP id t8mr132295fap.31.1281617005797; Thu,
 12 Aug 2010 05:43:25 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Thu, 12 Aug 2010 05:43:25 -0700 (PDT)
In-Reply-To: <4C63BD9B.6000608@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153370>

On Thu, Aug 12, 2010 at 3:23 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> [Sorry for the Cc spam; I lack the time to conduct individual message=
s.]
>
> I compiled many topics in pu and ran the test suite on Windows,
> particularly those that "look good" and "will merge to next". Here's =
a report.
>
> Today's next produces this warning:
>
> merge-recursive.c: In function 'process_df_entry':
> merge-recursive.c:1246: warning: unused variable 'o_sha'
>
> (line number may be different) because o_sha is only used inside asse=
rt().
> I don't know how you would like this fixed.

This is caused by en/d-f-conflict-fix.  I could remove the definition
of o_sha and the corresponding assert, or (my preference) just add a
simple null statement:
   (void)o_sha;
What would others prefer?

> Am 8/12/2010 1:35, schrieb Junio C Hamano:
>> * en/rebase-against-rebase-fix (2010-08-06) 2 commits
>> =C2=A0- pull --rebase: Avoid spurious conflicts and reapplying unnec=
essary patches
>> =C2=A0- t5520-pull: Add testcases showing spurious conflicts from gi=
t pull --rebase
>
> This should not use "sed -i" in the test suite.

Already fixed in v4 sent out last night (and was fixed in v3 that
Junio commented on, but for some reason he merged v1 instead).

>> * en/d-f-conflict-fix (2010-07-27) 7 commits
>> =C2=A0 (merged to 'next' on 2010-08-03 at 7f78604)
>> =C2=A0+ t/t6035-merge-dir-to-symlink.sh: Remove TODO on passing test
>> =C2=A0+ fast-import: Improve robustness when D->F changes provided i=
n wrong order
>> =C2=A0+ fast-export: Fix output order of D/F changes
>> =C2=A0+ merge_recursive: Fix renames across paths below D/F conflict=
s
>> =C2=A0+ merge-recursive: Fix D/F conflicts
>> =C2=A0+ Add a rename + D/F conflict testcase
>> =C2=A0+ Add additional testcases for D/F conflicts
>
> The new tests in t/t3509-cherry-pick-merge-df.sh and t9350-fast-expor=
t.sh
> need SYMLINKS prerequisite.

I'll fix them up.  Sorry for being less familiar with the rules, but
since these are in next, do I resend the series or just the new fixes?

Thanks,
Elijah

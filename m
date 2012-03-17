From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: print list of valid tools with '--tool-help'
Date: Fri, 16 Mar 2012 20:31:07 -0700
Message-ID: <CAJDDKr4bevWPjvQVLiWYm_6LxiHObms+i2QfeKKJB2g4eF6RnA@mail.gmail.com>
References: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com>
	<7vk42lijfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 17 04:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8kMO-0001wJ-2L
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 04:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819Ab2CQDbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Mar 2012 23:31:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60785 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab2CQDbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Mar 2012 23:31:08 -0400
Received: by yhmm54 with SMTP id m54so4854736yhm.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 20:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JniEr4LLDRz0ZrC0XgqwZzi3y0grQDGmDI3Iana/7fs=;
        b=taZz5/j/MIAOJPpx3flSuYk7hgfCCudSjHp3dYxxLsz7BUkMEvLNf4RnbFerMisb3D
         yqrTrutV3okVuZ0tg/GhH4frH6PXdEKF81MdSUq1V+x1jyFF3QUqtp1oxIx/srrescWr
         6YAbQ39Q5OJTpjaLj6dv3p3NDrVl2mH7ktN6QfgxLP3R4MdaZvBgC82VnrHCvf8toJYV
         fpwCzHh7vSEJJxPnOQyuOmfKuFzwX8zu3xBqkP5EZ5Low3plnC1HJnfqThTnkp4EH0nn
         W5fw8PsjSKgHMRzF2FBq+ofOwXrzGi+O0V6KRrQfKGa8cc7tESSkPLFlz8soCHRpIfCC
         AwaA==
Received: by 10.236.138.110 with SMTP id z74mr4856537yhi.114.1331955067509;
 Fri, 16 Mar 2012 20:31:07 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Fri, 16 Mar 2012 20:31:07 -0700 (PDT)
In-Reply-To: <7vk42lijfu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193304>

On Thu, Mar 15, 2012 at 3:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> @@ -100,6 +101,15 @@ sub generate_command
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($arg eq '-h') {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 usage();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ($arg eq '--tool-help=
') {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 my $gitpath =3D Git::exec_path();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 print "'git difftool --tool=3D<tool>' may be set to one of the foll=
owing:\n";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for (glob "$gitpath/mergetools/*") {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 next if /defaults$/;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print "\t" . basename($_) . "\n";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 exit(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> I know the call to usage() against "-h" has the same issue, but I thi=
nk
> people find it offensive when they ask for help and the command repor=
ts a
> failure with a non-zero exit code.
>
> Other than that, looks good from a cursory look. =C2=A0Davidd, any co=
mments?


I agree that the rework to make -h return 0 is sensible.  I also think
the `cando()` suggestion later in this thread is the way to go.

Thanks guys,
--=20
David

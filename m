From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Wed, 18 Apr 2012 01:19:12 +0300
Message-ID: <CAMP44s20UL4G7=Q=mhGf4coZm0CmZnLSDsKHfco8r2V8MiCYZw@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<20120416221531.GA2299@goldbirke>
	<CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
	<7vty0inys6.fsf@alter.siamese.dyndns.org>
	<CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com>
	<7v4nsins1j.fsf@alter.siamese.dyndns.org>
	<CAMP44s0w40ViecQsF8AeQLLxAEShC54TTyvcPVMabpOZ+DYDqQ@mail.gmail.com>
	<20120417221444.GD10081@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:19:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGk5-0003a9-4M
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab2DQWTP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 18:19:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2DQWTN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 18:19:13 -0400
Received: by eaaq12 with SMTP id q12so1712332eaa.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KOFfMriEF4zVjq9Yq/t8OJ3LBARLKCZAlnvZnGDUBho=;
        b=juoqspAnp+7ccxvYC0IBIorOSv27BYNUMK48y4pvFzAIpVjONO2116+v9VHflo1w17
         MhYTDVN/eIcDs2BUCeDXbGWUd8dSuvY8ha1tGniJOH+VYxfC6AU4mROjx9JegwSewD65
         DneRB/9MDBwJ0Qtm+OXfFnPy8htq88WnNrgnEXCMXeKBIjsSBSFxxHHkaIlzYCct19Xh
         gyR8n3QsMfrU/vDLsJ8EyVsZeZn9VABP+TjJYIyIZDjQC4AwPSa2IW1hwnagUjYpmNuP
         p8x2StHM0rb1V33FfSKWiRvxDPIHql9ljH6LQx3fcvy51fC6n9dM9ZT5RAza+syaGmoy
         vPHQ==
Received: by 10.213.19.138 with SMTP id a10mr21982ebb.259.1334701152375; Tue,
 17 Apr 2012 15:19:12 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Tue, 17 Apr 2012 15:19:12 -0700 (PDT)
In-Reply-To: <20120417221444.GD10081@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195820>

2012/4/18 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Tue, Apr 17, 2012 at 11:53:08PM +0300, Felipe Contreras wrote:
>> Are you saying that even if there are no real clashes, only
>> hypothetical ones, you would still prefer __git_complete?
>
> Can you ascertain that there are no real clashes?

After having this code for a certain amount of time, yeah:

if ! type git_complete >/dev/null 2>&1; then
git_complete ()
{
       echo "WARNING: This function is not meant for public use; the na=
me" \
               "might change. Use __git_complete for now."
       __git_complete "$@"
}
else
type git_complete | grep -q "WARNING" ||
echo "git_complete is already being used, please notify
git@vger.kernel.org, to" \
       "avoid overriding this function in the future."
fi

>> How are people going to distinguish between public and private funct=
ions?
>
> By reading the documentation, perhaps? =C2=A0It was not a problem for
> __git_ps1(), so I guess it won't be a problem for __git_complete()
> either. =C2=A0Assuming that it will be documented eventually, of cour=
se.

I guess that would do it. I would still prefer to have a different
convention for public functions. I feel we are being paranoid here.

Cheers.

--=20
=46elipe Contreras

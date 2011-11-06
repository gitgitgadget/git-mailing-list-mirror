From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: do not refer to non-existing marks
Date: Sun, 6 Nov 2011 20:40:51 +0100
Message-ID: <CAGdFq_i=f+ZD7pdN0D-hFBeq6TejXtt15Rb07UDViv1=nnXkmg@mail.gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-3-git-send-email-srabbelier@gmail.com> <20111106044514.GN27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 20:41:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN8b3-0003PE-PF
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 20:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab1KFTld convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 14:41:33 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55576 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1KFTlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 14:41:32 -0500
Received: by ywf7 with SMTP id 7so4480057ywf.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 11:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i1dNixx25ZhZMSANRVccS850/AELd9HOF+/DndtM9y4=;
        b=Is+3EFGZNB7r+tnLvWduPG/NkjDFjaJ10yD6f9Xjm1EAM0mSbBL+OIqiQcRMXd/NWR
         Q36v4BInxNt4DbJq47oRogFkFz/tpCGIQwFA02fzxWYyAKNQ3vg3K/0UYaGm2S01E2mC
         8kPVc9+7awXzTBWTrObF8mL4Dh4ZF01QoZftE=
Received: by 10.182.45.102 with SMTP id l6mr2265978obm.0.1320608492296; Sun,
 06 Nov 2011 11:41:32 -0800 (PST)
Received: by 10.182.52.3 with HTTP; Sun, 6 Nov 2011 11:40:51 -0800 (PST)
In-Reply-To: <20111106044514.GN27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184927>

Heya,

On Sun, Nov 6, 2011 at 05:45, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> Extract a handle_reset function that deals with this, which can then
>> be re-used in a later commit.
>
> So, does this patch drop the confusing behavior and add one that is
> more intuitive for remote helpers? =C2=A0It's not clear from this
> description what sort of deal the patch makes and whether it is a goo=
d
> or bad one.

Ah, yes. Perhaps something like:

"Extract a reset_ref function that deals with this situation by
printing the commit sha1 when no mark has been written yet."

> Ah --- the functional change is to use a sha1 when there is no mark
> corresponding to the object.
>
> Why is this codepath being run at all when b is excluded by the
> revision range (a..a a =3D ^a a a)? =C2=A0Is this the same bug tested
> for in patch 1/3 or something separate?

I must admit that I don't recall how exactly we stumbled on this case.
It might even make sense to instead die when we run into this corner
case, but I'm not convinced that there's no valid use case for this
(which we would block by die-ing).

--=20
Cheers,

Sverre Rabbelier

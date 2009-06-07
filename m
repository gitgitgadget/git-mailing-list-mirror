From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/2] git-send-email.perl: improve detection of MIME 
	encoded-words
Date: Sun, 7 Jun 2009 11:45:35 -0500
Message-ID: <ee63ef30906070945g62e94313r8b2a7128bde16f9d@mail.gmail.com>
References: <1244337151-6506-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 18:45:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLVB-0004Nx-BP
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 18:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbZFGQpg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 12:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbZFGQpf
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 12:45:35 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:48132 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbZFGQpe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 12:45:34 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1716300qwd.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1S1DkYA3VIMdV4axl2+S8cbau7S4mAVExnUgnVmelhI=;
        b=mzClWLuQH+Nm9KF9P918zkW8IFU1AUzmKT5vyOWQDdx3R+VpPLLgqRfovHQeQCeF2C
         aunHn5wilJ1t20BleJ89v4gZ9af3Z3LsdEmwqj6uwKa91AGhf5kEfe9oG56Fh2OwGGxt
         TiTB1bUubL5GQLOP0NWrcZZ69UHfCbV/BnrbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lwThObnWaePHMlatWYeXb0atVPB4h6w99Mw/z7bEGBoBQ/KPU76uBd5K9HxNUhkAEy
         xy2LVR1WiB2SimerAoE/zSSC0SjM9ffKl0ZnJO4dHH7K5/5xjk9pRxCBsNXpj8QFMVPU
         caOXoUF3zws6EfrKSYzyLuHoTtipoKeKa19YI=
Received: by 10.220.85.198 with SMTP id p6mr3133215vcl.48.1244393135923; Sun, 
	07 Jun 2009 09:45:35 -0700 (PDT)
In-Reply-To: <1244337151-6506-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120981>

On Sat, Jun 6, 2009 at 8:12 PM, Brandon Casey <drafnel@gmail.com> wrote=
:

> =C2=A0git-send-email.perl | =C2=A0 10 +++++++++-
> =C2=A01 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3d6a982..e735815 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -772,6 +772,14 @@ sub quote_rfc2047 {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return $_;
> =C2=A0}
>
> +sub is_rfc2047_quoted {
> + =C2=A0 =C2=A0 =C2=A0 my $s =3D shift;
> + =C2=A0 =C2=A0 =C2=A0 my $token =3D '[^][()<>@,;:"\/?.=3D \000-\037\=
177]+';

The last element of this regex should be changed to \177-\377 since
non-ascii characters are disallowed too.

I won't be able to send a new patch for a while.  Home internet is
down at the moment, and I don't have an alternative right now.

-brandon

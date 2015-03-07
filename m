From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/24] untracked cache: save to an index extension
Date: Sat, 7 Mar 2015 11:08:10 -0800
Message-ID: <CAGZ79kbM4aeGibZi0cpP69KHoObkEKcRnLBF8ZvhvbfRmDCcLA@mail.gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
	<1423385748-19825-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 20:08:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUK5B-00046G-3q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 20:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbbCGTIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2015 14:08:13 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42841 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbCGTIL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2015 14:08:11 -0500
Received: by iecvy18 with SMTP id vy18so29598660iec.9
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 11:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=scvZd2+lwFGjBH+lqX/vShFveBD1/XPCw1u5gTrBVag=;
        b=cNWSQsyjqd/k0U4umrawVFyg8aedNlGNfVnnke+oEc/7Ai1jUl+nJpylsKFMt7umEs
         CaHD3DtllCQg3ZULN8t5SZyx5EHyTJsN11qpC7Ou+lmervAvdVrvtdtMhLrdzycNFl+7
         GOYggTLRdPb5gDkpd/uB995r3yp3m9sTZOpPW0v/W9PgP66ijpGUp5+/cvg2kgAPmPcB
         Xd3yNoRnPL1sLuKtFYqffjEInDMAohqLt24xnWxklguFAGZtjARWlCckV9rNJsvQp6JB
         m5uT+vLFTaaVSA9IIENI1fPtAKVrff5Del1N1v2dZVFGm0wwevJu0sG5EzjAkomR0uON
         Wqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=scvZd2+lwFGjBH+lqX/vShFveBD1/XPCw1u5gTrBVag=;
        b=mdJxoBZgx2Qha7Y1MiCow/GnOs1fis61J8PlkEbDQ0Ww68Dy7Q/TznH+H7Ixi1AIow
         UBxWdL/PjXFUyMi/A0IQnQpQ0D4RPPvewwGllz7Un6aF1stGLUtVmzPB/OwuKA61s5fm
         5d905RzqaZsekJ48xNvD3ALDj/mpn5J8t7PQBC6pfc23OGtS1XrsshHCyxdbUxeotCRf
         FqA+tI+htyo/bAcMDsXROxuK2hmUNeNzU+1e07eedS/aykyE1zS/s9Ud369ItHnnXFoH
         iFqrvT0YIkmLRlW2Q9FQXyVEx722qX0umZCBVq3377NcoI1eRsZU4qcK5O+/qT5zHVL1
         SbAA==
X-Gm-Message-State: ALoCoQk6itDvjoebXTxfPemEQ5hqO1XWNW47pgtUKsaXDxXWnDW8KkAL0kfZCSC78E4jJeNc2d3k
X-Received: by 10.50.254.4 with SMTP id ae4mr36057573igd.10.1425755290764;
 Sat, 07 Mar 2015 11:08:10 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Sat, 7 Mar 2015 11:08:10 -0800 (PST)
In-Reply-To: <1423385748-19825-11-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265002>

On Sun, Feb 8, 2015 at 12:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> +       ouc =3D xmalloc(sizeof(*ouc) + len + 1);

Do we need to free `ouc` at the end of the function as well?

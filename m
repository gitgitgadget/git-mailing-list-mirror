From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/4] fetch-pack: prepare updated shallow file before
 fetching the pack
Date: Fri, 3 May 2013 08:37:40 -0400
Message-ID: <CAPig+cR=Vqj_XjsyHg649Dpjh_VHd8NRU8TMvjFM1w_Au1_-=g@mail.gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-1-git-send-email-pclouds@gmail.com>
	<1367584514-19806-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 14:37:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFFE-00052Z-9C
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761764Ab3ECMhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 08:37:43 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:40269 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758175Ab3ECMhm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 May 2013 08:37:42 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so1475151lab.14
        for <git@vger.kernel.org>; Fri, 03 May 2013 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l7iMki6WtoUrIrRC+6f67yd805QmkAzE5JH/nAxfKYc=;
        b=Oq4BUoqywxUnQnrSoRVn9nydGV61NdjHZvOkwrg2RJ6KVQStgnc0CFaKbedDlS/fft
         czfsYEIffcZm/C5Mmt6vvduYHuJ98oxblm2VVW30KWfakGu7g+DBUb6e+QGheI+BQSG5
         0CXs4gJ/L11GyvtlH3UWyZCgQVQuarez7h86hE83vsLlGa0YF/epaKFG2QIyPN1zs6ih
         8Lpcszxf2COObLbjloPIRduWkCfKfOtDXhpPj4NRopZFxGpCQTpMSLG1LTN8vtrwzpsH
         e0XYi3OiyEm+tltqQCfm2sb+uEr6eF2Tg1yrnQ0cdurxzERLcFMendd6BBkRedp/0iaw
         iJ8A==
X-Received: by 10.112.130.40 with SMTP id ob8mr4212338lbb.55.1367584660711;
 Fri, 03 May 2013 05:37:40 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Fri, 3 May 2013 05:37:40 -0700 (PDT)
In-Reply-To: <1367584514-19806-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: cHSHETKPrpRnYYymOf0JMdKoLOk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223309>

On Fri, May 3, 2013 at 8:35 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> index-pack --strict looks up and follows parent commits. If shallow
> information is not ready by the time index-pack is run, index-pack ma=
y
> be lead to non-existent objects. Make fetch-pack save shallow file to

s/lead/led/

> disk before invoking index-pack.
>
> git learns new global option --shallow-file to pass on the alternate
> shallow file path. Undocumented (and not even support --shallow-file=3D
> syntax) because it's unlikely to be used again elsewhere.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

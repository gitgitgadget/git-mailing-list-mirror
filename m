From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 02/11] upload-pack: only accept capabilities on the first "want" line
Date: Tue, 26 May 2015 15:17:33 -0700
Message-ID: <xmqqa8wrj85e.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 00:17:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxNAL-0001Ja-Np
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbbEZWRh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 18:17:37 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33455 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbbEZWRg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:17:36 -0400
Received: by iebgx4 with SMTP id gx4so332217ieb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Ae4Ai32byL+mzU9zTqxbH95Srs7fNXhMI4dlt3nHv44=;
        b=qZF66EqxDsvMAm4DQaeTox0yVdKl8Dp6L9rrPaIqdBClOIhQY2g2/fzdyNYf+mJPes
         gynXEi3xZ8j+8P8btX94iOwYru+P1cLO0NKJBqfErO82gp/qodkFfH4dnbPnycSDdRtK
         MPXjUzF3GwNx/0Gf62nHQdYwsNR3KZgCxUPitd9TkgDe3HM5XldigJklDGkyqVT3kYw1
         xDya9aOdcXeAN06p+em3L6GJqJ1fe5AGoUoi69pguhR8ZG5ZFzlUEr4h9Xgda5Qx36lq
         ehju2e8KX+xsfHctC+JOI+YFmozB+9g/V/FFkhRNLH2mhHs5yqgUGo/8PKlNtBuGz6yk
         lQHg==
X-Received: by 10.42.15.20 with SMTP id j20mr26289325ica.16.1432678655507;
        Tue, 26 May 2015 15:17:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id k16sm335768igf.19.2015.05.26.15.17.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:17:34 -0700 (PDT)
In-Reply-To: <1432677675-5118-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 May 2015 15:01:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269999>

Stefan Beller <sbeller@google.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> pack-protocol.txt says so and fetch-pack also follows it even though
> upload-pack is a bit lax. Fix it.

Hmm, I actually think the .txt file unsuccessfully tried to close
the barn door after horse has long left.  The existing clients that
read protocol capabilities keep the last-read copy and then
overwrite it when a new one came, which is why we couldn't update
the protocol by sending only incremental changes, etc. without
breaking existing clients.

I somehow thought that we already discussed why this was bad the
first time Duy's patch was posted, but apparently we didn't.

X-<.

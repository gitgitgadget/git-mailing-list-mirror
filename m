From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 1/2] builtin/apply: add 'lock_file' pointer into
 'struct apply_state'
Date: Fri, 3 Jun 2016 19:23:06 +0200
Message-ID: <CAP8UFD1Br15+TtD2kVOyeRExFJsDx3k4PD1Ab-xJaAhUHVbPXw@mail.gmail.com>
References: <20160603165852.12399-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:23:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8soU-0006tu-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbcFCRXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 13:23:10 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34627 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbcFCRXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:23:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id z87so10986790wmh.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KSYmfF+O13yt475Df+yGGAtITG50bblqXF2fp9AsGYU=;
        b=GqJqobg5mhWzcCOBIf2HE7UFtGf8Y3uX2DYaTxuFVNPhcJ439jlcbTdUeRy5Pw8/4c
         F387dhu40u1o9EQ8DRnGodO8zU6HYaQhBlhsYSugJitJNtKlQ839VBZGcmoMbzPHAbDp
         BOUiu0mGp2AtL3zjI7gv+vZIil7y08KNB3Rb1GbHqNLm9H4i7vfpMOUhsRooaHnlhYgc
         zqPhyT99F/r22D+ysRqoHNLyAX68Tce5wtxGCyegKeA3moSZ2jenPBLDBO+j7w2N44rQ
         kxsA/iYKYEdid2aWG1+pBsmvRSLlFn4peJlxwpBXwHYZTRwHrqLapZLEuoS0lCv5tTxg
         9JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KSYmfF+O13yt475Df+yGGAtITG50bblqXF2fp9AsGYU=;
        b=MYW+O2vDcyPwImsdO9KlvusZ0/AshHHfFzV9TwJpElYggRExaAercg7FYZ9OvvGbNs
         t2l1/NH/yjH9bBNdwoo771TWow/E3FeJAQx3K54HLUIJVKZ7A4oC6rvfI+LsamoGPj8b
         OLWVBu9ahuqQq77bwEr2UNaCiGyKZCcD2mzzMa7dH12CGSwqhM+9yODmTqby/DNItBGV
         H/VW4cBJs3uNMdIjrvu7n7WiwJ3InRyFc5kp0NPJPZHR2WOsfVnZXJb7fqo2HyYFTfwY
         XpzR8n6c0faRVZX+A0UZgtEvrbqqXDoutbCXFHgR2PxVR6P+j9hz1oyPduXg6ptRKmMo
         rJDQ==
X-Gm-Message-State: ALyK8tJaove0TDRExe9ApaOAkdcgIGejUTMccMNS5eBLIIFOn646RXsKa5YdCS/WhiZjMiranFVjxDsbKtgMBw==
X-Received: by 10.28.98.215 with SMTP id w206mr495615wmb.79.1464974587663;
 Fri, 03 Jun 2016 10:23:07 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Fri, 3 Jun 2016 10:23:06 -0700 (PDT)
In-Reply-To: <20160603165852.12399-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296356>

On Fri, Jun 3, 2016 at 6:58 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> From: Christian Couder <christian.couder@gmail.com>

Sorry for this spurious "From:" line.
It looks like send-email added it, and I don't understand why it does it now.

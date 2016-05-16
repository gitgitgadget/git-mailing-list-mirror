From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 56/94] apply: move 'struct apply_state' to apply.h
Date: Sun, 15 May 2016 23:10:14 -0400
Message-ID: <CAPig+cS98guXbeRH6oW8n2tPAa3u=2MvSx1H5rixGKdGTrVJPg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-57-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 05:10:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b28vl-00063P-NM
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 05:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbcEPDKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 23:10:30 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35993 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbcEPDKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 23:10:15 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so23391522iof.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 20:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=eLy07vNVoj1rz5hivW7rBk5ZZFE+l9MUxdcAsQswt4M=;
        b=x9lRXXTngliN93I28XbcxTHwefEwDhS4qZ5gfOLgPj3Cw8K5QE7VqYsyK18Qk/F0Q7
         e07i6tZY+Me8MMEWwltJZFIZ4YHNixkE/vJjZDxsS0KW/uXXlbBzpcWZVedhhvTVGq9s
         Boh1GgbseBOV6cdQH2nlKtXk2n2c0eOGGu+AKWc5pwn3TfH3lpfVYvoKCAvaIZ64YV43
         RnzBvFvnsFMX85G/wg/k+8+25ewz0WFiwuexWlhxT33LKxpEbdTxa1o2vD8nb8rKs5C2
         0QSbGPplT/w31JGQI24z0y9yKRfccE+5O2qb9nX5O9ZR6/b/Pm4BpIhTy7OdQSpfve+h
         52Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=eLy07vNVoj1rz5hivW7rBk5ZZFE+l9MUxdcAsQswt4M=;
        b=Ppbt0lQF9DcaHbQnESDRHetM0Bim0IzbhqjuXatb74H+vEz92N5AvC4TZrkfUxprQ3
         Zt9F3d6339yRPvIRzYxyqiQpFhEuD7HAAtBJ4aWreorV34aO2l3JI/yBP402pH7EcY+3
         z0SHEfQ0Bux8yl055c96qSgAu+DTkO2Q6HgN0oxdFNH2q0/DjA5T1HsdO7so0HvcwXjd
         mMECekuZ1GEknu79h/QMP4oGLKo8/5D8oDHfUPePbPdGgAP7NZ313lvJ7yMnKZ+rl2/I
         fY/Semu9Y9HH1yAMjjkD3IecyBDvp3+p3HQLu6dtRd89PhPaCXvVV5u7kRYoFlum9Lqi
         Snmg==
X-Gm-Message-State: AOPr4FWzNpRYuYSO3DIplLzS9GJS5edkTC34dSvyvzM60hZvxNElNAgfKGDw/f0WMlHvDu9Gu75l4bXR5IDzlw==
X-Received: by 10.36.69.156 with SMTP id c28mr7302567itd.84.1463368214546;
 Sun, 15 May 2016 20:10:14 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 20:10:14 -0700 (PDT)
In-Reply-To: <20160511131745.2914-57-chriscool@tuxfamily.org>
X-Google-Sender-Auth: gexP3FEenrj6fEe2OLuu39yG4Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294717>

On Wed, May 11, 2016 at 9:17 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To libify `git apply` functionality we must make 'struct apply_state'
> usable outside "builtin/apply.c".

Why is this patch plopped right in the middle of a bunch of other
patches which are making functions return -1 rather than die()ing?
Seems out of place.

> Let's do that by creating a new "apply.h" and moving
> 'struct apply_state' there.

I could easily see this header introduced at a very early stage when
'struct apply_state' itself is introduced, rather than introducing
'struct apply_state' in builtin/apply.c and later moving it here.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

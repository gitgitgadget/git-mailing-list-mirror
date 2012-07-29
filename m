From: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Sun, 29 Jul 2012 14:13:55 -0700
Message-ID: <72E23CD93B354FB28AFD12DDA7303016@gmail.com>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
 <500F00C7.4040209@web.de> <7va9yogb37.fsf@alter.siamese.dyndns.org>
 <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
 <CABURp0rM_zkA0Hb=kkJcEeqWBX0qgRqH-zviW8ofp-qQqkW6uw@mail.gmail.com>
 <FE466454ECCE48A19472B85D1C92E9E2@gmail.com>
 <CABURp0oHchc8KuwE+AxwzygLSi30+qiyqX=tfj9_rQrjBgO5AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:14:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvaoO-0004Qs-6c
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab2G2VN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 17:13:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59896 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab2G2VN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 17:13:58 -0400
Received: by pbbrp8 with SMTP id rp8so8637266pbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=pBGYBYD1M4sbsTxAZIxVCr5kbl2XdIW9saOPg1HWVlQ=;
        b=n1De6v48Sj6mMVUGQu8OPutLfl/w9ta33HooG1qc4n/Lemjthg6ET4ZVxk2WyDuyYh
         L8D5OZoUgbXEdpwLV9O8XsnWWdf+6RWnDWXp7ifqFZbAgKfJxNKNEwUvRm5lF7JVMKqe
         h5lfZ4dq94k/vRjOyaqDjmVMB73xqGuABg+098FbgiGMyB22zCFqkIeW4DviFm2JxjKq
         Qnrf8f85dEFbkk6SbKKixUdnT+DyDMWhe+PyKF+0Oz2r20vixL2oT8jz9hrrvrrJ7cyW
         nHaZUdYW6EBzcBskrRW2s5dS4kK9IKaND6qCaSYYOLL09+j2oVsAnkTVHibfdq82Vb23
         AA0A==
Received: by 10.66.77.71 with SMTP id q7mr20276995paw.0.1343596438177;
        Sun, 29 Jul 2012 14:13:58 -0700 (PDT)
Received: from [10.168.1.100] (c-24-16-145-254.hsd1.wa.comcast.net. [24.16.145.254])
        by mx.google.com with ESMTPS id qp6sm6430118pbc.55.2012.07.29.14.13.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 14:13:57 -0700 (PDT)
In-Reply-To: <CABURp0oHchc8KuwE+AxwzygLSi30+qiyqX=tfj9_rQrjBgO5AA@mail.gmail.com>
X-Mailer: sparrow 1.6.2 (build 1143.6)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202497>

On Sunday, 29. July 2012 at 14:10, Phil Hord wrote:
> On Sun, Jul 29, 2012 at 3:30 PM, Justin Spahr-Summers
> <justin.spahrsummers@gmail.com (mailto:justin.spahrsummers@gmail.com)> wrote:
> > Hmm, you're right. After further investigation, this actually looks like a weird issue with soft links. Here's some exact output (with spacing only for clarity), using a public test repository at https://github.com/jspahrsummers/recursive-submodules-test:
> 
> 
> 
> I can reproduce the problem now on 1.7.10.3. However the problem goes
> away in 1.7.12 since it was fixed in
> 
> 6eafa6d096ce6b0ae20e4c0fbb248958559daf64
> Author: Jens Lehmann <Jens.Lehmann@web.de (http://web.de)>
> Date: Thu Jul 12 19:45:32 2012 +0200
> Subject: submodules: don't stumble over symbolic links when cloning recursively
> 
> Regards,
> Phil

Ah, good to know. Thanks, everyone, for the help. 

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Tue, 17 Jun 2014 23:49:11 -0700
Message-ID: <CAPc5daVTZynCKMubZmreAjBh3i51wPaAA+8vSRwB9dGrrJb6FA@mail.gmail.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com> <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com> <20140615102736.GA11798@redhat.com>
 <xmqqy4wwraoz.fsf@gitster.dls.corp.google.com> <20140618030903.GA19593@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 08:50:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx9gw-0007Fw-TH
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 08:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756638AbaFRGte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 02:49:34 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:64473 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbaFRGtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 02:49:33 -0400
Received: by mail-lb0-f178.google.com with SMTP id 10so224890lbg.37
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RLKJ3KehKpWpdLi9nBJ/0b0SBcT6i8wQ4jxWsg6oGkc=;
        b=H1pV9zEAu1RBx8ZrxKILtzjfQ3YA+Pgdn1Ogt00+HxAXmbyiUQgRieXbQKShbcJpn6
         cdN2b2NXatboUactn52RVoIfsxCW5XbSXmyQdqj1EsnJdjvKcjsdweKydOC47U8M9Z3U
         3/kgOIPkDWZ3mlsjzURA4ssBOBarG43rQnRQspaTMYvvT9z5RJwnDTiDnnOTDo/rhTZl
         PsTd10MFhmxWmjqSunWNVFEInfF8WsWlNj+Zw6zAsWowUrao09/2AfWLNnLkgKiJbvzZ
         lmAcRekBROH2iwej4mncdRPKOyyOU+2ySubk1R6aPcHyDk6NvpPp1Yq+s5IwGiHWHbEo
         vQCg==
X-Received: by 10.152.6.37 with SMTP id x5mr23141lax.15.1403074171698; Tue, 17
 Jun 2014 23:49:31 -0700 (PDT)
Received: by 10.112.172.103 with HTTP; Tue, 17 Jun 2014 23:49:11 -0700 (PDT)
In-Reply-To: <20140618030903.GA19593@redhat.com>
X-Google-Sender-Auth: QF0D8sWbHfFQd2HgrDCptf-fvqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251969>

On Tue, Jun 17, 2014 at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> OK, after looking into this for a while, I realize
> this is a special property of the Signed-off-by footer.
> For now I think it's reasonable to just avoid de-duplicating
> other footers if any. Agree?

Not really. I'd rather see "git am" hardcode as little such policy as possible.
We do need to support S-o-b footer and the policy we defined for it long time
ago, if only for backward compatiblity, but for any other footers,
policy decision
such as "dedup by default" isn't something "am" should know about.

From: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Fri, 5 Feb 2016 12:18:22 +0300
Message-ID: <CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 10:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcXE-0005mA-MO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 10:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbcBEJSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 04:18:31 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:32857 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbcBEJSW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 04:18:22 -0500
Received: by mail-ob0-f179.google.com with SMTP id is5so82912772obc.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=5m3Gq/yhUVWJ9HnAvKPQGsS/+q5mWq+qrUFjVExYnMQ=;
        b=f7BYSPofP47cVu7mbojQh9DqF/0pec4bUFocI9lHCI03jLTpEGrj0tdkXOGsJZ9Tbk
         gTeOGGXuAQqSbh1NuqMGte5SRm6M4cC83fqgeeB9Sw3Trf2YmkgaQbsPBLX03762RXvZ
         IF99Pcoz2eiBot7+M4G7fcY49qmR9nudj/EhJn1pk1frB/5GGAj3Hul1twC1YBVGXFDC
         ARmE9NYZsSmZgKmnvrsK2CV27IRFDbKQmQId9CBcFp8KucI/wmD9lDn8rn61k9qcNDdf
         hem6TbujB3Mcx7ef3MqInqcolyWeLUUF8WTl6AqPyZBru6uGSas0EyD33eZYoQO1LEdL
         ZGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=5m3Gq/yhUVWJ9HnAvKPQGsS/+q5mWq+qrUFjVExYnMQ=;
        b=e7alwEc75ckAwWCCrtGjqkZ4gYGLn/phGB/KBmoEAjnk7kfPnbELbHRLmQiMt0Ptf+
         AWi/liO5mUuv4+aXqkt7P9KD1AlZ7PpkVNreNrzJjvNNTDzYfUN9l53+mG6tM5QV1rBR
         QIxL+Kj6kxKq/MqbALyI4ievVgzzhLNM86X8pncSVId/wsAOzLViYFvN01M7YZ9dm3YQ
         6syl2JQWcv2+tYRsoDkY/8aAh29Yyt1YSFWdKNyBrqt34W6DdYd35HclIxii+xwR4rPQ
         M2e0MX3ZnOgM2fazTiJxYj6e+6Fp0qmnAqeaUSetTxtp7xD+cL97gq33w8hlhjfsUTTf
         cTxg==
X-Gm-Message-State: AG10YOSpS9d+GN9X1dK4GwkEl9wObZT3seSBJJbJ0wHlGONDehFIZDR1qKI8llGCl+zEJTWuS1JnDRNRhwPZ+Q==
X-Received: by 10.182.225.132 with SMTP id rk4mr11196599obc.68.1454663902186;
 Fri, 05 Feb 2016 01:18:22 -0800 (PST)
Received: by 10.76.35.162 with HTTP; Fri, 5 Feb 2016 01:18:22 -0800 (PST)
In-Reply-To: <20160202232952.GA6503@vauxhall.crustytoothpaste.net>
X-Google-Sender-Auth: HcRZTw93FPTcUUNAEjQGwL1555s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285564>

2016-02-03 2:29 GMT+03:00 brian m. carlson <sandals@crustytoothpaste.net>:
> I'm unclear in what case you'd need to have a username and password
> combination with GSS-Negotiate.  Kerberos doesn't use your password,
> although you need some indication of a username (valid or not) to get
> libcurl to do authentication.
>
> Are you basically using a bare URL (without a username component) and
> waiting for git to prompt you for the username, so that it will then
> enable authentication?  If so, this patch looks fine for that, although
> I'd expand on the commit message.  If not, could you provide an example
> of what you're trying to do?

You are right, we are using a bare URL (without a username component).
With username encoded in URL everything works just fine. But it's
generally wrong to pass creds in URL (in my opinion) and security
policy of my employer prohibits doing such thing.
Anyway, as you said libcurl needs valid (not NULL) username/password
to do GSS-Negotiate, so there is nothing wrong if I set empty
username/password combination when git prompts for creds. Even more,
there is no other way to let libcurl to use GSS-Negotiate without
username in URL.

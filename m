From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Wed, 15 Jun 2016 21:37:51 +0200
Message-ID: <3899461F-44B4-407F-ACCE-793E65486554@gmail.com>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org> <998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr> <2104102670.380496.1465220639026.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Queru <Antoine.Queru@grenoble-inp.org>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	rsbecker@nexbridge.com, aaron@schrab.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net
To: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 15 21:37:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDGdR-0001TP-DS
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 21:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbcFOThx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 15:37:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34879 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbcFOThw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 15:37:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so6377126wme.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EcU2XS3L+tTInWJpOhaBEbCDWKqN2C5of/ux3taNPu0=;
        b=tzG6Vxdzjf8Vn6K4t3VP5+uw5eXNz3jXEcwTXfa7SDyyIfR7BKuSMuGXfneHdu4W50
         l3Z7GV6jUzZM67bSxrjHUbOGSbXDPcJ66/TLmZ3oP3WZsRPwyv0AgMA8tANxUKb3MsBr
         PIPUlMukS2hgsRc06vnT1yzOA1Q1JgygnlLeCSqYJ/UslzJpHg5j5nZ29KWjxD5f579G
         1lSI24vWdpWYKOmlV+UHAuwnPz+lkzxLjJzLYwba0DidxPr1Iptmb4XABAu9hJ3OT2Jj
         nEfUkFpb/uHUekF1p+QFe99EjOSeLBX1JruHFafK/uFMiiSKn5nIwRvjQh++P+nOoFAX
         rP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EcU2XS3L+tTInWJpOhaBEbCDWKqN2C5of/ux3taNPu0=;
        b=X5HuVLhfkAHQ/g+l/DNMTMOsj6Ah62d4rEWiEEUBTbiDHPqW7ieQDXGp5wXLdrsnPd
         LepfuOvAmw/83DpHk8QAKgdRbj89ar1qv5HDRFIIdzeqsZ6Iq4FxevPStr1fYf8xB+x7
         bFRdDYhc+Swn7Rr8YFMVws/anYP3AXllUdE8wQfyeDa5IX1hCA/4+MibhmE3jVtDcE7s
         vgS8Yx9cgbxdWnmrPsrId8vr3iBgE0iVb8CdId4AtZO1V4h2ypIe+zQXVh3YbVEJpjud
         59b2oD7DS4XIcp/lWtD3mv+WGLECCet+ptUv23eUqmo9LNguol02JoLFlvmhVE1j7oZp
         ef0w==
X-Gm-Message-State: ALyK8tLOchsblUFe2Gwyq4iNzE6tKqgH5TfGhY0dkRE7M6xeULF70f7DvfAoiWLpHor7CA==
X-Received: by 10.194.86.70 with SMTP id n6mr278846wjz.154.1466019471413;
        Wed, 15 Jun 2016 12:37:51 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5125.dip0.t-ipconnect.de. [93.219.81.37])
        by smtp.gmail.com with ESMTPSA id f189sm90627wmf.19.2016.06.15.12.37.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jun 2016 12:37:50 -0700 (PDT)
In-Reply-To: <2104102670.380496.1465220639026.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297395>


>> ...
>>=20
>=20
> Hello R=E9mi, thanks you for your input ! I'll make the appropriate c=
hanges=20
> and send a new version as soon as i can !

Hi Antoine,

do you have an updated version already or is this the one I should look=
 at?
http://article.gmane.org/gmane.comp.version-control.git/296445

Thanks,
Lars
From: Alexander Nestorov <alexandernst@gmail.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Tue, 18 Jun 2013 19:03:18 +0200
Message-ID: <CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
 <vpqsj0fr19j.fsf@anie.imag.fr> <CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
 <vpq7ghrqzrv.fsf@anie.imag.fr> <CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
 <vpqppvjpjz3.fsf@anie.imag.fr> <CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
 <CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com> <vpqy5a7mmsg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:04:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozKF-0003sL-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263Ab3FRRED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:04:03 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:39629 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253Ab3FRREA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:04:00 -0400
Received: by mail-qc0-f176.google.com with SMTP id z10so2459565qcx.35
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dLYXFdkmOrYYuYwVTpGH1xc+7nUCg4mpu/RrNdO4Kq4=;
        b=dyCkdqZkz7TGE5mmfP5GQrlFeJM1tCBLJrim5IjPIm0Rcg5FAOSz3OyTVbEqK3jo6r
         fyG5euu3Ce8pj/a0xy6phHIz6YUkBLg8XXeroTuD8vkjyNPcOVdooxj0WFFTaslWFL/y
         pBx3PmyyhcKYLR65soYB7M5RntkUy70+nG4IsBF3NJBLASP2bZnAwynlTLnuMu2xoWMq
         Hv1o9sXOYRMdnFe/Y5jHRlJt2wtQn+uFirzHanxV3Pi7dlmHuaN403AiX9KBnV/mxzIs
         xBQUmIUKwoXdb74Oe5Q0Upyt6EMJVFHaVRcZQGVd4vcSDQs3pYC6YeflcecwbuGlXGjb
         haPQ==
X-Received: by 10.49.24.13 with SMTP id q13mr29407613qef.49.1371575038589;
 Tue, 18 Jun 2013 10:03:58 -0700 (PDT)
Received: by 10.229.168.70 with HTTP; Tue, 18 Jun 2013 10:03:18 -0700 (PDT)
In-Reply-To: <vpqy5a7mmsg.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228276>

How about that:

+Reset only files who's content changed (instead of mtime modification)::
++
+------------
+$ git update-index --refresh               <1>
+$ git reset --hard                         <2>
+------------
++
+<1> Make git realize which files actually changed instead of
+checking out all files whether their content changed or only
+their mtime changed.
+<2> Now git reset --hard will checkout only the files that
+actually changed.

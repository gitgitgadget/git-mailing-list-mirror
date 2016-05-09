From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 2/3] t5551: make the test for extra HTTP headers more robust
Date: Mon, 9 May 2016 09:56:29 +0200
Message-ID: <BC0E627C-416C-41AA-9D09-68634845BC3D@gmail.com>
References: <cover.1462342213.git.johannes.schindelin@gmx.de> <cover.1462774709.git.johannes.schindelin@gmx.de> <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 09:56:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azg3i-000073-9s
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 09:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbcEIH4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 03:56:37 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35530 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbcEIH4e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 03:56:34 -0400
Received: by mail-wm0-f51.google.com with SMTP id e201so125548076wme.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mQOq8utFnmHjoYQDPdoiG/r6c+iiH9t/zgbg4WJ80tQ=;
        b=gA+XQ4fUOlJsWiMp+tYI5NmjRlKMzC3QJKMESo9lDkxrnd7ClySCVPQNKOWZ8qfYst
         7S0qk4UHQYQRB6/GDDOAmLN5UqYvARtBt3KdLPt3lktm2OkxifWmb3P9nItSKw2s0bFC
         cBEU6xWr/S3R1fizx8l3SuigSZqSeApbkGshdJfbmCoDx7t84c5HTtnjbsURX/0tiZ3p
         RunRfrMsRf1WDoXstEHRM29iqXkqyrGTOd5VDTpCbTjoCj0/RV+NHDAL3mKH4uMwYQHL
         Y3P74SUjzzUw/tFFqiEczdl1sApd2epAScgq0SQd2V0ocldtxBauWPsB6Q27mFnbNPjY
         gNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mQOq8utFnmHjoYQDPdoiG/r6c+iiH9t/zgbg4WJ80tQ=;
        b=cvbG9QirLlyXAWFJ5PtyQDKzwtBRD4hxxAzKcD4F0Sn1vv4y5Fecd/c1EVEFOzm5T8
         7adlEcrIURQ74vQiUazMQdfzKPbeEV+YeTClnrgSQNULXGA+hYmJlgxlNPv4jbp4utYy
         +gs1CG6NMjLr5o5pGdCfE+uPokmb/tzwtwZDeuXygfjjDDEF1eglihZeAYsr8PbW5m6R
         N2WQJH9H+WMx7gcUtcdKs9X134mbjbAg9huka56B+8KjzRzz2vgh9+Y1NrhNyS4klWHf
         E/9w2wlJqV7WiZPA3X9VwWSSIS+Yo9sECqPLAlSOR0wdX5h3OJwT4XMoCrOlk29YCVz/
         DgYw==
X-Gm-Message-State: AOPr4FXzAT7JouCl6Gcckc2Z3jdZUP2fQo9nlhoh6lAfojE4KEOmJje9i0+q9cq+VijUlw==
X-Received: by 10.28.184.22 with SMTP id i22mr9785545wmf.41.1462780592744;
        Mon, 09 May 2016 00:56:32 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB7587.dip0.t-ipconnect.de. [93.219.117.135])
        by smtp.gmail.com with ESMTPSA id k62sm9669015wmb.7.2016.05.09.00.56.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 May 2016 00:56:31 -0700 (PDT)
In-Reply-To: <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293989>


On 09 May 2016, at 08:19, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

> To test that extra HTTP headers are passed correctly, t5551 verifies that
> a fetch succeeds when two required headers are passed, and that the fetch
> does not succeed when those headers are not passed.
> 
> However, this test would also succeed if the configuration required only
> one header. As Apache's configuration is notoriously tricky (this
> developer frequently requires StackOverflow's help to understand Apache's
> documentation), especially when still supporting the 2.2 line, let's just
> really make sure that the test verifies what we want it to verify.

Haha. Me, too :-) After I wasn't able to find a working solution myself
I posted a question on ServerFault [1] ... I will test your solution
tomorrow!

Cheers,
Lars

[1] https://serverfault.com/questions/775515/requireall-require-expr-equivalent-in-apache-2-2-22-to-check-for-headers

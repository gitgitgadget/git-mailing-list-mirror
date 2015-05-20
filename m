From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Wed, 20 May 2015 10:03:45 -0700
Message-ID: <xmqqvbfnnpu6.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
	<xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
	<xmqqd21w8mal.fsf@gitster.dls.corp.google.com>
	<xmqq1tic8lgj.fsf@gitster.dls.corp.google.com>
	<xmqqk2w473i2.fsf@gitster.dls.corp.google.com>
	<20150519221450.GB779@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 19:03:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7PN-0000Pp-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbbETRDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:03:49 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38478 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbbETRDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:03:48 -0400
Received: by igcau1 with SMTP id au1so44761495igc.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iYGpYL+OnPIqAgqpN5pxyCyEMmyeDPTG8Vnebq+who0=;
        b=jnFCW8Qsou+vznMyMbNrbqv/M4GulQGMHCCK69TmSRcULd0P4umqANvzeT3jFUcspV
         zmJmsZgbVIBjpmS4Ss9cBJwPLeCv/dtokt9o1n2vbw7SnxEPc1jWAd7fwLimicmu2Qso
         qcS3DDmweIJeAMbPKvidw3WefCRw9XoYk8cxwb+tidAOvmUtpBuhZoo7/g2LRpwB5ycI
         xxy67+zPFyG92pR3j7N2tVxZsV6mzhj/37IUPLE155H4febMnc47Bk1MthaZIzzwJb+R
         7nSNDioQhvufq/oDAFJmisLGKO9E8TN4ak0V7NeoBU8YnI4QxIN/p0hLrA98fEW3km7y
         iYWw==
X-Received: by 10.42.37.5 with SMTP id w5mr47509718icd.39.1432141427747;
        Wed, 20 May 2015 10:03:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id cy11sm1985023igc.14.2015.05.20.10.03.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 10:03:46 -0700 (PDT)
In-Reply-To: <20150519221450.GB779@peff.net> (Jeff King's message of "Tue, 19
	May 2015 18:14:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269472>

Jeff King <peff@peff.net> writes:

> Your revised patch 2 looks good to me. I think you could test it more
> reliably by simply adding a larger file, like:
>
>   test-genrandom foo $((128 * 1024 + 1)) >big &&
>   echo 'big filter=epipe' >.gitattributes &&
>   git config filter.epipe.clean true &&
>   git add big
>
> The worst case if you get the size of the pipe buffer too small is that
> the test will erroneously pass, but that is OK. As long as one person
> has a reasonable-sized buffer, they will complain to the list
> eventually. :)

Yeah, I like it.  It was lazy of me not to add a new test.

Thanks.

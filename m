From: Andreas Ericsson <ae@op5.se>
Subject: Re: Certificate validation vulnerability in Git
Date: Sun, 24 Feb 2013 19:46:51 +0100
Message-ID: <512A601B.80807@op5.se>
References: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Dhanesh K." <dhanesh1428@gmail.com>
To: Zubin Mithra <zubin.mithra@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 19:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9gbn-0007Os-12
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 19:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab3BXSrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 13:47:00 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:46866 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443Ab3BXSq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 13:46:59 -0500
Received: by mail-lb0-f179.google.com with SMTP id j14so1742980lbo.38
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 10:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=09hStWDuLtwboHtvYPzcfUSKtK6fnr+VIEaq0qWYz9Q=;
        b=dSo1p34/OEMHWXXXQ4214Q91dBmNkNiiOhPDKh3zlJ+/GygWDhw2+qsxwEQUjJkuba
         dRuXxGD4n78qTj0UvHXEqnfpnSpyI7S2RHJbPAkw6qXhHR9vJMFQkhUTi5XwN2NY2EMu
         nbi/O2K4ZdASMJ2Oa16QRQWF+93FpxSpiBwh4wwQkpQIN2GmKC8L0YCfUMYydjho+BdD
         8V0BPFpLPJNQPBdm/IbEYxAFpWiagLKmgGpYyKNKCZSx9OxcjgoviWqXBdakiSex0pmV
         K+/lrYIaQdQKNXvNji4QO47wSd3NKN05BZini2lJYMnNouONNpfmd1Xm0AnjWJ+KPTdJ
         m7nw==
X-Received: by 10.152.134.164 with SMTP id pl4mr7654321lab.54.1361731615084;
        Sun, 24 Feb 2013 10:46:55 -0800 (PST)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id f4sm3257838lbo.4.2013.02.24.10.46.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Feb 2013 10:46:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQn4wGjbGHM5IC1ORPwnTfK/PfqROJoFasBFD6Aq4n8d0J0ZHJTeAzXHkkxObOlUTLjMZa4y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216998>

On 02/24/2013 06:31 PM, Zubin Mithra wrote:
> Hello,
> 
> There seems to be a security issue in the way git uses openssl for
> certificate validation. Similar occurrences have been found and
> documented in other open source projects, the research can be found at
> [1].
> 
> -=========]
> - imap-send.c
> 
> Line 307
> 
>   307   ret = SSL_connect(sock->ssl);
>   308   if (ret <= 0) {
>   309     socket_perror("SSL_connect", sock, ret);
>   310     return -1;
>   311   }
>   312
> 
> Certificate validation errors are signaled either through return
> values of SSL_connect or by setting internal flags. The internal flags
> need to be checked using the SSL_get_verify_result function. This is
> not performed.
> 
> Kindly fix these issues, file a CVE and credit it to Dhanesh K. and
> Zubin Mithra. Thanks.
> 

The lack of certificate authority verification presents no attack vector
for git imap-send. As such, it doesn't warrant a CVE. I'm sure you'll
be credited with a "reported-by" line in the commit message if someone
decides to fix it though. Personally, I'm not fussed.

> We are not subscribed to this list, so we'd appreciate it if you could
> CC us in the replies.
> 

That's standard on this list. Please follow the same convention if/when
you reply. Thanks.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

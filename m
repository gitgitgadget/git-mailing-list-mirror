From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t3400 (rebase): add failing test for a peculiar rev spec
Date: Fri, 19 Apr 2013 13:13:46 +0530
Message-ID: <CALkWK0=RDCCSxOJ2TU4=tniSRTg9VJohJ8Pf6uN9E=fd3jg=_Q@mail.gmail.com>
References: <1366275155-26244-1-git-send-email-artagnon@gmail.com> <7vmwsv94jo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 09:44:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT5zl-0004ZM-60
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 09:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab3DSHo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 03:44:28 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:47348 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab3DSHo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 03:44:27 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so4408977iej.30
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=51l3Q0lH7TlpVnvgYt7ww/iHmerVFElJP3eRIXCa1jQ=;
        b=ecMDy70MwBEmuhNNM/49ZefEK1E82/n3Ln0RsEMErbQdeP+rOQWkS3FIK+Q4nPIqfo
         zTG3KkBsATtL2OqDhWzufyNjnYEp0xY5HNnujaoRYAQey6hT8w7WBX3Ipdu7nSL5jtRu
         BlPMmboHKb/VRks1t9ncKD+dgh7LKdORqi0CH1tEEE4yEj4wxoKnh7rmg+7butBfi9Lt
         apvRNiwAIOm6afM5wX1o70t1yS/FQuVfAetCdtuh+qLDJsh5w41MAQitK/H+jX+K1ISN
         wvM6yAkGqGCyPccmDRrs/3Lt9Vgt220YYbvzthAWm2QJ3dDWEkezrsJi8YHXR5chdlix
         +vBQ==
X-Received: by 10.50.17.166 with SMTP id p6mr1659864igd.12.1366357467224; Fri,
 19 Apr 2013 00:44:27 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 19 Apr 2013 00:43:46 -0700 (PDT)
In-Reply-To: <7vmwsv94jo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221749>

Junio C Hamano wrote:
>         peel_committish () {
>                 case "$1" in
>                 :/*)
>                         peeltmp=$(git rev-parse --verify "$1") &&
>                         git rev-parse --verify "$peeltmp^0"
>                         ;;
>                 *)
>                         git rev-parse --verify "$1^0"
>                         ;;
>                 esac
>         }

Thanks.  Yeah, that's the obvious "hack solution": special handling
for refspecs of the kind :/text.  Will write a patch for it soon
(currently struggling to complete rebase.autostash).  In the meantime,
please queue this patch.

I'm more interested in knowing what you think of my first point: is
:/text fundamentally broken, as it can't be combined with other
operators like the other rev specs can?  If so, how do you think we
should fix it?

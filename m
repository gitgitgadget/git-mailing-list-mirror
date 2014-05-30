From: Nathan Neulinger <nneul@neulinger.org>
Subject: Re: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent,
 but processed BEFORE .gitconfig
Date: Fri, 30 May 2014 13:44:05 -0500
Organization: Neulinger Consulting
Message-ID: <5388D175.3060500@neulinger.org>
References: <5388CBA5.9030403@neulinger.org> <20140530182746.GK12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 20:44:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqRmn-0003D1-RZ
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbaE3SoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:44:09 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:50175 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbaE3SoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:44:07 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so2293621oag.32
        for <git@vger.kernel.org>; Fri, 30 May 2014 11:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RrCAW3+/DXalAxHreut+lURZIhIayN0VLPT6PiUaznI=;
        b=mZSsu1njjpKIbMo403aVnSA6eUM7hFRUp+H0nM0ORJbjRe9MvCFWUPIdIiqxG3qyyp
         mKj838EmrmzSiOOiuR1mrrBs3pRord96zK8P0QlGbnmjGtqWRbPB/PYOljyHHeDoMo8N
         uEsO3JSjyURBpawzmT/Yp7boYociwqSkGBFyXdCn+kbQrpMLMvkMW1fws049UVD23Ohk
         g+Y3xIXw/GegOr6cHmc9Jzmau3eAYIgbsHfai2QzuEdMH5kkFlEbkPl/GvIYVlBSVHpj
         YCugHpVyzPC4l3JwjlF5rqLFMW6vWOgMXyenGQTjNY1DPuKExjbr1pHEGvyzb7yDwSpO
         OfcA==
X-Gm-Message-State: ALoCoQmRHTWobwxf15mbYtpSc/RaTyPjCHOZjeTurHWcQOPL5G9Paq9lokx7YfOsYNS7a5+HDscQ
X-Received: by 10.60.54.101 with SMTP id i5mr19788646oep.10.1401475446673;
        Fri, 30 May 2014 11:44:06 -0700 (PDT)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.49.1])
        by mx.google.com with ESMTPSA id yt12sm8475200obc.4.2014.05.30.11.44.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 11:44:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140530182746.GK12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250465>

> I wouldn't mind having a GIT_EMAIL envvar with the semantics you mean,
> but can you say more about the use case?  What's wrong with the usual
> EMAIL environment variable?

EMAIL actually worked for this case for me, but there wasn't any equivalent for author name, so the commits all look 
like "sharedaccount <myuser@mydomain>".

> [...]
>> [include]
>>     path = !/usr/local/bin/gen-git-env
>
> This is scary in terms of privilege escalation attacks.  ("Admin,
> could you please take a look at this repo?  When I run 'git status',
> ...".)

Wouldn't that be pulling from ~sharedaccount/.gitconfig anyway though? (Agreed that it could be an issue if you have 
shared ssh agent, krb5 tgts, etc. - but that would exist any time you connected into a shared account.)

I would probably take the approach of not supporting that syntax in anything other than the per-user gitconfig file 
though as a safety measure - per-repo config could indeed be a problem.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Patch Series v3 for "use the $( ... ) construct for command
 substitution"
Date: Fri, 4 Apr 2014 10:29:46 -0700
Message-ID: <20140404172946.GI6851@google.com>
References: <CA+EOSBkF+hLOab0oJH7HuUb_KKn+1sgV_Lshwupgj-_yAAfmFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 19:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW7xC-0001Me-KR
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 19:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbaDDR3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 13:29:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:65363 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbaDDR3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 13:29:50 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so3781475pad.29
        for <git@vger.kernel.org>; Fri, 04 Apr 2014 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=L+4ALcGKtAtrC+d/YjT08q74GAzB1xfgchKBb/mW8TQ=;
        b=ixZfYnYgjSRyL0lbKMxUuWTRrsF3kiaVAL4RadQ6FZW3/+Lnf2VR+DHdtkndEVQ65z
         c4EZVKrQRkF1t0VPRGdi6S7QTfE9k9KLGPHxcS7ZAlCH09YRa2Y9XwtIBx33sM5JO05K
         cl2hBrvQVsWYJwt6OUeJ4AxiYYYCbgHarlAjEIyva7XHZYrwq7LXLNTAzgAp2O+YvRLT
         amBBQHgJwt6gn/bwoKu19ZLHy1xSep/mF56HYBGtpaUUPkGolxVb+MyS/LVJXaBg+gAC
         loVBcT33IRbFK3Q8M3KJ7SOWCZs6togseKnm8J+LDMWOM00fddefx5ddh3jbmMZ0xlNI
         gPXg==
X-Received: by 10.66.147.130 with SMTP id tk2mr16276448pab.125.1396632589641;
        Fri, 04 Apr 2014 10:29:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y9sm43466674pas.10.2014.04.04.10.29.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 04 Apr 2014 10:29:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+EOSBkF+hLOab0oJH7HuUb_KKn+1sgV_Lshwupgj-_yAAfmFw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245765>

Hi,

Elia Pinto wrote:

> This patch series contain the
>
>  use the $( ... ) construct for command substitution
>
> patches not already merged in ep/shell-command-substitution
> in the mantainer repository.

Thanks for working on this.  The $() form is less error-prone
than ``, so in that sense it can be worthwhile.

[...]
> Elia Pinto (140):

I admit I'm not excited to review these at all.

I wonder if it's possible to make the series easier to review.  For
example:

 * patch 0 makes preparatory changes to line wrapping or to avoid
   using `` some places to make an automatic transformation easier
 * patch 1 introduces a script to transform `` expressions to $()
   expressions
 * patch 2 just runs that script

If the script is "obviously correct" enough then there is no need
to manually go through 140 files after that point.

If the only way to get this done is to actually manually review those
140 files, I just don't think it's worth it.  The `` construct is not
*that* bad.  Another possible direction could be to add a tool to make
sure git doesn't get any new uses of ``, to let the changes flow in at
a manageable rate without too many cases of "one step forward, one
step back".

Hope that helps,
Jonathan

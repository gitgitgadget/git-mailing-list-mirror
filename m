From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Stalled git cloning and possible solutions
Date: Thu, 29 Aug 2013 14:10:34 -0700
Message-ID: <20130829211034.GB4110@google.com>
References: <201308300118.19166.vkrishn4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "V.Krishn" <vkrishn4@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9UJ-0003E8-Ct
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab3H2VKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:10:39 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36197 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896Ab3H2VKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:10:38 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so1422874pab.36
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NtCtIfGeT8UPIq8SfGI0fhllzc+xsFPeLqv3U/YJtjY=;
        b=N7DZ629vt42dsF3eCnhx/uqgJSLykRuaaYvJ9LM7gI7hgO/8swDddn0OfJMIIM2FD7
         qZ7pbpo2wGWPqOZ1J5uBuZaTxi1IEBaHCUhE0PPYYEOL3cMZmth/d19hFRnSW2x96LIL
         SX2q3J/8nUt8+LT0NLL0Wcphw2m+mLIpWF+iZUYe/ItdGYMPHSsXp7tfloX8aoGg+EBk
         ktm328qKKczx3rErgYdbeH/vNN7M9lyJDfestR7ETj19Daj4JukZPA2r/iC3zt6CQcLV
         eB8zSGnp4AB8amDkt+kZg7C3nwStOF9g8e+55jMMeJxBLu+P7ogeYEJllAjCixJA3Rq4
         AJWw==
X-Received: by 10.66.233.195 with SMTP id ty3mr6703209pac.70.1377810638455;
        Thu, 29 Aug 2013 14:10:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bt1sm39967910pbb.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 14:10:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201308300118.19166.vkrishn4@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233363>

V.Krishn wrote:

> Quite sometimes when cloning a large repo stalls, hitting Ctrl+c cleans what 
> been downloaded, and process needs re-start.
>
> Is there a way to recover or continue from already downloaded files during 
> cloning ?

No, sadly.  The pack sent for a clone is generated dynamically, so
there's no easy way to support the equivalent of an HTTP Range request
to resume.  Someone might implement an appropriate protocol extension
to tackle this (e.g., peff's seed-with-clone.bundle hack) some day,
but for now it doesn't exist.

What you *can* do today is create a bundle from the large repo
somewhere with a reliable connection and then grab that using a
resumable transport such as HTTP.  A kind person made a service to do
that.

  http://thread.gmane.org/gmane.comp.version-control.git/181380

Hope that helps,
Jonathan

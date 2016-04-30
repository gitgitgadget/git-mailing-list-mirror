From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 02/14] upload-pack.c: Refactor capability advertising
Date: Fri, 29 Apr 2016 21:04:06 -0400
Organization: Twitter
Message-ID: <1461978246.4123.45.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 03:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJKR-0000JY-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbcD3BEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 21:04:11 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35628 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbcD3BEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:04:09 -0400
Received: by mail-qg0-f46.google.com with SMTP id f74so49698377qge.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7pQ4z3OyLmWB77R2Icz1RfStPxsM4M6Bc+F1AqoUcLo=;
        b=XHPBnJBszSAkIWcF5TYszhHQLOw70A68E/RxNsLi7VqcwtqkucwmABBOnkY3rzu+HX
         UE2vKKo0lNEfFOit7V87DQAEqHWY9nbKA9RsztERACIAtFy1foFF7LdxHhuT0Dl2Ad08
         bzsh/MKxPwPdCdkco6hovnJbTe8qZRHGshbjK+7TDFzl5PVBANa3U+V9j4F6VW7aszzR
         b6BpdJFyV4wGi8CP2lzApM68ObRaafX8TCrre5TmeuacZl4I/UoTjj8fJfOp7RO0zZ+c
         dugmdp3Ds77C5gWZ9bVU2l5usmEfrD0fWF2reyLZtr5FE+Cxxgeq7sTfmn7jWl923X8v
         p2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7pQ4z3OyLmWB77R2Icz1RfStPxsM4M6Bc+F1AqoUcLo=;
        b=KhBZGrq1MloSs1uEliMnHexRJgK6qV0IXRfo/lLdY2Xdw727bc7v1+hwS7O3zkogIC
         c06Q0K/6+a8JdgCDco/STwbnEC+vjHCPQpBt1O7Qpi5thVors5M8dAXHaDL8cgucigOc
         D+/Ppisc6NyrdqDpLHOuoZ7qBIp3iaD02iwDQsprUJJ76xjqFhHCiRA9yxmHR+lg4/DE
         b4gK86p7d51/XfcJXDXE/gBQFvr7303DuK8MLnzqFxOwGzaNNlcmpKQagGQIWnVzu6Dh
         7dQm1g0Op9ZkqY2hS9R/86erC5kK4+p/F3iTkyJSrohBqU6t6BijR0cTP4S11U/AITAh
         6NvA==
X-Gm-Message-State: AOPr4FWzKNkmXkTluRsSji5x5IeIlT/IokGERjlyd/vjGFbVVbBtFQ8BoW3ggi6EM330ew==
X-Received: by 10.140.250.66 with SMTP id v63mr23256305qhc.101.1461978248122;
        Fri, 29 Apr 2016 18:04:08 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id s66sm5294612qha.44.2016.04.29.18.04.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:04:07 -0700 (PDT)
In-Reply-To: <1461972887-22100-3-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293118>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> Instead of having the capabilities in a local string, keep them
> in a struct outside the function. This will allow us in a later patch

nit: s/struct/array/

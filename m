From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 19/44] builtin-am: implement --3way, am.threeway
Date: Mon, 29 Jun 2015 17:18:01 -0700
Message-ID: <CAGZ79kYcYvpPBRqPBvRt0eJWkMtfGWVo-xvE1HVgMJLQ-9oWzw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-20-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 02:18:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9jFZ-0005SE-CH
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 02:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbbF3ASF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 20:18:05 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36790 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbbF3ASD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 20:18:03 -0400
Received: by ykdr198 with SMTP id r198so129767363ykd.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 17:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d6UiKzThuobgmrK3z6oK5kmF0v8/+E82jDIanXiTbr0=;
        b=he9xQNwL9GYm/XSzip3D5MtdwEgep+JSJzoxTRXMb12jfC/bN7LJSbU/crqFQkzB47
         9rmuLdF1Gir1WeB6HPJCvVIzndNE/wVfGNmFgwGkibi1IhVVxZl4YvFqzK89U9Xb7Y0J
         oOaqZq4CfCZVx+TN/m1utOyf4e5DLP7Rtp3M6GEQvYL0E0v1y11iZrnVy2gxjuHkcj/v
         389IznmOKKkkxNW51nl7jR0sAhcPnZIbASOHxUh8T2TmoyojpxIpEoMoHHwUpvDTw58X
         +TWFn47Gog9Fx/w2yP0ifOucrK705+LNND2JWf4s4WEKYrng69sVlKiZx/ir9LZACZ8O
         gt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=d6UiKzThuobgmrK3z6oK5kmF0v8/+E82jDIanXiTbr0=;
        b=C4iMTxZTcB0ZO4qYN2eN/As+KWMYkgqZvfX7hOfI6DHESxIOzF7o2fcpgrWeg8OOfd
         sMfvMS6sdMcYvzK9Mxje+/XjWqTnoisn2cHehFO07EyN+z29oM5Rg1RfUPGk0EBDiIW1
         W7LaMkBDgqHxBjnN8QIwvBh8mDh1CK4ULs+9mwAVaeq7vsL4dRifN/SwymYja4PmZgba
         nKbU+vwjk6Vs4Zn0Qszypr7U3f7BkoggctomPwrFVbhx2Ptwu8jBiVAdfhXhq7lSn6hD
         Ig0tt4JVVy8hO7Qyb4KZdZ8R+fWmxWxmovaqn0/ioScXIatB8jJ9+c4yQH2/EVzr4QPi
         VIaA==
X-Gm-Message-State: ALoCoQm3Y4cNbiybd6NgGTT7fwAng2M0Cm6MOsdqHDsgZuj5lbK73cSGyh4RoEF8OFnaAKF7hz//
X-Received: by 10.129.98.198 with SMTP id w189mr13140645ywb.32.1435623481775;
 Mon, 29 Jun 2015 17:18:01 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 17:18:01 -0700 (PDT)
In-Reply-To: <1435500366-31700-20-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273030>

> +/**
> + * Builds a index that contains just the blobs needed for a 3way merge.

an index

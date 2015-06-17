From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 10:58:10 -0700
Message-ID: <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
	<CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 19:58:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5HbU-0008S0-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 19:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756901AbbFQR6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 13:58:20 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:33086 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764AbbFQR6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 13:58:11 -0400
Received: by yhpn97 with SMTP id n97so39362652yhp.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Z4qScqz1mDVEvp2ATMVVxRJq9VeVYrCBptviEcQDZWc=;
        b=eY4rrkxu6c2vwhw6PDESELB4xtJBZqlqONKS6WoLMpcWZdSPNDGdM5J/2NkWnoYqzu
         ZXkmWDMcvmCdYAjppTfbN/VusYEyZWMhXa6ZUs76krc7g3CuW0h26l3t12eWd5bPDAk4
         Ur9AjycTv2CPfRlsgWI7OCQ2CBSBGHyc9K85XbSjr78wQ+QO7SDel9YgfGNErb9hahOQ
         rTSEzBZ8AhSWfb2+IEIWVoZuAktC4xXBJnq4PQq/tAp9cwlunwbBhEKwmS6d+z1mm1+7
         z7nXCdbhT65h+p1ncgJnFiBVxnqMSkd4mz6RTgmFy9ILX1AZMaxl6TnG4buFvsjuNwcT
         vQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z4qScqz1mDVEvp2ATMVVxRJq9VeVYrCBptviEcQDZWc=;
        b=YITydWnHOB6FGebHlmBqpMU/uBg2zYJF8d12Vz5hdOLrNOr0563MnLKw6cZORzT8s0
         rdkFYcRd8Jn+eGUtoykBoa4+LOjRYaA7wfsdgcNpAMFIfNvc27ncFi7jzCSsCwEAMPPy
         RmzSee21hJuEHkjYGzPmfjnuP1jdd4PpQBZAzfzRGGqW8YKlsciwve+EScLT30MA8+vW
         9CjrQ3INHO4oL4JtfOUCRZoKJO9hDF0OuZ311Lqw3g9NipBN9Rb46HzbWuyVASn5uGHv
         tJyb7CE+iCNWioLGTjGkrjRbQkQdxPt43HXNrCExH3NstopXCUXUlb2EBhz2wALcZRl4
         GuOw==
X-Gm-Message-State: ALoCoQm/+J9R+sAdGqI/AfqUbhDs4T2EwTShAQI1C4c10Kn0bFHjFJ1j83AR1RBTXY3J3RdQEX88
X-Received: by 10.129.111.65 with SMTP id k62mr8793335ywc.88.1434563890664;
 Wed, 17 Jun 2015 10:58:10 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Wed, 17 Jun 2015 10:58:10 -0700 (PDT)
In-Reply-To: <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271878>

> Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
> happy, we'll have cleaner defect list

It's down 31 defects, roughly 10% of all things coverity detected as
problematic.
YAY!

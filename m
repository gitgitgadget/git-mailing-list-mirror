From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 5/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 15:14:25 -0700
Message-ID: <20140526221425.GA20637@hudson.localdomain>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
 <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 00:22:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3IJ-0000it-2X
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbaEZWWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:22:55 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:56396 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbaEZWOa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:14:30 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so8237723pbb.27
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VIkH1Wiy+E9ce0BIFZ+cJx7Gwck3KbAvtgnwz7Wlh40=;
        b=Q1uT7Ug3Eo3UArJhiVW3Jk/PBU4x4EBrk517PW/8pqg+GZ6xrvAY2zXOybutLrQSWd
         +34AW0vYfQvSWyakhYl3jSdk2jM/Vzt2hZETqCV1JzDoyL1+TYj7W4as/zoOpperJ966
         R/Wp+auDjJKQ1b6CmMlQmM5tNhVxbEf1ZY2sWl21RwtT8aQGcxsq3RG3cTfWUB/YaUhu
         HvrAyV+gGoFYABS6PM1bCZAWhjSaZjpH2QPgmBtcrBU5W8nx12aGNz2H4faroYrEw3z+
         7mUhWAV0gT/sRMx2GF65bYISh7YIgvnEiA2DWKNIWamrP7+AnzLmKtaDhJvbH095x3rs
         pMnQ==
X-Received: by 10.68.231.35 with SMTP id td3mr30814157pbc.137.1401142469714;
        Mon, 26 May 2014 15:14:29 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id kj1sm19908278pbd.20.2014.05.26.15.14.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 15:14:28 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 15:14:25 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1401130586-93105-6-git-send-email-caleb@calebthompson.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250129>

Caleb,

On Mon, May 26, 2014 at 01:56:26PM -0500, Caleb Thompson wrote:
> Add a new configuration variable commit.verbose to implicitly pass
> `--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
> setting.
> 
> Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> ---
>  Documentation/config.txt               |  5 +++++
>  '
...
>  
> +test_expect_success 'commit shows verbose diff with set commit.verbose=true' '
> +	echo morecontent >>file &&
...
> +'
> +
> +test_expect_success 'commit --verbose overrides verbose=false' '
> +	echo evenmorecontent >>file &&
...
> +
> +test_expect_success 'commit does not show verbose diff with commit.verbose=false' '
> +	echo evenmorecontent >>file &&
...
> +'
> +
> +test_expect_success 'commit --no-verbose overrides commit.verbose=true' '
> +	echo evenmorecontent >>file &&
...
> +'
> +
>  

Some minor style nits...

Use a consistent naming convention for your tests.  verbose=false looks
different than commit.verbose=false at first glance.  Also, since
"commit.verbose=false" is an invalid syntax for a config option, I would
remove the '=' and just make it "commit.verbose false".

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler

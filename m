From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 14:17:04 -0700
Message-ID: <53558AD0.3010602@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:17:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLaa-0003J4-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbaDUVRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:17:18 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:40933 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaDUVRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:17:13 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so4049232pdj.22
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=sxnLVyNODzYvZCdxwVqk8EEaGl8tjuLn2W33PzTD++Q=;
        b=gnVBO9XdRRYqAhfbsrbmAu7sWolYhFTo+AdmPcMIlsaXQ8gpnKQJW5dPcY4smaSy4J
         3KX6FIM6v4JLBYcuV7QXBHRgkSxHS6NF5GfjAmAUiBPVzN0h7mRXc4MS/RyX1dxGqunv
         yV4ioHk3yw+jvivmM7SN3XsY9UMkc/EnyBxyqrk6W5NqTKhAqcnkS6TdIXlLoP5R+far
         fqPD4HYSAprziockZihZRxH7q0h8S2s7qXNuureCXDRo5Q+KGzKshLy8tOoRrJxFBPNq
         no3UM+jQ92Ivs5qXNt19p4/HQAFME1KbTX/tmTZlnq/cW5fASIVdAu0sopeYhVyAibpv
         FTPA==
X-Received: by 10.68.163.3 with SMTP id ye3mr40686998pbb.78.1398115033224;
        Mon, 21 Apr 2014 14:17:13 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id i10sm191279047pat.36.2014.04.21.14.17.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:17:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246641>

On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> [...]
>
> diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
> new file mode 100755
> index 0000000..d921c0e
> --- /dev/null
> +++ b/t/t5408-update-branch-hook.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +
> +test_description='Test the update-branch hook'
> +
> +. ./test-lib.sh
> +
> +setup () {
> +	mkdir -p .git/hooks &&
> +	cat > .git/hooks/update-branch <<-'EOF' &&
> +	#!/bin/sh
> +	echo $@ > .git/update-branch.args
> +	EOF
> +	chmod +x .git/hooks/update-branch &&
> +	echo one > content &&
> +	git add content &&
> +	git commit -a -m one
> +}
> +
> +setup

According to t/README `setup` should be inside an assertion just as any
other test:

> Do's, don'ts & things to keep in mind
> -------------------------------------
>
> Here are a few examples of things you probably should and shouldn't do
> when writing tests.
>
> Do:
>
>  - Put all code inside test_expect_success and other assertions.
>
>    Even code that isn't a test per se, but merely some setup code
>    should be inside a test assertion.

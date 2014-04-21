From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 16:15:18 -0500
Message-ID: <53558a663ea74_604be1f30c2c@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <53558AD0.3010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:25:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLij-0002f3-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521AbaDUVZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:25:42 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:54487 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbaDUVZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:25:41 -0400
Received: by mail-yk0-f171.google.com with SMTP id q9so3864371ykb.16
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=FS5+qI303JaZmsa+eZmpdevcyM94bJtbxLuLI40UBE4=;
        b=drQaMW/2dEItUOiv3OaMh8vlpedgr3768fpziUCfr8VehC+2ZXqyt9a4bifv7r5pQ8
         /Cz6huIS100TQE53N0D6wxk137lqnM42Vb9LHrObPxhHpvTsM3dtI3WIs3SyguRbmx+R
         3/yuBkNNCXh0774VWETQb2bKvknDGpTonU3CubdEfeylGUAKitRHQLo8slrwjijv/pq0
         0vniDXPI4OCiIdD/8jMQBgsSbJ3pw23Htg3dK0F11D4v5BbUVkxcwaSUg1kqsMkzr8MJ
         BQMAnjC9nyGwIiX/V7W+AMoh13TDSqpeiDFUfdMUzb23lAOwHE1ihWz6IfmugUV+ufCz
         RHvw==
X-Received: by 10.236.116.131 with SMTP id g3mr5569668yhh.110.1398115540549;
        Mon, 21 Apr 2014 14:25:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id b45sm73664575yhl.31.2014.04.21.14.25.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:25:39 -0700 (PDT)
In-Reply-To: <53558AD0.3010602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246645>

Ilya Bobyr wrote:
> On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> > [...]
> >
> > diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
> > new file mode 100755
> > index 0000000..d921c0e
> > --- /dev/null
> > +++ b/t/t5408-update-branch-hook.sh
> > @@ -0,0 +1,39 @@
> > +#!/bin/sh
> > +
> > +test_description='Test the update-branch hook'
> > +
> > +. ./test-lib.sh
> > +
> > +setup () {
> > +	mkdir -p .git/hooks &&
> > +	cat > .git/hooks/update-branch <<-'EOF' &&
> > +	#!/bin/sh
> > +	echo $@ > .git/update-branch.args
> > +	EOF
> > +	chmod +x .git/hooks/update-branch &&
> > +	echo one > content &&
> > +	git add content &&
> > +	git commit -a -m one
> > +}
> > +
> > +setup
> 
> According to t/README `setup` should be inside an assertion just as any
> other test:

I have a bunch of 'setup' calls outside such assertions already in other test
scripts. If you know how to put single quotes inside of single quotes in a
shell script, please share that knowledge, otherwise the setup must be outside.

Of course we could do the extremely reduntant:

test_expect_success 'setup' '
  setup
'

-- 
Felipe Contreras

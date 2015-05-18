From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] subdirectory tests: code cleanup, uncomment test
Date: Mon, 18 May 2015 14:21:24 -0700
Message-ID: <xmqqvbfpa8ff.fsf@gitster.dls.corp.google.com>
References: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
	<1431983426-4346-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes.Schindelin@gmx.de, Jens.Lehmann@web.de,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 18 23:21:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuSTb-0008Pu-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbbERVV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 17:21:28 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37753 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbERVV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:21:27 -0400
Received: by igbsb11 with SMTP id sb11so59012591igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=34XlqaFJoPG/8cIkw9+ro9LEICqp9ALlOSxN8ldOIww=;
        b=CJEjos4duPHbn/Ka5F/gu4flvSlYHKjRqrPbPNh+1QMp3B6bqYrjl68B3RV49i48yv
         lHAhdM//Tpv86lACvp7s3o95++cja3tq1k849YcCRR7w8jHRW5bgS9zpsyHTM4qMhQOx
         S/+vGnsPDPDNh/Y6+j6TVX1vg3qkj+nQAa+/3olhpP81KhuJsF4xRTjRpo/hMjQMnAmS
         E4LNoxVC7uZKNMPT1cfmH2eC25d/EVfl6GfpVezY+zxMCfKTQ1LKRfxaA5mdZZNymwwh
         BliKJgJe2M68sM1Q+fZdS4OM/K84DOxlcbia4eWUy2tBWoJZnPoUyqgb9clwQv6fc85u
         D55w==
X-Received: by 10.43.169.137 with SMTP id nm9mr17082207icc.82.1431984086365;
        Mon, 18 May 2015 14:21:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id h138sm8514846ioe.2.2015.05.18.14.21.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 14:21:25 -0700 (PDT)
In-Reply-To: <1431983426-4346-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 18 May 2015 14:10:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269321>

Stefan Beller <sbeller@google.com> writes:

> Originally the test in t1020 was meant to not include setting the GIT_DIR
> when testing inside a bare repository as it did not work without setting
> GIT_DIR explicitly.
>
> Nowadays the test as originally intended works, so add it to the test
> suite. We'll keep the test, which has been run through all years as another
> test for finding regressions.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Junio, thanks for providing the context!
>
> I tried tracking down when this changes via bisect, though I messed up.
> By looking through the code I find these commits most promising to have
> fixed the underlying issue (I am no expert on subdirectory treatment)
> 337e51c (Use git_config_early() instead of git_config() during repo setup, 2010-11-26)
> 72183cb (Fix gitdir detection when in subdir of gitdir, 2009-01-16)
> 9951d3b (setup: clean up setup_discovered_git_dir(), 2010-11-26)

Thanks for digging.

I personally do not think we would need to say "historic" (as it
makes it sound as if we do not care if the use case is deprecated
and dropped in the future) but I do not offhand think of a better
label for that test (other than doing the cop-out "test (1)" vs
"test (2)"), so let's queue this as-is.


>
>  t/t1020-subdirectory.sh | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> index 2edb4f2..022641d 100755
> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -162,16 +162,20 @@ test_expect_success 'no file/rev ambiguity check inside .git' '
>  	)
>  '
>  
> -test_expect_success 'no file/rev ambiguity check inside a bare repo' '
> +test_expect_success '(historic) no file/rev ambiguity check inside a bare repo' '
> +	test_when_finished "rm -fr foo.git" &&
>  	git clone -s --bare .git foo.git &&
>  	(
>  		cd foo.git &&
> +		# older Git needed help by exporting GIT_DIR=.
> +		# to realize that it is inside a bare repository.
> +		# We keep this test around for regression testing.
>  		GIT_DIR=. git show -s HEAD
>  	)
>  '
>  
> -# This still does not work as it should...
> -: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
> +test_expect_success 'no file/rev ambiguity check inside a bare repo' '
> +	test_when_finished "rm -fr foo.git" &&
>  	git clone -s --bare .git foo.git &&
>  	(
>  		cd foo.git &&
> @@ -180,7 +184,6 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo' '
>  '
>  
>  test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
> -	rm -fr foo.git &&
>  	git clone -s .git another &&
>  	ln -s another yetanother &&
>  	(
